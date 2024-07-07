--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Core.lua
	* Author.: StormFX

	Core Functions

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local _G, type = _G, type

----------------------------------------
-- Internal
---

-- @ Skins\Regions
local BaseTypes, RegTypes = Core.BaseTypes, Core.RegTypes

----------------------------------------
-- Frame Type
---

-- Frame Types
local oTypes = {
	Button = true,
	CheckButton = true,
	Frame = true,
}

-- Validates and returns the frame type.
local function GetFrameType(Button)
	if type(Button) ~= "table" then return end

	local oType = Button.__MSQ_oType

	if not oType then
		oType = Button.GetObjectType and Button:GetObjectType()
	end

	-- Validate the frame type.
	if not oType or not oTypes[oType] then
		oType = nil
	end

	Button.__MSQ_oType = oType
	return oType
end

-- Returns a sub-type, if applicable.
local function GetSubType(Button, bType)
	local Button_Name = Button.GetName and Button:GetName()
	local SubType = bType

	-- Action Sub-Types
	if bType == "Action" then
		if Button_Name then
			if Button_Name:find("Stance") then
				SubType = "Stance"
			elseif Button_Name:find("Possess") then
				SubType = "Possess"
			elseif Button_Name:find("Pet") then
				SubType = "Pet"
			end
		end

	-- Item Sub-Types
	elseif bType == "Item" then
		if Button_Name then
			if Button_Name:find("Backpack") then
				SubType = "Backpack"
			elseif Button_Name:find("CharacterBag") then
				SubType = "BagSlot"
			-- Retail Only
			elseif Button_Name:find("ReagentBag") then
				SubType = "ReagentBag"
			end
		end

	-- Aura Sub-Types
	elseif bType == "Aura" then
		-- Retail
		if Button.DebuffBorder then
			-- Possible values are "Buff", "DeadlyDebuff", "Debuff" and "TempEnchant"
			SubType = Button.auraType or bType

			if SubType == "DeadlyDebuff" then
				SubType = "Debuff"
			elseif SubType == "TempEnchant" then
				SubType = "Enchant"
			end

		-- Classic
		else
			-- The Button.Border key isn't used by Classic, but add-ons may be using it.
			local Border = Button.Border or (Button_Name and _G[Button_Name.."Border"])

			if Border then
				SubType = (Button.symbol and "Debuff") or "Enchant"
			end
		end
	end

	return SubType
end

-- Returns a button's internal type.
function Core.GetType(Button, bType)
	local oType = GetFrameType(Button)

	-- Exit if the frame type is invalid.
	if not oType then return end

	bType = bType or Button.__MSQ_bType

	-- Invalid/unspecified type.
	if not bType or not RegTypes[bType] then
		bType = bType or "Legacy"

		if oType == "CheckButton" then
			-- Action
			if Button.HotKey then
				bType = GetSubType(Button, "Action")

			-- Item
			-- * Classic bag buttons are CheckButtons.
			elseif Button.IconBorder then
				bType = GetSubType(Button, "Item")
			end

		elseif oType == "Button" then
			-- Item
			if Button.IconBorder then
				bType = GetSubType(Button, "Item")

			-- Aura
			elseif Button.duration or Button.Duration then
				bType = GetSubType(Button, "Aura")
			end
		end

	-- Declared as a base type.
	elseif BaseTypes[bType] then
		bType = GetSubType(Button, bType)
	end

	Button.__MSQ_bType = bType
	return oType, bType
end

----------------------------------------
-- Group Queue
---

-- Self-destructing table to skin groups created prior to the PLAYER_LOGIN event.
Core.Queue = {
	Cache = {},

	-- Adds a group to the queue.
	Add = function(self, Group)
		self.Cache[#self.Cache + 1] = Group
		Group.Queued = true
	end,

	-- Re-Skins all queued groups.
	ReSkin = function(self)
		for i = 1, #self.Cache do
			local Group = self.Cache[i]

			Group:ReSkin(true)
			Group.Queued = nil
		end

		-- GC
		self.Cache = nil
		Core.Queue = nil
	end,
}

setmetatable(Core.Queue, {__call = Core.Queue.Add})

----------------------------------------
-- Region Finder
---

-- Returns a region for a button that uses a template.
function Core.GetRegion(Button, Info)
	local Region_Key = Info.Key
	local Region

	-- Check for a key reference.
	if Region_Key then
		local Parent_Key = Info.Parent
		local Object

		-- Region Parent
		if Parent_Key then
			local Parent = Button[Parent_Key]

			if type(Parent) == "table" then
				Object = Parent[Region_Key]
			end

		-- Button Parent
		else
			Object = Button[Region_Key]
		end

		-- Validate the object type.
		if type(Object) == "table" then
			local Object_Type = Object.GetObjectType and Object:GetObjectType()

			if Object_Type == Info.Type then
				Region = Object
			end
		end
	end

	-- Check for a method or global reference.
	if not Region then
		local Method_Name = Info.Func
		local Region_Name = Info.Name

		-- Method
		if Method_Name then
			local f = Button[Method_Name]

			if type(f) == "function" then
				Region = f(Button)
			end

		-- Global
		elseif Region_Name then
			local Button_Name = Button.GetName and Button:GetName()

			Region = Button_Name and _G[Button_Name..Region_Name]
		end
	end

	return Region
end
