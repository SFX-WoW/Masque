## 8.1.3 (Alpha)

_**Warning:** This is an alpha version and may contain bugs._

### General

- _Masque_ now has a new icon.
- This update contains extensive changes that will require add-on, skin and localization updates. Please make sure that your add-ons and skins have been updated _before_ reporting issues.

### Options

- The options window has been updated.
  - The primary panel under the _"Masque"_ header is now an information display and contains information about _Masque_ and any installed skins.
  - The "Addons" panel has been more appropriately named "Skin Settings".
  - A new "General Settings" panel is available that contains interface and performance settings for _Masque_.
- The font size for all options panels has been increased.
- The "Gloss" option now has a toggle and color picker.
- Options that are unavailable due to skin settings will now be hidden.
- A new option, "Shadow", is available for skins that provide them.
- A new option, "Clean Database", is available in the "Developer" panel that will purge the settings of unused add-ons and groups.
- Masque now has an optional, stand-alone GUI.

### Skins

- The "Blizzard" skin has been renamed to "Classic".
- The "Classic", "Dream" and "Zoomed" skins have all been updated, including a slight increase in size to be more in line with the default button size.
- The "Zoomed" skin now has a background. (#44)
- The handling of Cooldown and Charge frames has been improved:
  - Added new, higher-quality, default textures that will change according to the shape set by the skin.
    - Only "Square" and "Circle" are supported.

### Core API

- API Version updated to 80100.
- A new API method, `:DefaultSkin()`, is available that will return the default skin.
- A new API method, `:GetShadow({Button})`, is available that will return the `Shadow` region for a button.
- A new API method, `:SetEmpty({Button} [, IsEmpty])`, is available that will tell _Masque_ whether a button has an icon, allowing it to apply different skin settings.
- The third parameter of the `:Group()` API method, `IsActionBar`, has been replaced with a new `string` parameter, `"StaticID"`. This will be used internally by _Masque_ instead of the `"Group"` parameter.
- The signature for callbacks has been updated. The new signature is as follows:
  - If `arg` is passed when registered: `Callback(arg, Group, SkinID, Backdrop, Shadow, Gloss, Colors, Disabled)`
  - If no `arg` is passed when registered: `Callback(Group, SkinID, Backdrop, Shadow, Gloss, Colors, Disabled)`

### Group API

- The `AddButton()` Group method now has a third, `string` parameter, `"Type"`, that will tell _Masque_ the type of button being passed.
  - If not passed, _Masque_ will attempt to determine the `"Type"` by checking for specific regions. If none are found, it will default to `"Legacy"`.
  - _Masque_ will use this value to determine which regions to search for, if unavailable in the `Regions` (`ButtonData`) table, and which regions to apply skins to when skinning a button.
  - The following are valid values:
    - `"Legacy"` - This is fall-back type for backwards compatibility. It supports most regions previously supported by _Masque_. Only use this value if the other types don't cover all necessary regions.
    - `"Action"` - Supports regions available in `ActionButtonTemplate` and its derivatives (`PetAction`, etc).
    - `"Item"` - Supports regions available in `ItemButtonTemplate` and its derivatives (`ContaineFrameItem`, etc).
      - `Border` is still available due to the skinning limitatons of `IconBorder`.
    - `"Aura"` - Supports regions available in `AuraButtonTemplate` plus `Border`.
      - Can be used for generic "Aura" buttons.
    - `"Debuff"` - Same as `"Aura"`, but a different default texture with no skin color support.
    - `"Enchant"` - Same as `"Aura"`, but a different default texture and supports skin colors.
- The `AddButton()` Group method now has a fourth, `boolean` parameter, `Strict`, that if set to `true` will cause Masque to skip locating missing regions.
- Groups can now be renamed.
  - Only sub-groups with static IDs support this feature. (See the Core API section above)
  - A new method, `:SetName("Name")`, is available that will replace the group's `Group` field and update _Masque_'s options.
- A new method, `:SetCallback(func [, {arg}])`, is available that will allow callbacks to be registered at the group level. This will allow add-ons to be notified on a per-group basis, rather than when _any_ group's settings have changed.
- The `:ReSkin()` method now has a`boolean` `Silent` parameter that when set to `true`, will prevent the add-on/group's callback from being fired.
- The `:GetOptions()` method now accepts an `Order` parameter (`number`).

### Skin API

- A new panel has been implemented that displays information about skins. The following fields are available for skin tables and will be used in this panel:
  - `Description` - A short `string` description of the skin.
  - `Version` - The skin version (`number`).
  - `Author` - A `string` value for the author's name.
  - `Authors` - An _indexed_ `table` list of author names.
  - `Website` - A `string` value for the website URL.
  - `Websites` - An _indexed_ `table` list of website URLs.
  - `Group` - A `string` name of the group the skin belongs to, when using skin variations. This will be automatically created for templated skins.
  - `Title` - A `string` title to be displayed instead of the `SkinID`. Requires `Group` to be set.
  - `Order` - An `number` indicating the order the skins should be displayed in. Requires `Group` to be set.
- Skins can now use custom Cooldown swipe textures.
- Skins can now customize the following button regions:
  - _ActionButton_
    - `"NewAction"` - Texture, Color, Size, Position
    - `"SpellHighlight"` - Texture, Color, Size, Position
  - _ItemButton_
    - `"IconBorder"` - Size, Position
    - `"SlotHighlight"` - Texture, Color, Size, Position
    - `"IconOverlay"` - Size, Position
    - `"NewItem"` - Texture, Color, Size, Position
    - `"SearchOverlay"` - Texture and/or Color, Size, Position
    - `"ContextOverlay"` - Texture and/or Color, Size, Position
- Skins can now use the following settings:
  - `DrawLayer` `string` - The layer to place the region.
  - `DrawLevel` `number` - The level to place the region.
  - `Point` `string` - The point of the region to anchor to the button.
  - `RelPoint` `string` - The point of the button where `Point` will be anchored. Defaults to `Point`.
  - `SetAllPoints` `boolean` - Fits the region to the button.
  - For details on these settings, check the API documentation online.
- The following regions can now use the `boolean` `UseColor` setting that, when set to `true`, will cause _Masque_ to use a color square instead of a texture:
  - `Backdrop`
  - `Pushed`
  - `Flash`
  - `SearchOverlay`
  - `ContextOverlay`
- Using a `Gloss` or `Shadow` texture no longer requires a `Normal` texture.
- The `Border` layer can now have nested skins for each button type. (See the Group API section above for a list of types)
- Most regions have been restored to their default positions. This will require updates to most skins.
- Most skin settings now have default values stored internally by _Masque_. Any settings not specified will fall back to these values.

### Bug Fixes/Improvements

- _Masque_ will now exit out of the `:SetNormalTexture()` hook of buttons that no longer belong to a group.
- _Masque_ no longer adjusts the frame levels of buttons or their child frames.
- Functions registered as callbacks without an `arg` `table` will no longer pass `false` in place of `arg`.
- Groups registered prior to the `PLAYER_LOGIN` event will now be queued and skinned when that event fires. (#41)
- Fixed an issue that would cause groups to incorrectly inherit the wrong skin. (WeakAuras/WeakAuras2#1171)
- Fixed an issue that would cause buttons to be skinned with the default skin when changing groups. (#47)
- Fixed an issue with edge textures on round buttons. (#38)
- Fixed an issue that would cause the default cooldown count to appear below other text regions. (#19)
- Fixed an issue that caused _Masque_ to attempt to skin newly-created groups.
- Fixed a missing entry for LibDualSpec-1.0.

### Feedback

For bug reports and suggestions, please use the [issue tracker](https://github.com/stormfx/masque/issues "Masque Issue Tracker") on GitHub.

### Localization

To help translate _Masque_, please use the [localization system](https://www.wowace.com/projects/masque/localization "Masque on WoW Ace") on WoW Ace or [contribute directly](https://github.com/stormfx/masque "Masque on GitHub") on GitHub.
