<?php

/**
 * @file plugins/themes/optimetaGeoTheme/OptimetaGeoChildThemePlugin.inc.php
 *
 * Copyright (c) 2022 OPTIMETA project
 * Copyright (c) 2022 Daniel Nüst
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Theme to add geospatial content.
 */
import('lib.pkp.classes.plugins.ThemePlugin');

class OptimetaGeoChildThemePlugin extends ThemePlugin {
	/**
	 * Initialize the theme's styles, scripts and hooks. This is only run for
	 * the currently active theme.
	 *
	 * @return null
	 */
	public function init() {
		// this will segfault, probably because of infinite loop:
		// $themes = array_keys(PluginRegistry::loadCategory('themes', true));
		// going via generic plugin also did not work:
		// $plugin = PluginRegistry::getPlugin('generic', 'optimetageoplugin'); /* @var $plugin OptimetaGeoPlugin */
		// is null

		$this->addOption('parentName', 'text', [
			'label' => __('plugins.themes.optimetaGeoTheme.parent.label'),
			'description' => __('plugins.themes.optimetaGeoTheme.parent.description'),
			'default' => 'defaultthemeplugin'
		]);
		$parentName = $this->getOption('parentName');

		$this->addOption('mapPage', 'FieldOptions', [
			'label' => __('plugins.themes.optimetaGeoTheme.mapPage.label'),
			'description' => __('plugins.themes.optimetaGeoTheme.mapPage.description'),
			'type' => 'checkbox',
			'options' => [
				[
					'value' => true,
					'label' => __('plugins.themes.optimetaGeoTheme.mapPage.option'),
				],
			],
			'default' => true,
		]);

		$this->setParent($parentName);

		// pragma uses this, and Smarty won't compile template without it
		HookRegistry::register ('TemplateManager::display', array($this, 'checkCurrentPage'));
	}

	/**
	 * Get the display name of this plugin
	 * @return string
	 */
	function getDisplayName() {
		return __('plugins.themes.optimetaGeoTheme.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription() {
		return __('plugins.themes.optimetaGeoTheme.description');
	}

	/**
	 * From: https://github.com/pkp/pragma/blob/main/PragmaThemePlugin.inc.php
	 * 
	 * @param $hookname string
	 * @param $args array
	 */
	public function checkCurrentPage($hookname, $args) {
		$templateMgr = $args[0];
		// TODO check the issue with multiple calls of the hook on settings/website
		if (!isset($templateMgr->registered_plugins["function"]["pragma_item_active"])) {
			$templateMgr->registerPlugin('function', 'pragma_item_active', array($this, 'isActiveItem'));
		}

	}

	/**
	 * From: https://github.com/pkp/pragma/blob/main/PragmaThemePlugin.inc.php
	 * 
	 * @param $params array
	 * @param $smarty Smarty_Internal_Template
	 * @return string
	 */
	public function isActiveItem($params, $smarty) {
		$navigationMenuItem = $params['item'];
		$emptyMarker = '';
		$activeMarker = ' active';

		// Get URL of the current page
		$request = $this->getRequest();
		$currentUrl = $request->getCompleteUrl();
		$currentPage = $request->getRequestedPage();

		if (!($navigationMenuItem instanceof NavigationMenuItem && $navigationMenuItem->getIsDisplayed())) {
			if (is_string($navigationMenuItem)) {
				$navigationMenuItemIndex = preg_replace('/index$/', '', $navigationMenuItem);
				$navigationMenuItemSlash = preg_replace('/\/index$/', '', $navigationMenuItem);
				if ($navigationMenuItem == $currentUrl || $navigationMenuItemIndex == $currentUrl || $navigationMenuItemSlash == $currentUrl) {
					return $activeMarker;
				} else {
					return $emptyMarker;
				}
			} else {
				return $emptyMarker;
			}
		}

		// Do not add an active marker if it's a dropdown menu
		if ($navigationMenuItem->getIsChildVisible()) return $emptyMarker;

		// Retrieve URL and its components for a menu item
		$itemUrl = $navigationMenuItem->getUrl();

		// Check whether menu item points to the current page
		switch ($navigationMenuItem->getType()) {
			case NMI_TYPE_CURRENT:
				$issue = $smarty->getTemplateVars('issue');
				if ($issue && $issue->getCurrent() && $currentPage == "issue") return $activeMarker;
				break;
			default:
				if ($currentUrl === $itemUrl) return $activeMarker;
				break;
		}

		return $emptyMarker;
	}

}
