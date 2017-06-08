--[[
	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Locales.lua
	* Author.: StormFX

	[ Notes ]

	The contents of this file are automatically generated. Please use the localization application on WoWAce.com
	to submit translations. https://www.wowace.com/projects/masque/localization
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
L["Addons"] = "Addons"
L["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = "Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."
L["Adjust the skin of all buttons registered to %s: %s."] = "Adjust the skin of all buttons registered to %s: %s."
L["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = "Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."
L["Backdrop Settings"] = "Backdrop Settings"
L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."
L["Checked"] = "Checked"
L["Click this button to load Masque's options. You can also use the %s or %s chat command."] = "Click this button to load Masque's options. You can also use the %s or %s chat command."
L["Click to open Masque's options window."] = "Click to open Masque's options window."
L["Color"] = "Color"
L["Colors"] = "Colors"
L["Cooldown"] = "Cooldown"
L["Debug Mode"] = "Debug Mode"
L["Disable the skinning of this group."] = "Disable the skinning of this group."
L["Disable"] = "Disable"
L["Disabled"] = "Disabled"
L["Enable the backdrop texture."] = "Enable the backdrop texture."
L["Enable the minimap icon."] = "Enable the minimap icon."
L["Enable"] = "Enable"
L["Equipped"] = "Equipped"
L["Flash"] = "Flash"
L["General"] = "General"
L["Global"] = "Global"
L["Gloss Settings"] = "Gloss Settings"
L["Highlight"] = "Highlight"
L["Load Masque Options"] = "Load Masque Options"
L["Loading Masque Options..."] = "Loading Masque Options..."
L["Masque debug mode disabled."] = "Masque debug mode disabled."
L["Masque debug mode enabled."] = "Masque debug mode enabled."
L["Masque is a dynamic button skinning add-on."] = "Masque is a dynamic button skinning add-on."
L["Minimap Icon"] = "Minimap Icon"
L["Normal"] = "Normal"
L["Opacity"] = "Opacity"
L["Profiles"] = "Profiles"
L["Pushed"] = "Pushed"
L["Reset Skin"] = "Reset Skin"
L["Reset all skin options to the defaults."] = "Reset all skin options to the defaults."
L["Set the color of the backdrop texture."] = "Set the color of the backdrop texture."
L["Set the color of the checked texture."] = "Set the color of the checked texture."
L["Set the color of the cooldown animation."] = "Set the color of the cooldown animation."
L["Set the color of the disabled texture."] = "Set the color of the disabled texture."
L["Set the color of the equipped item texture."] = "Set the color of the equipped item texture."
L["Set the color of the flash texture."] = "Set the color of the flash texture."
L["Set the color of the gloss texture."] = "Set the color of the gloss texture."
L["Set the color of the highlight texture."] = "Set the color of the highlight texture."
L["Set the color of the normal texture."] = "Set the color of the normal texture."
L["Set the color of the pushed texture."] = "Set the color of the pushed texture."
L["Set the intensity of the gloss color."] = "Set the intensity of the gloss color."
L["Set the skin for this group."] = "Set the skin for this group."
L["Skin"] = "Skin"
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."
]]

do
	local LOC = GetLocale()
	if LOC == "deDE" then
--@localization(locale="deDE", format="lua_additive_table", table-name="L")@
	elseif LOC == "esES" or LOC == "esMX" then
--@localization(locale="esES", format="lua_additive_table", table-name="L")@
	elseif LOC == "frFR" then
--@localization(locale="frFR", format="lua_additive_table", table-name="L")@
	elseif LOC == "itIT" then
--@localization(locale="itIT", format="lua_additive_table", table-name="L")@
	elseif LOC == "koKR" then
--@localization(locale="koKR", format="lua_additive_table", table-name="L")@
	elseif LOC == "ptBR" then
--@localization(locale="ptBR", format="lua_additive_table", table-name="L")@
	elseif LOC == "ruRU" then
--@localization(locale="ruRU", format="lua_additive_table", table-name="L")@
	elseif LOC == "zhCN" then
--@localization(locale="zhCN", format="lua_additive_table", table-name="L")@
	elseif LOC == "zhTW" then
--@localization(locale="zhTW", format="lua_additive_table", table-name="L")@
	end
end
