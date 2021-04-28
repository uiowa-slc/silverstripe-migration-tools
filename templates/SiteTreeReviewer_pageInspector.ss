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
    .h5
    {
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
        height: 100%;

    }

    </style>
<script>
const codeInput = document.querySelector('#content-text-area');

// initialise the highlighted output with whatever is in the input
hljs.highlightBlock(codeInput);
</script>
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
               <%--      <br />

                    Site: <a href="$BaseURL">$SiteConfig.Title <i class="fas fa-external-link-alt"></i></a><br /> --%>
                </p>




                  <p>Last edited by: <a href="mailto:$RecentEditor.Email">$RecentEditor.FirstName $RecentEditor.LastName</a><br />
                    Linked files: <% if $FilesInline%><% loop $FilesInline %><a href="$AbsoluteURL" />$Filename</a><% if not $Last %>, <% end_if %><% end_loop %><% else %> No inline files detected.<% end_if %>
                </p>





                 <hr />
             </div>

         </div>

         <div class="row">

            <div class="col-lg-7">
                <% with $Page %>

                <% if $SubHeading || $ButtonUrlOne || $ButtonUrlTwo || $ButtonUrlThree %>
                           <h2>Hero Subheading + Buttons</h2>
                <div class="bg-dark text-light p-4">
                    <% if $HeroVideo %>
                    <p>Background video: <a class="text-light" href="$HeroVideo.AbsoluteURL">$HeroVideo.AbsoluteURL</a></p>

                    <% end_if %>

                    <% if $HeroImage %>
                    <p>Background image: <a class="text-light" href="$HeroImage.AbsoluteURL">$HeroImage.AbsoluteURL</a></p>
                    <% end_if %>
                    <% if $SubHeading %>

                        <p class="h2  text-center"><strong>$SubHeading</strong></p>
                    <% end_if %>
                    <p class="text-center text-light">
                    <% if $ButtonUrlOne %>
                        <a href="$ButtonUrlOne" class="btn btn-primary">$ButtonTextOne <i class="fas fa-arrow-right"></i></a>
                    <% end_if %>
                    <% if $ButtonUrlTwo %>
                        <a href="$ButtonUrlTwo" class="btn btn-primary">$ButtonTextTwo <i class="fas fa-arrow-right"></i></a>
                    <% end_if %>
                    <% if $ButtonUrlThree %>
                        <a href="$ButtonUrlThree" class="btn btn-primary">$ButtonTextThree <i class="fas fa-arrow-right"></i></a>
                    <% end_if %>
                </p>
                </div>
                <% end_if %>
                 <% end_with %>
                <% if $Page.ClassName == "HomePage" %>

                    <% if $NewHomePageHeroFeatures %>
                        <h2>Homepage Media Slides:</h2>

                        <% loop $NewHomePageHeroFeatures %>
                         <div class="py-2 untamed-imgs">
                            <% if $Image %>
                                $Image
                            <% end_if %>
                                <h3>$Title</h3>
                                $Content
                                <% if $ButtonText %>
                                    <% if $ExternalLink %>
                                        <a href="$ExternalLink" target="_blank" class="button warning">$ButtonText <i class="fas fa-arrow-right"></i></a>
                                    <% else %>
                                        <a href="$AssociatedPage.Link" class="button warning">$ButtonText <i class="fas fa-arrow-right"></i></a>
                                    <% end_if %>
                                <% end_if  %>
                                <hr />
                                     </div>
                        <% end_loop %>
                    <% end_if %>

                <% end_if %>


                </div>
                <% with $Page %>
                <% if $ClassName == "StaffPage" %>

                    <h2>$Position</h2>
                    <ul>
                        <% if $DisplayPronouns && $Pronouns || $OtherPronouns %>
                            <li>
                                <strong>Pronouns:</strong>

                                <ul>
                                <% loop $Pronouns %>
                                    <li>$Pronoun</li>
                                <% end_loop %>
                                <% if $OtherPronouns%>
                                    <li>$OtherPronouns</li>
                                <% end_if %>
                                </ul>
                            </li>
                        <% end_if %>
                        <% if $EmailAddress %><li><strong>Email:</strong> <a href="mailto:$EmailAddress">$EmailAddress</a></li><% end_if %>
                        <% if $Phone %><li><strong>Phone:</strong> $Phone</li><% end_if %>
                        <% if $DepartmentName %>
                            <li>
                                <% if $DepartmentURL %>
                                    <a href="$DepartmentURL" target="_blank">Department website</a>
                                <% else %>
                                    $DepartmentName
                                <% end_if %>
                            </li>
                        <% end_if %>
                        <% if $OtherWebsiteLink %>
                            <li><a href="$OtherWebsiteLink" target="_blank">
                                <% if $OtherWebsiteLabel %>
                                    $OtherWebsiteLabel
                                <% else %>
                                    Website
                                <% end_if %>
                            </a></li>
                        <% end_if %>
                    </ul>



                <% end_if %>
                <% end_with %>
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

                <h2>Content HTML:</h2>
<textarea onclick="this.focus();this.select()" id="content-text-area" class="text-light bg-dark" style="font-family: monospace; "name="" rows="4" cols="50" readonly>
$Page.Content.ATT
$Page.Policies.ATT
</textarea>
<h2>Content:</h2>
<div class="untamed-imgs">

<% with $Page %>
 $Content
 $Policies
                <% if $Teams %>
                <h3>Staff / Person Pages</h3>
                    <% loop $Teams %>
                        <h4 class="stafflist__title">$Title</h4>
                        <ul>
                            <% loop $SortedStaffPages %>
                                <li>

                                    <h5>$FullName</h5>
                                    <p><img src="$Photo.URL" /></p>
                                    <p>
                                        <% if $Position %><em class="stafflist__position">$Position</em>
                                        <% end_if %>
                                    </p>
                                </li>
                                $Content
                            <% end_loop %>

                        </ul>
                    <% end_loop %>
                <% else %><%-- end if teams --%>
                    <ul>
                        <% loop $Children %>
                            <li>
                                <h5>$FullName</h5>
                                <p><img src="$Photo.URL" /></p>

                                    <p>
                                        <% if $Position %><em class="stafflist__position">$Position</em>
                                        <% end_if %>
                                    </p>
                            </li>
                        <% end_loop %>
                    </ul>
                <% end_if %>


<% end_with %>






</div>
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
