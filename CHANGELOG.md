## 12.1.1-Alpha

### General

- Enabled automated localization via the packager.
- Updated the `Interface` version:
  - **Forever**: `16001`

### API

- Added a new **Group** API method, `SetFrameSize(Width, Height[, Button[, SetOnly]])`
  - This method sets internal values that **Masque** will use instead of `Frame:GetSize()`.
  - It only needs to be called on frames whose `GetSize` function returns secret values.
  - Masque WILL call and use non-secret values from `GetSize`, if available and necessary.
  - `Width` and `Height` must be numbers and cannot be secrets.
  - If `Button` is passed and is part of the group, only that frame will be affected. Otherwise, all frames will be affected.
  - If `SetOnly` is truthy, it will **not** call `ReSkin()`.
- Updated the `API_VERSION` to `120000`.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
