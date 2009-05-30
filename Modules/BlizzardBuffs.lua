--[[
	Project.: ButtonFacade
	File....: Modules/BlizzardBuffs.lua
	Version.: @file-revision@
	Author..: StormFX
]]

-- [ Localization ] --

-- Hard-code enUS/enGB.
local L = {
	["Blizzard Buffs"] = "Blizzard Buffs",
	["Allows the default Blizzard buffs to be skinned by ButtonFacade."] = "Allows the default Blizzard buffs to be skinned by ButtonFacade.",
	["Enable Module"] = "Enable Module",
	["Enable this module."]	= "Enable this module.",
	["Border Colors"] = "Border Colors",
	["None"] = "None",
	["Magic"] = "Magic",
	["Curse"] = "Curse",
	["Poison"] = "Poison",
	["Disease"] = "Disease",
	["Enchant"] = "Enchant",
	["Change the border color of debuffs with no type."] = "Change the border color of debuffs with no type.",
	["Change the border color of %s debuffs."] = "Change the border color of %s debuffs.",
	["Change the border color of temporary enchants."] = "Change the border color of temporary enchants.",
	["Reset Colors"] = "Reset Colors",
	["Reset all colors."] = "Reset all colors.",
}
-- Automatically inject all other locales. Please use the localization application on WoWAce.com to update these.
-- http://www.wowace.com/projects/buttonfacade/localization/namespaces/blizzardbuffs/
do
	local LOC = GetLocale()
	if LOC == "deDE" then
