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
