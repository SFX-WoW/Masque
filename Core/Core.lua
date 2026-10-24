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

local type, string_find = type, string.find

----------------------------------------
-- Internal
---

-- @ Masque
local HasSecrets = Core.HasSecrets

-- @ Skins\Defaults
local SkinBase = Core.SKIN_BASE

-- @ Skins\Regions
local isBaseType, isCustomType = Core.isBaseType, Core.isCustomType
local isEmptyType, isRegisteredType = Core.isEmptyType, Core.TypeConfig
local isActionType, isAuraType, isItemType = Core.isActionType, Core.isAuraType, Core.isItemType

----------------------------------------
-- Locals
---

-- Scale Defaults
local BASE_SCALE = SkinBase.Scale
local BASE_SIZE = SkinBase.Size

-- Action Type Strings
local STR_ACTION = "Action"
local STR_PET = "Pet"
local STR_POSSESS = "Possess"
local STR_STANCE = "Stance"

-- Aura Type Strings
local STR_AURA = "Aura"
local STR_DEADLYDEBUFF = "DeadlyDebuff"
local STR_DEBUFF = "Debuff"
local STR_ENCHANT = "Enchant"
local STR_TEMPENCHANT = "TempEnchant"

-- Item Type Strings
local STR_BACKPACK = "Backpack"
local STR_BAGSLOT = "BagSlot"
local STR_CHARACTERBAG = "CharacterBag"
local STR_ITEM = "Item"
local STR_KEYRING = "KeyRing"
local STR_REAGENTBAG = "ReagentBag"

-- Misc Strings
local STR_BORDER = "Border"
local STR_DEFAULT = "Default"

-- Special Bags
local TYPE_SPECIAL = {
	[STR_KEYRING] = true,
	[STR_REAGENTBAG] = true,
}

----------------------------------------
-- Configuration
---

-- Updates the UID for the button to force hooks to update.
local function ForceUpdate(self)
	self._uID = (self._uID or 0) + 1

	if not self.ForceFrameSize then
		self:UpdateFrameSize()
	end
end

-- Checks to see if the region needs to be updated.
local function NeedsUpdate(self, UID, Unset)
	if Unset then
		return self[UID] ~= -1
	else
		return self[UID] ~= self._uID
	end
end

-- Updates the UID for a region.
local function UpdateUID(self, UID, Unset)
	if UID then
		if Unset then
			self[UID] = -1
		else
			self[UID] = self._uID
		end
	end
end

----------------------------------------
-- Scale
---

-- Returns the x and y scale of a button.
local function GetScale(self)
	return self.xScale or BASE_SCALE, self.yScale or BASE_SCALE
end

-- Updates the scales for a button.
local function UpdateScale(self, Button, Scale)
	Scale = Scale or BASE_SCALE

	local ScaleSize = BASE_SIZE / Scale
	local Width, Height = self:GetFrameSize()

	self.xScale = (Width or ScaleSize) / ScaleSize
	self.yScale = (Height or ScaleSize) / ScaleSize

	self.Scale = Scale
	self.ScaleSize = ScaleSize
end

----------------------------------------
-- Size
---

-- Returns the internal width and height of a frame.
local function GetFrameSize(self)
	return self.FrameWidth, self.FrameHeight
end

-- Returns a height and width relative to scaling.
local function GetScaleSize(self, Width, Height)
	local ScaleSize = self.ScaleSize

	local w = (Width or ScaleSize) * self.xScale
	local h = (Height or ScaleSize) * self.yScale

	return w, h
end

-- Sets the internal width and height of a frame.
local function SetFrameSize(self, Width, Height, Mutable)
	self.FrameWidth = Width
	self.FrameHeight = Height

	self.ForceFrameSize = (not Mutable) or nil
end

-- Updates the frame size cache.
local function UpdateFrameSize(self)
	local Width, Height = self.Frame:GetSize()

	if HasSecrets(Width, Height) then
		self.HasSecrets = true
		return
	end

	self.FrameWidth = Width
	self.FrameHeight = Height
end

----------------------------------------
-- Skin
---

-- Returns a sub-skin based on the type, if available.
local function GetTypeSkin(self, Skin)
	local subType = self.SubType

	if self.isAuraType then
		return Skin[subType] or Skin.Aura or Skin
	end

	if self.isItemType then
		if TYPE_SPECIAL[subType] then
			return Skin[subType] or Skin.BagSlot or Skin.Item or Skin

		else
			return Skin[subType] or Skin.Item or Skin
		end

	end

	return Skin[subType] or Skin
end

----------------------------------------
-- Type
---

