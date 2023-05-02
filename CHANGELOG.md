## 10.1.0

### General

- Added an entry for **Masque** in the new `AddonCompartment`. (#323)
- Added an `IconTexture` for the **AddOns** menu. (#323)
- Updated the `Interface` version for **Retail** to `100100`. (#322)
- Updated the `X-Discord` ToC entry.

### API

- Increased the `API_VERSION` to `100100`.
- The `Register` API and `SetCallback` Group API methods have been deprecated and no longer function. They will still print warnings when called.

### Callback Update

- The **Group** callback API via `RegisterCallback` has been improved so that authors can now specify which events/options their callback is fired on. (#324)
  - More information can be found in [this issue](https://github.com/SFX-WoW/Masque/issues/324).
  - The Wiki will be updated in the future to reflect these changes.
  - These changes should not affect existing group callbacks registered with the `RegisterCallback`.

### Localization

- Added a missing phrase to some locale files.
- Updated `koKR`. (HanaKiki) (#321)

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
