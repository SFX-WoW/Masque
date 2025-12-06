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

-- Base Paths
local PATH_BASE = [[Interface\AddOns\Masque\Textures\]]
local PATH_BACKDROP = PATH_BASE..[[Backdrop\]]

-- Backdrop Paths
local BACKDROP_ACTION = PATH_BACKDROP.."Action"
local BACKDROP_AURA = PATH_BACKDROP.."Aura"
local BACKDROP_ITEM = PATH_BACKDROP.."Action"

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
	Backdrop = {
		Texture = PATH_BACKDROP.."Slot-Modern",
		Textures = {
			Action = BACKDROP_ACTION,
			Aura = BACKDROP_AURA,
			Backpack = BACKDROP_ITEM,
			BagSlot = BACKDROP_ITEM,
			Buff = BACKDROP_AURA,
			Debuff = PATH_BACKDROP.."Debuff",
			Enchant = PATH_BACKDROP.."Enchant",
			Item = BACKDROP_ITEM,
			KeyRing = BACKDROP_ITEM,
			Pet = PATH_BACKDROP.."Pet",
			Possess = BACKDROP_ACTION,
			ReagentBag = BACKDROP_ITEM,
			Stance = BACKDROP_ACTION,
		},
		Color = {0, 0, 0, 0.5}, -- Color Texture Only
		BlendMode = "BLEND",
		DrawLayer = "BACKGROUND",
		DrawLevel = -1,
	},
}

----------------------------------------
-- Core
---

Core.SKIN_BASE = Defaults
