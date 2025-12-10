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
local PATH_SQUARE = PATH_BASE..[[Square\]]

-- Backdrop Paths
local BACKDROP_ACTION = PATH_BACKDROP.."Action"
local BACKDROP_AURA = PATH_BACKDROP.."Aura"
local BACKDROP_ITEM = PATH_BACKDROP.."Action"

local Defaults = {
	-- [ Shared ]
	-- TexCoords = {0, 1, 0, 1}, -- @ Core/Utility/GetTexCoords
	-- Color = {1, 1, 1, 1}, -- @ Core/Utility/GetColor
	BlendMode = "BLEND",
	WrapMode = "CLAMPTOBLACKADDITIVE",
	-- Width = 36,
	-- Height = 36,
	Scale = 1,
	Size = 36,
	Point = "CENTER",
	RelPoint = "CENTER",
	OffsetX = 0,
	OffsetY = 0,

	-- [ Regions ]

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
		DrawLayer = "BACKGROUND",
		DrawLevel = -1,
		Size = 36,
	},
	IconBorder = {
		Texture = [[Interface\Common\WhiteIconFrame]],
		RelicTexture = [[Interface\Artifacts\RelicIconFrame]],
		DrawLayer = "OVERLAY",
		DrawLevel = 0,
		Size = 36,
	},
	Icon = {
		Backpack = [[Interface\Icons\INV_Misc_Bag_08]],
		DrawLayer = "BACKGROUND",
		DrawLevel = 0,
		Size = 36,
	},
	Gloss = {
		DrawLayer = "OVERLAY",
		DrawLevel = 0,
		Size = 36,
	},
	-- [ AutoCast (Classic) ]
	AutoCastable = {
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
		DrawLayer = "OVERLAY",
		DrawLevel = 1,
		Size = 58,
	},
	AutoCastShine = {
		Size = 34, -- 28
	},
	-- [ AutoCast (Retail) ]
	-- AB (45) / SAB (30) = 1.5
	-- Lua @ SAB: 31 * 1.5 = 46.5
	-- AB (45) / 36 = 1.25
	-- Masque: 46.5 / 1.25 = 37.2
	-- Multiplier = 1.2 (1.5 / 1.25)
	AutoCast_Frame = {
		Size = 37, -- 31
	},
	AutoCast_Mask = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Mask",
		-- UseAtlasSize = false,
		Size = 28, -- 23
	},
	AutoCast_Shine = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Ants",
		-- UseAtlasSize = false,
		BlendMode = "BLEND",
		DrawLayer = "OVERLAY",
		DrawLevel = 0,
		Size = 49, -- 41
	},
	AutoCast_Corners = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Corners",
		-- UseAtlasSize = false,
		BlendMode = "BLEND",
		DrawLayer = "OVERLAY",
		DrawLevel = 1,
		Size = 36, -- 31
		-- SetAllPoints = true,
	},
	-- [ Cooldown ]
	Cooldown = {
		Swipe = PATH_SQUARE.."Mask",
		SwipeCircle = PATH_BASE..[[Circle\Mask]],
		Edge = PATH_SQUARE.."Edge",
		EdgeLoC = PATH_SQUARE.."Edge-LoC",
		Pulse = [[Interface\Cooldown\star4]],
		Color = {0, 0, 0, 0.8},
		Size = 36,
	},
}

----------------------------------------
-- Core
---

Core.SKIN_BASE = Defaults
