## 10.0.0-Beta

### Release Notes

**Notice:** This release is an _Beta_ release and therefore may contain unexpected bugs and/or errors. Please report any issues appropriately on [GitHub](https://github.com/SFX-WoW/Masque "Masque @ GitHub").

#### Known Issues

- _**Bartender4**_
  - Pet Bar buttons may not skin correctly when using the new "Default" skin.
  - _Bartender4_ will migrate your layout to compensate for the size increase of action buttons. A side effect of this is that buttons skinned with _Masque_ may be scaled smaller (or larger). To correct this, users will need to adjust the scale and padding in _Bartender4_ and then reposition those bars.
- These notes will be updated as needed.

#### General

- Added support for _Dragonflight_.
- Removed the _TBC Classic_ ToC file.
- The stand-alone _Options_ window is now enabled by default.
- Update _Masque_'s icon.
- Updated the `Interface` version for _Retail_ to `100000`.
- Update the _Supporters_ panel.

#### Skins

- Added a new "Default" skin that mimics the new interface in _Dragonflight_.
  - Note: This skin is unavailable in _Classic_ due to missing assets.
- Most skins will need to be updated. Most notably is the remove of the Backpack icon in Dragonflight. Skin authors will need to create a custom `Normal` texture for that. An example is available in the "Default (Classic)" skin.
- The original "Default" skin has been renamed to "Default (Classic)".
  - Note: Skin authors using the old "Default" skin as a template will need to update their skins.
- Updated all skins to support various changes.

#### API

- API version increased to `100000`.
- Added skin support for the `Anchor` attribute which allows a layer to be anchored to a region (eg, the icon) rather than the button. The value of this attribute must be a string that matches a table key for the regions table or the button itself.
  - This helps to alleviate issues with the positioning of text regions on buttons that are larger than their skin.
- Added five new button types, `Backpack`, `BagSlot`, `Possess`, `ReagentBag` and `Stance`.
- Added atlas support to various regions.
- Implemented a fail-safe for buttons that qualify as a sub-type but are passed as a base type.
- Implemented a fail-safe for add-ons that use custom `Normal` textures.
- Improved the skinning of masks.
- Improved the type-handling for buttons so that the base type will act as a fallback for sub-types. This will remove the need for skins to declare sub-types that have the same skin settings as the base type. The hierarchy is as follows:
  - `Action`
    - `Pet`
    - `Possess`
    - `Stance`
  - `Item`
    - `Backpack`
    - `BagSlot`
    - `ReagentBag`
  - `Aura`
    - `Buff`
    - `Debuff`
    - `Enchant`
  - In addtion, the `ReagentBag` type will fallback to the `BagSlot` type before falling back to `Item`.

#### Localization

- Added a missing `deDE` entry.
- Updated `koKR`. (Netaras)
- Updated `zhTW`. (BNS333)

#### Bug Fixes

- Fixed an issue that prevented bag buttons from being properly detected as item buttons in _Classic_.
- Fixed an issue with `LibDualSpec-1.0` being unavailable in _Wrath Classic_.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
