## 10.2.8-Beta

Disclaimers:
- This is a beta and may have bugs.
- Skins may need to be updated to work properly.

### General

- Switched to a single ToC file. (#365)
- Added five new spell alerts for **Retail** that use the new animations:
  - Circle
  - Hexagon
  - Hexagon-Rotated
  - Modern (Same shape as the new action button icon frames)
  - Square
- The spell alert start animation will no longer play while hidden when disabled.

### API

- Added two new API methods:
  - `AddSpellAlertFlipBook("Shape", {Data})` - Adds a custom flipbook-style animation for spell alerts.
    - The `Data` table can have the following field/value pairs:
	  - `LoopTexture` - Path to the loop texture. **Required**
	  - `StartTexture` - Path to the start texture. Will use `LoopTexture` if missing.
	  - `Color` - An RGBA color table for the animations.
	  - `FrameHeight` - The height of the frames in the animation. **Required**
	  - `FrameWidth` - The width of the frames in the animation. **Required**
	    - Note: The frame dimensions are the size, in pixels, of each frame on the texture. These must be precise in order for the texture to animate properly.
	  - `Columns` - The number of columns in the texture grid. Defaults to `5`.
	  - `Rows` - The number of rows in the texture grid. Defaults to `6`.
  - `GetSpellAlertFlipBook("Shape")`- Returns the table of a flipbook-style animation.
  - Shapes are now unique to each spell alert type (Classic and Modern).
- Updated the `API_VERSION` to `100207`.

### Bug Fixes

- Fixed an issue with the loop texture of spell alerts being visible while the start animation is playing.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
