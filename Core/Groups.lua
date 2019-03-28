--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Groups.lua
	* Author.: StormFX, JJSheets

	Group API

]]

-- GLOBALS:

local MASQUE, Core = ...

----------------------------------------
-- Lua
---

local error, pairs, setmetatable, type = error, pairs, setmetatable, type

----------------------------------------
-- Groups
---

do
	-- Storage
	local Groups = {}

	-- @ Core\Core
	local Group_MT = Core.Group_MT

	-- Creates and returns a simple ID for a group.
	local function GetID(Addon, Group, StaticID)
		local ID = MASQUE

		if Addon then
			ID = Addon
			if Group then
				if StaticID then
					ID = ID.."_"..StaticID
				else
					ID = ID.."_"..Group
				end
			end
		end

		return ID
	end

	-- Creates and returns a new group.
	local function NewGroup(ID, Addon, Group, StaticID)
		-- Build the group table.
		local obj = {
			ID = ID,
			Addon = Addon,
			Group = Group,
			Buttons = {},
			SubList = (not Group and {}) or nil,
			Regions  = (Addon and {}) or nil,
			StaticID = (Group and StaticID) or nil,
		}

		setmetatable(obj, Group_MT)
		Groups[ID] = obj

		-- Update the parent group.
		local Parent

		if Group then
			Parent = GetGroup(Addon)
		elseif Addon then
			Parent = GetGroup()
		end

		if Parent then
			Parent.SubList[ID] = obj
			obj.Parent = Parent
		end

		-- Update the group.
		obj:Update(true)
		return obj
	end

	-- Returns an existing or new group.
	local function GetGroup(Addon, Group, StaticID)
		local ID = GetID(Addon, Group, StaticID)
		return Groups[ID] or NewGroup(ID, Addon, Group, StaticID)
	end

	----------------------------------------
	-- Core
	---

	Core.GetID = GetID
	Core.GetGroup = GetGroup

	----------------------------------------
	-- API
	---

	-- Wrapper for the GetGroup function.
	function Core.API:Group(Addon, Group, StaticID, Deprecated)
		-- @Addon must be a string.
		if type(Addon) ~= "string" or Addon == MASQUE then
			if Core.Debug then
				error("Bad argument to API method 'Group'. 'Addon' must be a string.", 2)
			end
			return

		-- @Group must be a string or nil.
		elseif Group and type(Group) ~= "string" then
			if Core.Debug then
				error("Bad argument to API method 'Group'. 'Group' must be a string.", 2)
			end
			return

		-- Check for deprecated parameters.
		elseif type(StaticID) ~= "string" then
			if type(Deprecated) == "string" then
				StaticID = Deprecated
			else
				StaticID = nil
			end
		end

		return GetGroup(Addon, Group, StaticID)
	end
end
