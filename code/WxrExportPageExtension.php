<?php

use SilverStripe\ORM\DataExtension;
use SilverStripe\ORM\FieldType\DBHTMLText;
use SilverStripe\View\Parsers\ShortcodeParser;

class WxrExportPageExtension extends DataExtension {


    public function ContentWxrFiltered(){

        $contentFilteredObj = new DBHTMLText();
        $contentOriginal = $this->owner->Content;

        $contentFiltered = $this->filterContent($contentOriginal);
        $contentFilteredObj->setValue($contentFiltered);

        return $contentFilteredObj;
    }


    private function filterContent($content){
        $parser = ShortcodeParser::get();
        $domain = $_SERVER['HTTP_HOST'];

        $contentFiltered = $parser->parse($content);
        $contentFiltered = str_replace('href="assets/', 'href="sites/'.$domain.'/files/imports/', $contentFiltered);

        return $contentFiltered;


    }


}
