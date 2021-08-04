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
    <link>$BaseUrl</link>
    <description></description>
    <pubDate>Thu, 18 Feb 2021 20:33:25 +0000</pubDate>
    <language>en-US</language>
    <wp:wxr_version>1.2</wp:wxr_version>
    <wp:base_site_url>$BaseUrl</wp:base_site_url>
    <wp:base_blog_url>$BaseUrl</wp:base_blog_url>

    <% loop $Authors %>

        <wp:author><wp:author_id>$ID</wp:author_id><wp:author_login><![CDATA[$AdUsername]]></wp:author_login><wp:author_email><![CDATA[$Email]]></wp:author_email><wp:author_display_name><![CDATA[$AdUsername]]></wp:author_display_name><wp:author_first_name><![CDATA[$FirstName]]></wp:author_first_name><wp:author_last_name><![CDATA[$Surname]]></wp:author_last_name></wp:author>

    <% end_loop %>

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

<%--     <% loop $TagsCats %>
    <wp:term>
        <wp:term_id>$Pos</wp:term_id>
        <% if $ClassName == "BlogTag" %>
            <wp:term_taxonomy><![CDATA[tag]]></wp:term_taxonomy>
        <% else_if $ClassName == "BlogCategory" %>
            <wp:term_taxonomy><![CDATA[category]]></wp:term_taxonomy>
        <% end_if %>

        <wp:term_slug><![CDATA[$URLSegment]]></wp:term_slug>
        <wp:term_parent><![CDATA[]]></wp:term_parent>
        <wp:term_name><![CDATA[$Title]]></wp:term_name>
    </wp:term>
    <% end_loop %> --%>


    <generator>https://wordpress.org/?v=5.6.1</generator>

    <% loop $Pages %>
        <item>
        <title>$Title</title>
        <link>$AbsoluteLink</link>
        <% if $PublishDate %>
        <%-- <pubDate>Thu, 18 Feb 2021 20:29:19 +0000</pubDate> --%>
            <pubDate>$PublishDate</pubDate>
        <% else %>
           <pubDate>$LastEdited</pubDate>
        <% end_if %>
        <dc:creator><![CDATA[$Author.AdUsername]]></dc:creator>
        <guid isPermaLink="false">$AbsoluteLink</guid>
        <description></description>
        <content:encoded><![CDATA[$ContentWxrFiltered.RAW]]><![CDATA[$Policies.RAW]]><![CDATA[$StaffResearch.RAW]]></content:encoded>
        <excerpt:encoded><% if $MetaDescription %><![CDATA[$MetaDescription]]><% else %><![CDATA[$ContentWxrFiltered.Summary.RAW]]><% end_if %></excerpt:encoded>
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
        <% else_if $ClassName == "Topic" %>
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

        <wp:post_password><![CDATA[]]></wp:post_password>
        <wp:is_sticky>0</wp:is_sticky>

<%--         <% if $ImageLookup %>
             <wp:attachment_url><![CDATA[$ImageLookup.FitMax(2592,1458).AbsoluteURL]]></wp:attachment_url>
                                                        <wp:postmeta>
                    <wp:meta_key><![CDATA[_wp_attached_file]]></wp:meta_key>
                    <wp:meta_value><![CDATA[$ImageLookup.FitMax(2592,1458).AbsoluteURL]]></wp:meta_value>
                    </wp:postmeta>
                                        <wp:postmeta>
                    <wp:meta_key><![CDATA[_wp_attachment_metadata]]></wp:meta_key>
                    <wp:meta_value><![CDATA[a:5:{s:5:"width";i:$$ImageLookup.FitMax(2592,1458).Width;s:6:"height";i:$ImageLookup.FitMax(2592,1458).Height;s:4:"file";s:26:"$URL";a:0:{}}]]></wp:meta_value>
                    </wp:postmeta>
        <% end_if %> --%>
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

<% loop $Attachments %>
    <item>
        <wp:post_type><![CDATA[attachment]]></wp:post_type>
        <title>$Alt</title>
        <wp:post_id>$PostID</wp:post_id>
        <wp:attachment_url>$AbsoluteURL</wp:attachment_url>
        <pubDate>$Created</pubDate>
    </item>

<% end_loop %>
<% loop $Files %>
    <item>
        <wp:post_type><![CDATA[file]]></wp:post_type>
        <title>$Title</title>
        <wp:post_id>$PostID</wp:post_id>
        <wp:attachment_url>$AbsoluteURL</wp:attachment_url>
        <relative_url>$RelativeURL</relative_url>
        <pubDate>$Created</pubDate>
    </item>

<% end_loop %>
                </channel>
</rss>
