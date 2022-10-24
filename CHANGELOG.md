## 10.0.0-Alpha

### Release Notes

**Notice:** This release is an _alpha_ release and therefore may contain unexpected bugs and/or errors. Please report any issues appropriately on [GitHub](https://github.com/SFX-WoW/Masque "Masque @ GitHub").

- This release is only compatible with _Dragonflight_ and the _Classic_ versions of the game. It does _not_ support _Shadowlands_.
- This release is based on the PTR build so may not behave the same on the Beta.
- The _Dragonflight_ UI is currently buggy so users may experience odd errors or warnings until the developers fix them.

#### Known Issues

- Item buttons are still a work in progress.
- Pet buttons for Bartender4 may not skin correctly.

#### General

- Added support for the _Dragonflight_ (PTR) changes.
- Removed the _TBC Classic_ ToC file.
- The stand-alone _Options_ window is now enabled by default.
- Update _Masque_'s icon.
- Updated the `Interface` version for _Retail_ to `100000`.
- Update the _Supporters_ panel.

#### Skins

- Added a new `Default` skin that mimics the new interface in _Dragonflight_.
  - Note: This skin is unavailable in _Classic_ due to missing assets.
- The original `Default` skin has been renamed to `Default (Classic)`.
- Updated all skins to support various changes.

#### API

- Added skin support for the `Anchor` attribute which allows a layer to be anchored to a region (eg, the `icon`) rather than the button. The value of this attribute must be a string that matches a region key for the button.
  - This helps to alleviate issues with the positioning of text regions on buttons that are larger than their skin.
- Added four new button types, `Backpack`, `Bag`, `Possess` and `Stance`.
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
    - `Bag`
  - `Aura`
    - `Buff`
    - `Debuff`
    - `Enchant`

#### Localization

- Added a missing `deDE` entry.
- Updated `koKR`. (Netaras)
- Updated `zhTW`. (BNS333)

#### Bug Fixes

- Fixed an issue that prevented bag buttons from being properly detected as item buttons in _Classic_.
- Fixed an issue with `LibDualSpec-1.0` being unavailable in _Wrath Classic_.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
