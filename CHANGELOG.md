## 10.0.7

### General

- Updated the `Interface` version for **Retail** to `100007`. (#318)

### API

- Increased the `API_VERSION` to `100007`.
- Removed some deprecated methods that haven't been functional for quite some time.
- Reworked the callback system. (#317) (See below)

### Callback Overhaul

- Added a new Group API method, `RegisterCallback`, that is now the recommended way of registering a callback.
  - Authors are encouraged to register callbacks at the group level moving forward, as this allows more refined filtering.
  - A [wiki page](https://github.com/SFX-WoW/Masque/wiki/RegisterCallback) has been added for this method.
- Added a one-time, per-add-on, per-profile warning for add-ons using the deprecated methods to help with the transition.
  - Users can report these warning to the add-on author directly or by posting in the [relevant issue](https://github.com/SFX-WoW/Masque/issues/319) on Masque's project page.
- The Group API method `SetCallback` is now deprecated and will be removed in 10.1.0.
- The Group API method `ReSkin` no longer fires callbacks. These are now handled by the settings updater.
- The API method `Register` is now deprecated and will be removed in 10.1.0.
- When a callback is fired, it will now only return the group object, the `string` name of the setting that was changed and the value it was changed to.
  - This eliminates unnecessary table access when only a single value has changed and allows authors to target specific settings.

### Localization

- Updated `esES`/`esMX`. (Yllelder7) (#320)

### Bug Fixes

- Fixed an issue preventing callbacks from being fired for some options. (#316)

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
