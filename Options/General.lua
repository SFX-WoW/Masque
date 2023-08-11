--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Options\General.lua
	* Author.: StormFX

	'General Settings' Group/Panel

]]

local MASQUE, Core = ...

----------------------------------------
-- WoW API
---

local ReloadUI = ReloadUI

----------------------------------------
-- Internal
---

-- @ Options\Core
local Setup = Core.Setup
local WOW_RETAIL = Core.WOW_RETAIL
local GetOption, SetOption = Core.GetOption, Core.SetOption

----------------------------------------
-- Locals
---

-- Animation Events
local Effects = {
	Castbar = {
		"UNIT_SPELLCAST_CHANNEL_START",
		"UNIT_SPELLCAST_CHANNEL_STOP",
		"UNIT_SPELLCAST_EMPOWER_START",
		"UNIT_SPELLCAST_EMPOWER_STOP",
		"UNIT_SPELLCAST_START",
		"UNIT_SPELLCAST_STOP",
	},
	Interrupt = {
		"UNIT_SPELLCAST_INTERRUPTED",
		"UNIT_SPELLCAST_SUCCEEDED",
	},
	Reticle = {
		"UNIT_SPELLCAST_FAILED",
		"UNIT_SPELLCAST_RETICLE_CLEAR",
		"UNIT_SPELLCAST_RETICLE_TARGET",
		"UNIT_SPELLCAST_SENT",
	},
	SpellAlert = {
		"SPELL_ACTIVATION_OVERLAY_GLOW_HIDE",
		"SPELL_ACTIVATION_OVERLAY_GLOW_SHOW",
	},
}

-- Registers/unregisters events that trigger animations.
local function UpdateEffect(Name, Value)
	local Frame = _G.ActionBarActionEventsFrame
	local Events = Effects[Name]

	if Value then
		if Name == "SpellAlert" then
			if Value > 0 then
				Frame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
				Frame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
			else
				Frame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
				Frame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
			end
		else
			for i = 1, #Events do
				local Event = Events[i]

				if Event == "UNIT_SPELLCAST_SENT" then
					Frame:RegisterEvent(Event)
				else
					Frame:RegisterUnitEvent(Event, "player")
				end
			end
		end
	else
		for i = 1, #Events do
			Frame:UnregisterEvent(Events[i])
		end
	end
end

