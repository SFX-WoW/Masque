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

local error, setmetatable, table_insert = error, setmetatable, table.insert
local table_sort, type = table.sort, type

----------------------------------------
-- Internal
---

-- @ Skins\Regions
local Layers = Core.RegTypes.Legacy

----------------------------------------
-- Locals
---

local TYPE_STRING = "string"
local TYPE_TABLE = "table"

local AddedSkins, CoreSkins = {}, {}
local Skins, SkinList, SkinOrder = {}, {}, {}
local Hidden = {Hide = true}

-- Legacy Layer Names
local LegacyLayers = {
	-- Using `Shine` or `AutoCast`
	["AutoCastShine"] = function(Skin)
		return Skin.AutoCastShine or Skin.Shine or Skin.AutoCast
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
		Shape = "Square"
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
	-- Legacy Layer Validation
	for Layer, GetLayer in pairs(vLayers) do
		if not SkinData[Layer] then
			SkinData[Layer] = GetLayer(SkinData)
		end
	end

	local Skin_API = SkinData.API_VERSION or SkinData.Masque_Version
	local Template = SkinData.Template

	if Template then
		-- Only do this for skins using "Default" to reference "Blizzard Modern".
		if Skin_API == 100000 and Template == "Default" then
			Template = "Blizzard Modern"
		end

		setmetatable(SkinData, {__index = Skins[Template]})
	end

	if not IsBase then
		local Default = Core.DEFAULT_SKIN

		for Layer, Info in pairs(Layers) do
			local Skin = SkinData[Layer]
			local sType = type(Skin)

			-- Allow a layer to use the same skin settings as another layer.
			if sType == TYPE_STRING then
				Skin = SkinData[Skin]

			-- Account for missing skin settings and older skins.
			elseif sType ~= TYPE_TABLE then
				Skin = (Info.HideEmpty and Hidden) or Default[Layer]

			-- Prevent the hiding of regions that can't be hidden.
			elseif (Skin.Hide and not Info.CanHide) then
				Skin = Default[Layer]

			-- Hide unused regions.
			elseif Info.Hide then
				Skin = Hidden
			end

			SkinData[Layer] = Skin
		end
	end

	SkinData.API_VERSION = Skin_API
	SkinData.Shape = GetShape(SkinData.Shape)
	SkinData.SkinID = SkinID

	Skins[SkinID] = SkinData

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

Core._Hidden = Hidden
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
