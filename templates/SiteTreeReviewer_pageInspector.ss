<!doctype html>
<html class="no-js" lang="en-us">

<head>
    <% base_tag %>
    <meta charset="utf-8">
    <title>SiteTree Reviewer - $SiteConfig.Title</title>
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto Condensed:regular,bold|Roboto:light,regular,bold,italic|Zilla Slab:regular,bold,italic" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/js/fontawesome.min.js"></script>
    <style>
    body {
        font-family: 'Roboto', sans-serif;
    }

    h1,
    .h1 {
        font-family: 'Zilla Slab', serif;
    }

    h2,
    .h2,
    h3,
    .h3,
    h4,
    .h4,
    h5,
    .h5,
    h6,
    .h6 {
        font-family: 'Zilla Slab', serif;
    }

    .main-photo {
        max-width: 100%;
    }

    .sitetree-container {
        font-size: 0.9em;

    }

    .site-tree-button {
        color: #222;
        font-size: 0.5em;
        border: 1px solid #333;
        padding: 0.3em;
        margin-right: 2px;
        text-decoration: none;
    }

    .untamed-imgs img{
        display: block;
        width: 100%;

    }

    </style>
</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 pt-4">
                <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
<%--     <li class="breadcrumb-item"><a href="siteTreeReviewer/"><i class="fas fa-tree"></i> SiteTree Reviewer</a></li> --%>
    <li class="breadcrumb-item active" aria-current="page"><i class="fas fa-info-circle"></i> Page Inspector</li>
    <li class="breadcrumb-item"><a href="siteTreeReviewer/pageInspector/{$Page.ID}" target="_blank" rel="noopener"> Open inspector in a new tab <i class="fas fa-external-link-alt"></i></a></li>
  </ol>
</nav>
                <h1>$Page.Title <small>($Page.ClassName)</small></h1>

                <p>URL: <a href="$Page.AbsoluteLink" target="_blank" rel="noopener">$Page.AbsoluteLink <i class="fas fa-external-link-alt"></i></a>
                    <br />

                    Site: <a href="$BaseURL">$SiteConfig.Title <i class="fas fa-external-link-alt"></i></a><br />
                    Last edited by: <a href="mailto:$RecentEditor.Email">$RecentEditor.FirstName $RecentEditor.LastName</a>
                </p>
                  <small>
                <p>         <a href="admin/pages/edit/show/{$Page.ID}" class="" target="_blank"><i class="far fa-edit"></i> Edit this page in SilverStripe</a></p>
                <p>              <% if $Page.NextPage %>Next page: <a href="siteTreeReviewer/pageInspector/{$Page.NextPage.ID}" >$Page.NextPage.Title</a><% if $Page.PreviousPage %><br /><% end_if %><% end_if %>

                    <% if $Page.PreviousPage %>Previous page: <a href="siteTreeReviewer/pageInspector/{$Page.PreviousPage.ID}">$Page.PreviousPage.Title</a>
                    <% end_if %>



                </p>
                <% if $Page.getAllChildren %>
                    <p>Child Page: <a href="siteTreeReviewer/pageInspector/{$Page.AllChildren.First.ID}" >$Page.AllChildren.First.Title</a></p>
                <% end_if %>
            </small>
                 <hr />
             </div>

         </div>

         <div class="row">

            <div class="col-lg-7">


                <div class="py-2">
                <h2>Inline files:</h2>

                <% if $FilesAttached %>
                 <div class="row">
                <% loop $FilesAttached %>
                    <div class="col-lg-4">
                        <a href="$AbsoluteURL" />$Filename</a>
                    </div>
                <% end_loop %>
                </div>

                <% else %>
                    <p>No inline files detected.</p>

                <% end_if %>
                </div>
                <div class="py-2">
                <h2>Images attached (upload fields):</h2>


                <% if $ImagesAttached %>
                      <div class="row">
                <% loop $ImagesAttached %>
                    <div class="col-lg-4">
                        <img src="$AbsoluteURL" alt="$Title" class="d-block w-100" />
                    </div>
                <% end_loop %>
                    </div>

                <% else %>
                    <p>No image attachments detected.</p>

                <% end_if %>
                </div>

                <h2>Inline images:</h2>


                <% if $ImagesInline %>
                      <div class="row">
                <% loop $ImagesInline %>
                    <div class="col-lg-4">
                        <img src="$AbsoluteURL" alt="$Title" class="d-block w-100" />
                    </div>
                <% end_loop %>
                    </div>

                <% else %>
                    <p>No inline images detected.</p>

                <% end_if %>
                <div class="py-2">
                    <h2>Block Images:</h2>
                    <% if $BlockImages %>
                          <div class="row">
                    <% loop $BlockImages %>
                        <div class="col-lg-4">
                            <img src="$AbsoluteURL" alt="$Title" class="d-block w-100" />
                        </div>
                    <% end_loop %>
                        </div>

                    <% else %>
                        <p>No block images detected.</p>

                    <% end_if %>
                </div>
                <hr />

<%--                 <pre class="bg-dark text-light p-3" style="height: 200px;">
                    $Page.Content.ATT
                    $Page.Policies.ATT
                </pre>
 --%>

                <h2>Content:</h2>


 $Page.Content
 $Page.Policies
                <hr />
            </div>



            <div class="col-lg-4 untamed-imgs">
                    <h2>Blocks: </h2>
                    <% if $Elements %>
                    <% loop $Elements %>
                    <h3>$Title ($ClassName)</h3>
                        $FeaturePagePhoto
                       $BackgroundPhoto
                       $Photo
                       $Image
                       <% loop SlideshowBlockImages %>
                            $Image
                            <p>$Caption</p>
                       <% end_loop %>
                       <% if $Heading %><p>Heading: $Heading</p>
                       <% if not $TaglineAlt %><p>Tagline: $SiteConfig.Tagline</p><% end_if %>
                       <% end_if %>
                       <% if $TaglineAlt %><p>Tagline: $TaglineAlt</p><% end_if %>
                        <% if $Content %><p>Content: $Content </p><% end_if %>

                        <% if PageTree %><p>Links to this page: <a href="$PageTree.AbsoluteLink">$PageTree.AbsoluteLink</a></p><% end_if %>
                        <% if $ExternalLink %><p>External Link: <a href="$ExternalLink">$ExternalLink</a></p><% end_if %>
                        $FeaturePageSummary
                        <% if $YoutubeEmbed %><p>YouTube embed: $YouTubeEmbed </p><% end_if %>
                       <hr />
                    <% end_loop %>
                    <% else %>

                    <p>No blocks on this page.</p>

                    <% end_if %>

            </div>

        </div>
        <div class="row">
            <div class="col-lg-12 text-center">
                                <p><% if $Page.PreviousPage %>Previous Page: <a href="siteTreeReviewer/pageInspector/{$Page.PreviousPage.ID}">$Page.PreviousPage.Title</a> <% if $Page.NextPage %>|<% end_if %><% end_if %>
                    <% if $Page.NextPage %>Next Page: <a href="siteTreeReviewer/pageInspector/{$Page.NextPage.ID}">$Page.NextPage.Title</a><% end_if %>


                </p>
            </div>
        </div>
    </div>
</body>

</html>
