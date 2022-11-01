## 10.0.1 Release Notes

### General

- Added a new per-group skin scaling option that allows users to increase or reduce the size of the skin by up to 25%. (#264)
  - **Note:** This does _not_ change the size of the buttons, only the skin relative to the button.
- Masque will now fully load its options when the Options/Settings panel is opened.
  - **Note:** This should prevent issues with some of _Masque_'s options panels not loading correctly.
- Moved the `Reset Skin` button to just below the `Skin` drop-down menu.
- Removed the `Classic Scaling` option.
- Removed the `Load Options` button and its associated elements.
- Reverted to the scaling method used prior to _Dragonflight_. This should alleviate scaling issues a lot of people are having. (#264)

### Skins

- Added atlas support to the `Shadow` region.
- Fine-tuned item buttons in the `Default` and `Default (Classic)` skins.
- Reduced the size of the new `Default` skin so that it scales properly. (#273)

### Localization

- Added three new scale-related phrases.
- Removed phrases related to the `Classic Scaling` option.
- Removed phrases related to the `Load Options` button.
- Updated `koKR`. (Netaras)
- Updated `zhTW`. (BNS333)

### Bug Fixes

- Fixed an issue that caused the `Cooldown` to be off by one pixel in the `Default (Classic)` skin. (#265)
- Fixed an issue that could cause a mask to fail to be removed from a button if the skin wasn't using it.
- Fixed an issue that could cause a region's texture coordinates to not be reset when using an atlas. (#276)
- Fixed an issue that could cause an error in add-ons using the default buttons. (#266)
- Fixed the `HotKey` alignment in the `Default (Classic)` skin. (#268)
- Fixed the reagent bag using the wrong `Pushed` texture.
- The `HotKey` and `Duration` text regions should no longer extend beyond the button in the base skins. (#274)

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
