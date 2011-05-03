--[[
	Project.: Masque
	File....: Skins.lua
	Version.: @file-revision@
	Author..: StormFX, JJSheets
]]

-- [ Locals ] --

local _, Core = ...
if not Core.Loaded then return end

-- [ Default Button Skins] --

Core.Button:AddSkin("Blizzard", {
	Masque_Version = 40100,
	Version = "4.1.@project-revision@",
	Author = "Blizzard Entertainment",
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
	-- Gloss = Hidden,
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
	},
	AutoCast = {
		Width = 36,
		Height = 36,
	},
}, true)

-- Dream Layout
Core.Button:AddSkin("Dream Layout", {
	Masque_Version = 40100,
	Version = "4.1.@project-revision@",
	Author = "JJSheets, StormFX",
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
	-- Normal = Hidden,
	-- Disabled = Hidden,
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
	-- Gloss = Hidden,
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
	},
	AutoCast = {
		Width = 30,
		Height = 30,
		OffsetX = 0.5,
		OffsetY = -0.5,
	},
}, true)

-- Zoomed
Core.Button:AddSkin("Zoomed", {
	Masque_Version = 40100,
	Version = "4.1.@project-revision@",
	Author = "JJSheets, StormFX",
	-- Backdrop = Hidden,
	Icon = {
		Width = 36,
		Height = 36,
		TexCoords = {0.07,0.93,0.07,0.93},
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
	-- Normal = Hidden,
	-- Disabled = Hidden,
	Checked = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		BlendMode = "ADD",
	},
	Border = {
		Width = 64,
		Height = 64,
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		BlendMode = "ADD",
	},
	-- Gloss = Hidden,
	AutoCastable = {
		Width = 66,
		Height = 66,
		OffsetX = 0.5,
		OffsetY = -0.5,
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
	},
	Count = {
		Width = 36,
		Height = 10,
	},
	HotKey = {
		Width = 36,
		Height = 10,
		OffsetY = -1,
	},
	Duration = {
		Width = 36,
		Height = 10,
	},
	AutoCast = {
		Width = 36,
		Height = 36,
		OffsetX = 0.5,
	},
}, true)
