## 11.2.8

### General

- Implemented a `Defaults` table to migrate away from using the default skins as fallbacks.
- Optimized some code and logic.
- Removed the migration code for **Dragonflight**.
- Updated the `Interface` versions: (#455)(#460)
  - **The War Within**: `110207`
  - **Midnight** PTR: `120000`
  - **Midnight** Beta: `120001`
  - **Mists of Pandaria Classic**: `50503`

### Skins

- Added Defaults support to most regions. This allows skin authors to skip redundant skin settings.
- Cleaned up the non-Blizzard skins.
- Skins can now specify the texture used for the `Backpack` button via the `Backpack` field of the `Icon` skin table.
- Skins without a template will now inherit missing regions from the active default skin.
- The **Blizzard Modern** and **Modern Enhanced** skins are now available on **Classic** versions of the game. (#452)
  - **Masque** will still choose its default skin based on the game version.
- **Masque** will now use the `Icon` region of the `Backpack` button instead of a custom `SlotIcon` region on **Modern** skins. (#453)

### API

- Added support for custom `KeyRing` type buttons. (#454)
  - These must be implemented as `Item` or `BagSlot` buttons and have `"KeyRing"` in their name for skinning to work properly.
- Removed support for the `SlotIcon` region.

### Bug Fixes

- Fixed an issue that allowed the `Pulse` to be enabled on the `ChargeCooldown`.
- Fixed an issue that allowed the regions of the default skins to be iterated in the `AddSkin` function.
- Fixed an issue that prevented regions using an atlas from being colored.
- Fixed an issue in Midnight Beta related to the removal of `StartChargeCooldown`. (#457)

### Localization

- Updated `itIT`. (Faniel)(#459)
- Updated `ruRU`. (ZamestoTV)(#458)

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
