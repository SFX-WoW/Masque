--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Skins\Defaults.lua
	* Author.: StormFX

	Skin Defaults

]]

local _, Core = ...

----------------------------------------
-- Locals
---

local Defaults = {
	-- [ Shared ]
	-- TexCoords = {0, 1, 0, 1}, -- @ Core/Utility/GetTexCoords
	-- Color = {1, 1, 1, 1}, -- @ Core/Utility/GetColor
	BlendMode = "BLEND",
	Width = 36,
	Height = 36,
	Scale = 1,
	Size = 36,
	Point = "CENTER",
	RelPoint = "CENTER",
	OffsetX = 0,
	OffsetY = 0,
}

----------------------------------------
-- Core
---

Core.SKIN_BASE = Defaults
