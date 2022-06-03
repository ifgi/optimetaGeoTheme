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
		$this->setParent('defaultthemeplugin');
		//$this->modifyStyle('stylesheet', array('addLess' => array('styles/remove-borders.less')));
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
}

?>