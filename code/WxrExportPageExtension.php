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
        $contentFiltered = str_replace('href="/assets/', 'href="sites/'.$domain.'/files/imports/', $contentFiltered);

        return $contentFiltered;


    }

    public function ImageLookup(){
        $page = $this->owner->data();

        $tries = array(

            'FeaturedImage',
            'MainImage',
            'HeaderImage',
            'Photo',
            'BackgroundImage',
            'HeroImage',
            'MainPhoto',
            'ProgramPhoto',
            'Image',
            'StaffPhoto'

        );

        //Try the above image fields
        foreach($tries as $t) {
            // echo $t;
            $i = $page::getSchema()->hasOneComponent($page, $t);
            // echo $i;
            if($i) {
                if($page->getComponent($t)->exists()){
                    // echo 'component exists: '.$i;
                    return $page->getComponent($t);
                }
            }
        }


    }


}
