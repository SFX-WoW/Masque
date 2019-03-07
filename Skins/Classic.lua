--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Skins\Classic.lua
	* Author.: StormFX, Maul, Blizzard Entertainment

	'Classic' Skin

]]

local _, Core = ...

do
	local L = Core.Locale

	-- Skin
	Core:AddSkin("Classic", {
		Shape = "Square",
		Masque_Version = 80100,

		-- Info
		Description = L["An improved version of the game's default button style."],
		Version = Core.Version,
		Authors = {"StormFX", "|cff999999Maul|r", "|cff999999Blizzard Entertainment|r"},
		Websites = Core.Websites,

		-- Data
		Backdrop = {
			Width = 32,
			Height = 32,
			TexCoords = {0.2, 0.8, 0.2, 0.8},
			Texture = [[Interface\Buttons\UI-EmptySlot]],
		},
		Icon = {
			Width = 30,
			Height = 30,
			TexCoords = {0.07, 0.93, 0.07, 0.93},
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
		Normal = {
			Width = 56,
			Height = 56,
			OffsetX = 0.5,
			OffsetY = -0.5,
			Texture = [[Interface\Buttons\UI-Quickslot2]],
			EmptyTexture = [[Interface\Buttons\UI-Quickslot]],
			EmptyColor = {1, 1, 1, 0.5},
		},
		-- Disabled = {Hide = true},
		Checked = {
			Width = 31,
			Height = 31,
			BlendMode = "ADD",
			Texture = [[Interface\Buttons\CheckButtonHilight]],
		},
		Border = {
			Width = 60,
			Height = 60,
			OffsetX = 0.5,
			OffsetY = 0.5,
			BlendMode = "ADD",
			Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		},
		IconBorder = {
			Width = 35,
			Height = 35,
		},
		IconOverlay = {
			Width = 35,
			Height = 35,
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
			Width = 32,
			Height = 10,
			OffsetY = 6,
		},
		Count = {
			Width = 32,
			Height = 10,
			OffsetX = -3,
			OffsetY = 6,
		},
		HotKey = {
			Width = 32,
			Height = 10,
			OffsetX = 1,
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
			Width = 32,
			Height = 32,
			OffsetX = 0.5,
			OffsetY = -0.5
		},
	})
end
