--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Skins\Dream.lua
	* Author.: StormFX, JJSheets

	'Dream' Skin

]]

local _, Core = ...

do
	local L = Core.Locale

	-- Skin
	Core:AddSkin("Dream", {
		Shape = "Square",
		Masque_Version = 80100,

		-- Info
		Description = L["A square skin with trimmed icons and a semi-transparent background."],
		Version = Core.Version,
		Authors = Core.Authors,
		Websites = Core.Websites,

		-- Data
		Backdrop = {
			Width = 36,
			Height = 36,
			Color = {0, 0, 0, 0.5},
			Texture = [[Interface\Tooltips\UI-Tooltip-Background]],
		},
		Icon = {
			Width = 30,
			Height = 30,
			TexCoords = {0.08, 0.92, 0.08, 0.92},
		},
		Flash = {
			Width = 30,
			Height = 30,
			TexCoords = {0.2, 0.8, 0.2, 0.8},
			Texture = [[Interface\Buttons\UI-QuickslotRed]],
		},
		Pushed = {
			Width = 34,
			Height = 34,
			Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
		},
		-- Shadow = {Hide = true},
		-- Normal = {Hide = true},
		-- Disabled = {Hide = true},
		Checked = {
			Width = 32,
			Height = 32,
			BlendMode = "ADD",
			Texture = [[Interface\Buttons\CheckButtonHilight]],
		},
		Border = {
			Width = 54,
			Height = 54,
			OffsetY = 0.5,
			BlendMode = "ADD",
			Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		},
		-- Gloss = {Hide = true},
		AutoCastable = {
			Width = 56,
			Height = 56,
			OffsetX = 0.5,
			OffsetY = -0.5,
			Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
		},
		Highlight = {
			Width = 30,
			Height = 30,
			BlendMode = "ADD",
			Texture = [[Interface\Buttons\ButtonHilight-Square]],
		},
		Name = {
			Width = 36,
			Height = 10,
			OffsetY = 5,
		},
		Count = {
			Width = 36,
			Height = 10,
			OffsetX = -3,
			OffsetY = 5,
		},
		HotKey = {
			Width = 36,
			Height = 10,
			OffsetX = -3,
			OffsetY = -6,
		},
		Duration = {
			Width = 36,
			Height = 10,
			OffsetY = -2,
		},
		Cooldown = {
			Width = 30,
			Height = 30,
		},
		ChargeCooldown = {
			Width = 30,
			Height = 30,
		},
		Shine = {
			Width = 28,
			Height = 28,
			OffsetX = 0.5,
			OffsetY = -0.5,
		},
	})
end
