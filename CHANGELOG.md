## 10.1.5

### Notice for Dragonflight

Due to the addition of some new animations, it will take some time before alternatives are available for non-square skins. For the time being, users are encouraged to use a square skin (Eg, **Modern**/**Modern Enhanced**).

### General

- Updated the `Interface` version for **Retail** to `100105`. (#331)
- Updated the `Interface` version for **Wrath Classic** to `30402`. (#330)

### Interface

- Added an **Advanced** panel to the **General Settings** tab with options to control the new animations introduced in **Retail** patch `10.1.5`. They are as follows:
  - **Spell Alerts** - Drop-down: **None**, **Flash and Loop** and **Loop Only**.
  - **Cast Bar** - Toggle
  - **Interrupt** - Toggle
  - **Target Reticle** - Toggle
- Moved the **Skin Info** option from the **Performance** panel to the **Interface** panel.
- Removed the **Performance** panel.
- Updated some panels to a verticale layout.

### API

- Increased the `API_VERSION` to `10105`.
- The API methods for adding and retrieving the old style spell alert textures have been deprecated. Skin authors can now directly add those texture paths to a **SpellAlert** skin layer with setting names of **Ants** and **Glow**. See below.

### Skins

- Skin authors can now add their own spell alert textures for the new animations and set their size. Eg:
```lua
SpellAlert = {
	-- Old Spell Alerts
	Ants = "Path\\To\\Texture",
	Glow = "Path\\To\\Texture",
	-- New Spell Alerts
	Width = 63, -- Default calculated size.
	Height = 63, -- Default calculated size.
	Start = {
		Texture = "Path\\To\\Texture",
		TexCoords = {0, 1, 0, 1} 
	},
	Loop = {
		Texture = "Path\\To\\Texture",
		TexCoords = {0, 1, 0, 1}
	},
}
```

### Localization

- Updated `itIT`. (Elitesparkle) (#328)
- Updated `zhTW`. (RainbowUI) (#329)
- Updated all localization files with phrases for the new options.

### Bug Fixes

- The **Add-On Compartment** option will no longer appear in **Classic Era** or **Wrath Classic**.
- Fixed a bug that caused an "add-on blocked" message when clicking **Masque**'s icon while in combat.
- Fixed a bug that prevented the **Debug** setting from applying after logging into the game.
- Fixed a bug with the default UI that causes spell alerts to appear to scale up between the start and loop animation transitions.

[Release History](https://github.com/SFX-WoW/Masque/wiki/History)
