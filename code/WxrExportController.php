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
use SilverStripe\Control\HTTPRequest;
use SilverStripe\ORM\FieldType\DBInt;
use SilverStripe\ORM\DataObject;
use SilverStripe\Versioned\Versioned;
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

        $getVars = $request->getVars();
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
        $pages = SiteTree::get()->exclude('ClassName:PartialMatch', 'ErrorPage')->exclude('ClassName:PartialMatch', 'UtilityPage');


        if(isset($getVars["notopics"])){

            $pages = $pages->exclude('ClassName:PartialMatch', 'TopicHolder')->exclude('ClassName:PartialMatch', 'Topic');


        }

        // print_r($pages->toArray());
        foreach ($pages as $page) {
            //$versionedPage = $page->VersionsList()->sort('Version DESC')->First();
            $versionedPageId = Versioned::get_versionnumber_by_stage(get_class($page), 'Live', $page->ID);
            $versionedPage = $page->VersionsList()->filter(array('Version' => $versionedPageId))->First();

            //if a versioned page is orphaned/doesn't have an original page (aka the page has been nuked/archived)
            if(isset($versionedPage->RecordID)){
                $versionedPages->push($versionedPage);
            }



        }

        $attachments = new ArrayList();

        foreach($versionedPages as $versionedPage){

            $pageImages = $versionedPage->ImageLookup();


            // $postId = new DBInt();
            // $postId->setValue($page->ID);
            // $pageImage->PostID = $postId;

            foreach($pageImages as $pageImage){

                $proxyObject = new DataObject();
                $postId = new DBInt();
                $postId->setValue($versionedPage->ID);
                $proxyObject->PostID = $pageImage->ID;
                $proxyObject->Title = $pageImage->Title;
                $proxyObject->AbsoluteURL = $pageImage->FitMax(2592,1458)->getAbsoluteURL();
                $proxyObject->Alt = $pageImage->Title;
                $proxyObject->Created = $pageImage->Created;
                $attachments->push($proxyObject);
            }

            $pageInlineImages = $versionedPage->getInlineImages();

            // print_r($pageInlineImages->toArray());

            foreach($pageInlineImages as $inlineImage){
                if($inlineImage->getAbsoluteURL()){
                    $proxyObject = new DataObject();
                    $postId = new DBInt();
                    $postId->setValue($versionedPage->ID);
                    $proxyObject->PostID = $inlineImage->ID;
                    $proxyObject->Title = $inlineImage->Title;
                    $proxyObject->AbsoluteURL = $inlineImage->FitMax(2592,1458)->getAbsoluteURL();
                    $proxyObject->Alt = $inlineImage->Title;
                    $proxyObject->Created = $inlineImage->Created;
                    $attachments->push($proxyObject);

                }


            }


        }

        $homePageHeroFeatures = new ArrayList();


        if (class_exists('NewHomePageHeroFeature')) {
            $homePageHeroFeatures = NewHomePageHeroFeature::get();

        }

        foreach($homePageHeroFeatures as $homePageHeroFeature){
            $image = $homePageHeroFeature->obj('Image');
            if($image->getAbsoluteURL()){
            $proxyObject = new DataObject();
            $postId = new DBInt();
            $postId->setValue($page->ID);
            $proxyObject->PostID = $image->ID;
            $proxyObject->Title = $image->Title;
            $proxyObject->AbsoluteURL = $image->FitMax(2592,1458)->getAbsoluteURL();
            $proxyObject->Alt = $image->Title;
            $proxyObject->Created = $image->Created;

            $attachments->push($proxyObject);
            }
        }


        $attachments->removeDuplicates('PostID');

        //$blogTagsCats = $blogTags->merge($blogCats);

        $templateData = new ArrayData([
            'Authors' => $authors,
            'Pages' => $versionedPages,
            'Attachments' => $attachments,
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



        if(isset($getVars["view"])){
            header('Content-type: text/xml');
        }else{
            header('Content-Disposition: attachment; filename="' . $filename . '"');
        }

        print($dom->saveXML());

    }
}
