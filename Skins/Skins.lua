--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Skins\Skins.lua
	* Author.: StormFX, JJSheets

	Skin API

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local error, rawget, setmetatable = error, rawget, setmetatable
local table_insert, table_sort, type = table.insert, table.sort, type

----------------------------------------
-- Internal
---

-- @ Skins\Defaults
local Hidden = Core._Hidden

-- @ Skins\Regions
local Layers = Core.RegTypes.Legacy

----------------------------------------
-- Locals
---

-- String Constants
local STR_SQUARE = "Square"

-- Type Strings
local TYPE_STRING = "string"
local TYPE_TABLE = "table"

-- Skin Storage
local AddedSkins, CoreSkins = {}, {}
local Skins, SkinList, SkinOrder = {}, {}, {}

-- Skin Prototype
local Prototype

-- Unique Fields
local UniqueKeys = {
	API_VERSION = true,
	Author = true,
	Description = true,
	Version = true,
}

-- Legacy Layer Names
local LegacyLayers = {
	-- Using `Shine` or `AutoCast`
	["AutoCastShine"] = function(Skin)
		return Skin.AutoCastShine or Skin.Shine or Skin.AutoCast
	end,
	-- `CooldownLoC` Undefined
	["CooldownLoC"] = function(Skin)
		return Skin.CooldownLoC or Skin.Cooldown
	end,
	-- `ChargeCoolDown` Undefined
	["ChargeCooldown"] = function(Skin)
		return Skin.ChargeCooldown or Skin.Cooldown
	end,
	-- Using `Border.Debuff` / `DebuffBorder` Undefined
	["DebuffBorder"] = function(Skin)
		local Border = Skin.Border
		if type(Border) == TYPE_TABLE then
			Border = Border.Debuff or Border
		end
		return Border
	end,
	-- Using `Border.Enchant` / `EnchantBorder` Undefined
	["EnchantBorder"] = function(Skin)
		local Border = Skin.Border
		if type(Border) == TYPE_TABLE then
			Border = Border.Enchant or Border
		end
		return Border
	end,
	-- Using `Border.Item` / `IconBorder` Undefined
	["IconBorder"] = function(Skin)
		local Border = Skin.Border
		if type(Border) == TYPE_TABLE then
			Border = Border.Item or Border
		end
		return Border
	end,
}

----------------------------------------
-- Helpers
---

-- Returns a valid shape.
local function GetShape(Shape)
	if type(Shape) ~= TYPE_STRING then
		Shape = STR_SQUARE
	end
	return Shape
end

-- Sorts the `SkinOrder` table, for display in drop-downs.
local function SortSkins()
	table_sort(AddedSkins)

	local c = #CoreSkins

	for k, v in ipairs(AddedSkins) do
		SkinOrder[k + c] = v
	end
end

-- Adds data to the skin tables.
local function AddSkin(SkinID, SkinData, IsCore, IsBase)
	-- [ Legacy Layers ]

	for Layer, GetLayer in pairs(LegacyLayers) do
		if not SkinData[Layer] then
			SkinData[Layer] = GetLayer(SkinData)
		end
	end

	-- Mandatory Metadata
	SkinData.SkinID = SkinID

	if not IsBase then
		-- [ Templates]

		local Template = SkinData.Template

		-- Skin Template
		if Template then
			setmetatable(SkinData, {__index = Skins[Template]})

		-- Default Template
		else
			-- Prevent inheritance on unique fields.
			-- Update this when unique fields are added to the default skins.
			for Key in pairs(UniqueKeys) do
				if SkinData[Key] == nil then
					SkinData[Key] = false
				end
			end

			-- Set up the prototype.
			if not Prototype then
				Prototype = {__index = Core.DEFAULT_SKIN}
			end

			setmetatable(SkinData, Prototype)
		end

		-- Allow these to be inherited.
		SkinData.Shape = GetShape(SkinData.Shape)
		SkinData.API_VERSION = (SkinData.API_VERSION or SkinData.Masque_Version) or false

		-- [ Layer Validation]

		for Layer, Info in pairs(Layers) do
			local Skin = rawget(SkinData, Layer)
			local sType = type(Skin)

			-- String reference to another layer.
			if sType == TYPE_STRING then
				SkinData[Layer] = SkinData[Skin]

			-- Hide unused regions.
			elseif Info.Hide then
				SkinData[Layer] = Hidden

			-- Hide layers if allowed.
			elseif (sType == TYPE_TABLE) then
				if Skin.Hide then
					SkinData[Layer] = (Info.CanHide and Hidden) or nil
				end

			-- Unset invalid layers.
			elseif Skin ~= nil then
				SkinData[Layer] = nil
			end
		end
	end

	Skins[SkinID] = SkinData

	-- [ UI-Related ]

	if not SkinData.Disable then
		if IsCore then
			table_insert(CoreSkins, SkinID)
			table_insert(SkinOrder, SkinID)
		else
			table_insert(AddedSkins, SkinID)
			SortSkins()
		end

		SkinList[SkinID] = SkinID
	end
end

----------------------------------------
-- Core
---

Core.AddSkin = AddSkin
Core.Skins = Skins
Core.SkinList = SkinList
Core.SkinOrder = SkinOrder

----------------------------------------
-- API
---

local API = Core.API

-- Wrapper for the AddSkin function.
function API:AddSkin(SkinID, SkinData)
	local Debug = Core.Debug

	if type(SkinID) ~= TYPE_STRING then
		if Debug then
			error("Bad argument to API method 'AddSkin'. 'SkinID' must be a string.", 2)
		end
		return
	end

	if Skins[SkinID] then return end

	if type(SkinData) ~= TYPE_TABLE then
		if Debug then
			error("Bad argument to API method 'AddSkin'. 'SkinData' must be a table.", 2)
		end
		return
	end

	local Template = SkinData.Template

	if Template then
		if type(Template) ~= TYPE_STRING then
			if Debug then
				error(("Invalid template reference by skin '%s'. 'Template' must be a string."):format(SkinID), 2)
			end
			return
		end

		local Parent = Skins[Template]

		if type(Parent) ~= TYPE_TABLE  then
			if Debug then
				error(("Invalid template reference by skin '%s'. Template '%s' does not exist or is not a table."):format(SkinID, Template), 2)
			end
			return
		end
	end

	AddSkin(SkinID, SkinData)
end

-- Retrieves the default skin.
function API:GetDefaultSkin()
	return Core.DEFAULT_SKIN_ID, Core.DEFAULT_SKIN
end

-- Retrieves the skin data for the specified skin.
function API:GetSkin(SkinID)
	return SkinID and Skins[SkinID]
end

-- Retrieves the Skins table.
function API:GetSkins()
	return Skins
end
