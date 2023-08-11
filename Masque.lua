--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	docuementation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Masque.lua
	* Author.: StormFX

	Add-On Setup

]]

local MASQUE, Core = ...

assert(LibStub, MASQUE.." requires LibStub.")

----------------------------------------
-- Lua API
---

local print = print

----------------------------------------
-- Internal
---

-- @ Locales\enUS
local L = Core.Locale

----------------------------------------
-- Locals
---

local Masque = LibStub("AceAddon-3.0"):NewAddon(MASQUE)

-- API Version
local API_VERSION = 100105

-- Client Version
local WOW_VERSION = select(4, GetBuildInfo()) or 0
local WOW_RETAIL = (WOW_VERSION > 100000 and true) or nil

----------------------------------------
-- Utility
---

-- Updates saved variables and related settings.
local function UpdateDB()
	local db = Core.db.profile
	local Version = db.API_VERSION

	-- Migrate saved variables for API updates.
	-- SkinID Migration @ 100002
	if Version < 100002 then
		local GetSkinID = Core.GetSkinID

		for _, gDB in pairs(db.Groups) do
			local SkinID = gDB.SkinID
			local NewID = GetSkinID(SkinID)

			-- Client-Specific Skin
			if SkinID == "Default" then
				gDB.SkinID = Core.DEFAULT_SKIN_ID

			-- Other
			elseif NewID then
				gDB.SkinID = NewID
			end
		end

	-- Namespace Migration @ 100105
	elseif Version < 100105 then
		db.Developer.Debug = db.Debug

		local Interface = db.Interface

		Interface.AltSort = db.AltSort
		Interface.SkinInfo = db.SkinInfo
		Interface.StandAlone = db.StandAlone

		db.AltSort = nil
		db.Debug = nil
		db.SkinInfo = nil
		db.StandAlone = nil
	end

	-- Update the API version.
	db.API_VERSION = API_VERSION

	-- Icon
	Core:UpdateIconPosition()

	-- Debug
	Core.Debug = db.Developer.Debug
end

----------------------------------------
-- Core
---

-- API
Core.API_VERSION = API_VERSION
Core.OLD_VERSION = 70200

Core.API = LibStub:NewLibrary(MASQUE, API_VERSION)

-- Client Version
Core.WOW_VERSION = WOW_VERSION
Core.WOW_RETAIL = WOW_RETAIL

-- Add-On Info
Core.Version = "@project-version@"
Core.Discord = "https://discord.gg/7MTWRgDzz8"

Core.Authors = {
	"StormFX",
	"|cff999999JJSheets|r",
}
Core.Websites = {
	"https://github.com/SFX-WoW/Masque",
	"https://www.curseforge.com/wow/addons/masque",
	"https://addons.wago.io/addons/masque",
	"https://www.wowinterface.com/downloads/info12097",
}

-- Toggles debug mode.
function Core.ToggleDebug()
	local db = Core.db.profile.Developer
	local Debug = not db.Debug

	db.Debug = Debug
	Core.Debug = Debug

	if Debug then
		print("|cffffff99"..L["Masque debug mode enabled."].."|r")
	else
		print("|cffffff99"..L["Masque debug mode disabled."].."|r")
	end
end

-- Updates settings on profile activity.
function Core:UpdateProfile()
	-- LibDBIcon-1.0
	local LDBI = LibStub("LibDBIcon-1.0", true)

	if LDBI then
		LDBI:Refresh(MASQUE, Core.db.profile.LDB)
	end

	-- Saved Variables
	UpdateDB()

	-- Skins and Skin Options
	local Global = self.GetGroup()
	Global:__Update()

	-- Info Panel
	self.Setup("Info")
end

----------------------------------------
-- Add-On
---

-- ADDON_LOADED Event
function Masque:OnInitialize()
	local Defaults = {
		profile = {
			API_VERSION = 0,
			CB_Warn = {
				["*"] = true
			},
			Developer = {
				Debug = false,
			},
			Groups = {
				["*"] = {
					Backdrop = false,
					Colors = {},
					Disabled = false,
					Gloss = false,
					Inherit = true,
					Pulse = true,
					Scale = 1,
					Shadow = false,
					SkinID = Core.DEFAULT_SKIN_ID,
					UseScale = false,
				},
			},
			Interface = {
				AltSort = false,
				SkinInfo = true,
				StandAlone = true,
			},
			LDB = {
				hide = false,
				minimapPos = 240,
				position = 1,
				radius = 80,
			},
		},
	}

	-- AceDB-3.0
	local db = LibStub("AceDB-3.0"):New("MasqueDB", Defaults, true)

	db.RegisterCallback(Core, "OnProfileChanged", "UpdateProfile")
	db.RegisterCallback(Core, "OnProfileCopied", "UpdateProfile")
	db.RegisterCallback(Core, "OnProfileReset", "UpdateProfile")

	Core.db = db

	-- LibDualSpec-1.0
	local LDS = (WOW_VERSION > 30000) and LibStub("LibDualSpec-1.0", true)

	if LDS then
		LDS:EnhanceDatabase(Core.db, MASQUE)
	end

	-- Slash Commands
	SLASH_MASQUE1 = "/msq"
	SLASH_MASQUE2 = "/masque"

	SlashCmdList["MASQUE"] = function(Cmd, ...)
		if Cmd == "debug" then
			Core.ToggleDebug()
		else
			Core:ToggleOptions()
		end
	end
end

-- PLAYER_LOGIN Event
function Masque:OnEnable()
	-- Saved Variables
	UpdateDB()

	-- Skin queued groups.
	if Core.Queue then
		Core.Queue:ReSkin()
	end

	-- Core Options
	local Setup = Core.Setup

	if Setup then
		Setup("Core")
		Setup("LDB")
	end
end

-- Wrapper for the DB:CopyProfile method.
function Masque:CopyProfile(Name, Silent)
	Core.db:CopyProfile(Name, Silent)
end

-- Wrapper for the DB:SetProfile method.
function Masque:SetProfile(Name)
	Core.db:SetProfile(Name)
end
