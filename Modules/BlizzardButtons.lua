--[[
	Project.: ButtonFacade
	File....: Modules/BlizzardButtons.lua
	Version.: @file-revision@
	Author..: StormFX
]]

-- Dependencies
local BF = LibStub("AceAddon-3.0"):GetAddon("ButtonFacade")
local LBF = LibStub("LibButtonFacade")
if not LBF then return end

-- [ Localization ] --

-- Hard-code enUS/enGB.
local L = {
	["Blizzard Buttons"] = "Blizzard Buttons",
	["BBTN_Desc"] = "Allows the default Blizzard buttons to be skinned by ButtonFacade.",
	["Enable Module"] = "Enable Module",
	["Enable this module."]	= "Enable this module.",
}
-- Automatically inject all other locales. Please use the localization application on WoWAce.com to update these.
-- http://www.wowace.com/projects/buttonfacade/localization/namespaces/buttontest/
do
	local LOC = GetLocale()
	if LOC == "deDE" then
--@localization(locale="deDE", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardButtons")@
	elseif LOC == "esES" or LOC == "esMX" then
-- Use esES until we have a solid esMX localization.
--@localization(locale="esES", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardButtons")@
	elseif LOC == "frFR" then
--@localization(locale="frFR", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardButtons")@
	elseif LOC == "koKR" then
--@localization(locale="koKR", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardButtons")@
	elseif LOC == "ruRU" then
--@localization(locale="ruRU", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardButtons")@
	elseif LOC == "zhCN" then
--@localization(locale="zhCN", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardButtons")@
	elseif LOC == "zhTW" then
--@localization(locale="zhTW", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="BlizzardButtons")@
	end
end

-- [ Set Up ] --

-- Create the module.
local mod = BF:NewModule("BlizzardButtons")

-- Locals
local _G, pairs, strsub, insert, tostring = _G, pairs, strsub, table.insert, tostring
local db

-- Button Groups
local bars = {
	ActionButtons = {
		count = 12,
		buttons = {},
	},
	BonusActionButtons = {
		count = 12,
		buttons = {},
	},
	MultiBarBottomLeftButtons = {
		count = 12,
		buttons = {},
	},
	MultiBarBottomRightButtons = {
		count = 12,
		buttons = {},
	},
	MultiBarLeftButtons = {
		count = 12,
		buttons = {},
	},
	MultiBarRightButtons = {
		count = 12,
		buttons = {},
	},
	ShapeshiftButtons = {
		count = 10,
		buttons = {},
	},
	PetActionButtons = {
		count = 10,
		buttons = {},
	},
	PossessButtons = {
		count = 2,
		buttons = {},
	},
}

-- Options
local options = {
	type = "group",
	name = L["Blizzard Buttons"],
	args = {
		title = {
			type = "description",
			name = "|cffffcc00"..L["Blizzard Buttons"].."|r\n",
			order = 1,
		},
		info = {
			type = "description",
			name = L["BBTN_Desc"].."\n",
			order = 2,
		},
		enable = {
			type = "toggle",
			name = L["Enable Module"],
			desc = L["Enable this module."],
			get = function() return mod:IsEnabled() end,
			set = function(info, s)
				if s then
					BF:EnableModule("BlizzardButtons")
				else
					BF:DisableModule("BlizzardButtons")
				end
			end,
			order = 3,
		},
	},
}

-- [ Core Methods ] --

-- :OnInitialize(): Initialize the module.
function mod:OnInitialize()
	-- Set up defaults.
	local defaults = {
		profile = {
			enabled = false,
			["*"] = {
				skin = {
					ID = "Blizzard",
					Gloss = false,
					Backdrop = false,
					Colors = {},
				},
			},
		},
	}

	-- Set up the DB.
	self.db = self:RegisterNamespace("BlizzardButtons", defaults)
	db = self.db.profile
	self:SetEnabledState(db.enabled)

	-- Hook into the root events.
	BF.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	BF.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	BF.db.RegisterCallback(self, "OnProfileReset", "Refresh")

-- Set up options.
	self:RegisterModuleOptions("BlizzardButtons", options)
end

-- :OnEnable(): Enable function.
function mod:OnEnable()
	-- Register the skin callback function.
	LBF:RegisterSkinCallback("BlizzardButtons", self.SkinCallback, self)

	-- Apply the global skin.
	LBF:Group("BlizzardButtons"):Skin(db["BlizzardButtons"].skin.ID, db["BlizzardButtons"].skin.Gloss, db["BlizzardButtons"].skin.Backdrop, db["BlizzardButtons"].skin.Colors)

	-- Apply the group skins.
	for group, data in pairs(bars) do
		LBF:Group("BlizzardButtons", group):Skin(db[group].skin.ID, db[group].skin.Gloss, db[group].skin.Backdrop, db[group].skin.Colors)
		for i=1, data.count do
			local button = strsub(group, 1, -2)..tostring(i)
			insert(bars[group].buttons, button)
			LBF:Group("BlizzardButtons", group):AddButton(_G[button])
			-- Change the frame strata on the ActionButtons group so that the icons are visible.
			if group == "ActionButtons" then
				_G[button]:SetFrameStrata("HIGH")
			end
		end
	end
	db.enabled = true
end

-- :OnDisable(): Disable function.
function mod:OnDisable()
	local LBFG = LBF:Group("BlizzardButtons")
	for group, data in pairs(bars) do
		for _, button in pairs(data.buttons) do
			LBFG:RemoveButton(button)
		end
		LBFG:Delete()
		bars[group].buttons = {}
	end
	BF:RemoveModuleOptions("BlizzardButtons")
	db.enabled = false
end

-- :Refresh(): Refreshes the module's state.
function mod:Refresh()
	db = self.db.profile
	if db.enabled then
		self:Disable()
		self:Enable()
	else
		self:Disable()
	end
end

-- :SkinCallBack(): Callback function to store settings.
function mod:SkinCallback(SkinID, Gloss, Backdrop, Group, Button, Colors)
	if Group then
		db[Group].skin.ID = SkinID
		db[Group].skin.Gloss = Gloss
		db[Group].skin.Backdrop = Backdrop
		db[Group].skin.Colors = Colors
	end
end
