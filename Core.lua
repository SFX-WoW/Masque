--[[
	Project.: Masque
	File....: Core.lua
	Version.: @file-revision@
	Author..: Storm FX
]]

local Masque, Core = ...

-- [ Locals ] --

local LibStub = assert(LibStub, "Masque requires LibStub.")
local MSQ = LibStub("AceAddon-3.0"):NewAddon(Masque)

local error, print = error, print
local L = Core.Locale

-- [ Core Elements ] --

Core.Button = {}

-- [ Initial Options] --

Core.Options = {
	type = "group",
	name = Masque,
	args = {
		General = {
			type = "group",
			name = Masque,
			order = 0,
			args = {},
		},
	},
}

-- [ Add-On Methods ] --

-- OnInitialize
function MSQ:OnInitialize()
	-- Defaults
	local Defaults = {
		profile = {
			Debug = false,
			Preload = false,
			Button = {
				["*"] = {
					Import = true,
					Disabled = false,
					SkinID = "Blizzard",
					Gloss = false,
					Backdrop = false,
					Colors = {},
				},
			},
		},
	}

	-- Database
	Core.db = LibStub("AceDB-3.0"):New("MasqueDB", Defaults, true)
	Core.db.RegisterCallback(Core, "OnProfileChanged", "Reload")
	Core.db.RegisterCallback(Core, "OnProfileCopied", "Reload")
	Core.db.RegisterCallback(Core, "OnProfileReset", "Reload")

	-- Options
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(Masque, Core.Options)
	Core.OptionsPanel = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(Masque, Masque, nil, "General")
	if Core.db.profile.Preload then
		Core:LoadOptions()
	else
		Core.Options.args.General.args.Load = {
			type = "execute",
			name = L["Load Masque Options"],
			desc = (L["Click this button to load Masque's options. You can also use the %s or %s chat command."]):format("|cffffcc00/msq|r", "|cffffcc00/masque|r"),
			func = Core.LoadOptions,
			hidden = function()
				return Core.OptionsLoaded or false
			end,
			order = 0,
		}
	end

	-- Slash Commands
	SLASH_MASQUE1 = "/msq"
	SLASH_MASQUE2 = "/masque"
	SlashCmdList["MASQUE"] = function(Cmd, ...)
		if Cmd == "debug" then
			Core:Debug()
		else
			MSQ:ShowOptions()
		end
	end
end

-- OnEnable
function MSQ:OnEnable()
	-- Global Button Skin
	Core.Button:Group()
end

-- Opens the options window.
function MSQ:ShowOptions()
	if not Core.OptionsLoaded then
		print("|cffffff99"..L["Loading Masque Options..."].."|r")
		Core:LoadOptions()
	end
	--InterfaceOptionsFrame_OpenToCategory(Core.OptionsPanel.Profiles)
	InterfaceOptionsFrame_OpenToCategory(Core.OptionsPanel.Buttons)
end

-- Prevent module creation.
function MSQ:NewModule()
	if Core.db.profile.Debug then
		error("Masque does not support modules.", 2)
	end
	return
end

-- [ Core Methods ] --

-- Loads the options table when called.
function Core:LoadOptions()
	-- Info
	self.Options.args.General.args.Info = {
		type = "description",
		name = L["Masque is a modular skinning add-on."].."\n",
		order = 1,
	}
	-- Preload
	self.Options.args.General.args.Preload = {
		type = "toggle",
		name = L["Preload Options"],
		desc = L["Causes Masque to preload its options instead of having them loaded on demand."],
		get = function()
			return Core.db.profile.Preload
		end,
		set = function(i, v)
			Core.db.profile.Preload = v
		end,
		order = 2,
	}
	-- Debug
	self.Options.args.General.args.Debug = {
		type = "toggle",
		name = L["Debug Mode"],
		desc = L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."],
		get = function()
			return Core.db.profile.Debug
		end,
		set = Core.Debug,
		order = 3,
	}

	-- Loaded
	self.OptionsLoaded = true

	-- Buttons
	self.Button:LoadOptions()

	-- Profiles
	self.Options.args.Profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.Options.args.Profiles.order = -1
	self.OptionsPanel.Profiles = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(Masque, L["Profiles"], Masque, "Profiles")

	-- LibDualSpec
	local LDS = LibStub('LibDualSpec-1.0', true)
	if LDS then
		LDS:EnhanceDatabase(self.db, Masque)
		LDS:EnhanceOptions(self.Options.args.Profiles, self.db)
	end
end

-- Reloads settings on profile activity.
function Core:Reload()
	-- Buttons
	self.Button:Reload()
end

-- Toggles debug mode.
function Core:Debug()
	if self.db.profile.Debug then
		self.db.profile.Debug = false
		print("|cffffff99"..L["Masque debug mode disabled."].."|r")
	else
		self.db.profile.Debug = true
		print("|cffffff99"..L["Masque debug mode enabled."].."|r")
	end
end
