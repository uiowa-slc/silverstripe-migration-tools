<li><a href="$AbsoluteLink" target="site-tree-menu-item">$Title</a> <a href="admin/pages/edit/show/{$ID}" class="site-tree-button site-tree-edit d-none" target="_blank"><i class="far fa-edit"></i></a> <a href="" class="site-tree-button site-tree-adv-info d-none"><i class="fas fa-info-circle"></i></a>
    <% if $AllChildren %>
        <ul>
            <% loop AllChildren %>
                <% include SiteTreeMenuItem %>
            <% end_loop %>
        </ul>
    <% end_if %>
</li>
