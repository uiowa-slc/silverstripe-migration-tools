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
    .sitetree-container{
font-size: 0.9em;

    }
    .site-tree-button{
        color: #222;
        font-size: 0.5em;
        border: 1px solid #333;
        padding: 0.3em;
        margin-right: 2px;
        text-decoration: none;
    }
    </style>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-lg-12 pt-4">
                <nav aria-label="breadcrumb">

</nav>
                <h1><i class="fas fa-tree"></i> SiteTree Reviewer</h1>
                <div class="btn-group mb-2" role="group" aria-label="">
                    <a href="siteTreeReviewer/csvExport" class="btn btn-outline-primary"><i class="fas fa-file-csv"> Export to CSV </i></a>
                    <a href="wxrExport/" class="btn btn-outline-secondary"><i class="far fa-file-archive"></i> Export to WordPress XML </a>
                </div>
                <p>Exported CSV files use the <a href="https://iowa-my.sharepoint.com/:x:/g/personal/bosto_uiowa_edu/Eb0r95BQ86tMlQvisrBBOeoBPiGNgYpGNIN6pcOxYsFr_A?e=6YMVFN" target="blank">Content Inventory spreadsheet template</a> columns.</a></p>
                <hr />
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4">
                <h2>$SiteConfig.Title</h2>
                <p>Recent editors:
                    <% loop RecentEditors %><a href="mailto:$Email">$FirstName $Surname</a><% if not $Last %>,
                    <% end_if %>
                    <% end_loop %>
                </p>
                <div class="sitetree-container">
                    <ul>
                        <% loop $Menu(1) %>
                        <% include SiteTreeMenuItem %>
                        <% end_loop %>
                    </ul>
                </div>
            </div>
            <div class="col-lg-7 offset-lg-1">
                <iframe class="vh-100 border-none" name="site-tree-menu-item" src="siteTreeReviewer/pageInspectorInterstitalInspect/home" height="400" width="100%" style="border: 1px solid #ccc; background-color: #eee" />
            </div>
        </div>
    </div>
</body>

</html>
