## 11.2.8-Beta

### General

- Updated the `Interface` versions: (#455)
  - **The War Within**: `110207`

### Skins

- The **Blizzard Modern** and **Modern Enhanced** skins are now available on **Classic** versions of the game. (#452)
  - **Note**: This is pending testing and feedback.
- **Masque** will now use the `Icon` region of the `Backpack` button instead of a custom `SlotIcon` region on **Modern** skins. (#453)

### API

- Added support for custom `KeyRing` type buttons. (#454)
  - **Note**: These must be implemented as `Item` or `BagSlot` buttons and have `"KeyRing"` in their name for skinning to work properly.
- Removed support for the `SlotIcon` region.

### Bug Fixes
- Fixed an issue that allowed the regions of the default skins to be iterated in the `AddSkin` function.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
