## 9.0.2

### Skins

- Relaxed the restrictions on skin compatibilty checks to be more in line with their actual compatibility level.
  - The [skin list](https://github.com/SFX-WoW/Masque/wiki/Skin-List) has been updated accordingly.
- Updated the level of the `HotKey`, `Count` and `Duration` regions so that they appear above other regions.

### API

- Added support for the `IconOverlay2` (Conduit Frame) item button region.
- Masque will now hook the `:Show()` and `:Hide()` methods of `Icon` regions to determine if a button is empty. This only applies to `Action`, `Item` and `Pet` buttons.
- The API method `:AddType()` now has a third parameter that can be used to specify an existing type as a reference for per-type settings.
