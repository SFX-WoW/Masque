--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Options\LDB.lua
	* Author.: StormFX

	LDB Launcher

]]

local MASQUE, Core = ...

----------------------------------------
-- WoW API
---

local AOC_FRAME = AddonCompartmentFrame
local InCombatLockdown = InCombatLockdown

----------------------------------------
-- Libraries
---

local LIB_DBI = Core.LIB_DBI

----------------------------------------
-- Internal
---

-- @ Options\Core
local Setup = Core.Setup

----------------------------------------
-- Setup
---

function Setup.LDB(self)
	local LDB = LibStub("LibDataBroker-1.1", true)

	if LDB then
		-- @ Locales\enUS
		local L = self.Locale

		self.LDBO = LDB:NewDataObject(MASQUE, {
			type  = "launcher",
			label = MASQUE,
			icon  = "Interface\\Addons\\Masque\\Textures\\LDB",
			tocname = MASQUE, -- Required by Diagnostics
			OnClick = function(Tip, Button)
				if Button == "LeftButton" or Button == "RightButton" then
					Core:ToggleOptions()
				end
			end,
			OnTooltipShow = function(Tip)
				if not Tip or not Tip.AddLine then
					return
				end
				Tip:AddLine(MASQUE)
				Tip:AddLine(L["Click to open Masque's settings."], 1, 1, 1)

				if InCombatLockdown() then
					Tip:AddLine(L["Unavailable in combat."], 1, 0, 0)
				end
			end,
		})

		if LIB_DBI then
			LIB_DBI:Register(MASQUE, self.LDBO, self.db.profile.LDB)
		end
	end

	-- GC
	Setup.LDB = nil
end

----------------------------------------
-- Core
---

-- Updates the icon position.
function Core:UpdateIconPosition(Position)
	if LIB_DBI then
		local db = Core.db.profile.LDB
		local pos = Position or db.position

		-- Minimap Icon
		if pos == 1 then
			LIB_DBI:Show(MASQUE)
			db.hide = false
		else
			LIB_DBI:Hide(MASQUE)
			db.hide = true
		end

		-- Add-On Compartment
		if AOC_FRAME then
			if pos == 2 then
				LIB_DBI:AddButtonToCompartment(MASQUE)
			else
				LIB_DBI:RemoveButtonFromCompartment(MASQUE)
			end
		end

		db.position = pos
	end
end
