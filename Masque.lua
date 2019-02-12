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

	-- General Info
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

local L = Core.Locale
local LDBI = LibStub("LibDBIcon-1.0", true)

----------------------------------------
-- Basic Options Table
---

Core.Options = {
	type = "group",
	name = MASQUE,
	args = {
		General = {
			type = "group",
			name = L["General"],
			order = 0,
			args = {},
		},
	},
}

----------------------------------------
-- Add-On
---

do
	local Masque = LibStub("AceAddon-3.0"):NewAddon(MASQUE)

	-- ADDON_LOADED Event
	function Masque:OnInitialize()
		-- DB
		local Defaults = {
			profile = {
				Debug = false,
				Groups = {
					["*"] = {
						Inherit = true,
						Disabled = false,
						SkinID = "Classic",
						Gloss = 0,
						Backdrop = false,
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
		SLASH_MASQUE1 = "/msq"
		SLASH_MASQUE2 = "/masque"
		SlashCmdList["MASQUE"] = function(Cmd, ...)
			if Cmd == "debug" then
				Core:ToggleDebug()
			else
				Core:ShowOptions()
			end
		end
	end

	local ACR = LibStub("AceConfigRegistry-3.0")
	local LDB = LibStub("LibDataBroker-1.1", true)

	-- PLAYER_LOGIN Event
	function Masque:OnEnable()
		local db = Core.db.profile
		ACR:RegisterOptionsTable(MASQUE, Core.Options)
		Core.ACR = ACR
		Core.OptionsPanel = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(MASQUE, MASQUE, nil, "General")
		Core.Options.args.General.args.Load = {
			type = "execute",
			name = L["Load Masque Options"],
			desc = (L["Click this button to load Masque's options. You can also use the %s or %s chat command."]):format("|cffffcc00/msq|r", "|cffffcc00/masque|r"),
			func = function()
				Core:LoadOptions()
				InterfaceOptionsFrame_OpenToCategory(Core.OptionsPanel.Addons)
			end,
			hidden = function()
				return Core.OptionsLoaded
			end,
			order = 0,
		}
		if LDB then
			Core.LDBO = LDB:NewDataObject(MASQUE, {
				type  = "launcher",
				label = MASQUE,
				icon  = "Interface\\Addons\\Masque\\Textures\\Icon",
				OnClick = function(self, Button)
					if Button == "LeftButton" or Button == "RightButton" then
						Core:ShowOptions()
					end
				end,
				OnTooltipShow = function(Tip)
					if not Tip or not Tip.AddLine then
						return
					end
					Tip:AddLine(MASQUE)
					Tip:AddLine(L["Click to open Masque's options window."], 1, 1, 1)
				end,
			})
			Core.LDB = LDB
			if LDBI then
				LDBI:Register(MASQUE, Core.LDBO, db.LDB)
				Core.LDBI = LDBI
			end
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
	-- Toggles debug mode.
	function Core:ToggleDebug()
		local db = self.db.profile
		db.Debug = not db.Debug
		Core.Debug = db.Debug
		if db.Debug then
			print("|cffffff99"..L["Masque debug mode disabled."].."|r")
		else
			print("|cffffff99"..L["Masque debug mode enabled."].."|r")
		end
	end

	-- Updates on profile activity.
	function Core:Update()
		-- Debug
		Core.Debug = self.db.profile.Debug

		-- Skin Settings
		local Global = Core:Group()
		Global:Update()

		-- LDB Icon
		if LDBI then
			LDBI:Refresh(MASQUE, Core.db.profile.LDB)
		end
	end
end
