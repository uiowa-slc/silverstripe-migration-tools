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

    <% loop $AllStaffTeams %>
    <wp:category>
        <wp:term_id>$ID</wp:term_id>
        <wp:category_nicename><![CDATA[$URLSegment]]></wp:category_nicename>
        <wp:category_parent><![CDATA[]]></wp:category_parent>
        <wp:cat_name><![CDATA[$Name]]></wp:cat_name>
    </wp:category>
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

    <% loop $Pages %>
        <item>
        <title>$Title</title>
        <link>$AbsoluteLink</link>
        <pubDate>$LastEdited</pubDate>
        <dc:creator><![CDATA[$Author.AdUsername]]></dc:creator>
        <guid isPermaLink="false">$AbsoluteLink</guid>
        <description></description>
        <content:encoded><![CDATA[$ContentWxrFiltered.RAW]]><![CDATA[$Policies.RAW]]><![CDATA[$StaffResearch.RAW]]>
            <![CDATA[<% if $WebsiteLink %><p><a href="$WebsiteLink" class="bttn bttn--primary bttn--caps" target="_blank"><% if $WebsiteLinkButtonText %>$WebsiteLinkButtonText<% else %>Visit Website<% end_if %> <span class="fa-arrow-right fas"></span></a></p><% end_if %>
                        <% if $FavoriteProject %>
                            <h2>Favorite SLC project and why?</h2>
                            $FavoriteProject
                        <% end_if %>

                        <% if $Interests %>
                            <h2>Interests</h2>
                            $Interests
                        <% end_if %>


                        <%-- student --%>
                        <% if $isStudent %>
                            <% if $DegreeDescription %>
                                <h2>Why I chose my degree</h2>
                                $DegreeDescription
                            <% end_if %>
                             <% if $TopStrengths %>
                                <h2>My top strengths</h2>
                                $TopStrengths
                            <% end_if %>

                            <% if $MDExperience %>
                                <h2>What I've learned from my experience at SLC</h2>
                                $MDExperience
                            <% end_if %>

                            <% if $PostGraduation %>
                                <h2>Plans after graduation</h2>
                                $PostGraduation
                            <% end_if %>
                         <% end_if %>

                        <%-- alumni --%>
                        <% if $inTeam("Alumni") %>
                            <% if $EmploymentLocation %>
                                <h2>Where I'm currently employed</h2>
                                <% if $EmploymentLocationURL %>
                                    <a href="$EmploymentLocationURL">$EmploymentLocation</a>
                                <% else %>
                                    $EmploymentLocation
                                <% end_if %>
                            <% end_if %>

                            <% if $CurrentPosition %>
                                <h2>My current position title</h2>
                                $CurrentPosition
                            <% end_if %>

                            <% if $FavoriteMemory %>
                                <h2>Favorite memory of SLC</h2>
                                $FavoriteMemory
                            <% end_if %>

                            <% if $Advice %>
                                <h2>What advice would you give to current students?</h2>
                                $Advice
                            <% end_if %>
                        <% end_if %>

                        <%-- Professional Staff --%>

                        <% if $inTeam("Professional Staff") %>
                            <% if $EnjoymentFactors %>
                                <h2>What I enjoy about working at SLC</h2>
                                $EnjoymentFactors
                            <% end_if %>

                            <% if $JoinDate %>
                                <h2>When I joined the SLC staff team</h2>
                                $JoinDate
                            <% end_if %>

                            <% if $Background %>
                                <h2>Background and education</h2>
                                $Background
                            <% end_if %>
                        <% end_if %>

                        <% if $FavoriteQuote %>
                            <h2>Favorite quote</h2>
                            <blockquote>$FavoriteQuote</blockquote>
                        <% end_if %>
                        <% if $InstagramHandle || $TwitterHandle || $LinkedInURL || $GithubURL || $PortfolioURL %>
                        <h2>Links:</h2>
                        <ul>
                            <% if $InstagramHandle %>
                                <li><a href="https://www.instagram.com/$InstagramHandle/">Instagram</a></li>
                            <% end_if %>
                            <% if $TwitterHandle %>
                                <li><a href="https://www.twitter.com/$TwitterHandle/">Twitter</a></li>
                            <% end_if %>
                            <% if $LinkedInURL %>
                                <li><a href="$LinkedInURL">LinkedIn</a></li>
                            <% end_if %>
                            <% if $GithubURL %>
                                <li><a href="$GithubURL">GitHub</a></li>
                            <% end_if %>
                            <% if $PortfolioURL %>
                                <li><a href="$PortfolioURL">Website</a></li>
                            <% end_if %>
                        </ul>
                        <% end_if %>]]>
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
            <% if not $inTeam("Alumni") %>
                <email>$EmailAddress</email>
            <% end_if %>
            <position><% loop $TeamsWithoutAlumni %>$TeamTitle<% if not $Last %>, <% end_if %><% end_loop %></position>
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
        <% if $Teams %>
            <% if $inTeam("Alumni") %>
                <category domain="category" nicename="alumni"><![CDATA[Alumni]]></category>
            <% else %>
                <% loop $Teams %>
                    <category domain="category" nicename="$URLSegment"><![CDATA[$Name]]></category>
                <% end_loop %>
            <% end_if %>
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
