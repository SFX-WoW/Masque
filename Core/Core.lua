--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Core.lua
	* Author.: StormFX

	Core Functions

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Lua
---

local _G, setmetatable, type = _G, setmetatable, type

----------------------------------------
-- Core
---

do
	----------------------------------------
	-- Type Validation
	---

	-- Valid Object Types
	local oTypes = {
		Button = true,
		CheckButton = true,
		Frame = true,
	}

	-- Returns a button's object or internal type.
	function Core.GetType(Button, oType)
		local Type

		-- Object Type
		if oType then
			if type(Button) == "table" then
				Type = Button.GetObjectType and Button:GetObjectType()

				-- Only allow the certain object types.
				if not Type or not oTypes[Type] then
					Type = nil
				end
			end

			Button.__MSQ_oType = Type

		-- Internal Type
		else
			oType = Button.__MSQ_oType
			Type = "Button"

			-- CheckButton
			if oType == "CheckButton" then
				-- Action Button
				if Button.HotKey then
					Type = "Action"
				end

			-- Button
			elseif oType == "Button" then
				-- Item Button
				if Button.IconBorder then
					Type = "Item"

				-- Aura Button
				elseif Button.duration then
					Type = "Aura"

					local bName = Button:GetName()
					local Border = bName and _G[bName.."Border"]

					-- Debuff/Enchant Button
					if Border then
						Type = (Button.symbol and "Debuff") or "Enchant"
					end
				end
			end
		end

		return Type
	end

	----------------------------------------
	-- Region Retrieval
	---

	-- Gets a button region.
	function Core.GetRegion(Button, Info)
		local Key, Region = Info.Key, nil

		-- Check for a field first.
		if Key then
			local Value = Key and Button[Key]

			-- Make sure it points to a valid region.
			if Value and type(Value) == "table" then
				local Type = Value.GetObjectType and Value:GetObjectType()

				-- Compare the types.
				if Type == Info.Type then
					Region = Value
				end
			end
		end

		-- Check for a method or global field if the field wasn't valid.
		if not Region then
			local Func, Name = Info.Func, Info.Name

			-- Method Check
			if Func then
				local f = Func and Button[Func]
				Region = f and f(Button)

			-- Global Check
			elseif Name then
				local n = Button.GetName and Button:GetName()
				Region = n and _G[n..Name]
			end
		end

		return Region
	end

	----------------------------------------
	-- Region Skinning
	---

	-- Metatable to call region-skinning functions.
	Core.SkinRegion = setmetatable({}, {
		__call = function(self, Region, ...)
			local func = Region and self[Region]
			if func then
				func(...)
			end
		end,
	})

	----------------------------------------
	-- Group Queue
	---

	-- Self-destructing table to skin groups created prior to PLAYER_LOGIN.
	Core.Queue = {
		-- Storage
		Cache = {},

		-- Adds a group to the queue.
		Add = function(self, obj)
			self.Cache[#self.Cache + 1] = obj
			obj.Queued = true
		end,

		-- Re-Skins all queued groups.
		ReSkin = function(self)
			for i = 1, #self.Cache do
				local obj = self.Cache[i]

				-- Skin the group.
				obj:ReSkin(true)
				obj.Queued = nil
			end

			-- GC
			self.Cache = nil
			Core.Queue = nil
		end,
	}

	setmetatable(Core.Queue, {__call = Core.Queue.Add})
end
