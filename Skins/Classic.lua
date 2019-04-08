--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Skins\Classic.lua
	* Author.: StormFX, Maul, Blizzard Entertainment

	'Classic' Skin

]]

local _, Core = ...

----------------------------------------
-- Classic
---

do
	local L = Core.Locale

	-- Classic
	Core.AddSkin("Classic", {
		Shape = "Square",
		Masque_Version = 80100,

		-- Info
		Description = L["An improved version of the game's default button style."],
		Version = Core.Version,
		Authors = {"StormFX", "|cff999999Maul|r", "|cff999999Blizzard Entertainment|r"},
		Websites = Core.Websites,

		-- Skin
		Backdrop = {
			Texture = [[Interface\Buttons\UI-Quickslot]],
			Color = {1, 1, 1, 0.8},
			Width = 66,
			Height = 66,
			Point = "CENTER",
		},
		Icon = {
			Width = 36,
			Height = 36,
		},
		-- Shadow = {Hide = true},
		Normal = {
			Texture = [[Interface\Buttons\UI-Quickslot2]],
			EmptyTexture = [[Interface\Buttons\UI-Quickslot]],
			EmptyColor = {1, 1, 1, 0.5},
			Width = 60,
			Height = 60,
		},
		-- Disabled = {Hide = true},
		Pushed = {
			Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
			DrawLevel = 1,
			Width = 36,
			Height = 36,
			OffsetX = -0.5,
			OffsetY = 0.5,
		},
		Flash = {
			Texture = [[Interface\Buttons\UI-QuickslotRed]],
			DrawLayer = "BORDER",
			Color = {1, 1, 1, 0.75},
			Width = 34,
			Height = 34,
		},
		HotKey = {
			Width = 32,
			Height = 10,
			OffsetX = -1,
			OffsetY = -3,
		},
		Count = {
			Width = 32,
			Height = 10,
			OffsetX = -1,
			OffsetY = 3,
		},
		Duration = {
			Width = 36,
			Height = 10,
			OffsetY = -2,
		},
		Checked = {
			Texture = [[Interface\Buttons\CheckButtonHilight]],
			Color = {1, 1, 1, 0.8},
			BlendMode = "ADD",
			Width = 34,
			Height = 34,
			OffsetX = -0.5,
			OffsetY = 0.5,
		},
		Border = {
			BlendMode = "ADD",
			Width = 57,
			Height = 57,
			OffsetY = 1,
			Item = {
				Width = 36,
				Height = 36,
				OffsetX = -0.5,
				OffsetY = 0.5,
			},
			Debuff = {
				Width = 38,
				Height = 38,
				OffsetY = 1,
			},
			Enchant = {
				Width = 36,
				Height = 36,
			},
		},
		IconBorder = {
			Width = 37,
			Height = 37,
		},
		SlotHighlight = {
			Texture = [[Interface\Buttons\CheckButtonHilight]],
			Color = {1, 1, 1, 0.8},
			BlendMode = "ADD",
			Width = 34,
			Height = 34,
			OffsetX = -0.5,
			OffsetY = 0.5,
		},
		-- Gloss = {Hide = true},
		IconOverlay = {
			Width = 37,
			Height = 37,
		},
		NewAction = {
			Width = 44,
			Height = 44,
			OffsetX = -1,
			OffsetY = 1,
		},
		SpellHighlight = {
			Width = 44,
			Height = 44,
			OffsetX = -1,
			OffsetY = 1,
		},
		AutoCastable = {
			Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
			Width = 66,
			Height = 66,
		},
		NewItem = {
			Width = 35,
			Height = 35,
		},
		SearchOverlay = {
			Color = {0, 0, 0, 0.75},
			UseColor = true,
		},
		ContextOverlay = {
			Color = {0, 0, 0, 0.75},
			UseColor = true,
		},
		Name = {
			Width = 32,
			Height = 10,
			OffsetY = 2,
		},
		Highlight = {
			Texture = [[Interface\Buttons\ButtonHilight-Square]],
			Color = {1, 1, 1, 1},
			BlendMode = "ADD",
			Width = 34,
			Height = 34,
		},
		AutoCastShine = {
			Width = 32,
			Height = 32,
			OffsetX = 0.5,
			OffsetY = -0.5
		},
		Cooldown = {
			Width = 32,
			Height = 32,
		},
		ChargeCooldown = {
			Width = 32,
			Height = 32,
		},
	})
end
