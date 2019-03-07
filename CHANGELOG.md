## 8.1.0 (Alpha)

_**Warning:** This is an alpha version and may contain bugs._

### General

- Masque now has a new icon.
- This update has quite a few changes that will require localization updates.

### Options

- The options window has been updated.
  - The primary panel under the "Masque" header is now an information display and contains information about Masque and any installed skins.
  - The "Addons" panel has been more appropriately named "Skin Settings".
  - A new "General Settings" panel is available that contains interface and performance settings for Masque.
- The font size for all options panels has been increased.

### Skins

- The "Blizzard" skin has been renamed to "Classic".
- The "Zoomed" skin now has a background. (#44)
- The handling of Cooldown and Charge frames has been improved:
  - Added new higher quality, default textures.
    - These will change according to the shape set by the skin.
      - Only "Square" and "Circle" are supported.
  - Skins can now use custom Swipe textures.
  - This update puts Cooldown frames back above the button, so skins will need to be updated.

### Core API

- API Version updated to 80100.
- Added a new API method, `:DefaultSkin()`, that will return the default skin.

### Group API

- Added support for group renaming.
  - Only sub-groups with static IDs support this feature.
  - Added a fourth, `string` parameter, `"StaticID"`, to the `:Group()` method. This will be used internally by Masque instead of the `Group` parameter.
  - Added a new group method, `:SetName("Name")`. This will replace the group's `Group` field and update Masque's options.
- Added a new group method, `:SetCallback(func [, {arg}])`, that will allow callbacks to be registered at the group level.
  - This will allow add-ons to be notified on a per-group basis, rather than when _any_ group's settings have changed.
- The `:ReSkin()` method now has a`boolean` `Silent` parameter that when passed, will prevent the add-on/group's callback from being fired.
- The `:GetOptions()` method now accepts an `Order` parameter (`number`).

### Skin API

- A new panel has been implemented that displays information about skins. The following fields are available for skin tables and will be used in this panel:
  - `Description` - A short `string` description of the skin.
  - `Version` - The skin version (`number`).
  - `Author` - A `string` value for the author's name.
  - `Authors` - An _indexed_ `table` list of author names.
  - `Website` - A `string` value for the website URL.
  - `Websites` - An _indexed_ `table` list of website URLs.
  - `Group` - A `string` name of the group the skin belongs to. This will be automatically created for templated skins.
  - `Title` - A `string` title to be displayed instead of the `SkinID`. Requires `Group` to be set.
  - `Order` - An `number` indicating the order the skins should be displayed in. Requires `Group` to be set.
- Added basic support for the `IconBorder` and `IconOverlay` regions of item buttons.

### Bug Fixes/Improvements

- Functions registered as callbacks without a parent table will no longer pass `false` as the first argument.
- Fixed an issue that would cause groups to incorrectly inherit the wrong skin. (WeakAuras/WeakAuras2#1171)
- Fixed an issue that would cause buttons to be skinned with the default skin when changing groups. (#47)
- Groups registered prior to the `PLAYER_LOGIN` event will now be queued and skinned when that event fires. (#41)
- Fixed an issue with edge textures on round buttons. (#38)
- Fixed an issue that would cause the default cooldown count to appear below other text regions. (#19)
- Fixed an issue that caused Masque to attempt to skin newly-created groups.
- Fixed a missing entry for LibDualSpec-1.0.

### Feedback

For bug reports and suggestions, please use the [issue tracker](https://github.com/stormfx/masque/issues "Masque Issue Tracker") on GitHub.

### Localization

To help translate _Masque_, please use the [localization system](https://www.wowace.com/projects/masque/localization "Masque on WoW Ace") on WoW Ace or [contribute directly](https://github.com/stormfx/masque "Masque on GitHub") on GitHub.
