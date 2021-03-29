
<!doctype html>
<html class="no-js" lang="en-us">

<head>
    <meta charset="utf-8">
    <title>Site Tree Reviewer - $SiteConfig.Title</title>
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto Condensed:regular,bold|Roboto:light,regular,bold,italic|Zilla Slab:regular,bold,italic" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
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
    </style>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h1>SiteTree Reviewer</h1>
                <div class="btn-group mb-2" role="group" aria-label="">
                  <a href="siteTreeReviewer/csvExport" class="btn btn-outline-primary">Export to CSV</a>
                  <a href="{$BaseURL}/wxrExport" class="btn btn-outline-secondary">Export to WordPress XML</a>
                </div>
                <p>Exported CSV files use the <a href="https://iowa-my.sharepoint.com/:x:/g/personal/bosto_uiowa_edu/Eb0r95BQ86tMlQvisrBBOeoBPiGNgYpGNIN6pcOxYsFr_A?e=6YMVFN" target="blank">Content Inventory spreadsheet template</a> columns.</a></p>
                <hr />
            </div>

        </div>
        <div class="row">
            <div class="col-lg-6">
                <h2>$SiteConfig.Title</h2>
                    <ul>
                    <% loop $Menu(1) %>
                        <% include SiteTreeMenuItem %>
                    <% end_loop %>
                    </ul>
            </div>
            <div class="d-none d-lg-block col-lg-6">
                <iframe class="vh-100 border border-secondary" name="site-tree-menu-item" src="{$absoluteBaseURL}" height="400" width="600" style="background-color: #eee" />
            </div>

        </div>
    </div>

</body>

</html>




