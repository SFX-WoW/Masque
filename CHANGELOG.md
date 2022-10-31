## 10.0.1-Beta Release Notes

### General

- Added a new per-group skin scaling option that allows users to increase or reduce the size of the skin by up to 25%. (#264)
  - **Note:** This does _not_ change the size of the buttons, only the skin relative to the button.
- Moved the `Reset Skin` option to just below the `Skin` drop-down menu.
- Removed the `Classic Scaling` option.
- Reverted to the scaling method used prior to _Dragonflight_. This should alleviate scaling issues a lot of people are having. (#264)

### Skins

- Added atlas support to the `Shadow` region.
- Fine-tuned item buttons in the _Default_ and _Default (Classic)_ skins.
- Reduced the size of the new _Default_ skin so that it scales properly. (#273)

### Localization

- Added three new Scale-related phrases.
- Removed the Classic Scaling phrases.
- Updated koKR. (Netaras)

### Bug Fixes

- Fixed an issue that caused the `Cooldown` to be off by one pixel in some skins. (#265)
- Fixed an issue that could cause a mask to fail to be removed from a button if the skin wasn't using it.
- Fixed an issue that could cause a region's texture coordinates to not be reset when using an atlas. (#276)
- Fixed an issue that could cause an error in add-ons using the default buttons. (#266)
- Fixed the `HotKey` alignment in the _Default (Classic)_ skin. (#268)
- Fixed the reagent bag using the wrong `Pushed` texture.
- The `HotKey` and `Duration` text regions should no longer extend beyond the button in the base skins. (#274)

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
