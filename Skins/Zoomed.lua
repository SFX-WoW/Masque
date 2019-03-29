--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Skins\Zoomed.lua
	* Author.: StormFX, JJSheets

	'Zoomed' Skin

]]

local _, Core = ...

----------------------------------------
-- Zoomed
---

do
	local L = Core.Locale

	-- Zoomed
	Core.AddSkin("Zoomed", {
		Shape = "Square",
		Masque_Version = 80100,

		-- Info
		Description = L["A square skin with zoomed icons and a semi-transparent background."],
		Version = Core.Version,
		Authors = Core.Authors,
		Websites = Core.Websites,

		-- Skin
		Backdrop = {
			Texture = [[Interface\Tooltips\UI-Tooltip-Background]],
			Color = {0, 0, 0, 0.5},
			Width = 36,
			Height = 36,
		},
		Icon = {
			Width = 36,
			Height = 36,
			TexCoords = {0.07, 0.93, 0.07, 0.93},
		},
		-- Shadow = {Hide = true},
		-- Normal = {Hide = true},
		-- Disabled = {Hide = true},
		Pushed = {
			Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
			Width = 38,
			Height = 38,
		},
		Flash = {
			Texture = [[Interface\Buttons\UI-QuickslotRed]],
			Width = 36,
			Height = 36,
		},
		HotKey = {
			Width = 36,
			Height = 10,
			OffsetX = -1,
			OffsetY = -2,
		},
		Count = {
			Width = 36,
			Height = 10,
			OffsetX = -1,
			OffsetY = 2,
		},
		Duration = {
			Width = 36,
			Height = 10,
			OffsetY = -3,
		},
		Border = {
			Width = 66,
			Height = 66,
			OffsetX = 0.5,
			OffsetY = 0.5,
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
			Width = 37,
			Height = 37,
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
			Width = 37,
			Height = 37,
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
			Width = 48,
			Height = 48,
		},
		SpellHighlight = {
			Width = 48,
			Height = 48,
		},
		AutoCastable = {
			Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
			Width = 66,
			Height = 66,
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
			Width = 36,
			Height = 36,
		},
		Name = {
			Width = 36,
			Height = 10,
			OffsetY = 2,
		},
		Cooldown = {
			Width = 36,
			Height = 36,
		},
		ChargeCooldown = {
			Width = 36,
			Height = 36,
		},
		Shine = {
			Width = 36,
			Height = 36,
			OffsetX = 0.5,
			OffsetY = -0.5
		},
	})
end
