<li><a href="$AbsoluteLink" target="site-tree-menu-item">$Title</a>
    <% if $AllChildren %>
        <ul>
            <% loop AllChildren %>
                <% include SiteTreeMenuItem %>
            <% end_loop %>
        </ul>
    <% end_if %>
</li>
