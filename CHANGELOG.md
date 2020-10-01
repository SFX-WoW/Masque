## 8.3.1

### General

- (Hopefully) fixed an issue with duplicate libraries.
- Updated ruRU. (Doomstep_)

### Classic

- ItemButtons should now correctly use the `Checked` texture instead of the `SlotHighlight` texture that _Retail_ uses.

### Skins

#### All Skins

- Added support for the new regions.

#### Classic, Dream & Zoomed

- Reduced the size of the `JunkIcon`, `QuestBorder` and `UpgradeIcon` regions.
- The `UpgradeIcon` region was adjusted to be above the `IconOverlay` texture used for Azerite and corrupted items.

### API

- `API_Version` increased to `90000`.
- Added support for the follow item button regions:
  - `JunkIcon`
  - `QuestBorder`
  - `UpgradeIcon`

### Skin API

- Regions that are undeclared and cannot be hidden will use the settings of the "Default" skin. This improves compatibility between Masque and older skins.
- Masks specified at the button or region level can now be either a `string` texture path or a `table` of settings.
