--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Groups.lua
	* Author.: StormFX, JJSheets

	Group API

]]

-- GLOBALS: setmetatable

local _, Core = ...

----------------------------------------
-- Lua
---

local error, pairs, type = error, pairs, type

----------------------------------------
-- Callback
---

do
	-- Storage
	local Cache = {}

	local Callback = {

		-- Notifies an add-on of skin changes.
		Fire = function(self, Addon, Group, SkinID, Gloss, Backdrop, Colors, Disabled)
			local args = Cache[Addon]
			if args then
				for arg, func in pairs(args) do
					if arg then
						func(arg, Group, SkinID, Gloss, Backdrop, Colors, Disabled)
					else
						func(Group, SkinID, Gloss, Backdrop, Colors, Disabled)
					end
				end
			end
		end,

		-- Registers an add-on to be notified of skin changes.
		Register = function(self, Addon, func, arg)
			Cache[Addon] = Cache[Addon] or {}
			Cache[Addon][arg] = func
		end,
	}

	----------------------------------------
	-- Core
	---

	Core.Callback = setmetatable(Callback, {__call = Callback.Fire})

	----------------------------------------
	-- API
	---

	-- Wrapper for the 'Register' method.
	function Core.API:Register(Addon, func, arg)
		-- @Addon must be a string.
		if type(Addon) ~= "string" then
			if Core.Debug then
				error("Bad argument to API method 'Register'. 'Addon' must be a string.", 2)
			end
			return

		-- @func must be a function reference.
		elseif type(func) ~= "function" then
			if Core.Debug then
				error("Bad argument to API method 'Register'. 'func' must be a function.", 2)
			end
			return

		-- @arg must be a table or nil.
		elseif arg and type(arg) ~= "table" then
			if Core.Debug then
				error("Bad argument to API method 'Register'. 'arg' must be a table or nil.", 2)
			end
			return
		end

		-- Register the callback.
		Callback:Register(Addon, func, arg or false)
	end
end
