<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0"
    xmlns:excerpt="http://wordpress.org/export/1.2/excerpt/"
    xmlns:content="http://purl.org/rss/1.0/modules/content/"
    xmlns:wfw="http://wellformedweb.org/CommentAPI/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:wp="http://wordpress.org/export/1.2/"
>

<channel>
    <title>$SiteConfig.Title</title>
    <language>en-US</language>
    <% loop $Categories %>
    <wp:category>
        <wp:term_id>$ID</wp:term_id>
        <wp:category_nicename><![CDATA[$URLSegment]]></wp:category_nicename>
        <wp:category_parent><![CDATA[]]></wp:category_parent>
        <wp:cat_name><![CDATA[$Title]]></wp:cat_name>
    </wp:category>
    <% end_loop %>

    <% loop $Tags %>
    <wp:tag>
        <wp:term_id>$ID</wp:term_id>
        <wp:tag_slug><![CDATA[$URLSegment]]></wp:tag_slug>
        <wp:tag_name><![CDATA[$Title]]></wp:tag_name>
    </wp:tag>
    <% end_loop %>

    <% loop $Pages %>
        <item>
        <title>$Title</title>
        <link>$AbsoluteLink</link>
        <pubDate>$LastEdited</pubDate>
        <dc:creator><![CDATA[$Author.AdUsername]]></dc:creator>
        <guid isPermaLink="false">$AbsoluteLink</guid>
        <description></description>
        <content:encoded>

            <% if $ClassName == "WhoDoesWhatHolder" %>
            <![CDATA[
                $ContentWxrFiltered.RAW
                <% loop AllChildren.Sort('Title') %>
                    <h2>$MenuTitle</h2>
                    <p>
                    <% if $OfficeName %><br />Office Name: $OfficeName<% end_if %>
                    <% if $OfficeLocation %><br />Location: $OfficeLocation<% end_if %>
                    <% if $PhoneNumber %><br />Phone Number: $PhoneNumber<% end_if %>

                    <% if $EmailAddress %><br />Email: <a href="mailto:$EmailAddress">$EmailAddress</a><% end_if %>
                    </p>
                    <% if $Website %><p><a class="btn" href="$Website" target="_blank">Visit Website</a></p><% end_if %>
                    <% if $AdditionalInfo %>$AdditionalInfo<% end_if %>
                <% end_loop %>
            ]]>
            <% end_if %>

            <% if $ClassName == "BuildingHoursPage" %>
            <![CDATA[

                <% if $EffectiveStartDate && $EffectiveEndDate %>
                    <p><em>Effective from $EffectiveStartDate.Nice - $EffectiveEndDate.Nice</em></p>
                <% end_if %>
                <% loop $Children %>
                    <h2>$Title</h2>
                    $ContentWxrFiltered.RAW
                    <% include BuildingHoursTable %>
                <% end_loop %>
            ]]>
            <% end_if %>

            <% if $ClassName == "MeetingRoomHolder" %>
            <![CDATA[
                <% if $EffectiveStartDate && $EffectiveEndDate %>
                    <p><em>Effective from $EffectiveStartDate.Nice - $EffectiveEndDate.Nice</em></p>
                <% end_if %>
                <% loop $Children %>
                    <h2>$Title</h2>
                    $ContentWxrFiltered.RAW
                    <% include BuildingHoursTable %>
                <% end_loop %>
            ]]>
            <% end_if %>  

            <% if $ClassName == "MeetingRoomPage" %>
            <![CDATA[
                <% if $Number %>
                    <p style="font-size: 24px;"><strong>Room number:</strong> $Number</p>
                <% end_if %>
                <% if $FormerlyKnownAs %>
                    <p><strong>Formerly known as:</strong> $FormerlyKnownAs</p>
                <% end_if %>
                $ContentWxrFiltered.RAW
            <% if $TablesAndChairsCapacity || $RoundedTablesCapacity || $TheaterCapacity || $ClassroomCapacity || $UshapeCapacity || $BoardroomCapacity || $SocialDistancingCapacity %>
            

                        <% if $SocialDistancingOnly  %>
                            <% if SocialDistancingCapacity%>
                                <h2>Capacity by setup</h2>
                                <ul>
                                    <li>
                                        <strong>Social Distancing:</strong> $SocialDistancingCapacity
                                    </li>
                                </ul>
                
                            <% end_if %>
                        <% else %>
                            <h2>Capacity by setup</h2>
                            <ul>
                            <% if $TablesAndChairsCapacity %>
                            <li>
                        
                                <strong>Banquet Rectangles:</strong> $TablesAndChairsCapacity
                            </li>
                            <% end_if %>
                            <% if $RoundedTablesCapacity %>
                            <li>
                    
                                <strong>Banquet Rounds:</strong> $RoundedTablesCapacity
                            </li>
                            <% end_if %>
                            <% if $TheaterCapacity %>
                            <li>
            
                                <strong>Theater:</strong> $TheaterCapacity
                            </li>
                            <% end_if %>
                            <% if $ClassroomCapacity %>
                            <li>
                                <strong>Classroom:</strong> $ClassroomCapacity
                            </li>
                            <% end_if %>
                            <% if $UshapeCapacity %>
                            <li>
                                <strong>U-Shape:</strong> $UshapeCapacity
                            </li>
                            <% end_if %>
                            <% if $BoardroomCapacity %>
                            <li>
                                <strong>Board Room:</strong> $BoardroomCapacity
                            </li>
                            <% end_if %>
                        </ul>

                        <% end_if %>
                    </div>
                    <% end_if %>
                 

                    <% if $HasComputer || $HasEthernetConnection || $HasProjectorScreen || $HasProjector || $HasDVD || $HasBluRay || $HasSpeakers || $HasMarkerboard || $HasMicrophone || $HasWifi || $HasElectricPiano|| $ComplimentaryEquipmentProvided %>

                    
                        <h2>Equipment</h2>
                        <ul>
                            <% if $HasComputer %>
                                <li>
        
                                    Computer
                                </li>
                            <% end_if %>
                            <% if $HasEthernetConnection %>
                                <li>

                                    Ethernet connection
                                </li>
                            <% end_if %>
                            <% if $HasProjectorScreen %>
                                <li>
                        
                                    Projector screen
                                </li>
                            <% end_if %>
                            <% if $HasProjector %>
                                <li>
                        
                                    Projector
                                </li>
                            <% end_if %>
                            <% if $HasDVD %>
                                <li>
                
                                    DVD player
                                </li>
                            <% end_if %>
                            <% if $HasBluRay %>
                                <li>
                    
                                    Blu-ray player
                                </li>
                            <% end_if %>
                            <% if $HasSpeakers %>
                                <li>
            
                                    Speakers
                                </li>
                            <% end_if %>
                            <% if $HasMarkerboard %>
                                <li>

                                    Markerboard
                                </li>
                            <% end_if %>
                            <% if $HasMicrophone %>
                                <li>
                    
                                    Microphone
                                </li>
                            <% end_if %>
                            <% if $HasWifi %>
                                <li>
                
                                    Wifi
                                </li>
                            <% end_if %>
                            <% if $HasElectricPiano %>
                                <li>
                        
                                    Electric piano
                                </li>
                            <% end_if %>
                            <% if $ComplimentaryEquipmentProvided %>
                                <li>
                
                                    Complimentary items*
                                </li>
                            <% end_if %>
                        </ul>
    
                    <% end_if %>

                    <% if $StudentRate || $FacultyRate || $GeneralRate %>
        
                        <h2>Rates</h2>
                        <ul>
                        <% if $StudentRate %>
                            <li>
                                <strong>UI student organization events:</strong>
                                <span class="dolla_dolla_bill">
                                    $StudentRate
                                </span>
                            </li>
                        <% end_if %>

                        <% if $FacultyRate %>
                            <li>
                                <strong>UI departmental events:</strong>                <span class="dolla_dolla_bill">
                                    $FacultyRate
                                </span>

                            </li>
                        <% end_if %>

                        <% if $GeneralRate %>
                            <li>
                                <strong>General public events:</strong>                             <span class="dolla_dolla_bill">
                                    $GeneralRate
                                </span>

                            </li>
                        <% end_if %>
                        </ul>
                    
                    <% end_if %>

        

                    <% if $ContactInfo %>
                        <h2>Contact information</h2>
                        <p>$ContactInfo</p>
                    <% else_if $Parent.ID == 417 %>
                        <p>Make a reservation for this space by calling 319-335-3114 or emailing <a href="mailto:imu-eventservices@uiowa.edu">imu-eventservices@uiowa.edu</a>.</p>
                    <% else %>
                        <a href="event-services/reservations/" class="button button--large">Make a reservation</a>
                    <% end_if %>
                


                    <% if $ComplimentaryEquipmentProvided %>
                        <p>*Some items are provided in fee rooms in limited amounts for no charge: for a full list see our <a href="event-services/fees/"> A/V, Equipment, and Services page.  </p></a>
                    <% end_if %>

                    <% if $SocialDistancingOnly  %>
                        <p class="standard_setup_notice">Due to social distancing guidelines, the meeting room configuration and capacity cannot be changed.</p>
                    <% else %>
                        <% if $StandardCapacity && $ShowSetupChangeFee && $SetupChangeFee %>
                            <p class="standard_setup_notice">
                                * denotes a room's standard setup. Minimum setup change fee: 
                                <strong>$SetupChangeFee</strong>.
                            </p>
                        <% end_if %>
                    <% end_if %>
            
                <% if $ShowRoomLayout %>
                <h2>Available setups for {$Title}:</h2>


                    
                    <% if $TablesAndChairsCapacity %>

                        <img src="{$ThemeDir}/dist/images/room-setups/tables.png" alt="tables">
                        <h3>Banquet Rectangles</h3>
                        <p>
                            <strong> Capacity: </strong> $TablesAndChairsCapacity
                        </p>
                        
    
                    <% end_if %>

                    <% if $RoundedTablesCapacity %>
        

                            <img src="{$ThemeDir}/dist/images/room-setups/roundTables.png" alt="roundTables">

                        <h3>Banquet Rounds</h3>
                        <p>
                            <strong> Capacity: </strong> $RoundedTablesCapacity
                        </p>
                    
            
                    <% end_if %>

                    <% if $TheaterCapacity %>
                
                            <img src="{$ThemeDir}/dist/images/room-setups/theater.png" alt="theater">

                        <h3>Theater</h3>
                        <p>
                            <strong> Capacity: </strong> $TheaterCapacity
                        </p>
                    
            
                    <% end_if %>

                    <% if $ClassroomCapacity %>
            

                            <img src="{$ThemeDir}/dist/images/room-setups/classroom.png" alt="classroom">

                        <h3>Classroom</h3>
                        <p>
                            <strong> Capacity: </strong> $ClassroomCapacity
                        </p>
                    
            
                    <% end_if %>                                

                    <% if $UshapeCapacity %>
                

                        <img src="{$ThemeDir}/dist/images/room-setups/Ushape.png" alt="Ushape">
                        <h3>U-Shape</h3>
                        <p>
                            <strong> Capacity: </strong> $UshapeCapacity
                        </p>
                    
            
                    <% end_if %>

                    <% if $BoardroomCapacity %>
                
                        <img src="{$ThemeDir}/dist/images/room-setups/boardRoom.png" alt="boardRoom">
                        <h3>Board Room</h3>
                        <p>
                            <strong> Capacity: </strong> $BoardroomCapacity
                        </p>
                    
        
                    <% end_if %>
        
                <% end_if %>
            ]]>
            <% end_if %>      

        </content:encoded>
        <% if $ClassName == "SilverStripe\Blog\Model\BlogPost" %>
        <excerpt:encoded><% if $MetaDescription %><![CDATA[$MetaDescription]]><% else %><![CDATA[$ContentWxrFiltered.Summary.RAW]]><% end_if %></excerpt:encoded>
        <% end_if %>
        <wp:post_id>$ID</wp:post_id>

        <wp:post_date><![CDATA[$Created]]></wp:post_date>
        <wp:post_date_gmt><![CDATA[$Created]]></wp:post_date_gmt>
        <wp:comment_status><![CDATA[open]]></wp:comment_status>
        <wp:ping_status><![CDATA[open]]></wp:ping_status>
        <wp:post_name><![CDATA[$URLSegment]]></wp:post_name>
        <wp:status><![CDATA[publish]]></wp:status>
        <wp:post_parent>$ParentID</wp:post_parent>
        <wp:menu_order>$SortOrder</wp:menu_order>
        <% if $ClassName == "SilverStripe\Blog\Model\BlogPost" %>
            <wp:post_type><![CDATA[post]]></wp:post_type>
        <% else_if $ClassName == "NewsEntry" %>
             <wp:post_type><![CDATA[post]]></wp:post_type>
        <% else_if $ClassName == "StaffPage" %>
            <wp:post_type><![CDATA[staffpage]]></wp:post_type>
            <firstname>$FirstName $MiddleName</firstname>
            <lastname>$LastName</lastname>
            <phone>$Phone</phone>
            <email>$EmailAddress</email>
            <position>$Position</position>
        <% else_if $ClassName == "StaffMember" %>
            <wp:post_type><![CDATA[staffmembercustom]]></wp:post_type>
            <firstname>$FirstName</firstname>
            <lastname>$Surname</lastname>
            <phone>$StaffPhoneNumber</phone>
            <email>$StaffEmailAddress</email>
            <position>$StaffPosition</position>
        <% else %>
            <wp:post_type><![CDATA[page]]></wp:post_type>
        <% end_if %>
        <path>$Path</path>

        <% if $Categories %>
            <% loop $Categories %>
                <category domain="category" nicename="$URLSegment"><![CDATA[$Title]]></category>
            <% end_loop %>
        <% end_if %>
        <% if $Tags %>
            <% loop $Tags %>
                <category domain="post_tag" nicename="$URLSegment"><![CDATA[$Title]]></category>
            <% end_loop %>
        <% end_if %>

        </item>

<% end_loop %>

<% loop $Images %>
    <image>
        <title>$Alt</title>
        <wp:post_id>$PostID</wp:post_id>
        <wp:attachment_url>$AbsoluteURL</wp:attachment_url>
        <pubDate>$Created</pubDate>
    </image>

<% end_loop %>
<% loop $Files %>
    <file>
        <title>$Title</title>
        <wp:post_id>$PostID</wp:post_id>
        <wp:attachment_url>$AbsoluteURL</wp:attachment_url>
        <relative_url>$RelativeURL</relative_url>
        <pubDate>$Created</pubDate>
    </file>

<% end_loop %>
    </channel>
</rss>
