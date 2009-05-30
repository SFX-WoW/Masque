--[[
	Project.: ButtonFacade
	File....: Modules/BlizzardButtons.lua
	Version.: @file-revision@
	Author..: StormFX
]]

-- [ Localization ] --

-- Hard-code enUS/enGB.
local L = {
	["Blizzard Buttons"] = "Blizzard Buttons",
	["Allows the default Blizzard buttons to be skinned by ButtonFacade."] = "Allows the default Blizzard buttons to be skinned by ButtonFacade.",
	["Enable Module"] = "Enable Module",
	["Enable this module."]	= "Enable this module.",
	["Skin Main Bar"] = "Skin Main Bar",
	["Skin the buttons of the main action bar."] = "Skin the buttons of the main action bar.",
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

-- Dependencies
local BF = LibStub("AceAddon-3.0"):GetAddon("ButtonFacade")
local LBF = LibStub("LibButtonFacade")
if not LBF then return end

-- [ Set Up ] --

-- Create the module.
local mod = BF:NewModule("BlizzardButtons")

-- Locals
local _G, pairs, strsub, format = _G, pairs, strsub, format
local db
local buttons = {
	BonusActionButtons = 12,
	MultiBarBottomLeftButtons = 12,
	MultiBarBottomRightButtons = 12,
	MultiBarLeftButtons = 12,
	MultiBarRightButtons = 12,
	ShapeshiftButtons = 10,
	PetActionButtons = 10,
	PossessButtons = 2,
}

-- [ Options ] --

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
			name = L["Allows the default Blizzard buttons to be skinned by ButtonFacade."].."\n",
			order = 2,
		},
		enable = {
			type = "toggle",
			name = L["Enable Module"],
			desc = L["Enable this module."],
			get = function() return mod:IsEnabled() end,
			set = function(info, s) BF:ToggleModule("BlizzardButtons", s) end,
			order = 3,
		},
		mainbar = {
			type = "toggle",
			name = L["Skin Main Bar"],
			desc = L["Skin the buttons of the main action bar."],
			get = function() return db.mainbar end,
			set = function(info, s)
				db.mainbar = s
				mod:UpdateMainBar()
			end,
			disabled = function() return not mod:IsEnabled() end,
			order = 4,
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
			mainbar = true,
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
			local button = strsub(group, 1, -2).."%d"
			button = button:format(i)
			LBF:Group("BlizzardButtons", group):AddButton(_G[button])
		end
	end
	self:UpdateMainBar()
end

-- :OnDisable(): Disable function.
function mod:OnDisable()
	LBF:Group("BlizzardButtons"):Delete()
	BF:RemoveModuleOptions("BlizzardButtons")
end

-- :Refresh(): Refreshes the module's profile.
function mod:Refresh()
	db = self.db.profile
end

-- :UpdateMainBar(): Skins the main menu bar buttons if enabled.
function mod:UpdateMainBar()
	local g = "ActionButtons"
	local group = LBF:Group("BlizzardButtons", g)
	if db.mainbar then
		group:Skin(db[g].skin.ID, db[g].skin.Gloss, db[g].skin.Backdrop, db[g].skin.Colors)
		for i=1, 12 do
			local button = "ActionButton%d"
			button = button:format(i)
			group:AddButton(_G[button])
			-- Change the frame strata on the ActionButtons group so that the icons are visible.
			_G[button]:SetFrameStrata("HIGH")
		end
	else
		group:Delete()
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
