## 8.0.2

### General

- Updated the zhTW locale.
- The "Blizzard" skin has been renamed to "Classic".

### Features

- Added new textures for Cooldowns and Charges.
  - The new textures are higher quality and will look more crisp.
  - Includes alternate textures for round buttons.

### API

- Masque_Version updated to 80100.
- The "Blizzard" skin has been renamed to "Classic".
  - Until add-ons authors update their code, a fail-safe has been implemented.
    - Please use the API's `.DefaultSkin` key instead of referencing the skin by name.

### Skins

- Added new default 'Swipe' and 'Edge' textures for the Cooldown and ChargeCooldown regions. These will change according to the shape set by the skin.
  - Only the "Square" and "Circle" shapes are currently supported.
  - At the moment, only the 'Swipe' texture is available to skins and it will take precedence over the default.
  - This change puts cooldown frames back above the button, where they belong so skins will need to be updated.

### Bug Fixes

- Fixed an issue that would cause the default cooldown count to appear beneath other text regions. (#19)
- Tentative fix for edge textures on round buttons. (#38)

## 8.0.1

### General

- Libraries have been updated.
  - LibDualSpec-1.0 is once again included by default. (#29)
- Localization files are now embedded so that translators can fork from GitHub.

### API

- Added bridge methods to Masque's add-on object to allow UI authors to copy and switch Masque's profiles via AceDB-3.0. (#30)
  - `:CopyProfile("Name" [, Silent])`
  - `:SetProfile("Name")`

### Bug Fixes

- Fixed some faulty itIT phrases. (#22)(#28)

## 8.0.0

### General

- ToC to 80000.
