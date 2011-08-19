--[[
	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: Skins\Blizzard.lua
	* Revision.: @file-revision@
	* Author...: Blizzard Entertainment

	'Blizzard' skin for Masque.
]]

local _, Core = ...

-- Improved Blizzard skin. Thanks to Maul for the reference!
Core:AddSkin("Blizzard", {
	Author = "Blizzard Entertainment",
	Version = "4.2.@project-revision@",
	Masque_Version = 40200,
	Shape = "Square",
	Backdrop = {
		Width = 32,
		Height = 32,
		OffsetY = -0.5,
		TexCoords = {0.2, 0.8, 0.2, 0.8},
		Texture = [[Interface\Buttons\UI-EmptySlot]],
	},
	Icon = {
		Width = 32,
		Height = 32,
		TexCoords = {0.07, 0.93, 0.07, 0.93},
	},
	Flash = {
		Width = 32,
		Height = 32,
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
	},
	Cooldown = {
		Width = 32,
		Height = 32,
	},
	Pushed = {
		Width = 34,
		Height = 34,
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
	},
	Normal = {
		Width = 56,
		Height = 56,
		Texture = [[Interface\Buttons\UI-Quickslot2]],
		EmptyTexture = [[Interface\Buttons\UI-Quickslot]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 32,
		Height = 32,
		BlendMode = "ADD",
		Texture = [[Interface\Buttons\CheckButtonHilight]],
	},
	Border = {
		Width = 60,
		Height = 60,
		BlendMode = "ADD",
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
	},
	Gloss = {
		Hide = true,
	},
	AutoCastable = {
		Width = 56,
		Height = 56,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 32,
		Height = 32,
		BlendMode = "ADD",
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
	},
	Name = {
		Width = 32,
		Height = 10,
		OffsetY = 4,
	},
	Count = {
		Width = 32,
		Height = 10,
		OffsetX = -1,
		OffsetY = 5,
	},
	HotKey = {
		Width = 32,
		Height = 10,
		OffsetX = 3,
		OffsetY = -4,
	},
	Duration = {
		Width = 32,
		Height = 10,
		OffsetY = -2,
	},
	AutoCast = {
		Width = 30,
		Height = 30,
		OffsetX = 0.5,
		OffsetY = -0.5
	},
})
