[![OPTIMETA Logo](https://projects.tib.eu/fileadmin/_processed_/e/8/csm_Optimeta_Logo_web_98c26141b1.png)](https://projects.tib.eu/optimeta/en/)

# OPTIMETA Geo Plugin Theme

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.8199045.svg)](https://doi.org/10.5281/zenodo.8199045)

OJS child theme for extending OJS's default theme with views of the geospatial metadata for the OPTIMETA Geo Plugin, <https://github.com/TIBHannover/optimetaGeo>.

Based on <https://github.com/NateWr/defaultChild>.

**Issues are managed on the mein repository at TIBHannover/optimetaGeo.**

## Features

- Add spatial and temporal metadata (timeline & map) to **issue pages**

  The theme adds a wrapper that is filled from the plugin.

- Add a button in the **main menu for the journal-wide map**

## Making your theme compatible

This theme is a child theme overriding seleted components of the OJS frontend that need to be extended for the OPTIMETA Geo Plugin.
If your plugin overrides the same components, then the OPTIMETA Geo Plugin might not behave correctly.
Therefore, please open an issue with the label `theme` by [clicking this link](https://github.com/TIBHannover/optimetaGeo/issues/new?labels=theme) if you want to add support for your template - we will help you!

### Currently supported themes

- Default Theme Plugin, `defaultthemeplugin`
- [Material Theme Plugin](https://github.com/madi-nuralin/material), `materialthemeplugin`
- [Pragma Theme Plugin](https://github.com/pkp/pragma), `pragmathemeplugin`

## License

This project is published under GNU General Public License, Version 3.
Please check licenses of snippets from used themes.
