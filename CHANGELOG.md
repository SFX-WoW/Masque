## 12.1.7

### Skins

- Due to all game versions now using a similar `AutoCastOverlay` template, the following changes have been made:
  - The `AutoCast`/`AutoCastShine` and `AutoCastable` regions have been deprecated.
  - For **Classic** clients, **Masque** will now look in the `AutoCast_Frame.Classic` and `AutoCast_Corners.Classic` fields for the respective **Classic** settings.
  - **Masque** will automatically redirect those fields to the respective skin definition if the parent field exists. Otherwise it will use the default settings.
    - Eg: If `AutoCast_Corners` exists within the skin, **Masque** will point `AutoCast_Corners.Classic` toward `AutoCastable` if `AutoCast_Corners.Classic` is missing.

### Bug Fixes

- Fixed error with the `Backdropp` region during skinning.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
