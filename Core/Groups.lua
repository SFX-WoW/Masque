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
-- Locals
---

local C_API = Core.API
local Skins, SkinButton = Core.Skins, Core.SkinButton

-- @ Core\Utility: Size, Points, Color, Coords
local _, _, GetColor = Core.Utility()

----------------------------------------
-- Groups
---

-- Group Storage
local Groups = {}
local GMT

local GetID, GetGroup

do
	-- Creates and returns a simple ID for a group.
	function GetID(Addon, Group, StaticID)
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
	local function NewGroup(ID, Addon, Group, IsActionBar, StaticID)
		-- Build the group object.
		local obj = {
			ID = ID,
			Addon = Addon,
			Group = Group,
			Buttons = {},
			SubList = (not Group and {}) or nil,
			StaticID = (Group and StaticID) or nil,
			IsActionBar = IsActionBar,
		}

		setmetatable(obj, GMT)
		Groups[ID] = obj

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

		obj:Update(true)
		return obj
	end

	-- Returns an existing or new group.
	function GetGroup(Addon, Group, IsActionBar, StaticID)
		local ID = GetID(Addon, Group, StaticID)
		return Groups[ID] or NewGroup(ID, Addon, Group, IsActionBar, StaticID)
	end

	----------------------------------------
	-- Core
	---

	Core.GetGroup = GetGroup

	----------------------------------------
	-- API
	---

	-- Wrapper for the GetGroup function.
	function C_API:Group(Addon, Group, IsActionBar, StaticID)
		-- Validation
		if type(Addon) ~= "string" or Addon == MASQUE then
			if Core.Debug then
				error("Bad argument to API method 'Group'. 'Addon' must be a string.", 2)
			end
			return
		elseif Group and type(Group) ~= "string" then
			if Core.Debug then
				error("Bad argument to API method 'Group'. 'Group' must be a string.", 2)
			end
			return
		elseif StaticID and type(StaticID) ~= "string" then
			if Core.Debug then
				error("Bad argument to API method 'Group'. 'StaticID' must be a string.", 2)
			end
			return
		end

		return GetGroup(Addon, Group, IsActionBar, StaticID)
	end
end