local function SetEffectOption(Info, Value)
	local Name = Info[#Info]

	Core.db.profile.Effects[Name] = Value

	if Name ~= "Cooldown" then
		UpdateEffect(Name, Value)
	end
end

Core.UpdateEffect = UpdateEffect

----------------------------------------
-- Setup
---

-- Creates the 'General Settings' group/panel.
function Setup.General(self)
	-- @ Locales\enUS
	local L = self.Locale

	-- @ Masque
	local CRLF = Core.CRLF

	local Reload = "\n|cff0099ff"..L["Requires an interface reload."].."|r"
	local Tooltip = "|cffffffff"..L["Select to view."].."|r"

	local Options = {
		type = "group",
		name = L["General Settings"],
		order = 2,
		args = {
			Head = {
				type = "header",
				name = MASQUE.." - "..L["General Settings"],
				hidden = self.GetStandAlone,
				order = 0,
				disabled = true,
				dialogControl = "SFX-Header",
			},
			Desc = {
				type = "description",
				name = L["This section will allow you to adjust Masque's interface and performance settings."]..CRLF,
				order = 1,
				fontSize = "medium",
			},
			Interface = {
				type = "group",
				name = L["Interface"],
				desc = Tooltip,
				order = 2,
				get = GetOption,
				set = SetOption,
				args = {
					Head = {
						type = "header",
						name = L["Interface Settings"],
						order = 0,
						disabled = true,
						dialogControl = "SFX-Header",
					},
					Desc = {
						type = "description",
						name = L["This section will allow you to adjust settings that affect Masque's interface."]..CRLF,
						order = 1,
						fontSize = "medium",
					},
					Icon = {
						type = "select",
						name = L["Menu Icon"],
						desc = L["Select where Masque's menu icon is displayed."],
						order = 2,
						values = {
							[0] = L["None"],
							[1] = L["Minimap"],
							[2] = (WOW_RETAIL and L["Add-On Compartment"]) or nil,
						},
						get = function(i) return Core.db.profile.LDB.position end,
						set = function(i, v) Core:UpdateIconPosition(v) end,
						disabled = function() return not Core.LDBI end,
					},
					SPC01 = {
						type = "description",
						name = " ",
						order = 3,
					},
					StandAlone = {
						type = "toggle",
						name = L["Stand-Alone GUI"],
						desc = L["Use a resizable, stand-alone options window."],
						get = GetOption,
						set = SetOption,
						order = 4,
					},
					SPC02 = {
						type = "description",
						name = " ",
						order = 5,
					},
					AltSort = {
						type = "toggle",
						name = L["Alternate Sorting"],
						desc = L["Causes the skins included with Masque to be listed above third-party skins."],
						get = GetOption,
						set = SetOption,
						order = 6,
					},
					SPC03 = {
						type = "description",
						name = " ",
						order = 7,
					},
					SkinInfo = {
						type = "toggle",
						name = L["Skin Information"],
						desc = L["Load the skin information panel."]..Reload,
						order = 8,
						get = GetOption,
						set = function(i, v)
							Core.db.profile.Interface.SkinInfo = v
							Core.Setup("Info")
						end,
					},
					SPC04 = {
						type = "description",
						name = " ",
						order = 10,
					},
					Reload = {
						type = "execute",
						name = L["Reload Interface"],
						desc = L["Click to load reload the interface."],
						order = -1,
						func = function() ReloadUI() end,
					},
				},
			},
			Effects = Core.WOW_RETAIL and {
				type = "group",
				name = L["Advanced"],
				desc = Tooltip,
				order = 3,
				get = GetOption,
				set = SetEffectOption,
				args = {
					Head = {
						type = "header",
						name = L["Advanced Settings"],
						order = 0,
						disabled = true,
						dialogControl = "SFX-Header",
					},
					Desc = {
						type = "description",
						name = L["This section will allow you to adjust button settings for the default interface."]..CRLF,
						order = 1,
						fontSize = "medium",
					},
					SpellAlert = {
						type = "select",
						name = L["Spell Alerts"],
						desc = L["Select which spell alert animations are enabled."],
						values = {
							[0] = L["None"],
							[1] = L["Flash and Loop"],
							[2] = L["Loop Only"],
						},
						order = 2,
					},
					SPC01 = {
						type = "description",
						name = " ",
						order = 3,
					},
					Castbar = {
						type = "toggle",
						name = L["Cast Animations"],
						desc = L["Enable cast animations on action buttons."],
						order = 4,
					},
					SPC02 = {
						type = "description",
						name = " ",
						order = 5,
						hidden = true,
					},
					Cooldown = {
						type = "toggle",
						name = L["Cooldown Animations"],
						desc = L["Enable animations when action button cooldowns finish."],
						hidden = true,
						order = 6,
					},
					SPC03 = {
						type = "description",
						name = " ",
						order = 7,
					},
					Interrupt = {
						type = "toggle",
						name = L["Interrupt Animations"],
						desc = L["Enable interrupt animations on action buttons."],
						order = 8,
					},
					SPC04 = {
						type = "description",
						name = " ",
						order = 9,
					},
					Reticle = {
						type = "toggle",
						name = L["Targeting Reticles"],
						desc = L["Eanble targeting reticles on action buttons."],
						order = 10,
					},
				},
			} or nil,
			Developer = {
				type = "group",
				name = L["Developer"],
				desc = Tooltip,
				order = 10,
				args = {
					Head = {
						type = "header",
						name = L["Developer Settings"],
						order = 0,
						disabled = true,
						dialogControl = "SFX-Header",
					},
					Desc = {
						type = "description",
						name = L["This section will allow you to adjust settings that affect working with Masque's API."]..CRLF,
						order = 1,
						fontSize = "medium",
					},
					Debug = {
						type = "toggle",
						name = L["Debug Mode"],
						desc = L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."],
						get = GetOption,
						set = self.ToggleDebug,
						order = 2,
					},
					SPC01 = {
						type = "description",
						name = " ",
						order = 10,
					},
					Purge = {
						type = "execute",
						name = L["Clean Database"],
						desc = L["Click to purge the settings of all unused add-ons and groups."],
						func = Core.CleanDB,
						order = -1,
						confirm = true,
						confirmText = L["This action cannot be undone. Continue?"],
					},
				},
			},
		},
	}

	self.Options.args.General = Options

	local Path = "General"
	self:AddOptionsPanel(Path, LibStub("AceConfigDialog-3.0"):AddToBlizOptions(MASQUE, L["General Settings"], MASQUE, Path))

	-- GC
	Setup.General = nil
end
