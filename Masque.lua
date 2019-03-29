--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Masque.lua
	* Author.: StormFX

	Add-On Setup

]]

-- GLOBALS: LibStub, GetAddOnMetadata

local MASQUE, Core = ...

assert(LibStub, MASQUE.." requires LibStub.")

----------------------------------------
-- Lua
---

local print = print

----------------------------------------
-- API
---

do
	local VERSION = 80100
	Core.API = LibStub:NewLibrary(MASQUE, VERSION)

	----------------------------------------
	-- Internal
	---

	Core.API_VERSION = VERSION
	Core.OLD_VERSION = 70200

	-- Core Info
	Core.Version = GetAddOnMetadata(MASQUE, "Version")
	Core.Authors = {
		"StormFX",
		"|cff999999JJSheets|r",
	}
	Core.Websites = {
		"https://github.com/stormfx/masque",
		"https://www.wowace.com/projects/masque",
		"https://www.curseforge.com/wow/addons/masque",
		"https://www.wowinterface.com/downloads/info12097",
	}
end

----------------------------------------
-- Add-On
---

do
	local Masque = LibStub("AceAddon-3.0"):NewAddon(MASQUE)

	-- ADDON_LOADED Event
	function Masque:OnInitialize()
		-- DB Setup
		local Defaults = {
			profile = {
				Debug = false,
				SkinInfo = true,
				StandAlone = false,
				Groups = {
					["*"] = {
						Inherit = true,
						Disabled = false,
						SkinID = "Classic",
						Backdrop = false,
						Shadow = false,
						Gloss = false,
						Colors = {},
					},
				},
				LDB = {
					hide = true,
					minimapPos = 220,
					radius = 80,
				},
			},
		}

		local db = LibStub("AceDB-3.0"):New("MasqueDB", Defaults, true)
		db.RegisterCallback(Core, "OnProfileChanged", "Update")
		db.RegisterCallback(Core, "OnProfileCopied", "Update")
		db.RegisterCallback(Core, "OnProfileReset", "Update")
		Core.db = db

		-- LibDualSpec-1.0
		local LDS = LibStub("LibDualSpec-1.0", true)
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
		-- Core Options
		local Setup = Core.Setup
		if Setup then
			Setup("Core")
			Setup("LDB")
		end

		-- Re-skin queued groups.
		if Core.Queue then
			Core.Queue:ReSkin()
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
end

----------------------------------------
-- Core
---

do
	local L = Core.Locale

	-- Toggles debug mode.
	function Core.ToggleDebug()
		local db = Core.db.profile

		db.Debug = not db.Debug
		Core.Debug = db.Debug

		if db.Debug then
			print("|cffffff99"..L["Masque debug mode enabled."].."|r")
		else
			print("|cffffff99"..L["Masque debug mode disabled."].."|r")
		end
	end

	-- Updates on profile activity.
	function Core:Update()
		-- Debug
		self.Debug = self.db.profile.Debug

		-- Skin Settings
		local Global = self.GetGroup()
		Global:Update()

		-- Skin Info Panel
		self.Setup("Info")

		-- LDB Icon
		local LDBI = LibStub("LibDBIcon-1.0", true)
		if LDBI then
			LDBI:Refresh(MASQUE, Core.db.profile.LDB)
		end
	end
end
