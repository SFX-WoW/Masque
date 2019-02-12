--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Options\Profiles.lua
	* Author.: StormFX

	'Profile Settings' Group/Panel

	TODO: Create a custom profiles panel.

]]

-- GLOBALS: LibStub

local MASQUE, Core = ...

----------------------------------------
-- Lua
---

local pairs = pairs

----------------------------------------
-- Setup
---

do
	local Setup = Core.Setup

	-- Creates the 'Profile Settings' group and panel.
	function Setup.Profiles(self)
		local L = Core.Locale

		-- Root Options Group
		local Options = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
		Options.name = L["Profile Settings"]
		Options.order = -1

		-- Font Size Fix
		local args = Options.args
		for _, arg in pairs(args) do
			local type = arg.type
			if type and type == "description" then
				arg.fontSize = "medium"
			end
		end

		-- LibDualSpec-1.0
		local LDS = LibStub("LibDualSpec-1.0", true)
		if LDS then
			LDS:EnhanceOptions(Options, self.db)
		end

		-- Core Options Group/Panel
		self.Options.args.Profiles = Options
		self.ProfilesPanel = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(MASQUE, L["Profile Settings"], MASQUE, "Profiles")

		-- GC
		Setup.Profiles = nil
	end
end
