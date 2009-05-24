--[[
	Project.: ButtonFacade
	File....: Modules/BlizzardBuffs.lua
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
	["Blizzard Buffs"] = "Blizzard Buffs",
	["BBUFF_Desc"] = "Allows the default Blizzard buffs to be skinned by ButtonFacade.",
	["Enable Module"] = "Enable Module",
	["Enable this module."]	= "Enable this module.",
}
-- Automatically inject all other locales. Please use the localization application on WoWAce.com to update these.
-- http://www.wowace.com/projects/buttonfacade/localization/namespaces/buttontest/
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

-- [ Set Up ] --

-- Create the module.
local mod = BF:NewModule("BlizzardBuffs")

-- Locals
local pairs, insert = pairs, table.insert
local db
local buffs = {}
local colors = { 
	none = {0.8, 0, 0, 1},
	Magic = {0.2, 0.6, 1, 1},
	Curse = {0.6, 0, 1, 1},
	Poison = {0.6, 0.4, 0, 1},
	Disease = {0, 0.6, 0, 1},
	Enchant = {0.2, 0, 0.4, 1},
}

-- Options
local options = {
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
			name = L["BBUFF_Desc"].."\n",
			order = 2,
		},
		enable = {
			type = "toggle",
			name = L["Enable Module"],
			desc = L["Enable this module."],
			get = function() return mod:IsEnabled() end,
			set = function(info, s)
				if s then
					BF:EnableModule("BlizzardBuffs")
				else
					BF:DisableModule("BlizzardBuffs")
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
		},
	}

	-- Set up the DB.
	self.db = self:RegisterNamespace("BlizzardBuffs", defaults)
	db = self.db.profile
	self:SetEnabledState(db.enabled)

	-- Hook into the root events.
	BF.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	BF.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	BF.db.RegisterCallback(self, "OnProfileReset", "Refresh")

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
	hooksecurefunc("BuffFrame_Update", self.Update)
	self:Update()
	db.enabled = true
end

-- :OnDisable(): Disable function.
function mod:OnDisable()
	LBF:Group("BlizzardBuffs"):Delete()
	BF:RemoveModuleOptions("BlizzardBuffs")
	db.enabled = false
	wipe(buffs)
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

-- :Update(): Updates the list of buffs to be skinned.
function mod:Update()
	local group = LBF:Group("BlizzardBuffs")
	-- Buffs
	for i=1, BUFF_ACTUAL_DISPLAY do
		local btn = "BuffButton"..i
		if _G[btn] then
			buffs[btn] = btn
			group:AddButton(_G[btn])
		else
			if buffs[btn] then
				buffs[btn] = nil
				group:RemoveButton(_G[btn])
			end
		end
	end
	-- Debuffs
	for i=1, DEBUFF_ACTUAL_DISPLAY do
		local _, _, _, _, t = UnitDebuff("player", i)
		if not t then t = "none" end
		local btn = "DebuffButton"..i
		if _G[btn] then
			buffs[btn] = btn
			local border = btn.."Border"
			group:AddButton(_G[btn])
			_G[border]:SetVertexColor(unpack(colors[t]))
		else
			if buffs[btn] then
				buffs[btn] = nil
				group:RemoveButton(_G[btn])
			end
		end
	end
	-- Temp Enchants
	for i=1, 2 do
		local btn = "TempEnchant"..i
		if _G[btn] then
			buffs[btn] = btn
			local border = btn.."Border"
			group:AddButton(_G[btn])
			_G[border]:SetVertexColor(unpack(colors["Enchant"]))
		else
			if buffs[btn] then
				buffs[btn] = nil
				group:RemoveButton(_G[btn])
			end
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
end
