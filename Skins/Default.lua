--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Skins\Default.lua
	* Author.: Blizzard Entertainment

	'Default' Skin

	* Note: Some attributes are modified for internal consistency.

]]

local _, Core = ...

----------------------------------------
-- Locals
---

local L = Core.Locale

----------------------------------------
-- Default
---

Core.AddSkin("Default", {
	Shape = "Square",
	Masque_Version = Core.API_VERSION,

	-- Info
	Description = L["The default button style."],
	Version = Core.Version,
	Author = "|cff0099ffBlizzard Entertainment|r",

	-- Skin
	Backdrop = {
		Texture = [[Interface\Buttons\UI-Quickslot]],
		-- TexCoords = {0, 1, 0, 1},
		Color = {1, 1, 1, 0.4},
		BlendMode = "BLEND",
		DrawLayer = "BACKGROUND",
		DrawLevel = -1,
		Width = 66,
		Height = 66,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	Icon = {
		-- TexCoords = {0, 1, 0, 1},
		DrawLayer = "BACKGROUND",
		DrawLevel = 0,
		Width = 36,
		Height = 36,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	-- Shadow = {Hide = true},
	Normal = {
		Texture = [[Interface\Buttons\UI-Quickslot2]],
		-- TexCoords = {0, 1, 0, 1},
		Color = {1, 1, 1, 1},
		-- EmptyTexture = [[Interface\Buttons\UI-Quickslot2]],
		-- EmptyCoords = {0, 1, 0, 1},
		-- EmptyColor = {1, 1, 1, 0.5},
		BlendMode = "BLEND",
		DrawLayer = "ARTWORK",
		DrawLevel = 0,
		Width = 66,
		Height = 66,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
		UseStates = true,
		Pet = {
			Texture = "Interface\\Buttons\\UI-Quickslot2",
			-- TexCoords = {0, 1, 0, 1},
			Color = {1, 1, 1, 1},
			-- EmptyTexture = [[Interface\Buttons\UI-Quickslot2]],
			-- EmptyCoords = {0, 1, 0, 1},
			-- EmptyColor = {1, 1, 1, 0.5},
			BlendMode = "BLEND",
			DrawLayer = "ARTWORK",
			DrawLevel = 0,
			Width = 64,
			Height = 64,
			Point = "CENTER",
			OffsetX = 0,
			OffsetY = -1,
			UseStates = true,
		},
		Item = {
			Texture = "Interface\\Buttons\\UI-Quickslot2",
			-- TexCoords = {0, 1, 0, 1},
			Color = {1, 1, 1, 1},
			-- EmptyTexture = [[Interface\Buttons\UI-Quickslot2]],
			-- EmptyCoords = {0, 1, 0, 1},
			-- EmptyColor = {1, 1, 1, 1},
			BlendMode = "BLEND",
			DrawLayer = "ARTWORK",
			DrawLevel = 0,
			Width = 62,
			Height = 62,
			Point = "CENTER",
			OffsetX = 0,
			OffsetY = -1,
			UseStates = true,
		},
	},
	-- Disabled = {Hide = true},
	Pushed = {
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
		-- TexCoords = {0, 1, 0, 1},
		-- Color = {1, 1, 1, 1},
		BlendMode = "BLEND",
		DrawLayer = "ARTWORK",
		DrawLevel = 0,
		Width = 36,
		Height = 36,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	Flash = {
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
		-- TexCoords = {0, 1, 0, 1},
		-- Color = {1, 1, 1, 1},
		BlendMode = "BLEND",
		DrawLayer = "ARTWORK",
		DrawLevel = 1,
		Width = 36,
		Height = 36,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	HotKey = {
		JustifyH = "RIGHT",
		JustifyV = "MIDDLE",
		DrawLayer = "ARTWORK",
		Width = 36,
		Height = 10,
		Point = "TOPRIGHT",
		OffsetX = 1,
		OffsetY = -3,
		Pet = {
			JustifyH = "RIGHT",
			JustifyV = "MIDDLE",
			DrawLayer = "ARTWORK",
			Width = 36,
			Height = 10,
			Point = "TOPRIGHT",
			OffsetX = 4,
			OffsetY = -3.5,
		},
	},
	Count = {
		JustifyH = "RIGHT",
		JustifyV = "MIDDLE",
		DrawLayer = "ARTWORK",
		Width = 36,
		Height = 10,
		Point = "BOTTOMRIGHT",
		OffsetX = -2,
		OffsetY = 4.5,
		Item = {
			JustifyH = "RIGHT",
			JustifyV = "MIDDLE",
			DrawLayer = "ARTWORK",
			Width = 36,
			Height = 10,
			Point = "BOTTOMRIGHT",
			OffsetX = -5,
			OffsetY = 4.5,
		},
	},
	Duration = {
		JustifyH = "CENTER",
		JustifyV = "MIDDLE",
		DrawLayer = "ARTWORK",
		Width = 36,
		Height = 10,
		Point = "TOP",
		RelPoint = "BOTTOM",
		OffsetX = 0,
		OffsetY = -1.5,
	},
	Checked = {
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		-- TexCoords = {0, 1, 0, 1},
		-- Color = {1, 1, 1, 1},
		BlendMode = "ADD",
		DrawLayer = "OVERLAY",
		DrawLevel = 0,
		Width = 36,
		Height = 36,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	Border = {
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		-- TexCoords = {0, 1, 0, 1},
		-- Color = {1, 1, 1, 1},
		BlendMode = "ADD",
		DrawLayer = "OVERLAY",
		DrawLevel = 0,
		Width = 62,
		Height = 62,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
		Item = {
			Texture = [[Interface\Common\WhiteIconFrame]],
			RelicTexture = [[Interface\Artifacts\RelicIconFrame]],
			-- TexCoords = {0, 1, 0, 1},
			-- Color = {1, 1, 1, 1},
			BlendMode = "BLEND",
			DrawLayer = "OVERLAY",
			DrawLevel = 0,
			Width = 36,
			Height = 36,
			Point = "CENTER",
			OffsetX = 0,
			OffsetY = 0,
		},
		Debuff = {
			Texture = [[Interface\Buttons\UI-Debuff-Overlays]],
			TexCoords = {0.296875, 0.5703125, 0, 0.515625},
			-- Color = {1, 1, 1, 1},
			BlendMode = "BLEND",
			DrawLayer = "OVERLAY",
			DrawLevel = 0,
			Width = 32,
			Height = 32,
			Point = "CENTER",
			OffsetX = 0,
			OffsetY = 0,
		},
		Enchant = {
			Texture = [[Interface\Buttons\UI-TempEnchant-Border]],
			-- TexCoords = {0, 1, 0, 1},
			-- Color = {1, 1, 1, 1},
			BlendMode = "BLEND",
			DrawLayer = "OVERLAY",
			DrawLevel = 0,
			Width = 32,
			Height = 32,
			Point = "CENTER",
			OffsetX = 0,
			OffsetY = 0,
		},
	},
	IconBorder = {
		Texture = [[Interface\Common\WhiteIconFrame]],
		RelicTexture = [[Interface\Artifacts\RelicIconFrame]],
		-- TexCoords = {0, 1, 0, 1},
		-- Color = {1, 1, 1, 1},
		BlendMode = "BLEND",
		DrawLayer = "OVERLAY",
		DrawLevel = 0,
		Width = 36,
		Height = 36,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	SlotHighlight = {
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		-- TexCoords = {0, 1, 0, 1},
		-- Color = {1, 1, 1, 1},
		BlendMode = "ADD",
		DrawLayer = "OVERLAY",
		DrawLevel = 0,
		Width = 36,
		Height = 36,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
		-- SetAllPoints = true,
	},
	-- Gloss = {Hide = true},
	IconOverlay = {
		Atlas = "AzeriteIconFrame",
		-- Color = {1, 1, 1, 1},
		BlendMode = "BLEND",
		DrawLayer = "OVERLAY",
		DrawLevel = 1,
		Width = 36,
		Height = 36,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	NewAction = {
		Atlas = "bags-newitem",
		-- Color = {1, 1, 1, 1},
		BlendMode = "ADD",
		DrawLayer = "OVERLAY",
		DrawLevel = 1,
		Width = 44,
		Height = 44,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	SpellHighlight = {
		Atlas = "bags-newitem",
		-- Color = {1, 1, 1, 1},
		BlendMode = "ADD",
		DrawLayer = "OVERLAY",
		DrawLevel = 1,
		Width = 44,
		Height = 44,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	AutoCastable = {
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
		-- TexCoords = {0, 1, 0, 1},
		-- Color = {1, 1, 1, 1},
		BlendMode = "BLEND",
		DrawLayer = "OVERLAY",
		DrawLevel = 1,
		Width = 70,
		Height = 70,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	NewItem = {
		Atlas = "bags-glow-white",
		-- Color = {1, 1, 1, 1},
		BlendMode = "ADD",
		DrawLayer = "OVERLAY",
		DrawLevel = 2,
		Width = 38,
		Height = 38,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	SearchOverlay = {
		-- TexCoords = {0, 1, 0, 1},
		Color = {0, 0, 0, 0.8},
		BlendMode = "BLEND",
		DrawLayer = "OVERLAY",
		DrawLevel = 4,
		Width = 36,
		Height = 36,
		-- Point = "CENTER",
		-- OffsetX = 0,
		-- OffsetY = 0,
		UseColor = true,
		SetAllPoints = true,
	},
	ContextOverlay = {
		-- TexCoords = {0, 1, 0, 1},
		Color = {0, 0, 0, 0.8},
		BlendMode = "BLEND",
		DrawLayer = "OVERLAY",
		DrawLevel = 4,
		Width = 36,
		Height = 36,
		-- Point = "CENTER",
		-- OffsetX = 0,
		-- OffsetY = 0,
		UseColor = true,
		SetAllPoints = true,
	},
	Name = {
		JustifyH = "CENTER",
		JustifyV = "MIDDLE",
		DrawLayer = "OVERLAY",
		Width = 36,
		Height = 10,
		Point = "BOTTOM",
		OffsetX = 0,
		OffsetY = 2,
	},
	Highlight = {
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
		-- TexCoords = {0, 1, 0, 1},
		-- Color = {1, 1, 1, 1},
		BlendMode = "ADD",
		DrawLayer = "HIGHLIGHT",
		DrawLevel = 0,
		Width = 36,
		Height = 36,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	AutoCastShine = {
		Width = 34,
		Height = 34,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	Cooldown = {
		Color = {0, 0, 0, 0.8},
		Width = 36,
		Height = 36,
		Point = "CENTER",
		OffsetX = 0,
		OffsetY = 0,
	},
	ChargeCooldown = {
		Width = 36,
		Height = 36,
		SetAllPoints = true,
	},
})