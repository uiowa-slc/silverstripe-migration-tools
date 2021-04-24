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
    <div class="container-fluid text-center">
        <div class="row">
            <div class="col-lg-12">

                <div style="position: relative;">
                <div class="py-2 btn-group text-center" role="group" aria-label="Toolbar" style="">
                <a href="siteTreeReviewer/pageInspectorInterstitalView/{$Page.ID}" class="btn btn-primary <% if $Action == "view" %>active<% end_if %>"><i class="fas fa-globe"></i> View</a>
                  <a href="siteTreeReviewer/pageInspectorInterstitalEdit/{$Page.ID}"  class="btn btn-primary <% if $Action == "edit" %>active<% end_if %>"><i class="far fa-edit"></i> Edit</a>

                  <a href="siteTreeReviewer/pageInspectorInterstitalInspect/{$Page.ID}" class="btn btn-primary <% if $Action == "inspect" %>active<% end_if %>"><i class="fas fa-info-circle"></i> Inspect</a>
                </div>
                    <iframe class="vh-100 border-none" name="site-tree-menu-item" src="{$Link}" height="400" width="100%" style="background-color: #eee" />
                </div>
            </div>

         </div>

    </div>
</body>

</html>
