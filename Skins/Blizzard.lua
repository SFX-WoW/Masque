--[[
	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: Skins\Blizzard.lua
	* Revision.: @file-revision@
	* Author...: Blizzard Entertainment

	'Blizzard' skin for Masque.
]]

local _, Core = ...

Core:AddSkin("Blizzard", {
	Author = "Blizzard Entertainment",
	Version = "4.2.@project-revision@",
	Masque_Version = 40200,
	Shape = "Square",
	Backdrop = {
		Width = 34,
		Height = 35,
		Texture = [[Interface\Buttons\UI-EmptySlot]],
		OffsetY = -0.5,
		TexCoords = {0.2,0.8,0.2,0.8},
	},
	Icon = {
		Width = 36,
		Height = 36,
	},
	Flash = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
	},
	Cooldown = {
		Width = 36,
		Height = 36,
	},
	Pushed = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
	},
	Normal = {
		Width = 66,
		Height = 66,
		Static = false,
		Texture = [[Interface\Buttons\UI-Quickslot2]],
		EmptyTexture = [[Interface\Buttons\UI-Quickslot]],
		OffsetY = -1,
	},
	Disabled = {
		Width = 66,
		Height = 66,
		Texture = [[Interface\Buttons\UI-Quickslot2]],
		OffsetY = -1,
	},
	Checked = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		BlendMode = "ADD",
	},
	Border = {
		Width = 62,
		Height = 62,
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		BlendMode = "ADD",
	},
	Gloss = {
		Hide = true,
	},
	AutoCastable = {
		Width = 58,
		Height = 58,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
		BlendMode = "ADD",
	},
	Name = {
		Width = 36,
		Height = 10,
		OffsetY = 2,
	},
	Count = {
		Width = 36,
		Height = 10,
		OffsetY = 2,
	},
	HotKey = {
		Width = 36,
		Height = 10,
		OffsetY = -3,
	},
	Duration = {
		Width = 36,
		Height = 10,
		OffsetY = -4,
	},
	AutoCast = {
		Width = 34,
		Height = 34,
		OffsetX = 0.5,
		OffsetY = -0.5
	},
})
