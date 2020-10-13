## 9.0.0

### General

- Updated the `Interface` version for _Retail_ to `90001`.

### Skins

- Added generic `Backdrop` textures for the following button types:
  - `Action`
  - `Aura`/`Buff`
  - `Debuff`
  - `Enchant`
  - `Item`
  - `Pet`
  - _**Note:** Skin authors must reference these textures in their skins if they want to use them._

### API

- Masque will no longer override the `SetPoint` method of the `HotKey` region.
- Increased the `API_VERSION` to `90001`.
