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
local LDB = LibStub("LibDataBroker-1.1", true)
local DBI = LibStub("LibDBIcon-1.0", true)

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
			LDB = {
				hide = true,
				minimapPos = 220,
				radius = 80,
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
			func = function() 
				Core:LoadOptions()
			end,
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
			Core:ShowOptions()
		end
	end
end

-- OnEnable
function MSQ:OnEnable()
	-- Global Button Skin
	Core.Button:Group()

	-- LibDataBroker-1.1
	if LDB then
		Core.LDBO = LDB:NewDataObject(Masque, {
			type  = "launcher",
			label = Masque,
			icon  = "Interface\\Addons\\Masque\\Icon",
			OnClick = function(self, Button)
				if Button == "LeftButton" or Button == "RightButton" then
					Core:ShowOptions()
				end
			end,
			OnTooltipShow = function(Tip)
				if not Tip or not Tip.AddLine then return end
				local Group = Core.Button:Group()
				local Skin = Group.SkinID or "Blizzard"
				Tip:AddLine(Masque)
				Tip:AddLine(L["Click to open Masque's options window."], 1, 1, 1)
				Tip:AddDoubleLine(L["Current Skin:"], "|cffff8000"..Skin.."|r")
			end,
		})

		-- LibDBIcon-1.0
		if DBI then
			DBI:Register(Masque, Core.LDBO, Core.db.profile.LDB)
		end
	end
end

-- Opens the options window.
function Core:ShowOptions()
	if not self.OptionsLoaded then
		print("|cffffff99"..L["Loading Masque Options..."].."|r")
		self:LoadOptions()
	end
	if InterfaceOptionsFrame:IsShown() then
		InterfaceOptionsFrame_Show()
	else
		--InterfaceOptionsFrame_OpenToCategory(Core.OptionsPanel.Profiles)
		InterfaceOptionsFrame_OpenToCategory(Core.OptionsPanel.Buttons)
	end
end

-- Prevent module creation.
function MSQ:NewModule()
	if Core.db.profile.Debug then
		error("Masque does not support modules.", 2)
	end
	return
end

-- [ Core Methods ] --

-- Loads the options when called.
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
	-- LBD Icon
	self.Options.args.General.args.Icon = {
		type = "toggle",
		name = L["Minimap Icon"],
		desc = L["Enable the minimap icon."],
		get = function()
			return not Core.db.profile.LDB.hide
		end,
		set = function(i, v)
			Core.db.profile.LDB.hide = not v
			if not v then
				DBI:Hide(Masque)
			else
				DBI:Show(Masque)
			end
		end,
		disabled = function()
			return not DBI
		end,
		order = 3,
	}
	-- Debug
	self.Options.args.General.args.Debug = {
		type = "toggle",
		name = L["Debug Mode"],
		desc = L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."],
		get = function()
			return Core.db.profile.Debug
		end,
		set = function()
			Core:Debug()
		end,
		order = 4,
	}

	-- Loaded
	self.OptionsLoaded = true

	-- Buttons
	self.Button:LoadOptions()

	-- Profiles
	self.Options.args.Profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.Options.args.Profiles.order = -1
	self.OptionsPanel.Profiles = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(Masque, L["Profiles"], Masque, "Profiles")

	-- LibDualSpec-1.0
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
