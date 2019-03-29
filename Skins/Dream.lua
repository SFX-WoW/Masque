--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Skins\Dream.lua
	* Author.: StormFX, JJSheets

	'Dream' Skin

]]

local _, Core = ...

----------------------------------------
-- Dream
---

do
	local L = Core.Locale

	-- Dream
	Core.AddSkin("Dream", {
		Shape = "Square",
		Masque_Version = 80100,

		-- Info
		Description = L["A square skin with trimmed icons and a semi-transparent background."],
		Version = Core.Version,
		Authors = Core.Authors,
		Websites = Core.Websites,

		-- Skin
		Backdrop = {
			Color = {0, 0, 0, 0.5},
			UseColor = true,
			Width = 40,
			Height = 40,
		},
		Icon = {
			TexCoords = {0.08, 0.92, 0.08, 0.92},
			Width = 34,
			Height = 34,
		},
		-- Shadow = {Hide = true},
		-- Normal = {Hide = true},
		-- Disabled = {Hide = true},
		Pushed = {
			Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
			Width = 36,
			Height = 36,
		},
		Flash = {
			Texture = [[Interface\Buttons\UI-QuickslotRed]],
			TexCoords = {0.2, 0.8, 0.2, 0.8},
			Color = {1, 1, 1, 0.75},
			Width = 34,
			Height = 34,
		},
		HotKey = {
			Width = 36,
			Height = 10,
			OffsetX = -1,
			OffsetY = -3,
		},
		Count = {
			Width = 36,
			Height = 10,
			OffsetX = -2,
			OffsetY = 3,
		},
		Duration = {
			Width = 36,
			Height = 10,
			OffsetY = -2,
		},
		Border = {
			BlendMode = "ADD",
			Width = 64,
			Height = 64,
			Item = {
				Width = 36,
				Height = 36,
			},
			Debuff = {
				Width = 36,
				Height = 36,
			},
			Enchant = {
				Width = 36,
				Height = 36,
			},
		},
		IconBorder = {
			Width = 36,
			Height = 36,
		},
		Checked = {
			Texture = [[Interface\Buttons\CheckButtonHilight]],
			BlendMode = "ADD",
			Width = 38,
			Height = 38,
		},
		SlotHighlight = {
			Texture = [[Interface\Buttons\CheckButtonHilight]],
			BlendMode = "ADD",
			Width = 38,
			Height = 38,
		},
		-- Gloss = {Hide = true},
		IconOverlay = {
			Width = 36,
			Height = 36,
		},
		SearchOverlay = {
			Color = {0, 0, 0, 0.75},
			UseColor = true,
		},
		ContextOverlay = {
			Color = {0, 0, 0, 0.75},
			UseColor = true,
		},
		NewAction = {
			Width = 44,
			Height = 44,
		},
		SpellHighlight = {
			Width = 44,
			Height = 44,
		},
		AutoCastable = {
			Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
			Width = 64,
			Height = 64,
			OffsetX = 0.5,
			OffsetY = -0.5,
		},
		NewItem = {
			Width = 35,
			Height = 35,
		},
		Highlight = {
			Texture = [[Interface\Buttons\ButtonHilight-Square]],
			BlendMode = "ADD",
			Width = 34,
			Height = 34,
		},
		Name = {
			Width = 36,
			Height = 10,
			OffsetY = 3,
		},
		Cooldown = {
			Width = 34,
			Height = 34,
		},
		ChargeCooldown = {
			Width = 34,
			Height = 34,
		},
		Shine = {
			Width = 34,
			Height = 34,
			OffsetX = 0.5,
			OffsetY = -0.5,
		},
	})
end
