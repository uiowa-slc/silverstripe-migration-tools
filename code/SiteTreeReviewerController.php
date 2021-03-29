<?php

use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Core\Config\Config;
use SilverStripe\Security\Permission;

class SiteTreeReviewerController extends ContentController {

	private static $url_handlers = [
		'siteTreeReviewer/$@' => 'index',
		'csvExport/$@' => 'csvExport',
	];

	private static $allowed_actions = [
		'index',
		'csvExport',
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
