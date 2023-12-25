--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Options/Core.lua
	* Author.: StormFX

	Core Options Group/Panel

]]

local MASQUE, Core = ...

----------------------------------------
-- WoW API
---

local InCombatLockdown = InCombatLockdown

----------------------------------------
-- Libraries
---

local LIB_ACD = LibStub("AceConfigDialog-3.0")
local LIB_ACR = LibStub("AceConfigRegistry-3.0")

----------------------------------------
-- Locals
---

-- Empty lines need a space.
local CRLF = "\n "

-- Options Loader Frame
local OPT_LDR_FRAME

----------------------------------------
-- Setup
---

-- Options Setup Table
local Setup = {}

-- Sets up the root options group/panel.
function Setup.Core(self)
	-- @ Locales\enUS
	local L = self.Locale

	local Options = {
		type = "group",
		name = MASQUE,
		args = {
			Core = {
				type = "group",
				name = L["About"],
				order = 0,
				args = {
					Head = {
						type = "header",
						name = MASQUE.." - "..L["About"],
						order = 0,
						hidden = self.GetStandAlone,
						disabled = true,
						dialogControl = "SFX-Header",
					},
					Desc = {
						type = "description",
						name = L["This section will allow you to view information about Masque and any skins you have installed."]..CRLF,
						order = 1,
						hidden = function() return not Core.OptionsLoaded end,
						fontSize = "medium",
					},
				},
			},
		},
	}

	self.Options = Options

	LIB_ACR:RegisterOptionsTable(MASQUE, self.Options)

	local Path = "Core"
	self:AddOptionsPanel(Path, LIB_ACD:AddToBlizOptions(MASQUE, MASQUE, nil, Path))

	OPT_LDR_FRAME = CreateFrame("Frame", "MSQ_LDR_FRAME", SettingsPanel)
	OPT_LDR_FRAME:SetScript("OnShow", function() Setup("LoD") end)

	-- GC
	Setup.Core = nil
end

-- Loads the LoD options.
function Setup.LoD(self)
	self.OptionsLoaded = true

	Setup("About")
	Setup("Info")
	Setup("Skins")
	Setup("General")
	Setup("Profiles")

	-- GC
	if OPT_LDR_FRAME then
		OPT_LDR_FRAME:SetScript("OnShow", nil)
	end

	Setup.LoD = nil
end

----------------------------------------
-- Core
---

Core.LIB_ACD = LIB_ACD
Core.LIB_ACR = LIB_ACR

Core.CRLF = CRLF

Core.Setup = setmetatable(Setup, {
	__call = function(self, Name, ...)
		local func = Name and self[Name]
		if func then
			func(Core, ...)
		end
	end,
})

-- Adds options panel info.
function Core:AddOptionsPanel(Path, Frame, Name)
	local Panels = self.OptionsPanels

	if not Panels then
		Panels = {Frames = {}}
		self.OptionsPanels = Panels
	end

	local Frames = Panels.Frames

	Frames[Path] = Frame
	Panels[Path] = Name
end

-- Toggles the Interface/ACD options frame.
function Core:ToggleOptions()
	if Setup.LoD then Setup("LoD") end

	if InCombatLockdown() then return end

	if self.db.profile.Interface.StandAlone then
		if SettingsPanel:IsShown() then
			HideUIPanel(GameMenuFrame)
			HideUIPanel(SettingsPanel)
		end

		if LIB_ACD.OpenFrames[MASQUE] then
			LIB_ACD:Close(MASQUE)
		else
			LIB_ACD:Open(MASQUE)
			LIB_ACD:SelectGroup(MASQUE, "Skins", "Global")
		end
	else
		if LIB_ACD.OpenFrames[MASQUE] then
			LIB_ACD:Close(MASQUE)
		end

		if SettingsPanel:IsShown() then
			HideUIPanel(GameMenuFrame)
			HideUIPanel(SettingsPanel)
		else
			SettingsPanel:OpenToCategory(self.OptionsPanels.Core)
		end
	end
end

----------------------------------------
-- Utility
---

-- Returns the 'arg' of an options group.
function Core.GetArg(Info, ...)
	return Info.arg
end

-- Generic getter function.
function Core.GetOption(Info)
	local Parent, Name = Info[#Info-1], Info[#Info]
	return Core.db.profile[Parent][Name]
end

-- Generic setter function.
function Core.SetOption(Info, Value)
	local Parent, Name = Info[#Info-1], Info[#Info]
	Core.db.profile[Parent][Name] = Value
end

-- Returns stand-alone options status.
function Core.GetStandAlone()
	return not LIB_ACD.OpenFrames[MASQUE]
end
