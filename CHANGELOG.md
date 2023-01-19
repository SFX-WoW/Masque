## 10.0.5-Beta

### General

- Updated the `Interface` version for _Wrath Classic_ to `30401. (#304),

### API

- Added support for two new regions added to `AuraButtonTemplate` 10.0.5:
  - `DebuffBorder` - Replaces the `Border` region for buttons based on `DebuffButtonTemplate`, which is removed in 10.0.5.
  - `EnchantBorder` - Replaces the `Border` region for buttons based on `TempEnchantButtonTemplate`, which is removed in 10.0.5.
  - Compatibility code between the live and PTR servers will be removed when 10.0.5 goes live.
- Further improvements to type-handling.
- Updated various region settings.

### Bug Fixes

- Fixed an issue causing spell alerts to not be skinned properly.
- Fixed an issue causing buttons moved from an enabled group to a disabled group to not be unskinned properly. (#299)

### Localization

- Updated `ruRU`. (Hollicsh) (#306)

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
