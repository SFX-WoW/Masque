### 7.3.0 ###

**General**

  - ToC to 70300.

### 7.2.4 ###

**Bug Fixes**

  - Modified previous fixes that were conflicting with some add-ons.

### 7.2.3 ###

**Bug Fixes**

  - Added missing itIT and ptBR localization entries.
  - Replaced overrides with secure hooks to prevent taint in some add-ons.
  - Removed the HotKey override that hasn't been necessary in years.

### 7.2.2 ###

**General**

  - Users can now adjust the color of the cooldown swipe via Masque's options.
  - Users can now control the color of the border of equipped items via Masque's options, if using an add-on that supports it.
  - LibDualSpec-1.0 is no longer included with Masque. You'll need to download it separately if you want to use it.
  - Masque now supports masks for icons. This allows for a variety of new button shapes.
	- _Due the nature of this feature, users may experience "lag" or memory issues with skins using the mask feature. The PTR patch supposedly fixes these issues so if you do experience this, avoid those skins for now._

**Skins**

  - Added tentative support for icon masks implemented in patch 7.2. See _Masque: Cirque_ for implementation until the wiki is updated.
  - Added support for cooldown swipe textures and colors using the same format as other texture regions.
  - Added support for Border colors using the same format as other texture regions.

**API**

  - API version increased to 70200.
  - A third parameter, `IsActionBar`, is now available to the `:Group()` method. Setting this parameter to true will allow Masque (and by proxy, users) to adjust the color of equipped item borders.
	- _With this option enabled, Masque will override the Border region's `SetVertexColor` method of all buttons in this group. This is to prevent the game from changing the color. The functionality remains in a substitute method, `__MSQ_SetVertexColor`._
	- _This parameter must be passed on the initial `:Group()` call as its presence or absence in calls after the group has been created will have no effect. The group option `IsActionBar` must be explicitly set or unset if the group has already been created._

### 7.2.0 ###

**General**

  - ToC to 70200.

### 7.1.0 ###

**General**

  - ToC to 70100.

### 7.0.1 ###

**General**

  - ToC to 70000.
  - Updated Locales.
  - Adjust text positions.

### 6.2.1 ###

**General**

  - SVN to Git conversion.
  - Updated License and ReadMe.
  - Updated .pkgmeta.
 
**API**

  - API version 60201.
  - Renamed the "AutoCast" layer to the native name, "Shine".
      - Backwards compatibility available until game version 7.0.
  - Added support for ChargeCooldowns (tentative).
	  - A new API method, :UpdateCharge(Button) is available for add-ons that implement their own API for charges.

### 6.2.0 ###

**General**

  - ToC to 60200.

**API**

  - API version 60200.

### 6.1.0 ###

**General**

  - ToC to 60100.
  - Updated Locales.

**API**

  - API version 60100.

**Bug Fixes**

  - Fixed hiding of options frame on `Group:Delete()`. [A147]
  - Fixed inheritence for disabled groups. [A153]
  - Fixed "General" options group.
  - Fixed minimap option not appearing. [A154]

### 6.0.0 ###

**General**

  - ToC to 60000.
  - Removed legacy ButtonFacade support.
  - Options panel is always load-on-demand.

**API**

  - New API method `:UpdateSpellAlert()` to allow add-ons that handle their own spell alerts to have them updated by Masque.
  - The callback for an add-on registered with Masque will return a sixth parameter, set to true, if the group is disabled.
  - Removed the Static parameter for groups.
  - Removed the following legacy group methods:
      - `GetLayerColor`
	  - `AddSubGroup`
	  - `RemoveSubGroup`
	  - `SetLayerColor`
	  - `Skin`
	  - `ResetColors`

**Bug Fixes**

  - Fixed groups not being removed from the options panel. [A144]
  - Fixed options window not opening to the correct panel.

### 5.4.396 ###

**General**

  - ToC to 50400.

### 5.3.394 ###

**General**

  - ToC to 50300.

### 5.2.391 ###

**General**

  - ToC to 50200.

### 5.1.389 ###

**General**

  - ToC to 50100.

### 5.0.387 ###

**General**

  - ToC to 50001.
  - Updated version.
  - Allow no-lib packages.

### 4.3.382 ###

**General**

  - ToC to 40300.
  - Updated Locales.

**API**

  - New API method `:GetSpellAlert() to return the texture paths for the passed shape string.
  - Removed the Fonts feature.

**Bug Fixes**

  - Fixed the Background on Multibar buttons.
  - Fixed the Gloss showing on empty buttons.
  - Fixed 'Hotkey.SetPoint()'

### 4.2.375 ###

**General**

  - ToC to 40200.
  - Renamed ButtonFacade to Masque.
  - Added LibDualSpec support.
  - Added an option to disable groups.

**API**

  - Masque's API is accessed through `LibStub("Masque")`.
  - Added a debug mode.
  - Add-ons no longer need to save skin settings.
  - Renamed `:GetlayerColor()` to `GetColor()`.
  - Only hook check buttons for spell alert updates.

**Skins**

  - Cleaned up the default skin.
  - Skins can now use a random texture for the Normal layer.
  - Added a Duration layer.
  - Added Shape, Author, Version and Masque_Version attributes.

### 4.0.340 ###

**General**

  - ToC to 40000.

### 3.3.330 ###

**General**

  - Removed Border color support.
  - Miscellaneous fixes.

### 3.3.301 ###

**General**

  - ToC to 30300.
  - Updated Locales.

### 3.2.285 ###

**General**

  - Updated Locales.

### 3.2.275 ###

**General**

  - ToC to 30200.
  - Updated Locales.

### 3.1.270 ###

**General**

  - Removed the About panel.
  - Updated Locales.

### 3.1.260 ###

**API**

  - Removed module support.

### 3.1.255 ###

**General**

  - Add X-WoWI-ID.
  - More GUI fixes.
  - Updated Locales.

### 3.1.240 ###

**General**

  - GUI fixes.
  - Updated Locales.

### 3.1.235 ###

**General**

  - ToC to 30100.
  - Updated GUI.
  - Updated Locales.

### 3.1.225 ###

**General**

  - Added a new icon.
  - Updated Locales.

### 3.0.211 ###

**General**

  - Updated Locales.
  - Tag clean-up.

### 3.0.208 ###

**General**

  - Updated Locales.

### 3.0.205 ###

**General**

  - Updated Locales.

### 3.0.202 ###

**General**

  - Apply a fix for Border-less skins.

### 3.0.200 ###

**General**

  - Removed FuBar/Harbor support.
  - Rebuilt the options window.
  - The /bf and /buttonfacade chat commands now open the options window.
  - Updated Locales.
  - Code clean-up.
