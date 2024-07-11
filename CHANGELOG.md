## 10.2.8

#### Disclaimers

- This release may have bugs.
- Skins may need to be updated to work properly.

### General

- Added **Aevari** to the supporters list.
- Switched to a single ToC file. (#365)
- Updated the `Interface` version for **Classic Era** to `11503`.
- Updated the `Interface` version for **Classic Wrath** (China) to `30403`.
- Updated the `Interface` version for **The War Within** (Beta) to `110002`.

### Skins

- Added five new spell minimalistic spell alert textures for **Retail** that will be applied to non-default skins that specify one the natively-supported shapes.
- Added five new pet `AutoCast` animation texture masks for **The War Within** that skin authors can use to fit their skin(s).
- Added support for the new `AutoCast` animations in **The War Within**. These animations consist of the following regions:
  - `AutoCast_Frame` - The frame that the textures are parented to. This should never need to be manipulated.
  - `AutoCast_Shine` - This is the content texture that gets animated. Accepts standard texture attributes.
  - `AutoCast_Mask` - This is the mask applied to `AutoCast_Shine` to show specific regions of the texture. Accepts standard `Mask` attributes.
    - **Note:** As mentioned above, five mask shapes are included with **Masque**.
  - `AutCast_Corners` - This is corner texture. Accepts standard texture attributes.
  - An example of implementation can be seen in any of my custom skins.
  - Any region not specified with fallback to the default region, making skinning these regions optional.
- All texture paths except for `Textures\Backdrop` have been updated to align with their respective shapes. Eg:
  - `Textures\Cooldown\Swipe-Circle` is now `Textures\Circle\Mask`.
- **Masque** now natively supports five shapes usable by skin authors. These shapes are:
  - `Circle`
  - `Hexagon`
  - `Hexagon-Rotated`
  - `Modern` (Retail Action Button Shape)
  - `Square`
- **Masque** now includes the following textures for each of the aforementioned shapes:
  - `AutoCast-Mask`
  - `Mask`
  - `SpellAlert-Loop`
- **Masque** now includes the following textures for `Modern` and `Square` shapes:
  - `Edge`
  - `Edge-LoC`
- Renamed **Classic Redux** to **Classic Enhanced**.
- Updated all `Cooldown` settings to use appropriate masks.

### API

- Added two new API methods:
  - `AddSpellAlertFlipBook("Shape", {Data})` - Adds a custom flipbook-style animation for spell alerts.
    - The `Data` table can have the following field/value pairs:
      - `LoopTexture` - Path to the loop texture. **Required**
      - `StartTexture` - Path to the start texture. The start animation will be disabled if missing.
      - `Color` - An RGBA color table for the texture.
      - `FrameHeight` - The height of the frames in the animation. **Required**
      - `FrameWidth` - The width of the frames in the animation. **Required**
        - **Note:** The frame dimensions are the size, in pixels, of each frame on the texture. These must be precise in order for the texture to animate properly.
      - `Columns` - The number of columns in the texture grid. Defaults to `5`.
      - `Rows` - The number of rows in the texture grid. Defaults to `6`.
  - `GetSpellAlertFlipBook("Shape")`- Returns the table of a flipbook-style animation.
  - Shapes are now unique to each spell alert type (**Classic** and **Modern**) and can no longer be overwritten.
- Skinning of the `AutoCast` animation is now limited to `Pet` type buttons. Authors will either need to have a global name registered with the word `Pet` as part of the string or they must explicitly pass `Pet` as the type in the `AddButton()` group API method.
- Updated the `API_VERSION` to `100208`.

### Bug Fixes

- Fixed an issue that caused the `HotKey` text to be misaligned in the **Blizzard Modern** skin.
- Fixed an issue that prevented the color option from working on square skins.
- Fixed an issue that prevented `LibDualSpec-1.0` from enabling properly in **Season of Mastery**.
- Fixed an issue with the loop texture of spell alerts being visible while the start animation is playing. (Retail)
- The spell alert start animation will no longer play while hidden when disabled. (Retail)

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
