## 11.2.6

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
- Updated the **Supporters** list.

### API

- Added three new API methods:
  - `AddAssistedCombatHighlightStyle("Shape", {Data})`
    - Adds a new style for the specified shape.
  - `GetAssistedCombatHighlightStyle("Shape")`
    - Returns the style data for the specified shape.
  - `UpdateAssistedCombatHighlight({Button})`
    - Updates the skin of an **Assisted Combat Highlight** animation when using third-party API.
    - **Note:** APIs like **LibActionButton-1.0** will need to be updated.
- Future-proofed some skinning functions for mixed API.
- Moved most per-button settings from the button root to a per-button configuration table.
  - **Note**: This table can be found at `Button._MSQ_CFG`. Any add-ons using `Button.__MSQ_` fields will need to be updated.
- Optimized all non-Blizzard skins.
- Optimized most skinning and utility functions.
- Renamed the `UpdateCharge` API method to `UpdateChargeCooldown`. The former is still functional but deprecated.

### Skins

- All non-text regions now default to the following settings if not specified by the skin:
  - `Point`: `"CENTER"`
  - `RelPoint`: `"CENTER"`
  - `OffsetX`: `0`
  - `OffsetY`: `0`
- Text regions now default to the following settings if not specified by the skin:
  - `DrawLayer`: `"OVERLAY"`
  - `OffsetX`: `0`
  - `OffsetY`: `0`
  - `Count`:
    - `Point`: `"BOTTOMRIGHT"`
    - `RelPoint`: `"BOTTOMRIGHT"`
    - `JustifyH`: `"RIGHT"`
    - `JustifyV`: `"BOTTOM"`
  - `Duration`:
    - `Point`: `"BOTTOM"`
    - `RelPoint`: `"TOP"`
    - `JustifyH`: `"CENTER"`
    - `JustifyV`: `"TOP"`
  - `HotKey`:
    - `Point`: `"TOPRIGHT"`
    - `RelPoint`: `"TOPRIGHT"`
    - `JustifyH`: `"RIGHT"`
    - `JustifyV`: `"TOP"`
  - `Name`:
    - `Point`: `"BOTTOM"`
    - `RelPoint`: `"BOTTOM"`
    - `JustifyH`: `"CENTER"`
    - `JustifyV`: `"BOTTOM"`

### Bug Fixes

- Fixed a bug that would cause outdated add-ons using the deprecated `SetCallback` group method to throw an error. (#432)
- Fixed a missing `nil` check in `Skin_Overlay`. (#433)

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
