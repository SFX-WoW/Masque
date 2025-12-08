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

local _G = _G

----------------------------------------
-- Internal
---

-- @ Skins\Defaults
local SkinBase = Core.SKIN_BASE

-- @ Skins\Regions
local BaseTypes, RegTypes = Core.BaseTypes, Core.RegTypes

----------------------------------------
-- Locals
---

-- Scale Defaults
local BASE_SCALE = SkinBase.Scale
local BASE_SIZE = SkinBase.Size

-- Misc Strings
local STR_BORDER = "Border"
local TYPE_LEGACY = "Legacy"

-- Object Type Strings
local TYPE_BUTTON = "Button"
local TYPE_CHECKBUTTON = "CheckButton"

-- Action Type Strings
local TYPE_ACTION = "Action"
local TYPE_PET = "Pet"
local TYPE_POSSESS = "Possess"
local TYPE_STANCE = "Stance"

-- Aura Type Strings
local TYPE_AURA = "Aura"
local TYPE_DEADLYDEBUFF = "DeadlyDebuff"
local TYPE_DEBUFF = "Debuff"
local TYPE_ENCHANT = "Enchant"
local TYPE_TEMPENCHANT = "TempEnchant"

-- Item Type Strings
local TYPE_BACKPACK = "Backpack"
local TYPE_BAGSLOT = "BagSlot"
local TYPE_CHARACTERBAG = "CharacterBag"
local TYPE_ITEM = "Item"
local TYPE_KEYRING = "KeyRing"
local TYPE_REAGENTBAG = "ReagentBag"

-- Special Bags
local TYPE_SPECIAL = {
	[TYPE_KEYRING] = true,
	[TYPE_REAGENTBAG] = true,
}

----------------------------------------
-- Configuration
---

-- Updates the UID for the button to force hooks to update.
local function ForceUpdate(self)
	self._uID = (self._uID or 0) + 1
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
	local Width, Height = Button:GetSize()

	self.xScale = (Width or ScaleSize) / ScaleSize
	self.yScale = (Height or ScaleSize) / ScaleSize

	self.Scale = Scale
	self.ScaleSize = ScaleSize
end

----------------------------------------
-- Size
---

-- Returns a height and width relative to scaling.
local function GetSize(self, Width, Height)
	local ScaleSize = self.ScaleSize

	local w = (Width or ScaleSize) * self.xScale
	local h = (Height or ScaleSize) * self.yScale

	return w, h
end

----------------------------------------
-- Type (Frame)
---

-- Returns a sub-type, if applicable.
local function GetSubType(Button, bType)
	local bName = Button.GetName and Button:GetName()

	-- Action
	if bType == TYPE_ACTION and bName then
		if bName:find(TYPE_STANCE, 1, true) then return TYPE_STANCE end
		if bName:find(TYPE_POSSESS, 1, true) then return TYPE_POSSESS end
		if bName:find(TYPE_PET, 1, true) then return TYPE_PET end

		return bType
	end

	-- Item
	if bType == TYPE_ITEM and bName then
		if bName:find(TYPE_BACKPACK, 1, true) then return TYPE_BACKPACK end
		if bName:find(TYPE_CHARACTERBAG, 1, true) then return TYPE_BAGSLOT end
		if bName:find(TYPE_KEYRING, 1, true) then return TYPE_KEYRING end
		if bName:find(TYPE_REAGENTBAG, 1, true) then return TYPE_REAGENTBAG end

		return bType
	end

	-- Aura
	if bType == TYPE_AURA then
		-- Retail
		if Button.DebuffBorder then
			-- Possible Values: "Buff", "DeadlyDebuff", "Debuff" and "TempEnchant"
			local AuraType = Button.auraType or bType

			if AuraType == TYPE_DEADLYDEBUFF then return TYPE_DEBUFF end
			if AuraType == TYPE_TEMPENCHANT then return TYPE_ENCHANT end

			return AuraType
		end

		-- Classic
		-- Button.Border isn't used in Classic but add-ons may be using it.
		if Button.Border or (bName and _G[bName..STR_BORDER]) then
			return (Button.symbol and TYPE_DEBUFF) or TYPE_ENCHANT
		end
	end

	return bType
end

-- Returns a button's internal type.
local function GetType(self, Button, bType)
	local oType = self.oType

	if not oType then return end

	bType = bType or self.bType

	-- Base/Registered Types
	if bType and RegTypes[bType] then
		if BaseTypes[bType] then
			bType = GetSubType(Button, bType)
		end

	-- Invalid/Unspecified
	else
		if oType == TYPE_CHECKBUTTON then
			-- Action
			if Button.HotKey then
				bType = GetSubType(Button, TYPE_ACTION)

			-- Classic bag buttons are CheckButtons.
			elseif Button.IconBorder then
				bType = GetSubType(Button, TYPE_ITEM)
			end

		elseif oType == TYPE_BUTTON then
			-- Item
			if Button.IconBorder then
				bType = GetSubType(Button, TYPE_ITEM)

			-- Aura
			elseif Button.duration or Button.Duration then
				bType = GetSubType(Button, TYPE_AURA)
			end
		end
	end

	bType = bType or TYPE_LEGACY
	self.bType = bType

	return bType
end

----------------------------------------
-- Type Skin
---

-- Returns a sub-skin based on the button type, if available.
local function GetTypeSkin(self, Button, Skin)
	local bType = self.bType

	if self.IsAura then
		return Skin[bType] or Skin.Aura or Skin
	end

	if self.IsItem then
		if TYPE_SPECIAL[bType] then
			return Skin[bType] or Skin.BagSlot or Skin.Item or Skin

		else
			return Skin[bType] or Skin.Item or Skin
		end

	end

	return Skin[bType] or Skin
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

			-- Internal
			ForceUpdate = ForceUpdate,
			NeedsUpdate = NeedsUpdate,
			UpdateUID = UpdateUID,

			-- Scale
			GetScale = GetScale,
			GetSize = GetSize,
			GetTypeSkin = GetTypeSkin,
			UpdateScale = UpdateScale,

			-- Type
			GetType = GetType,
		}

		Button._MSQ_CFG = _mcfg
	end

	return _mcfg
end
