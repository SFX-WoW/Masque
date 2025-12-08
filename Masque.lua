--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

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
-- Libraries
---

local LIB_DBI = LibStub("LibDBIcon-1.0", true)
local LIB_LDS = LibStub("LibDualSpec-1.0", true)

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
local API_VERSION = 110207

-- Client Version
local WOW_VERSION = select(4, GetBuildInfo()) or 0
local WOW_RETAIL = ((WOW_VERSION > 110000) and true) or nil

----------------------------------------
-- Utility
---

-- Updates saved variables and related settings.
local function UpdateDB()
	local db = Core.db.profile

	db.API_VERSION = API_VERSION
	db.CB_Warn = nil

	-- Refresh Settings
	Core:UpdateIconPosition()
	Core.Debug = db.Developer.Debug
end

----------------------------------------
-- Core
---

-- Libraries
Core.LIB_DBI = LIB_DBI
Core.LIB_LDS = LIB_LDS

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
	if LIB_DBI then
		LIB_DBI:Refresh(MASQUE, Core.db.profile.LDB)
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

-- 'ADDON_LOADED' Event
function Masque:OnInitialize()
	local Defaults = {
		profile = {
			API_VERSION = 0,
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
				ProfileFontFix = true,
				SkinInfo = true,
				StandAlone = true,
			},
			LDB = {
				hide = false,
				minimapPos = 240,
				position = 1,
				radius = 80,
			},
			Effects = {
				Castbar = true,
				Interrupt = true,
				Reticle = true,
			},
			SpellAlert = {
				State = 1,
				Style = 0,
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
	if LIB_LDS then
		LIB_LDS:EnhanceDatabase(Core.db, MASQUE)
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

-- 'PLAYER_LOGIN' Event
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

-- 'PLAYER_ENTERING_WORLD' Event
if WOW_RETAIL then
	local MSQ_EVENTS_FRAME = CreateFrame("Frame", "MSQ_EVENTS_FRAME")
	MSQ_EVENTS_FRAME:Hide()

	local function OnEvent(...)
		-- Animation Settings
		local db = Core.db.profile
		local UpdateEffect = Core.UpdateEffect

		for k, v in pairs(db.Effects) do
			UpdateEffect(k, v)
		end
	end

	-- Delay the registering of events until after `PLAYER_LOGIN`.
	MSQ_EVENTS_FRAME:RegisterEvent("PLAYER_ENTERING_WORLD")
	MSQ_EVENTS_FRAME:SetScript("OnEvent", OnEvent)
end

-- Wrapper for the DB:CopyProfile method.
function Masque:CopyProfile(Name, Silent)
	Core.db:CopyProfile(Name, Silent)
end

-- Wrapper for the DB:SetProfile method.
function Masque:SetProfile(Name)
	Core.db:SetProfile(Name)
end