--@localization(locale="deDE", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardBuffs")@
	elseif LOC == "esES" or LOC == "esMX" then
-- Use esES until we have a solid esMX localization.
--@localization(locale="esES", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardBuffs")@
	elseif LOC == "frFR" then
--@localization(locale="frFR", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardBuffs")@
	elseif LOC == "koKR" then
--@localization(locale="koKR", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardBuffs")@
	elseif LOC == "ruRU" then
--@localization(locale="ruRU", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardBuffs")@
	elseif LOC == "zhCN" then
--@localization(locale="zhCN", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardBuffs")@
	elseif LOC == "zhTW" then
--@localization(locale="zhTW", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardBuffs")@
	end
end

-- [ Dependencies ] --

local BF = LibStub("AceAddon-3.0"):GetAddon("ButtonFacade")
local LBF = LibStub("LibButtonFacade")
if not LBF then return end

-- [ Set Up ] --

-- Create the module.
local mod = BF:NewModule("BlizzardBuffs", "AceHook-3.0")

-- Locals
local _G, pairs, format = _G, pairs, format
local db, options
local buttons = {
	buff = {},
	harm = {},
	item = {},
}

-- [  Local Functions ] --

-- UpdateBorder(): Updates the border for the specified button.
local function UpdateBorder(button, type)
	if button and _G[button] then
		local border = button.."Border"
		_G[border]:SetVertexColor(unpack(db.colors[type]))
	end
end

-- UpdateBorders(): Updates the borders of all active buttons.
local function UpdateBorders()
	for button, type in pairs(buttons.harm) do
		UpdateBorder(button, type)
	end
	for button, type in pairs(buttons.item) do
		UpdateBorder(button, type)
	end
end

-- [ Options ] --

do
	local function GetColor(info)
		return unpack(db.colors[info[#info]])
	end
	local function SetColor(info, r, g, b, a)
		db.colors[info[#info]] = {r, g, b, a}
		UpdateBorders()
	end
	local function ResetColors()
		local skin = db.skin
		mod.db:ResetProfile()
		db.skin = skin
		UpdateBorders()
	end
	options = {
		type = "group",
		name = L["Blizzard Buffs"],
		args = {
			title = {
				type = "description",
				name = "|cffffcc00"..L["Blizzard Buffs"].."|r\n",
				order = 1,
			},
			info = {
				type = "description",
				name = L["Allows the default Blizzard buffs to be skinned by ButtonFacade."].."\n",
				order = 2,
			},
			enable = {
				type = "toggle",
				name = L["Enable Module"],
				desc = L["Enable this module."],
				get = function() return mod:IsEnabled() end,
				set = function(info, s)	BF:ToggleModule("BlizzardBuffs", s) end,
				width = "full",
				order = 3,
			},
			spacer = {
				type = "description",
				name = " ",
				order = 4,
			},
			colors = {
				type = "group",
				name = L["Border Colors"],
				order = 5,
				get = GetColor,
				set = SetColor,
				inline = true,
				disabled = function() return not mod:IsEnabled() end,
				args = {
					None = {
						type = "color",
						name = L["None"],
						desc = L["Change the border color of debuffs with no type."],
						hasAlpha = true,
						order = 1,
					},
					Magic = {
						type = "color",
						name = L["Magic"],
						desc = L["Change the border color of %s debuffs."]:format(L["Magic"]),
						hasAlpha = true,
						order = 2,
					},
					Curse = {
						type = "color",
						name = L["Curse"],
						desc = L["Change the border color of %s debuffs."]:format(L["Curse"]),
						hasAlpha = true,
						order = 3,
					},
					Poison = {
						type = "color",
						name = L["Poison"],
						desc = L["Change the border color of %s debuffs."]:format(L["Poison"]),
						hasAlpha = true,
						order = 4,
					},
					Disease = {
						type = "color",
						name = L["Disease"],
						desc = L["Change the border color of %s debuffs."]:format(L["Disease"]),
						hasAlpha = true,
						order = 5,
					},
					Enchant = {
						type = "color",
						name = L["Enchant"],
						desc = L["Change the border color of temporary enchants."],
						hasAlpha = true,
						order = 6,
					},
				},
			},
			reset = {
				type = "execute",
				name = L["Reset Colors"],
				desc = L["Reset all colors."],
				func = ResetColors,
				disabled = function() return not mod:IsEnabled() end,
				order = 15,
			},
		},
	}
end

-- [ Core Methods ] --

-- :OnInitialize(): Initialize the module.
function mod:OnInitialize()
	-- Set up defaults.
	local defaults = {
		profile = {
			skin = {
				ID = "Blizzard",
				Gloss = false,
				Backdrop = false,
				Colors = {},
			},
			colors = { 
				None = {0.8, 0, 0, 1},
				Magic = {0.2, 0.6, 1, 1},
				Curse = {0.6, 0, 1, 1},
				Poison = {0, 0.6, 0, 1},
				Disease = {0.6, 0.4, 0, 1},
				Enchant = {0.2, 0, 0.4, 1},
			},
		},
	}

	-- Set up the DB.
	self.db = self:RegisterNamespace("BlizzardBuffs", defaults)
	db = self.db.profile

	-- Set up options.
	self:RegisterModuleOptions("BlizzardBuffs", options)
end

-- :OnEnable(): Enable function.
function mod:OnEnable()
	-- Register the skin callback function.
	LBF:RegisterSkinCallback("BlizzardBuffs", self.SkinCallback, self)

	-- Apply the global skin.
	LBF:Group("BlizzardBuffs"):Skin(db.skin.ID, db.skin.Gloss, db.skin.Backdrop, db.skin.Colors)

	-- Hook the buff frame.
	self:SecureHook("BuffFrame_Update", "UpdateBuffs")
	self:UpdateBuffs()
end

-- :OnDisable(): Disable function.
function mod:OnDisable()
	LBF:Group("BlizzardBuffs"):Delete()
	BF:RemoveModuleOptions("BlizzardBuffs")
	buttons = {buff = {}, harm = {}, item = {}}
end

-- :Refresh(): Refreshes the module's current profile.
function mod:Refresh()
	db = self.db.profile
end

-- :UpdateBuffs(): Updates the list of buffs to be skinned.
function mod:UpdateBuffs()
	local group = LBF:Group("BlizzardBuffs")
	-- Buffs
	for i=1, BUFF_ACTUAL_DISPLAY do
		local button = "BuffButton"..i
		if _G[button] then
			buttons.buff[button] = button
			group:AddButton(_G[button])
		end
	end
	-- Debuffs
	for i=1, DEBUFF_ACTUAL_DISPLAY do
		local button = "DebuffButton"..i
		if _G[button] then
			local _, _, _, _, type = UnitDebuff("player", i)
			type = type or "None"
			buttons.harm[button] = type
			group:AddButton(_G[button])
			UpdateBorder(button, type)
		end
	end
	-- Temp Enchants
	for i=1, 2 do
		local type = "Enchant"
		local button = "TempEnchant"..i
		if _G[button] then
			buttons.item[button] = type
			group:AddButton(_G[button])
			UpdateBorder(button, type)
		end
	end
end

-- :SkinCallBack(): Callback function to store settings.
function mod:SkinCallback(SkinID, Gloss, Backdrop, Group, Button, Colors)
	if not Group then
		db.skin.ID = SkinID
		db.skin.Gloss = Gloss
		db.skin.Backdrop = Backdrop
		db.skin.Colors = Colors
	end
	UpdateBorders()
end
