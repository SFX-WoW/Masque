## 10.0.1-Beta Release Notes

### General

- Added a new per-group skin scaling option that allows users to reduce/increase the size of the skin by up to 25%. (#264)
  - **Note:** This does _not_ change the size of the buttons, only the skin relative to the button.
- Moved the `Reset Skin` option to just below the `Skin` drop-down menu.
- Removed the `Classic Scaling` option.
- Reverted to the scaling method used prior to _Dragonflight_. This should alleviate scaling issues a lot of people are having. (#264)

### Bug Fixes

- Fixed an issue that could cause a mask to fail to be removed from a button if the skin isn't using it.
- Fixed an issue that could cause an error in add-ons using the default buttons. (#266)
- Fixed an issue that caused the `Cooldown` to be off by one pixel in some skins. (#265)

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
