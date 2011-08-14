--[[
	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: Core\Locales.lua
	* Revision.: @file-revision@
	* Author...: StormFX

	Localization

	[ Notes ]

	The contents of this file are automatically generated. Please use the localization application on WoWAce.com
	to submit translations. http://www.wowace.com/projects/masque/localization/
]]

local _, Core = ...

-- Locales Table
local L = {}

-- Thanks, Tekkub/Rabbit.
Core.Locale = setmetatable(L, {
	__index = function(self, k)
		self[k] = k
		return k
	end
})

--[[ enUS/enGB: For reference only.
L = {
	["Addons"] = "Addons",
	["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = "Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings.",
	["Adjust the skin of all buttons registered to %s: %s."] = "Adjust the skin of all buttons registered to %s: %s.",
	["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = "Adjust the skin of all registered buttons. This will overwrite any per-add-on settings.",
	["Backdrop Settings"] = "Backdrop Settings",
	["Causes Masque to preload its options instead of having them loaded on demand."] = "Causes Masque to preload its options instead of having them loaded on demand.",
	["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin.",
	["Checked"] = "Checked",
	["Click this button to load Masque's options. You can also use the %s or %s chat command."] = "Click this button to load Masque's options. You can also use the %s or %s chat command.",
	["Click to open Masque's options window."] = "Click to open Masque's options window.",
	["Color"] = "Color",
	["Colors"] = "Colors",
	["Debug Mode"] = "Debug Mode",
	["Disable"] = "Disable",
	["Disable the skinning of this group."] = "Disable the skinning of this group.",
	["Disabled"] = "Disabled",
	["Enable"] = "Enable",
	["Enable fonts provided by skins."] = "Enable fonts provided by skins.",
	["Enable the backdrop texture."] = "Enable the backdrop texture.",
	["Enable the minimap icon."] = "Enable the minimap icon.",
	["Flash"] = "Flash",
	["Global"] = "Global",
	["Gloss Settings"] = "Gloss Settings",
	["Highlight"] = "Highlight",
	["Load Masque Options"] = "Load Masque Options",
	["Loading Masque Options..."] = "Loading Masque Options...",
	["Masque debug mode disabled."] = "Masque debug mode disabled.",
	["Masque debug mode enabled."] = "Masque debug mode enabled.",
	["Masque is a dynamic button skinning add-on."] = "Masque is a dynamic button skinning add-on.",
	["Minimap Icon"] = "Minimap Icon",
	["Normal"] = "Normal",
	["Opacity"] = "Opacity",
	["Preload Options"] = "Preload Options",
	["Profiles"] = "Profiles",
	["Pushed"] = "Pushed",
	["Reset Skin"] = "Reset Skin",
	["Reset all skin options to the defaults."] = "Reset all skin options to the defaults.",
	["Set the color of the backdrop texture."] = "Set the color of the backdrop texture.",
	["Set the color of the checked texture."] = "Set the color of the checked texture.",
	["Set the color of the disabled texture."] = "Set the color of the disabled texture.",
	["Set the color of the flash texture."] = "Set the color of the flash texture.",
	["Set the color of the gloss texture."] = "Set the color of the gloss texture.",
	["Set the color of the highlight texture."] = "Set the color of the highlight texture.",
	["Set the color of the normal texture."] = "Set the color of the normal texture.",
	["Set the color of the pushed texture."] = "Set the color of the pushed texture.",
	["Set the intensity of the gloss color."] = "Set the intensity of the gloss color.",
	["Set the skin for this group."] = "Set the skin for this group.",
	["Skin"] = "Skin",
	["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque.",
}
]]

do
	local LOC = GetLocale()
	if LOC == "deDE" then
--@localization(locale="deDE", format="lua_additive_table", table-name="L")@
	elseif LOC == "esES" then
--@localization(locale="esES", format="lua_additive_table", table-name="L")@
	elseif LOC == "esMX" then
--@localization(locale="esMX", format="lua_additive_table", table-name="L")@
	elseif LOC == "frFR" then
--@localization(locale="frFR", format="lua_additive_table", table-name="L")@
	elseif LOC == "koKR" then
--@localization(locale="koKR", format="lua_additive_table", table-name="L")@
	elseif LOC == "ruRU" then
--@localization(locale="ruRU", format="lua_additive_table", table-name="L")@
	elseif LOC == "zhCN" then
--@localization(locale="zhCN", format="lua_additive_table", table-name="L")@
	elseif LOC == "zhTW" then
--@localization(locale="zhTW", format="lua_additive_table", table-name="L")@
	end
end
