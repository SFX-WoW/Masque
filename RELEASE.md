### 7.2.1 ###

**General**

  - Users can now adjust the color of the cooldown swipe via Masque's options.
  - Users can now control the color of the border of equipped items via Masque's options, if the supporting add-on allows it.
  - LibDualSpec-1.0 is no longer included with Masque. You'll need to download it separately if you want to use it.
  - Masque now supports masks for icons. This allows for a variety of new button shapes.
	- _Due the nature of this feature, users may experience "lag" or memory issues with skins using the mask feature. The PTR patch supposedly fixes these issues so if you do experience this, avoid those skins for now._

**Skins**

  - Added tentative support for icon masks implemented in patch 7.2. See _Masque: Cirque_ for implementation until the wiki is updated.
  - Added support for cooldown swipe textures and colors using the same format as other texture regions.
  - Added support for Border colors using the same format as other texture regions.

**API**

  - API version increased to 70200.
  - Masque now overrides Border region's `SetVertexColor` method. Add-on authors who use custom Border coloring can disable this feature at the group level by setting the group's `BorderSVC` variable to `true` prior to adding buttons to the group. Alternatively, they can use the new method `__MSQ_SetVertexColor`.
