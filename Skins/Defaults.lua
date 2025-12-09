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
	Clamp = "CLAMPTOBLACKADDITIVE",
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
	-- [ AutoCast (Classic) ]
	AutoCastable = {
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
		BlendMode = "BLEND",
		DrawLayer = "OVERLAY",
		DrawLevel = 1,
		-- Width = 58,
		-- Height = 58,
		Size = 58,
	},
	AutoCastShine = {
		-- Width = 34, -- 28
		-- Height = 34, -- 28
		Size = 34,
	},
	-- [ AutoCast (Retail) ]
	-- AB (45) / SAB (30) = 1.5
	-- Lua @ SAB: 31 * 1.5 = 46.5
	-- Masque: 46.5 / 1.25 = 37.2
	-- Multiplier = 1.2 (1.5 / 1.25)
	AutoCast_Frame = {
		-- Width = 37, -- 31
		-- Height = 37, -- 31
		Size = 37,
	},
	AutoCast_Mask = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Mask",
		-- UseAtlasSize = false,
		-- Width = 28, -- 23
		-- Height = 28, -- 23
		Size = 28,
	},
	AutoCast_Shine = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Ants",
		-- UseAtlasSize = false,
		BlendMode = "BLEND",
		DrawLayer = "OVERLAY",
		DrawLevel = 0,
		-- Width = 49, -- 41
		-- Height = 49, -- 41
		Size = 49,
	},
	AutoCast_Corners = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Corners",
		-- UseAtlasSize = false,
		BlendMode = "BLEND",
		DrawLayer = "OVERLAY",
		DrawLevel = 1,
		-- Width = 36, -- 31
		-- Height = 36, -- 31
		Size = 36,
		-- SetAllPoints = true,
	},
}

----------------------------------------
-- Core
---

Core.SKIN_BASE = Defaults
