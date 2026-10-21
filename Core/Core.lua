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

-- @ Masque
local HasSecrets = Core.HasSecrets

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

-- Returns a height and width relative to scaling.
local function GetScaleSize(self, Width, Height)
	local ScaleSize = self.ScaleSize

	local w = (Width or ScaleSize) * self.xScale
	local h = (Height or ScaleSize) * self.yScale

	return w, h
end

-- Returns the internal width and height of a frame.
local function GetFrameSize(self)
	return self.FrameWidth, self.FrameHeight
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
-- Type (Frame)
---

-- Returns a sub-type, if applicable.
local function GetSubType(Button, subType)
	local bName = Button.GetName and Button:GetName()

	-- Action
	if subType == STR_ACTION and bName then
		if bName:find(STR_STANCE, 1, true) then return STR_STANCE end
		if bName:find(STR_POSSESS, 1, true) then return STR_POSSESS end
		if bName:find(STR_PET, 1, true) then return STR_PET end

		return subType
	end

	-- Item
	if subType == STR_ITEM and bName then
		if bName:find(STR_BACKPACK, 1, true) then return STR_BACKPACK end
		if bName:find(STR_CHARACTERBAG, 1, true) then return STR_BAGSLOT end
		if bName:find(STR_KEYRING, 1, true) then return STR_KEYRING end
		if bName:find(STR_REAGENTBAG, 1, true) then return STR_REAGENTBAG end

		return subType
	end

	-- Aura
	if subType == STR_AURA then
		-- Retail
		if Button.DebuffBorder then
			-- Possible Values: "Buff", "DeadlyDebuff", "Debuff" and "TempEnchant"
			local AuraType = Button.auraType or subType

			if AuraType == STR_DEADLYDEBUFF then return STR_DEBUFF end
			if AuraType == STR_TEMPENCHANT then return STR_ENCHANT end

			return AuraType
		end

		-- Classic
		-- Button.Border isn't used in Classic but add-ons may be using it.
		if Button.Border or (bName and _G[bName..STR_BORDER]) then
			return (Button.symbol and STR_DEBUFF) or STR_ENCHANT
		end
	end

	return subType
end

-- Returns a button's internal type.
local function GetType(self, Button, subType)
	local frameType = self.FrameType

	if not frameType then return end

	subType = subType or self.SubType

	-- Base/Registered Types
	if subType and RegTypes[subType] then
		if BaseTypes[subType] then
			subType = GetSubType(Button, subType)
		end

	-- Invalid/Unspecified
	else
		if frameType == "CheckButton" then
			-- Action
			if Button.HotKey then
				subType = GetSubType(Button, STR_ACTION)

			-- Classic bag buttons are CheckButtons.
			elseif Button.IconBorder then
				subType = GetSubType(Button, STR_ITEM)
			end

		elseif frameType == "Button" then
			-- Item
			if Button.IconBorder then
				subType = GetSubType(Button, STR_ITEM)

			-- Aura
			elseif Button.duration or Button.Duration then
				subType = GetSubType(Button, STR_AURA)
			end
		end
	end

	subType = subType or STR_DEFAULT
	self.SubType = subType

	return subType
end

----------------------------------------
-- Type Skin
---

-- Returns a sub-skin based on the button type, if available.
local function GetTypeSkin(self, Button, Skin)
	local subType = self.SubType

	if self.IsAura then
		return Skin[subType] or Skin.Aura or Skin
	end

	if self.IsItem then
		if TYPE_SPECIAL[subType] then
			return Skin[subType] or Skin.BagSlot or Skin.Item or Skin

		else
			return Skin[subType] or Skin.Item or Skin
		end

	end

	return Skin[subType] or Skin
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

			-- Type
			GetType = GetType,
			GetTypeSkin = GetTypeSkin,
		}

		Button._MSQ_CFG = _mcfg
	end

	return _mcfg
end
