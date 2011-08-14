--[[
	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: Skins\Dream.lua
	* Revision.: @file-revision@
	* Author...: JJSheets, StormFX

	'Dream' skin for Masque.
]]

local _, Core = ...

Core:AddSkin("Dream", {
	Author = "JJSheets, StormFX",
	Version = "4.2.@project-revision@",
	Masque_Version = 40200,
	Shape = "Square",
	Backdrop = {
		Width = 36,
		Height = 36,
		Color = {0, 0, 0, 0.6},
		Texture = [[Interface\Tooltips\UI-Tooltip-Background]],
	},
	Icon = {
		Width = 30,
		Height = 30,
		TexCoords = {0.07,0.93,0.07,0.93},
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
		Width = 32,
		Height = 32,
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
	},
	Normal = {
		Hide = true,
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 32,
		Height = 32,
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		BlendMode = "ADD",
	},
	Border = {
		Width = 56,
		Height = 56,
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		BlendMode = "ADD",
	},
	Gloss = {
		Hide = true,
	},
	AutoCastable = {
		Width = 54,
		Height = 54,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 32,
		Height = 32,
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
		BlendMode = "ADD",
	},
	Name = {
		Width = 36,
		Height = 10,
		OffsetY = 4,
	},
	Count = {
		Width = 36,
		Height = 10,
		OffsetX = -1,
		OffsetY = 4,
	},
	HotKey = {
		Width = 36,
		Height = 10,
		OffsetX = -2,
		OffsetY = -4,
	},
	Duration = {
		Width = 36,
		Height = 10,
		OffsetY = -3,
	},
	AutoCast = {
		Width = 28,
		Height = 28,
		OffsetX = 0.5,
		OffsetY = -0.5,
	},
})
