## 10.0.0-Beta Release Notes

**Disclaimer:** This release is an _Beta_ release and therefore may contain unexpected bugs and/or errors. Please report any issues appropriately on [GitHub](https://github.com/SFX-WoW/Masque "Masque @ GitHub").

### New in This Build

- A new `BagSlot` texture region is available to skins to compensate for the removal of the Backpack icon in _Dragonflight_ and is only used for that specific button on the _Retail_ client. An example implementation can be seen in the _Default (Classic)_ skin.
- Added a `Classic Scaling` option to Masque's option under `General Settings` / `Interface` that forces _Masque_ to use the old scaling method for action bars. This is a _global_ option that is _disabled_ by default, so that users who've already adjusted their action bars will be unaffected by the change.
- Minor bug fixes and tweaks.

### Known Issues

#### Bartender4

- Pet Bar buttons may not skin correctly when using the new "Default" skin.
- _Bartender_ will migrate your your old action bar settings to compensate for the size increase of action buttons. A side effect of this is that buttons skinned with _Masque_ may be scaled smaller (or larger). To correct this, users will need to either adjust the scale and padding of their action bars in _Bartender4_ and then reposition them or enable the **Classic Scaling** option mentioned above.

#### Miscellaneous

- Due to some bugs with the new UI, add-ons are unable to open the new _Settings_ menu to sub-categories. Therefore, users who go to _Masque_'s options from the new Settings window and press the `Load Options`* button won't see the headers for the other sections. To solve this, do one of the following:
  - Always open _Masque_'s options via the `/msq` chat command.
  - Enable the Stand-Alone GUI by navigating `General Settings` / `Interface` in _Masque_'s options panel and ticking the `Stand-Alone GUI` option.

### General

- Added support for the changes implemented in the _Dragonflight_ pre-patch.
- Removed the _TBC Classic_ ToC file.
- Update _Masque_'s icon.
- Updated the `Interface` version for _Retail_ to `100000`.
- Updated the _Supporters_ panel.

### Skins

- Added a new _"Default"_ skin that mimics the new interface in _Dragonflight_.
  - **Notes:**
    - This skin is unavailable in _Classic_ due to missing assets.
    - The original "Default" skin has been renamed to "Default (Classic)".
- Updated all included skins to support changes made in this update.
  - **Note:** Skin authors using the old "Default" skin as a template will need to update their skins.

### API

- API version increased to `100000`.
- Added five new button types: `Backpack`, `BagSlot`, `Possess`, `ReagentBag` and `Stance`.
- Implemented a fail-safe for buttons that qualify as a sub-type but are passed as a base type.
- Implemented a fail-safe for add-ons that use custom `Normal` textures.

### Skin API

- Added atlas support to various regions.
- Added skin support for the `Anchor` attribute which allows a layer to be anchored to a region (eg, the icon) rather than the button. The value of this attribute must be a string that matches a table key for either the regions table or the button.
  - This will help alleviate issues with the positioning of text regions on buttons that are larger than their skin by allowing those regions be positioned relative to the icon.
- Improved the skinning of masks.
- Improved the type-handling for buttons so that the base type will act as a fall-back for sub-types. This will remove the need for skins to declare sub-types that have the same skin settings as the base type. The hierarchy is as follows:
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
  - In addition, the `ReagentBag` type will fall back to the `BagSlot` type before falling back to `Item`.
- Skins using `"Default"` as a template will need to be updated to use `"Default (Classic)"`.

### Localization

- Added a missing `deDE` entry.
- Updated `koKR`. (Netaras)
- Updated `zhTW`. (BNS333)

### Bug Fixes

- Fixed an issue that prevented bag buttons from being properly detected as item buttons in _Classic_.
- Fixed an issue with `LibDualSpec-1.0` being unavailable in _Wrath Classic_.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