-- Returns a button's base type.
local function GetBaseType(self, SetType)
	local baseType = self.BaseType

	if baseType then return baseType end

	if SetType then
		-- Base Type
		if isBaseType[SetType] then
			self.BaseType = SetType
			self["is"..SetType.."Type"] = true

			return SetType
		end

		-- Determine the base type of custom types.
		if isCustomType[SetType] then
			baseType = STR_DEFAULT
			self.isCustomType = true

			if isActionType[SetType] then
				baseType = STR_ACTION

			elseif isAuraType[SetType] then
				baseType = STR_AURA

			elseif isItemType[SetType] then
				baseType = STR_ITEM
			end

			self.BaseType = baseType
			self["is"..baseType.."Type"] = true

			return baseType
		end
	end

	local frame = self.Frame
	local frameType = self.FrameType

	baseType = STR_DEFAULT

	if frameType == "CheckButton" then
		if frame.HotKey then
			baseType = STR_ACTION

		-- Classic bag buttons are CheckButtons.
		elseif frame.IconBorder then
			baseType = STR_ITEM
		end

	elseif frameType == "Button" then
		if frame.IconBorder then
			baseType = STR_ITEM

		elseif frame.Duration then
			baseType = STR_AURA
		end
	end

	self.BaseType = baseType
	self.isEmptyType = isEmptyType[baseType]
	self["is"..baseType.."Type"] = true

	return baseType
end

-- Returns a button's sub-type.
local function GetSubType(self, SetType)
	local subType = self.SubType

	if subType then return subType end

	-- Allows the sub-type to be a base type and handles custom types.
	if SetType and isRegisteredType[SetType] then
		self.SubType = SetType

		return SetType
	end

	local baseType = self.BaseType
	local frame = self.Frame

	-- Action
	if baseType == STR_ACTION then
		subType = baseType

		local name = frame.GetName and frame:GetName()

		if name then
			if string_find(name, STR_PET, 1, true) then
				subType = STR_PET
			elseif string_find(name, STR_STANCE, 1, true) then
				subType = STR_STANCE
			elseif string_find(name, STR_POSSESS, 1, true) then
				subType = STR_POSSESS
			end
		end

		self.SubType = subType
		return subType
	end

	-- Item
	if baseType == STR_ITEM then
		subType = baseType

		local name = frame.GetName and frame:GetName()

		if name then
			if string_find(name, STR_BACKPACK, 1, true) then
				subType = STR_BACKPACK
			elseif string_find(name, STR_CHARACTERBAG, 1, true) then
				subType = STR_BAGSLOT
			elseif string_find(name, STR_REAGENTBAG, 1, true) then
				subType = STR_REAGENTBAG
			elseif string_find(name, STR_KEYRING, 1, true) then
				subType = STR_KEYRING
			end
		end

		self.SubType = subType
		return subType
	end

	-- Aura
	if baseType == STR_AURA then
		subType = baseType

		-- Possible values: 'Buff', `Debuff`, `DeadlyDebuff`, `TempEnchant`
		local auraType = frame.auraType

		if auraType == STR_DEADLYDEBUFF then
			subType = STR_DEBUFF
		elseif auraType == STR_TEMPENCHANT then
			subType = STR_ENCHANT
		end

		self.SubType = subType
		return subType
	end

	subType = subType or baseType or STR_DEFAULT
	self.SubType = subType

	return subType
end

-- Returns the config types, performing an update if necessary.
local function GetConfigTypes(self, SetType)
	SetType = (type(SetType) == "string") and SetType or nil
	return self:GetBaseType(SetType), self:GetSubType(SetType)
end

----------------------------------------
-- Masque Configuration Table
---

-- Creates/Returns the Masque configuration table for a button.
function Core.GetMasqueConfig(Button)
	local _mcfg = Button._MSQ_CFG

	if not _mcfg then
		_mcfg = {
			-- _uID is used internally to track updates.
			_uID = 0,
			Frame = Button,
			FrameWidth = BASE_SIZE,
			FrameHeight = BASE_SIZE,

			-- Internal
			ForceUpdate = ForceUpdate,
			NeedsUpdate = NeedsUpdate,
			UpdateUID = UpdateUID,

			-- Scale
			GetScale = GetScale,
			UpdateScale = UpdateScale,

			-- Size
			GetFrameSize = GetFrameSize,
			GetScaleSize = GetScaleSize,
			SetFrameSize = SetFrameSize,
			UpdateFrameSize = UpdateFrameSize,

			-- Skin
			GetTypeSkin = GetTypeSkin,

			-- Type
			GetBaseType = GetBaseType,
			GetSubType = GetSubType,
			GetConfigTypes = GetConfigTypes,
		}

		Button._MSQ_CFG = _mcfg
	end

	return _mcfg
end
