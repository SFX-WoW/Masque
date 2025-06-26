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
-- Libraries
---

local LIB_DBI = Core.LIB_DBI

----------------------------------------
-- Internal
---

-- @ Core\Groups
local Groups = Core.Groups

-- @ Options\Core
local GetOption, SetOption, Setup = Core.GetOption, Core.SetOption, Core.Setup

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
}

----------------------------------------
-- Functions
---

-- Registers/unregisters events that trigger animations.
local function UpdateEffect(Name, Value)
	local Events = Effects[Name]

	if Events then
		local Frame = ActionBarActionEventsFrame

		if Value then
			for i = 1, #Events do
				local Event = Events[i]

				if Event == "UNIT_SPELLCAST_SENT" then
					Frame:RegisterEvent(Event)
				else
					Frame:RegisterUnitEvent(Event, "player")
				end
			end
		else
			for i = 1, #Events do
				Frame:UnregisterEvent(Events[i])
			end
		end
	end
end

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
				get = GetOption,
				set = SetOption,
				order = 2,
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
						get = function(i) return Core.db.profile.LDB.position end,
						set = function(i, Value) Core:UpdateIconPosition(Value) end,
						values = {
							[0] = L["None"],
							[1] = L["Minimap"],
							[2] = (AddonCompartmentFrame and L["Add-On Compartment"]) or nil,
						},
						order = 2,
						disabled = function() return not LIB_DBI end,
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
						set = function(i, Value)
							Core.db.profile.Interface.SkinInfo = Value
							Core.Setup("Info")
						end,
						order = 8,
					},
					SPC04 = {
						type = "description",
						name = " ",
						order = 10,
					},
					Reload = {
						type = "execute",
						name = L["Reload Interface"],
						desc = L["Click to reload the interface."],
						func = function(i) ReloadUI() end,
						order = -1,
					},
				},
			},
			Effects = self.WOW_RETAIL and {
				type = "group",
				name = L["Advanced"],
				desc = Tooltip,
				get = GetOption,
				set = function(Info, Value)
					local Name = Info[#Info]

					UpdateEffect(Name, Value)
					Core.db.profile.Effects[Name] = Value
				end,
				order = 3,
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
						type = "group",
						name = "",
						inline = true,
						set = function(Info, Value)
							local Name = Info[#Info]

							Core.db.profile.SpellAlert[Name] = Value
						end,
						order = 2,
						args = {
							State = {
								type = "select",
								name = L["Spell Alert Animations"],
								desc = L["Select which spell alert animations are enabled."],
								values = {
									[0] = L["None"],
									[1] = L["Flash and Loop"],
									[2] = L["Loop Only"],
								},
								order = 1,
							},
							Style = {
								type = "select",
								name = L["Spell Alert Style"],
								desc = L["Select the spell alert style."]..Reload,
								values = Core.FlipBook_List,
								order = 2,
							},
						},
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
						desc = L["Enable targeting reticles on action buttons."],
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
						func = function(i)
							local db = Core.db.profile.Groups

							for ID in pairs(db) do
								if not Groups[ID] then
									db[ID] = nil
								end
							end
						end,
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
	self:AddOptionsPanel(Path, self.LIB_ACD:AddToBlizOptions(MASQUE, L["General Settings"], MASQUE, Path))

	-- GC
	Setup.General = nil
end

----------------------------------------
-- Core
---

Core.UpdateEffect = UpdateEffect
