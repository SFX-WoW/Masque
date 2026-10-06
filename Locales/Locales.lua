--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\Locales.lua
	* Author.: StormFX

	enUS/enGB

]]

local _, Core = ...

-- Locales Table
local L = {}

Core.Locale = setmetatable(L, {
	__index = function(self, k)
		self[k] = k
		return k
	end
})

--[===[
--@localization(locale="enUS", format="lua_additive_table", namespace="Info", handle-unlocalized="comment")@
--@localization(locale="enUS", format="lua_additive_table", namespace="Settings", handle-unlocalized="comment")@
--@localization(locale="enUS", format="lua_additive_table", namespace="Skins", handle-unlocalized="comment")@
--]===]
