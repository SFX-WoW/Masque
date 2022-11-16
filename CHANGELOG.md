## 10.0.2 Release Notes

### General

- Updated the `Interface` version for _Retail_ to `100002`. (#286)

### Skins

- Due to some ambiguity with the naming of some included skins, those names have been revisited and are as follows: (#280)
  - "_Default_" (Dragonflight) is now "_Blizzard Modern_".
  - "_Default (Classic)_" is now "_Blizzard Classic_".
  - "_Classic_" is now "_Classic Redux_".
- Due to the name changes, a fail-safe has been implemented for skins that have yet to be updated to use the new names in their template field. This will allow those skins to continue to function. (#280)
- The default skins for new profiles will now be the "_Blizzard_" variant for the respective client. (#281)
- Users who use one of the renamed skins will have their saved variables migrated automatically to reference the new names. (#284)

### API

- The `GetDefaultSkin` API method will now return the skin table along with the `SkinID` of the default skin.  (#283)
- The `SetCallback` Group API method now accepts a third `boolean` parameter that will cause the callback to return the group object rather than the `string` ID as the first parameter. (#285)

### Localization

- Updated `koKR`. (Netaras) (#278)

### Bug Fixes

- Fixed an issue that allowed text regions with spaces to wrap to new lines.
- Fixed an issue that caused the edge texture for the _Blizzard Modern_ skin to be too large. (#279)
- Fixed an issue that caused some skins to use the wrong edge texture. (#282)

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
