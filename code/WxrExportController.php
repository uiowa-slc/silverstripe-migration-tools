<?php

use SilverStripe\Blog\Model\BlogCategory;
use SilverStripe\Blog\Model\BlogTag;
use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\CMS\Model\SiteTree;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Core\Config\Config;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Security\Member;
use SilverStripe\Security\Permission;
use SilverStripe\View\ArrayData;
use SilverStripe\View\Parsers\URLSegmentFilter;
use SilverStripe\Core\Environment;

class WxrExportController extends ContentController {

	private static $url_handlers = [
		'wxrExport/$@' => 'index',
	];

	public function init() {
		parent::init();

		if (!Permission::check('ADMIN')) {
			//return $this->httpError(403);
			$response = $this ? $this->getResponse() : new HTTPResponse();
			$response->setStatusCode(403);
			return $this->redirect(Config::inst()->get('SilverStripe\\Security\\Security', 'login_url') . "?BackURL=" . urlencode($_SERVER['REQUEST_URI']));
		}
	}

	//In order to find all pages on the site
	// private static $pageFilters = [
	//     'ClassName:not' => 'Blog'
	//     'ClassName:not' => 'BlogPost',
	//     'ClassName:not' => 'TopicHolder',
	//     'ClassName:not' => 'Topic',
	// ];

	public function index($request) {
		$filter = new URLSegmentFilter();
		$filename = $filter->filter($this->SiteConfig()->obj('Title')) . '.xml';

		$authors = new ArrayList();
		$pages = new ArrayList();
		$posts = new ArrayList();
		$tags = new ArrayList();
		$cats = new ArrayList();
		$tagsCats = array();

		$authors = Member::get();

		//normalize authors, ensure they have HawkID username
		foreach ($authors as $author) {

			if (!$author->AdUsername) {
				$author->parseNamesAndGroups();
				$author->write();
			}
		}

		$versionedPages = new ArrayList();

		$tags = BlogTag::get();

		//TODO: Make a TopicHolder "tag" so we can successfully account for multiple TopicHolders and use taxonomy instead of a separate "page"

		$cats = BlogCategory::get();

		$tagsArray = $tags->toArray();
		$catsArray = $cats->toArray();

		$tagsCats = array_merge($tagsArray, $catsArray);

		// $pageExcludes = [
		//     'ClassName:PartialMatch:not' => 'ErrorPage',
		//     'ClassName:PartialMatch:not' => 'StaffPage',
		//     'ClassName:PartialMatch:not' => 'HomePage',
		//     'ClassName:PartialMatch:not' => 'UtilityPage',
		// ];
		$pages = SiteTree::get()->exclude('ClassName:PartialMatch', 'ErrorPage')->exclude('ClassName:PartialMatch', 'UtilityPage')->exclude('ClassName:PartialMatch', 'StaffPage')->exclude('ClassName:PartialMatch', 'HomePage');
		// print_r($pages->toArray());
		foreach ($pages as $page) {
			$versionedPage = $page->VersionsList()->Last();

			$versionedPages->push($versionedPage);

		}

		//$blogTagsCats = $blogTags->merge($blogCats);

		$templateData = new ArrayData([
			'Authors' => $authors,
			'Pages' => $versionedPages,
			'Tags' => $tags,
			'Categories' => $cats,
			'TagsCats' => $tagsCats,
		]);

		$renderedData = $templateData->renderWith('WxrFeed');

		$xml = simplexml_load_string($renderedData);

		$dom = new DOMDocument("1.0");
		$dom->preserveWhiteSpace = false;
		$dom->formatOutput = true;
		$dom->loadXML($xml->asXML());

        if(Environment::getEnv('SS_ENVIRONMENT_TYPE') == "dev"){
            header('Content-type: text/xml');
        }else{
            header('Content-Disposition: attachment; filename="' . $filename . '"');
        }

		print($dom->saveXML());

	}
}
