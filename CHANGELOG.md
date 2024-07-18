## 10.2.11

### General

- Added a new **Classic** spell alert style for **Retail** that mimics the original style that includes variations for **Masque**'s default shapes.
- Settings for spell alerts have been updated, so users may need to reselect their preferred options.

### Skins

- Skins can now nest spell alert settings for various styles. See **Modern Enhanced** for an example.
  - **Note:** The root settings (width and height) will be applied to the default spell alerts when custom spell alerts are disabled or when no nested settings are found.
- Updated the non-Blizzard skins for the spell alert changes.

### Options

- Renamed the "Masque Thin" spell alert style to simple "Thin".

### API

- Updated the following API methods:
  - `AddSpellAlertFlipBook("Style", "Shape", {Data})` - Adds a single shape to a new or existing flipbook style. Needs to be called for each shape added.
  - `GetSpellAlertFlipBook("Style", "Shape")`- Returns a single shape table based from the specified style.
- Updated the `API_VERSION` to `100209`.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
