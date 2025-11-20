## 11.2.6-Beta

### General

- Added support for the **Assisted Combat Highlight**. (#428)
  - **Note:** Does **not** include single-button rotation support.
- Reworked the **Thin** spell alert. (#430)
  - Renamed to **Modern Lite**
  - Now resembles the **Assisted Combat Highlight** animation, but clockwise and in gold.
- Updated the `Interface` versions: (#431)
  - **Classic Era**: `11508`
  - **Mists of Pandaria Classic**: `50502`
  - **Mists of Pandaria Classic** PTR: `50503`

### API

- Added three new API methods:
  - `AddAssistedCombatHighlightStyle("Shape", {Data})`
    - Adds a new style for the specified shape.
  - `GetAssistedCombatHighlightStyle("Shape")`
    - Returns the style data for the specified shape.
  - `UpdateAssistedCombatHighlight({Button})`
    - Updates the skin of an **Assisted Combat Highlight** animation when using third-party API.
    - **Note:** APIs like **LibActionButton-1.0** will need to be updated.
- Moved most per-button settings from the button root to a per-button configuration table.
- Optimized all non-Blizzard skins.
- Optimized most skinning and utility functions.
- Renamed the `UpdateCharge` API method to `UpdateChargeCooldown`. The former is still functional but deprecated.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
