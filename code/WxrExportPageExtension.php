<?php

use SilverStripe\ORM\DataExtension;
use SilverStripe\ORM\FieldType\DBHTMLText;
use SilverStripe\View\Parsers\ShortcodeParser;
use SilverStripe\ORM\ArrayList;
use Thunder\Shortcode\Parser\RegularParser;
use SilverStripe\Assets\Image;

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
        $contentFiltered = str_replace('href="/assets/', 'href="/sites/'.$domain.'/files/imports/', $contentFiltered);

        return $contentFiltered;


    }

    public function getInlineImages(){
        $content = $this->owner->Content;

        $parser = new RegularParser();
        $parsedShortcodes = $parser->parse($content);
        $imagesInline = new ArrayList();

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

        return $imagesInline;
    }

    public function ImageLookup(){
        $page = $this->owner->data();
        $images = new ArrayList();

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
            'StaffPhoto',
            'TestimonialPhoto',
            'Program1Photo',
            'Program2Photo',
            'Program3Photo',
            'DefaultPhoto',
            'AboutUsFeature1Photo',
            'AboutUsFeature2Photo'

        );

        //Try the above image fields
        foreach($tries as $t) {
            // echo $t;
            $i = $page::getSchema()->hasOneComponent($page, $t);
            // echo $i;
            if($i) {
                if($page->getComponent($t)->exists()){
                    // echo 'component exists: '.$i;
                    $images->push($page->getComponent($t));
                }
            }
        }

        return $images;

    }


}
