--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Options/Core.lua
	* Author.: StormFX

	Core Options Group/Panel

]]

-- GLOBALS: LibStub, InterfaceOptionsFrame, InterfaceOptionsFrame_OpenToCategory, InterfaceOptionsFrame_Show

local MASQUE, Core = ...

----------------------------------------
-- Setup
---

-- Options Loader
local Setup = {}
Core.Setup = setmetatable(Setup, {
	__call = function(self, Name, ...)
		local func = Name and self[Name]
		if func then
			func(Core, ...)
		end
	end,
})

-- Sets up the root options group/panel.
function Setup.Core(self)
	local L = self.Locale

	-- Root Options Group
	local Options = {
		type = "group",
		name = MASQUE,
		args = {
			Core = {
				type = "group",
				name = L["About"],
				order = 0,
				args = {
					Title = {
						type = "description",
						name = "|cffffcc00"..MASQUE.." - "..L["About"].."|r\n",
						order = 0,
						fontSize = "medium",
						hidden = Core.GetStandAlone,
					},
					Desc = {
						type = "description",
						name = L["This section will allow you to view information about Masque and any skins you have installed."].."\n",
						order = 1,
						fontSize = "medium",
						hidden = function() return not Core.OptionsLoaded end,
					},
					-- Necessary when manually navigating to the InterfaceOptionsFrame prior to the options being loaded.
					Load = {
						type = "group",
						name = "",
						inline = true,
						--order = 100,
						hidden = function() return Core.OptionsLoaded end,
						args = {
							Desc = {
								type = "description",
								name = L["Masque's options are load on demand. Click the button below to load them."].."\n",
								fontSize = "medium",
								order = 0,
							},
							Button = {
								type = "execute",
								name = L["Load Options"],
								desc = L["Click to load Masque's options."],
								func = function()
									if not Core.OptionsLoaded then
										Core:LoadOptions()
									end
									-- Force a sub-panel refresh.
									-- Call the main panel first to prevent an error in AceConfigDialog-3.0.
									InterfaceOptionsFrame_OpenToCategory(Core.OptionsPanel)
									InterfaceOptionsFrame_OpenToCategory(Core.SkinOptionsPanel)
									InterfaceOptionsFrame_OpenToCategory(Core.OptionsPanel)
									Core.Options.args.Core.args.Load = nil -- GC
								end,
								order = 1,
							},
						},
					},
				},
			},
		},
	}

	-- Root Options Group/Panel
	self.Options = Options
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(MASQUE, self.Options)
	self.OptionsPanel = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(MASQUE, MASQUE, nil, "Core")

	-- GC
	Setup.Core = nil
end

-- Loads all remaining options.
function Core:LoadOptions()
	if self.OptionsLoaded then return end
	self.OptionsLoaded = true

	-- Load the options.
	Setup("About")
	Setup("Info")
	Setup("Skins")
	Setup("General")
	Setup("Profiles")
end

----------------------------------------
-- Core
---

do
	local ACD = LibStub("AceConfigDialog-3.0")

	-- Toggles the Interface/ACD options frame.
	function Core:ToggleOptions()
		if not self.OptionsLoaded then
			self:LoadOptions()
		end
		local IOF_Open = InterfaceOptionsFrame:IsShown()
		local ACD_Open = ACD.OpenFrames[MASQUE]

		-- Toggle the stand-alone GUI if enabled.
		if self.db.profile.StandAlone then
			if IOF_Open then
				InterfaceOptionsFrame_Show()
			elseif ACD_Open then
				ACD:Close(MASQUE)
			else
				ACD:Open(MASQUE)
			end
		-- Toggle the Interface Options frame.
		else
			if ACD_Open then
				ACD:Close(MASQUE)
			elseif IOF_Open then
				InterfaceOptionsFrame_Show()
			else
				-- Call twice to make sure the IOF opens to the proper category.
				InterfaceOptionsFrame_OpenToCategory(self.OptionsPanel)
				InterfaceOptionsFrame_OpenToCategory(self.SkinOptionsPanel)
			end
		end
	end

	----------------------------------------
	-- Utility
	---

	-- Hides or shows panel titles.
	function Core.GetStandAlone()
		return not ACD.OpenFrames[MASQUE]
	end

	-- Returns the 'arg' of an options group.
	Core.GetArg = function(info, ...)
		return info.arg
	end

	-- NoOp
	Core.NoOp = function() end
end
