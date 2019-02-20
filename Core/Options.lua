--[[
	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Options.lua
	* Author.: StormFX

]]

local MASQUE, Core = ...
local pairs = pairs

local L = Core.Locale
local Skins, SkinList = Core.Skins, Core.SkinList

----------------------------------------
-- Options Loader
----------------------------------------

-- Loads the options when called.
function Core:LoadOptions()
	local args = self.Options.args.General.args
	args.Info = {
		type = "description",
		name = L["Masque is a dynamic button skinning add-on."].."\n",
		order = 1,
	}
	if Core.LDB then
		args.Icon = {
			type = "toggle",
			name = L["Minimap Icon"],
			desc = L["Enable the Minimap icon."],
			get = function()
				return not Core.db.profile.LDB.hide
			end,
			set = function(i, v)
				Core.db.profile.LDB.hide = not v
				if not v then
					Core.LDBI:Hide(MASQUE)
				else
					Core.LDBI:Show(MASQUE)
				end
			end,
			disabled = function()
				return not Core.LDBI
			end,
			order = 3,
		}
	end
	args.Debug = {
		type = "toggle",
		name = L["Debug Mode"],
		desc = L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."],
		get = function()
			return Core.db.profile.Debug
		end,
		set = function()
			Core:ToggleDebug()
		end,
		order = 4,
	}
	self.OptionsPanel.Addons = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(MASQUE, L["Addons"], MASQUE, "Addons")
end

----------------------------------------
-- Options Window
----------------------------------------

-- Opens the options window.
function Core:ShowOptions()
	if not self.OptionsLoaded then
		self:LoadOptions()
	end
	-- Double call to ensure the proper category is opened.
	InterfaceOptionsFrame_OpenToCategory(Core.OptionsPanel)
	InterfaceOptionsFrame_OpenToCategory(Core.OptionsPanel.Addons)
end
