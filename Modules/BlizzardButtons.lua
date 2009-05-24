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
local _G, pairs, strsub, tostring = _G, pairs, strsub, tostring
local db

-- Buttons
local buttons = {
	ActionButtons = 12,
	BonusActionButtons = 12,
	MultiBarBottomLeftButtons = 12,
	MultiBarBottomRightButtons = 12,
	MultiBarLeftButtons = 12,
	MultiBarRightButtons = 12,
	ShapeshiftButtons = 10,
	PetActionButtons = 10,
	PossessButtons = 2,
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
			skin = {
				ID = "Blizzard",
				Gloss = false,
				Backdrop = false,
				Colors = {},
			},
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
	LBF:Group("BlizzardButtons"):Skin(db.skin.ID, db.skin.Gloss, db.skin.Backdrop, db.skin.Colors)

	-- Apply the group skins.
	for group, count in pairs(buttons) do
		LBF:Group("BlizzardButtons", group):Skin(db[group].skin.ID, db[group].skin.Gloss, db[group].skin.Backdrop, db[group].skin.Colors)
		for i=1, count do
			local button = strsub(group, 1, -2)..tostring(i)
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
	LBF:Group("BlizzardButtons"):Delete()
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
	if not Group then
		db.skin.ID = SkinID
		db.skin.Gloss = Gloss
		db.skin.Backdrop = Backdrop
		db.skin.Colors = Colors
	else
		db[Group].skin.ID = SkinID
		db[Group].skin.Gloss = Gloss
		db[Group].skin.Backdrop = Backdrop
		db[Group].skin.Colors = Colors
	end
end
