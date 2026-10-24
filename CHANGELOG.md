## 12.1.5

### General

- Enabled automated localization via the packager.
- Updated the `Interface` version:
  - **Midnight**: `120105`
  - **Forever**: `16001`

### API

- Added a new **Group** API method, `SetFrameSize(Width, Height [, Button [, Mutable [, SetOnly]]])`
  - This method allows authors to set internal values that **Masque** will use when `Frame:GetSize()` returns secret values.
  - `Width` and `Height` must be numbers and cannot be secrets.
  - If `Button` is passed and is part of the group, only that frame will be affected. Otherwise, all frames will be affected.
  - If `Mutable` is true, **Masque** will call `Frame:GetSize()` when reskinning and use non-secret value pairs.
  - If `SetOnly` is true, it will **not** call `ReSkin()`.
- Removed references to `FloatingBG`. `Backdrop` is now fully a custom region.
- Updated the `API_VERSION` to `120001`.
- Updated the region configuration to account for UI changes.
- Updated the type logic to account for for UI changes.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
