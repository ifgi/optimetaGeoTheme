{**
 * templates/frontend/components/navigationMenu.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Primary navigation menu list for OJS
 *
 * @uses navigationMenu array Hierarchical array of navigation menu item assignments
 * @uses id string Element ID to assign the outer <ul>
 * @uses ulClass string Class name(s) to assign the outer <ul>
 * @uses liClass string Class name(s) to assign all <li> elements
 *}

{if $navigationMenu}

	{if $activeTheme->getOption('parentName') == 'defaultthemeplugin'}
	<ul id="{$id|escape}" class="{$ulClass|escape} pkp_nav_list">
		{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
			{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
				{continue}
			{/if}
			<li class="{$liClass|escape}">
				<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}">
					{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
				</a>
				{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
					<ul>
						{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
							{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
								<li class="{$liClass|escape}">
									<a href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
										{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
									</a>
								</li>
							{/if}
						{/foreach}
					</ul>
				{/if}
			</li>
		{/foreach}
		{if $activeTheme->getOption('mapPage')}
			{if $id === 'navigationPrimary'}
				<li class="{$liClass|escape}">
					<a href="{url page="{$optimetageo_mapUrlPath}" op=""}">
						{translate key="plugins.generic.optimetaGeo.journal.mapMenu"}
					</a>
				</li>
			{/if}
		{/if}
	</ul>
	{/if}

	{if $activeTheme->getOption('parentName') == 'materialthemeplugin'}
	{*
	 * Copyright (c) 2021 Madi Nuralin
	 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
	 *}
	<ul id="{$id|escape}" class="{$ulClass|escape} navbar-nav ml-auto">

		{foreach
			key=field
			item=navigationMenuItemAssignment
			from=$navigationMenu->menuTree}
			{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
				{continue}
			{/if}
			<li class="{$liClass|escape} nav-item">
				{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
					<div class="dropdown">
						<a
							href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}"
							class="dropdown-toggle nav-link"
							type="button"
							id="{$id|escape}"
							data-mdb-toggle="dropdown"
							aria-expanded="false" >
							{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
						</a>
						<ul
							class="dropdown-menu dropdown-menu-xxl-end dropdown-menu-light"
							aria-labelledby="{$id|escape}">
							{foreach
								key=childField
								item=childNavigationMenuItemAssignment
								from=$navigationMenuItemAssignment->children}
								{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
									<li class="{$liClass|escape}">
										<a
											href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}"
											class="dropdown-item">
											{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
										</a>
									</li>
								{/if}
							{/foreach}
						</ul>
					</div>
				{else}
					{assign var="url" value=$navigationMenuItemAssignment->navigationMenuItem->getUrl()}
					<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="nav-link">
						{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
					</a>
				{/if}
			</li>
		{/foreach}
		{if $activeTheme->getOption('mapPage')}
			{if $id === 'navigationPrimary'}
				<li class="{$liClass|escape} nav-item">
					<a class="nav-link" href="{url page="{$optimetageo_mapUrlPath}" op=""}" >
						{translate key="plugins.generic.optimetaGeo.journal.mapMenu"}
					</a>
				</li>
			{/if}
		{/if}
	</ul>
	{/if}

	{* https://github.com/pkp/pragma/blob/main/templates/frontend/components/navigationMenu.tpl *}
	{if $activeTheme->getOption('parentName') == 'pragmathemeplugin'}
	<ul id="{$id|escape}"{if $id==="navigationPrimary"} class="navbar-nav"{/if}>
		{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
			{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
				{continue}
			{/if}

			{* Check if menu item has submenu *}
			{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
				{assign var=hasSubmenu value=true}
			{else}
				{assign var=hasSubmenu value=false}
			{/if}
			<li class="{$navigationMenuItemAssignment->navigationMenuItem->getType()|lower} main-menu__nav-item{if $hasSubmenu} dropdown{/if} {pragma_item_active item=$navigationMenuItemAssignment->navigationMenuItem}">
				<a class="main-menu__nav-link"
				   href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" {if $hasSubmenu} role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"{/if}>
					<span{if $hasSubmenu} class="dropdown-toggle"{/if}>{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}</span>
				</a>
				{if $hasSubmenu}
					<ul class="dropdown-menu{if $id==="navigationUser"} dropdown-menu-right{/if}">
						{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
							{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
								<li class="{$liClass|escape} dropdown-item">
									<a href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
										{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
									</a>
								</li>
							{/if}
						{/foreach}
					</ul>
				{/if}
			</li>
		{/foreach}
			<li>test</li>
		{if $activeTheme->getOption('mapPage')}
			{if $id === 'navigationPrimary'}
				<li class="{$navigationMenuItemAssignment->navigationMenuItem->getType()|lower} main-menu__nav-item{if $hasSubmenu} dropdown{/if} {pragma_item_active item=$navigationMenuItemAssignment->navigationMenuItem}">
				<a class="main-menu__nav-link"
				   href="{url page="{$optimetageo_mapUrlPath}" op=""}">
					<span>{translate key="plugins.generic.optimetaGeo.journal.mapMenu"}</span>
				</a>
				</li>

				<li class="{$liClass|escape} nav-item">
					<a class="nav-link" href="" >
						
					</a>
				</li>
			{/if}
		{/if}
	</ul>
	{/if}
{/if} {* navigationMenu *}
