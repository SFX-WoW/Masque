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

local Hidden = {Hide = true}

-- Base Paths
local PATH_BASE = [[Interface\AddOns\Masque\Textures\]]
local PATH_BACKDROP = PATH_BASE..[[Backdrop\]]
local PATH_SQUARE = PATH_BASE..[[Square\]]

-- Backdrop Paths
local BACKDROP_ACTION = PATH_BACKDROP.."Action"
local BACKDROP_AURA = PATH_BACKDROP.."Aura"
local BACKDROP_ITEM = PATH_BACKDROP.."Action"

-- String Constants
local STR_ADD = "ADD"
local STR_ARTWORK = "ARTWORK"
local STR_BOTTOM = "BOTTOM"
local STR_BOTTOMRIGHT = "BOTTOMRIGHT"
local STR_CENTER = "CENTER"
local STR_BACKGROUND = "BACKGROUND"
local STR_ICON = "Icon"
local STR_OVERLAY = "OVERLAY"
local STR_RIGHT = "RIGHT"
local STR_TOP = "TOP"
local STR_TOPLEFT = "TOPLEFT"
local STR_TOPRIGHT = "TOPRIGHT"

-- Skin Defaults
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
	Point = STR_CENTER,
	RelPoint = STR_CENTER,
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
		DrawLayer = STR_BACKGROUND,
		DrawLevel = -1,
	},
	Icon = {
		Backpack = [[Interface\Icons\INV_Misc_Bag_08]],
		DrawLayer = STR_BACKGROUND,
		DrawLevel = 0,
	},
	Shadow = {
		DrawLayer = STR_ARTWORK,
		DrawLevel = -1,
	},
	Normal = {
		Texture = [[Interface\Buttons\UI-Quickslot2]],
		DrawLayer = STR_ARTWORK,
		DrawLevel = 0,
	},
	Disabled = Hidden, -- [IT]
	Pushed = { -- [IT]
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
		DrawLayer = STR_ARTWORK,
		DrawLevel = 0,
	},
	Flash = { -- [IT]
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
		DrawLayer = STR_ARTWORK,
		DrawLevel = 1,
	},
	Checked = { -- [IT]
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		DrawLayer = STR_OVERLAY,
		DrawLevel = 0,
	},
	SlotHighlight = { -- [IT]
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		DrawLayer = STR_OVERLAY,
		DrawLevel = 0,
	},
	Border = { -- [IT]
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		DrawLayer = STR_OVERLAY,
		DrawLevel = 0,
		Size = 62,
		Debuff = {
			Texture = [[Interface\Buttons\UI-Debuff-Overlays]],
			TexCoords = {0.296875, 0.5703125, 0, 0.515625},
			DrawLayer = STR_OVERLAY,
			DrawLevel = 0,
			Size = 38,
		},
		Enchant = {
			Texture = [[Interface\Buttons\UI-TempEnchant-Border]],
			DrawLayer = STR_OVERLAY,
			DrawLevel = 0,
			Size = 38,
		},
		Item = { -- Still necessary for some add-ons.
			Texture = [[Interface\Common\WhiteIconFrame]],
			DrawLayer = STR_OVERLAY,
			DrawLevel = 0,
		},
	},
	DebuffBorder = { -- [IT]
		Texture = [[Interface\Buttons\UI-Debuff-Overlays]],
		TexCoords = {0.296875, 0.5703125, 0, 0.515625},
		DrawLayer = STR_OVERLAY,
		DrawLevel = 0,
		Size = 38,
	},
	EnchantBorder = { -- [IT]
		Texture = [[Interface\Buttons\UI-TempEnchant-Border]],
		DrawLayer = STR_OVERLAY,
		DrawLevel = 0,
		Size = 38,
	},
	IconBorder = {
		Texture = [[Interface\Common\WhiteIconFrame]],
		RelicTexture = [[Interface\Artifacts\RelicIconFrame]],
		DrawLayer = STR_OVERLAY,
		DrawLevel = 0,
	},
	Gloss = {
		DrawLayer = STR_OVERLAY,
		DrawLevel = 1,
	},
	NewAction = { -- [IT]
		Atlas = "bags-newitem",
		BlendMode = STR_ADD,
		DrawLayer = STR_OVERLAY,
		DrawLevel = 1,
		Size = 44,
	},
	SpellHighlight = { -- [IT]
		Atlas = "bags-newitem",
		BlendMode = STR_ADD,
		DrawLayer = STR_OVERLAY,
		DrawLevel = 1,
		Size = 44,
	},
	IconOverlay = { -- [IT]
		Atlas = "AzeriteIconFrame",
		DrawLayer = STR_OVERLAY,
		DrawLevel = 1,
		Size = 36,
	},
	IconOverlay2 = { -- [IT]
		Atlas = "ConduitIconFrame-Corners",
		DrawLayer = STR_OVERLAY,
		DrawLevel = 2,
		Size = 36,
	},
	NewItem = {
		Atlas = "bags-glow-white",
		BlendMode = STR_ADD,
		DrawLayer = STR_OVERLAY,
		DrawLevel = 2,
		Size = 37,
	},
	QuestBorder = {
		Border = [[Interface\ContainerFrame\UI-Icon-QuestBang]],
		Texture = [[Interface\ContainerFrame\UI-Icon-QuestBorder]],
		DrawLayer = STR_OVERLAY,
		DrawLevel = 2,
	},
	UpgradeIcon = { -- [IT]
		Atlas = "bags-greenarrow",
		UseAtlasSize = true,
		DrawLayer = STR_OVERLAY,
		DrawLevel = 3, -- 1
		Size = 16,
		Point = STR_TOPLEFT,
		RelPoint = STR_TOPLEFT,
	},
	ContextOverlay = { -- [IT]
		Color = {0, 0, 0, 0.8},
		DrawLayer = STR_OVERLAY,
		DrawLevel = 4,
		Size = 37,
		UseColor = true,
	},
	SearchOverlay = { -- [IT]
		Color = {0, 0, 0, 0.8},
		DrawLayer = STR_OVERLAY,
		DrawLevel = 4,
		Size = 37,
		UseColor = true,
	},
	JunkIcon = { -- [IT]
		Atlas = "bags-junkcoin",
		UseAtlasSize = true,
		DrawLayer = STR_OVERLAY,
		DrawLevel = 5,
		Size = 20,
		Point = STR_TOPLEFT,
		RelPoint = STR_TOPLEFT,
	},
	Duration = {
		JustifyH = STR_CENTER,
		JustifyV = STR_TOP,
		DrawLayer = STR_OVERLAY,
		Width = 36,
		Height = 0,
		Anchor = STR_ICON,
		Point = STR_TOP,
		RelPoint = STR_BOTTOM,
	},
	Name = {
		JustifyH = STR_CENTER,
		JustifyV = STR_BOTTOM,
		DrawLayer = STR_OVERLAY,
		Width = 36,
		Height = 0, -- 10
		Anchor = STR_ICON,
		Point = STR_BOTTOM,
		RelPoint = STR_BOTTOM,
	},
	Highlight = { -- [IT]
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
		BlendMode = STR_ADD,
		DrawLayer = "HIGHLIGHT",
		DrawLevel = 0,
	},
	-- [ TextOverlayContainer (Retail) ]
	Count = {
		JustifyH = STR_RIGHT,
		JustifyV = STR_BOTTOM,
		DrawLayer = STR_OVERLAY,
		Width = 0,
		Height = 0,
		Anchor = STR_ICON,
		Point = STR_BOTTOMRIGHT,
		RelPoint = STR_BOTTOMRIGHT,
	},
	HotKey = {
		JustifyH = STR_RIGHT,
		JustifyV = STR_TOP,
		DrawLayer = STR_OVERLAY,
		Width = 36,
		Height = 0, -- 10
		Anchor = STR_ICON,
		Point = STR_TOPRIGHT,
		RelPoint = STR_TOPRIGHT,
	},
	-- [ AutoCast (Classic) ]
	AutoCastable = { -- [IT]
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
		DrawLayer = STR_OVERLAY,
		DrawLevel = 1,
		Size = 58,
	},
	AutoCastShine = {
		Size = 34,
	},
	-- [ AutoCast (Retail) ]
	-- AB (45) / SAB (30) = 1.5
	-- Lua @ SAB: 31 * 1.5 = 46.5
	-- AB (45) / 36 = 1.25
	-- Masque: 46.5 / 1.25 = 37.2
	-- Multiplier = 1.2 (1.5 / 1.25)
	AutoCast_Frame = {
		Size = 37,
	},
	AutoCast_Shine = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Ants",
		DrawLayer = STR_OVERLAY,
		DrawLevel = 0,
		Size = 49,
	},
	AutoCast_Mask = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Mask",
		-- UseAtlasSize = false,
		Size = 30,
	},
	AutoCast_Corners = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Corners",
		DrawLayer = STR_OVERLAY,
		DrawLevel = 1,
	},
	-- [ Cooldown ]
	Cooldown = {
		Swipe = PATH_SQUARE.."Mask",
		SwipeCircle = PATH_BASE..[[Circle\Mask]],
		Edge = PATH_SQUARE.."Edge",
		Pulse = [[Interface\Cooldown\star4]],
		Color = {0, 0, 0, 0.8},
		LoC = {
			Edge = PATH_SQUARE.."Edge-LoC",
			Color = {0.2, 0, 0, 0.8},
		},
	},
}

----------------------------------------
-- Core
---

Core._Hidden = Hidden
Core.SKIN_BASE = Defaults
