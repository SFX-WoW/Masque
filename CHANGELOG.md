## 10.0.5

### General

- Updated the `Interface` version for **Retail** to `100005`. (#305)
- Updated the `Interface` version for **Wrath Classic** to `30401`. (#304)
- Updated the supporters list.

### API

- Added support for two new regions added to `AuraButtonTemplate` in 10.0.5 (#302):
  - `DebuffBorder` - Replaces the `Border` region for buttons based on `DebuffButtonTemplate`, which was removed in 10.0.5.
  - `EnchantBorder` - Replaces the `Border` region for buttons based on `TempEnchantButtonTemplate`, which was removed in 10.0.5.
  - Masque will check for older definitions (Eg: `Border.Debuff` or `Border`) to maintain compatibility with skins missing these layers and **Classic**.
- Further improvements to type-handling.
- Increased the `API_VERSION` to `100005`.
- In an effort to reduce redundancy in skins, skin layers can now reference other layers by passing the `string` name of the referenced layer instead of a definition table. Eg:
  - If `Border` is defined as `Border = { ... }`, `DebuffBorder` can be defined as `DebuffBorder = "Border"` to tell **Masque** to use the `Border` table for `DebuffBorder`.
  - Note that this is only useful for layers with the identical definition tables.
  - A better example can be seen in the **Dream** skin.
- Updated various region settings.

### Skins

- Updated all skins for the changed listed above.

### Bug Fixes

- Fixed an issue causing spell alerts to not be skinned properly.
- Fixed an issue causing buttons moved from an enabled group to a disabled group to not be unskinned properly. (#299)

### Localization

- Updated `ruRU`. (Hollicsh) (#306)

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
