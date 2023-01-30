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
        <% if not $AudioClip %>
        <item>
        <title>$Title</title>
        <link>$AbsoluteLink</link>
        <pubDate>$LastEdited</pubDate>
        <dc:creator><![CDATA[$Author.AdUsername]]></dc:creator>
        <guid isPermaLink="false">$AbsoluteLink</guid>
        <description></description>
        <content:encoded>

            <% if $ClassName == "SilverStripe\Blog\Model\BlogPost" %>
            <![CDATA[
             <% if $Credits %>
                <p>By <% loop $Credits %>$Name.XML<% if not $Last %>, <% end_if %><% end_loop %></p>
                <% end_if %>
             
                    $ContentWxrFiltered.RAW
                ]]>
            <% else_if $ClassName == "NewsEntry" %>
            <![CDATA[
            <% if $FeaturedImageCaption %>
                <p class="featured-image-caption">Image caption: $FeaturedImageCaption</p>
            <% end_if %>
                <% if $Credits %><p>By <% loop $Credits %><% if not $First && not $Last %>, <% end_if %><% if not $First && $Last %><span class="byline__and">&nbsp;and </span><% end_if %><span class="byline__author">$Name.XML</span><% end_loop %></p>
                    <% end_if %>
                    <% if not $Credits && $StoryBy %>
                        <p><span class="byline__by">By </span>
                        <% if $StoryByEmail %>
                            <a href="mailto:$StoryByEmail">$StoryBy</a><% if $StoryByTitle || $StoryByDept %>,<% end_if %>
                        <% else %>
                            $StoryBy<% if $StoryByTitle || $StoryByDept %>,<% end_if %>
                        <% end_if %>
                        <% if $StoryByTitle %>$StoryByTitle<% end_if %>
                        <% if $StoryByDept %>$StoryByDept<% end_if %>
                        </p>
                    <% end_if %>
                    <% if $PhotosBy %><span class="byline__media">Media by <% if $PhotosByEmail %><a href="mailto:$PhotosByEmail">$PhotosBy</a><% else %>$PhotosBy<% end_if %></span><% end_if %>
                <% if $ExternalURL %>
                    <p><a class="bttn bttn--caps bttn--primary" href="$ExternalURL">Read this story on Iowa Nowspan class="fa-arrow-right fas"></span></a></p>

                <% end_if %>
                $ContentWxrFiltered.RAW
            ]]>

            <% else_if ClassName == "PolicyHolder" %>
            <![CDATA[
                <% if $PolicyYear %>
                    <p> Note: These policies are from the <strong>$PolicyYear academic year</strong>. Some policies that reside on other websites have not been archived. <br /><a href="/policies/" class="btn">View current policies &rarr;</a></p>
                <% end_if %>

                $ContentWxrFiltered.RAW

                $Policies
                 ]]>
            <% else_if ClassName == "PolicyPage" %>
            <![CDATA[
                <% if $Parent.PolicyYear %>
                    <p> Note: These policies are from the <strong>$Parent.PolicyYear academic year</strong>. Some policies that reside on other websites have not been archived. <br /><a href="/policies/" class="btn">View current policies &rarr;</a></p>
                <% end_if %>
                
                $ContentWxrFiltered.RAW

            ]]>
            <% else_if $ClassName == "DepartmentPage" %>
                <![CDATA[

                    <% if $OrganizationalUnit %><p>$OrganizationalUnit</p><% end_if %>
                    $Content
                    <% if $WebsiteURL %>

                        <p>
                            <a class="bttn bttn--caps bttn--primary" href="$WebsiteURL" >Visit website <span class="fa-arrow-right fas"></span></a>
                        </p>
                    <% end_if %>

                    $ContentWxrFiltered.RAW

                    <div class="dept-stats">
                        <div class="row">
                            <div class="column">
                                <h2><% if $KeyStatTitle %>$KeyStatTitle<% else %>Key Statistics<% end_if %></h2>
                            </div>
                        </div>
                        <div class="stat-cards">
                            <% if $KeyStat1Num %>
                            <div class="stat-card">
                                <div class="stat-card__digit">$KeyStat1Num</div>
                                <div class="stat-card__text">$KeyStat1Body</div>
                            </div>
                             <% end_if %>
                             <% if $KeyStat2Num %>
                            <div class="stat-card">
                                <div class="stat-card__digit">$KeyStat2Num</div>
                                <div class="stat-card__text">$KeyStat2Body</div>
                            </div>
                             <% end_if %>
                             <% if $KeyStat3Num %>
                            <div class="stat-card">
                                <div class="stat-card__digit">$KeyStat3Num</div>
                                <div class="stat-card__text">$KeyStat3Body</div>
                            </div>
                            <% end_if %>
                        </div>
                    </div>
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
        <% end_if %>
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
