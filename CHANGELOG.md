## 10.0.0-Alpha

### Release Notes

**Notice:** This release is an _alpha_ release and therefore may contain unexpected bugs and/or errors. Please report any issues appropriately on [GitHub](https://github.com/SFX-WoW/Masque "Masque @ GitHub").

- This release is only compatible with _Dragonflight_ and the _Classic_ versions of the game. It does _not_ support _Shadowlands_.
- This release is based on the PTR build so may not behave the same on the Beta.
- The _Dragonflight_ UI is currently buggy so users may experience odd errors or warnings until the developers fix them.
- Item buttons will need additional tweaks that cannot be completed until a bag add-on is updated for _Dragonflight_.

#### General

- Added support for the _Dragonflight_ (PTR) changes.
- Added a new default skin that mimics the new interface in _Dragonflight_.
- Removed the _TBC Classic_ ToC file.
- The stand-alone Options window is now enabled by default due to taint issues with the new Settings panel.
- Update _Masque_'s icon.
- Updated the `Interface` version for _Retail_ to `100000`.

#### Localization

- Added a missing `deDE` entry.
- Updated `koKR`. (Netaras)

#### API

- Added skin support for the `Anchor` attribute which allows a layer to be anchored to a region (eg, the icon) rather than the button. The value of this attribute must be a string that matches a region key for the button.
- Added two new button types, `Backpack` and `Bag`.
- Improved the type-handling for buttons so that the base type will act as a fallback for sub-types. The hierarchy is as follows:
  - `Action`
    - `Pet`
  - `Item`
    - `Backpack`
    - `Bag`
  - `Aura`
    - `Buff`
    - `Debuff`
    - `Enchant`
- Masque now uses `AceHook-3.0` and will unhook regions when no longer needed.

#### Bug Fixes

- Fixed an issue that prevented bag buttons from being properly detected as item buttons.
- Fixed an issue with `LibDualSpec-1.0` being unavailable in _Wrath Classic_.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
