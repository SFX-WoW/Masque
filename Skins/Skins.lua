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
local Layers = Core.TypeConfig.Default

----------------------------------------
-- Locals
---

-- String Constants
local STR_SQUARE = "Square"

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

----------------------------------------
-- Helpers
---

-- Returns a valid shape.
local function GetShape(Shape)
	if type(Shape) ~= "string" then
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

-- Updates outdated skins.
-- * Do not set the root tables or it'll break inheritance from the default skin.
local function UpdateSubSkins(Skin)
	-- [ AutoCast Frame ][*]
	local frame = Skin.AutoCast_Frame

	if type(frame) == "table" then
		frame.Classic = frame.Classic or Skin.AutoCastShine or Skin.Shine or Skin.AutoCast
	end

	-- [ AutoCast Corners ][*]
	local corners = Skin.AutoCast_Corners

	if type(corners) == "table" then
		corners.Classic = corners.Classic or Skin.AutoCastable
	end

	-- [ Borders ]
	local border = Skin.Border

	if type(border) ~= "table" then border = nil end

	local debuff = border and border.Debuff
	local enchant = border and border.Enchant
	local item = border and border.Item

	Skin.DebuffBorder = Skin.DebuffBorder or debuff or border
	Skin.EnchantBorder = Skin.EnchantBorder or enchant or border
	Skin.IconBorder = Skin.IconBorder or item or border

	-- [ Cooldowns ]
	Skin.ChargeCooldown = Skin.ChargeCooldown or Skin.Cooldown
	Skin.CooldownLoC = Skin.CooldownLoC or Skin.Cooldown
end

-- Adds data to the skin tables.
local function AddSkin(SkinID, SkinData, IsCore, IsBase)
	-- Update older skins.
	UpdateSubSkins(SkinData)

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
			if sType == "string" then
				SkinData[Layer] = SkinData[Skin]

			-- Hide unused regions.
			elseif Info.Hide then
				SkinData[Layer] = Hidden

			-- Hide layers if allowed.
			elseif (sType == "table") then
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

	if type(SkinID) ~= "string" then
		if Debug then
			error("Bad argument to API method 'AddSkin'. 'SkinID' must be a string.", 2)
		end
		return
	end

	if Skins[SkinID] then return end

	if type(SkinData) ~= "table" then
		if Debug then
			error("Bad argument to API method 'AddSkin'. 'SkinData' must be a table.", 2)
		end
		return
	end

	local Template = SkinData.Template

	if Template then
		if type(Template) ~= "string" then
			if Debug then
				error(("Invalid template reference by skin '%s'. 'Template' must be a string."):format(SkinID), 2)
			end
			return
		end

		local Parent = Skins[Template]

		if type(Parent) ~= "table"  then
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
