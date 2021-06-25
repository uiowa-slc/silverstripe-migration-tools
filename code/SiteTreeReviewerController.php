<?php

use SilverStripe\Assets\File;
use SilverStripe\Assets\Image;
use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\CMS\Model\SiteTree;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Core\Config\Config;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Security\Permission;
use SilverStripe\View\ArrayData;
use Thunder\Shortcode\Parser\RegularParser;

class SiteTreeReviewerController extends ContentController {

	private static $url_handlers = [
		'siteTreeReviewer/$@' => 'index',
		'csvExport/$@' => 'csvExport',
		'pageInspector//$ID' => 'pageInspector',
		'pageInspectorInterstital/edit//$ID' => 'pageInspectorInterstitalEdit',
		'pageInspectorInterstital/view//$ID' => 'pageInspectorInterstitalView',
		'pageInspectorInterstital/inspect//$ID' => 'pageInspectorInterstitalInspect',
	];

	private static $allowed_actions = [
		'index',
		'csvExport',
		'pageInspector',
		'pageInspectorInterstitalEdit',
		'pageInspectorInterstitalView',
		'pageInspectorInterstitalInspect',

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

	public function index($request) {
		$renderedData = $this->renderWith('SiteTreeReviewer');
		return $renderedData;
	}

	public function pageInspectorInterstitalEdit() {

		$id = $this->getRequest()->param('ID');
		$page = SiteTree::get()->filter(array('ID' => $id))->First();
		$link = 'admin/pages/edit/show/' . $id;

		$data = new ArrayData(array(
			'Page' => $page,
			'Link' => $link,
			'Action' => 'edit',
		));

		return $this->customise($data)->renderWith('SiteTreeReviewer_pageInspectorInterstital');

	}
	public function pageInspectorInterstitalView() {

		$id = $this->getRequest()->param('ID');

		if ($id == "home") {
			$page = SiteTree::get()->filter(array('URLSegment' => 'home'))->First();
		} else {
			$page = SiteTree::get()->filter(array('ID' => $id))->First();
		}

		$link = $page->AbsoluteLink();

		$data = new ArrayData(array(
			'Page' => $page,
			'Link' => $link,
			'Action' => 'view',
		));

		return $this->customise($data)->renderWith('SiteTreeReviewer_pageInspectorInterstital');

	}

	public function pageInspectorInterstitalInspect() {

		$id = $this->getRequest()->param('ID');
		if ($id == "home") {
			$page = SiteTree::get()->filter(array('URLSegment' => 'home'))->First();
		} else {
			$page = SiteTree::get()->filter(array('ID' => $id))->First();
		}
		$link = 'siteTreeReviewer/pageInspector/' . $id;

		$data = new ArrayData(array(
			'Page' => $page,
			'Link' => $link,
			'Action' => 'inspect',
		));

		return $this->customise($data)->renderWith('SiteTreeReviewer_pageInspectorInterstital');

	}
	public function pageInspector() {

		//TODO maybe make an interstitial page with an iframe with "Edit View Inspect" as a tool bar with buttons linking to v
		// pageInspector/edit/XX pageInspector/view/XX pageInspector/inspect/XX

		$id = $this->getRequest()->param('ID');
		if ($id == "home") {
			$page = SiteTree::get()->filter(array('URLSegment' => 'home'))->First();
		} else {
			$page = SiteTree::get()->filter(array('ID' => $id))->First();
		}
		$imagesAttached = new ArrayList();
		$imagesInline = new ArrayList();
		$filesInline = new ArrayList();
		$blockImages = new ArrayList();
		$homePageHeroFeatures = new ArrayList();

		if (class_exists('NewHomePageHeroFeature')) {

			$homePageHeroFeatures = NewHomePageHeroFeature::get();
		}

		//TODO GET ATTACHED IMAGES:

		$imageTries = array(
			'OgImage',
			'FeaturedImage',
			'MainImage',
			'HeaderImage',
			'Photo',
			'BackgroundImage',
			'HeroImage',
			'MainPhoto',
			'ProgramPhoto',
			'Image'
		);

		foreach ($imageTries as $t) {
			$i = $page::getSchema()->hasOneComponent($page, $t);
			if ($i) {
				if ($page->getComponent($t)->exists()) {

					$imagesAttached->push($page->getComponent($t));
				}
			}
		}

		$content = $page->Content;
		//TODO GET INLINE IMAGES
		$parser = new RegularParser();
		$parsedShortcodes = $parser->parse($content);

		foreach ($parsedShortcodes as $shortcode) {
			$name = $shortcode->getName();
			if ($name == "image") {
				$params = $shortcode->getParameters();
				//print_r($params);
				$id = $params['id'];
				$image = Image::get()->filter(array('ID' => $id))->First();

				if ($image) {
					$imagesInline->push($image);
				}

			}

		}
		//print_r($parser->parse($content));

		//BLOCK IMAGES:

		$elementRelations = new ArrayList();
		if (class_exists('DNADesign\Elemental\Extensions\ElementalAreasExtension')) {
			$elementRelations = $page->getElementalRelations();
		}
		
		$elementAreas = new ArrayList();
		$elementList = new ArrayList();

		foreach ($elementRelations as $elementRelation) {
			//print_r($elementRelation . 'ID ');
			//print_r($page->{$elementRelation} . "ID");
			$elementAreas->push($page->obj($elementRelation));
		}

		foreach ($elementAreas as $elementArea) {
			$elements = $elementArea->Elements();

			foreach ($elements as $element) {

				$elementList->push($element);

				$elementImageTries = array(
					'Image',
					'BackgroundImage',
					'Photo',
					'FeaturePagePhoto',

				);

				foreach ($elementImageTries as $elementImageTry) {
					$i = $element::getSchema()->hasOneComponent($element, $elementImageTry);

					if ($i) {
						if ($element->getComponent($elementImageTry)->exists()) {

							$blockImages->push($element->getComponent($elementImageTry));
						}
					}

				}

			}

		}

		//print_r($elementRelations);

		//TODO GET INLINE FILES

		preg_match_all("[file_link,id=([0-9]+)]", $content, $findFile);

		if (isset($findFile[1])) {
			foreach ($findFile[1] as $foundFile) {
				$fileCheck = File::get()->filter(array('ID' => $foundFile))->First();

				if ($fileCheck) {
					$filesInline->push($fileCheck);
				}
			}
		}

		//Get latest editor:

		$versionedPage = $page->VersionsList()->Last();
		$recentEditor = $versionedPage->Author();

		$data = new ArrayData(array(
			'Page' => $page,
			'ImagesAttached' => $imagesAttached,
			'ImagesInline' => $imagesInline,
			'FilesInline' => $filesInline,
			'BlockImages' => $blockImages,
			'Elements' => $elementList,
			'RecentEditor' => $recentEditor,
			'NewHomePageHeroFeatures' => $homePageHeroFeatures,
		));

		return $this->customise($data)->renderWith('SiteTreeReviewer_pageInspector');

	}

	public function csvExport($request) {

		$filename = $this->SiteConfig()->Title . ' - Site Inventory.csv';
		$pagesArray = array();

		$pagesArray[] = ['Page title', 'URL', 'Content type', 'Attached/embedded files', 'Target audience', 'Top-level or sub-page', 'SEO metadescription', 'Last updated', 'Author/Editor', 'Actions (Keep/Delete/Modify)', 'Redirect URL', 'Notes'];

		$pages = $this->getMenu();

		//$pages = Page::get();

		foreach ($pages as $page) {

			$pagesArray[] = $this->convertPageToCsvArray($page);

			$pageChildren = $page->Children();

			$pagesArray = $this->ChildrenToArray($page, $pagesArray);

			// foreach ($pageChildren as $pageChild) {
			//              print_r($pageChild
			// 	$pagesArray[] = $this->convertPageToCsvArray($pageChildren);
			// }

			//foreach($page)

		}

		// output headers so that the file is downloaded rather than displayed
		header('Content-Type: text/csv; charset=utf-8');
		header('Content-Disposition: attachment; filename=' . $filename);

		// create a file pointer connected to the output stream
		$output = fopen('php://output', 'w');

		foreach ($pagesArray as $fields) {
			fputcsv($output, $fields);
		}

	}
	private function ChildrenToArray($page, $pagesArray) {

		$pageChildren = $page->Children();

		if ($pageChildren) {

			foreach ($pageChildren as $pageChild) {

				$pagesArray[] = $this->convertPageToCsvArray($pageChild);

				if ($pageChild->Children()) {
					$pagesArray = $this->ChildrenToArray($pageChild, $pagesArray);
				}

			}

		} else {

		}

		return $pagesArray;

	}
	private function convertPageToCsvArray($page) {

		if ($page->ParentID == 0) {
			$pageSubOrTop = 'Top-level';
		} else {
			$pageSubOrTop = 'Sub-page';
		}

		if ($this->checkForAttachedFiles($page) == true) {
			$pageContainsFiles = 'Has attached files';
		} else {
			$pageContainsFiles = 'No attached files';
		}

		$versionedPage = $page->VersionsList()->Last();
		$pageAuthor = $versionedPage->Author();
		if ($pageAuthor) {
			//$pageAuthorName = $page->Author()->Name;
			$pageAuthorName = $pageAuthor->Name;
		} else {
			$pageAuthorName = '';
		}

		$pageArray = [$page->Title, $page->AbsoluteLink(), $page->ClassName, $pageContainsFiles, '', $pageSubOrTop, $page->MetaDescription, $page->LastEdited, $pageAuthorName, '', '', ''];

		return $pageArray;

	}

	public function RecentEditors() {

		$recentPages = Page::get()->sort(array('LastEdited DESC'))->Limit(50);
		$authors = new ArrayList();

		foreach ($recentPages as $page) {
			$versionedPage = $page->VersionsList()->Last();
			$pageAuthor = $versionedPage->Author();

			if ($pageAuthor) {
				$authors->push($pageAuthor);
			}

		}

		$authors->removeDuplicates();

		return $authors;

	}
	public function RecentlyEditedPages() {

		$recentPages = Page::get()->sort(array('LastEdited DESC'))->Limit(20);
		$versionedPageList = new ArrayList();

		foreach ($recentPages as $page) {
			$versionedPageList->push($page->VersionsList()->Last());
		}
		return $versionedPageList;

	}
	private function checkForAttachedFiles($page) {
		$content = $page->Content;
		$pos = strpos($content, '[file_link');
		if ($pos !== false) {
			return true;
		} else {
			return false;
		}
	}
}
