<?php

use SilverStripe\Admin\CMSMenu;
use SilverStripe\Admin\LeftAndMainExtension;

class SiteTreeReviewerCustomLinkExtension extends LeftAndMainExtension {

	public function init() {

		// unique identifier for this item. Will have an ID of Menu-$ID
		$id = 'SiteTreeReviewerCustomLink';
		$title = 'SiteTree Reviewer';
		$iconClass = 'font-icon-columns';

		// the link you want to item to go to
		$link = 'siteTreeReviewer';

		// priority controls the ordering of the link in the stack. The
		// lower the number, the lower in the list
		$priority = -2;

		// Add your own attributes onto the link. In our case, we want to
		// open the link in a new window (not the original)
		$attributes = [
			'target' => '_blank',
		];
//add_link(string $code, string $menuTitle, string $url, integer $priority = -1, array $attributes = null, string $iconClass = null)

		CMSMenu::add_link($id, $title, $link, $priority, $attributes, $iconClass);
	}
}
