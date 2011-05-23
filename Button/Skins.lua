--[[
	Project.: Masque
	File....: Button/Skins.lua
	Version.: @file-revision@
	Author..: StormFX, JJSheets
]]

local _, Core = ...

-- [ Locals ] --

local error, pairs, setmetatable, type = error, pairs, setmetatable, type

-- Layer Types
local Layers = {
	Backdrop = "Custom",
	Icon = "Texture",
	Flash = "Texture",
	Cooldown = "Frame",
	Pushed = "Special",
	Normal = "Custom",
	Disabled = "Special",
	Checked = "Special",
	Border = "Texture",
	Gloss = "Custom",
	AutoCastable = "Texture",
	Highlight = "Special",
	Name = "Text",
	Count = "Text",
	HotKey = "Text",
	Duration = "Text",
	AutoCast = "Frame",
}

-- Returns a list of button layers.
function Core.Button:GetLayers()
	return Layers
end

-- [ Skin API ] --

-- Skin Tables
local Skins = {}
local SkinList = {}

-- Hidden Layer
local Hidden = {Hide = true}

-- Adds a button skin.
function Core.Button:AddSkin(SkinID, SkinData, Replace)
	if type(SkinID) ~= "string" then
		if Core.db.profile.Debug then
			error("Bad argument to method 'AddSkin'. 'SkinID' must be a string.", 2)
		end
		return
	end
	if Skins[SkinID] and not Replace then
		return
	end
	if type(SkinData) ~= "table" then
		if Core.db.profile.Debug then
			error("Bad argument to method 'AddSkin'. 'SkinData' must be a table.", 2)
		end
		return
	end
	if SkinData.Template then
		if Skins[SkinData.Template] then
			setmetatable(SkinData, {__index=Skins[SkinData.Template]})
		else
			if Core.db.profile.Debug then
				error(("Invalid template reference by skin '%s'. Skin '%s' does not exist."):format(SkinID, SkinData.Template), 2)
			end
			return
		end
	end
	for Layer in pairs(Layers) do
		if type(SkinData[Layer]) ~= "table" then
			SkinData[Layer] = Hidden
		end
	end
	Skins[SkinID] = SkinData
	SkinList[SkinID] = SkinID
end

-- Returns the specified skin.
function Core.Button:GetSkin(SkinID)
	return Skins[SkinID]
end

-- Returns the skins table.
function Core.Button:GetSkins()
	return Skins
end

-- Returns a list of skins.
function Core.Button:ListSkins()
	return SkinList
end

-- [ Default Skins] --

Core.Button:AddSkin("Blizzard", {
	Author = "Blizzard Entertainment",
	Version = "4.1.@project-revision@",
	Masque_Version = 40100,
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
		OffsetY = -4,
	},
	AutoCast = {
		Width = 34,
		Height = 34,
		OffsetX = 0.5,
		OffsetY = -0.5
	},
}, true)

-- Blizzard 2.0, awaiting permission for inclusion from Maul.

-- Dream Layout
Core.Button:AddSkin("Dream Layout", {
	Author = "JJSheets, StormFX",
	Version = "4.1.@project-revision@",
	Masque_Version = 40100,
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
		OffsetY = -3,
	},
	AutoCast = {
		Width = 28,
		Height = 28,
		OffsetX = 0.5,
		OffsetY = -0.5,
	},
}, true)

-- Zoomed
Core.Button:AddSkin("Zoomed", {
	Author = "JJSheets, StormFX",
	Version = "4.1.@project-revision@",
	Masque_Version = 40100,
	Shape = "Square",
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
		OffsetY = -3,
	},
	AutoCast = {
		Width = 34,
		Height = 34,
		OffsetX = 0.5,
		OffsetY = -0.5
	},
}, true)
