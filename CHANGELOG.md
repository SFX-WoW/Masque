## 9.0.4

### General

- Improved the handling of skin setting changes.
- Updated the `Interface` version for Retail to `90002`.
- Updated SFX Widgets.

### GUI

- Added an option to toggle the pulse effect on cooldown regions.

### API

- Increased the `API_VERSION` to `90002`.

### Group API

- The `:ReSkin()` method now accepts a button as a parameter that will cause only that button to be refreshed.
- The `:Disable()`, `:Enable()` and `:SetColor()` methods have been deprecated for external use.

### Skin API

- Added support for custom edge textures via the `EdgeTexture` attribute for cooldown regions.
  - `String` path to a custom edge texture.
  - Defaults to Masque's high-quality edge texture.
- Added support for custom pulse textures via the `PulseTexture` attribute for cooldown regions.
  - `String` path to a custom pulse texture.
  - Defaults to the game's "star" texture.
  - This texture cannot be recolored.
- Added an `IsRound` option to `Cooldown` regions that tells Masque to use circular textures.
- The `Masque_Version` attribute has been deprecated in favor of an `API_VERSION` attribute, for consistency.
- The third parameter, `Replace`, of the `:AddSkin()` method has been deprecated, as it's unnecessary.

### Localization

- Updated zhTW. (RainbowUI)

### Bug Fixes

- Custom spell alerts should now be properly applied to skins with a matching shape.
- Empty textures should now function properly for the `Normal` region on Action, Item and Pet Buttons.
- Fixed a bug that would cause a skin's default color to be saved to the user's profile when cancelling out of the color picker.
