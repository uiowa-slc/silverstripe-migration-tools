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
        <title><% if $LectureTitle %>$LectureTitle <% if $Lecturer %> - $Lecturer<% end_if %><% else_if $Lecturer %>$Lecturer<% else %>$Title<% end_if %></title>
        <link>$AbsoluteLink</link>
        <pubDate>$LastEdited</pubDate>
        <dc:creator><![CDATA[$Author.AdUsername]]></dc:creator>
        <guid isPermaLink="false">$AbsoluteLink</guid>
        <description></description>
        <content:encoded>

            <% if $ClassName == "LecturePage" %>
            <![CDATA[
             
                <% if $DonorByline %>
                    <p>$DonorByline</p>
                <% end_if %>
       
                <% if $HostedBy %>
                    <p>
                        <strong>Hosted by:</strong> $HostedBy
                    </p>
                <% end_if %>
                <p>
                <strong><% if $Cancelled %>Originally scheduled for:<% else %> Date:<% end_if %></strong> $EventDate.Format("MMMM d, Y"), $Time
                </p>
                <% if $Location %>
                    <p>
                        <strong>Location:</strong> $Location
                    </p>
                <% end_if %>
                <% if $StreamingLink && $isFuture %>
                    <p>
                        <% include StreamButton %>
                    </p>
                <% end_if %>

                <% if $Partnership %>
                    <p>
                        <strong>In partnership with:</strong> $Partnership
                    </p>
                <% end_if %>
                <% if $Donations %>
                    <p>
                        <strong>Support provided by:</strong> $Donations
                    </p>
                <% end_if %>
                 <% if $SponsoredBy %>
                    <p>
                        <strong>Sponsored by:</strong> $SponsoredBy
                    </p>
                <% end_if %> 
   

            <% if $TicketingInfo && $isFuture %>
                $TicketingInfo
            <% end_if %>
            $ContentWxrFiltered.RAW
                ]]>
            <% else_if $ClassName == "LectureHolderPage" %>
            <![CDATA[
                <ul>
                    <% loop $Years %>
                        <% if $Year %>
                            <li>$Year
                                <ul>
                                <% loop $Lectures %>
                                    <% if $LectureTitle %>
                                        <li>
                                            <a href="$Link">$LectureTitle.RAW - $Lecturer </a>
                                        </li>
                                    <% else %>
                                        <li>
                                            <a href="$Link">$Lecturer</a>
                                        </li>
                                    <% end_if %>
                                <% end_loop %>
                                </ul>
                            </li>
                        <% end_if %>
                    <% end_loop %>
                </ul>
            ]]>
            <% else %>
            <![CDATA[
                $ContentWxrFiltered.RAW
            ]]>
            <% end_if %>      

        </content:encoded>
        <% if $ClassName == "SilverStripe\Blog\Model\BlogPost" %>
        <excerpt:encoded><![CDATA[$ContentWxrFiltered.Summary.RAW]]></excerpt:encoded>
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
