<li><a href="siteTreeReviewer/pageInspectorInterstitalInspect/{$ID}" target="site-tree-menu-item">$Title</a> <a href="siteTreeReviewer/pageInspectorInterstitalEdit/{$ID}" class="site-tree-button site-tree-edit" target="site-tree-menu-item"><i class="far fa-edit"></i></a> <a href="siteTreeReviewer/pageInspectorInterstitalView/{$ID}" class="site-tree-button" target="site-tree-menu-item"><i class="fas fa-globe"></i></a>
    <% if $AllChildren %>
        <ul>
            <% loop AllChildren %>
                <% include SiteTreeMenuItem %>
            <% end_loop %>
        </ul>
    <% end_if %>
</li>
