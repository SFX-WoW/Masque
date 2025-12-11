--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Icon.lua
	* Author.: StormFX

	'Icon' Region

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local error, type = error, type

----------------------------------------
-- WoW API
---

local hooksecurefunc = hooksecurefunc

----------------------------------------
-- Internal
---

-- @ Skins\Defaults
local SkinRoot = Core.SKIN_BASE

-- @ Core\Utility
local GetTexCoords, SetSkinPoint = Core.GetTexCoords, Core.SetSkinPoint

-- @ Core\Regions\Mask
local Skin_Mask = Core.Skin_Mask

-- @ Core\Regions\Normal
local Update_Normal = Core.Update_Normal

----------------------------------------
-- Locals
---

local SkinBase = SkinRoot.Icon

-- Skin Defaults
local BASE_BACKPACK = SkinBase.Backpack -- [[Interface\Icons\INV_Misc_Bag_08]]
local BASE_LAYER = SkinBase.DrawLayer -- "BACKGROUND"
local BASE_LEVEL = SkinBase.DrawLevel -- 0
local BASE_SIZE = SkinRoot.Size -- 36

-- String Constants
local STR_BORDER = "BORDER"
local STR_HIDE = "Hide"
local STR_SHOW = "Show"

-- Type Strings
local TYPE_BACKPACK = "Backpack"
local TYPE_ITEM = "Item"
local TYPE_TABLE = "table"

----------------------------------------
-- Helpers
---

-- Sets a button's empty state and updates its regions.
local function SetEmpty(Button, IsEmpty, Limit)
	local _mcfg = Button._MSQ_CFG

	IsEmpty = (IsEmpty and true) or nil
	_mcfg.IsEmpty = IsEmpty

	local Shadow = _mcfg.Shadow
	local Gloss = _mcfg.Gloss

	if IsEmpty then
		if Shadow then Shadow:Hide() end
		if Gloss then Gloss:Hide() end
	else
		if Shadow then Shadow:Show() end
		if Gloss then Gloss:Show() end
	end

	if not Limit then
		Update_Normal(Button, IsEmpty)
	end
end

----------------------------------------
-- Hooks
---

-- Types of buttons to hook.
local Hook_Icon = {
	Action = true,
	Pet = true,
}

-- Don't hook these in Retail.
-- @ Core\Button -> Hooks
if (not Core.WOW_RETAIL) then
	Hook_Icon.BagSlot = true
	Hook_Icon.Item = true
end

-- Sets a button's empty state to empty.
local function Hook_Hide(Region)
	local Button = Region._MSQ_Button

	if not Button then return end

	SetEmpty(Button, true)
end

-- Sets a button's empty state to not empty.
local function Hook_Show(Region)
	local Button = Region._MSQ_Button

	if not Button then return end

	SetEmpty(Button)
end

----------------------------------------
-- Core
---

Core.SetEmpty = SetEmpty

-- Internal skin handler for the `Icon` region.
function Core.Skin_Icon(Region, Button, Skin, Hide)
	local _mcfg = Button._MSQ_CFG

	local bType = _mcfg.bType

	if bType == TYPE_BACKPACK then
		if Hide then
			Region:SetTexture()
		else
			Region:SetTexture(Skin.Backpack or BASE_BACKPACK)
		end
	end

	local Layer = (bType == TYPE_ITEM and STR_BORDER) or BASE_LAYER

	Region._MSQ_Button = Button

	-- Skin
	Skin = _mcfg:GetTypeSkin(Button, Skin)

	Region:SetParent(Button)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetDrawLayer(Layer, BASE_LEVEL)

	Region:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))

	local SetAllPoints = Skin.SetAllPoints

	if not SetAllPoints then
		local Width = Skin.Width or BASE_SIZE
		local Height = Skin.Height or BASE_SIZE

		Region:SetSize(_mcfg:GetSize(Width, Height))
	end

	SetSkinPoint(Region, Button, Skin, SetAllPoints)

	-- Mask
	Skin_Mask(Button, Skin, Region)

	if not _mcfg.Enabled then
		Region._MSQ_Button = nil
	end

	if _mcfg.IsEmptyType then
		local IsEmpty = (not Region:IsShown()) or (Region:GetAlpha() == 0)

		SetEmpty(Button, IsEmpty)

		-- Hooks
		if Hook_Icon[bType] and (not Region._MSQ_Hooked) then
			hooksecurefunc(Region, STR_HIDE, Hook_Hide)
			hooksecurefunc(Region, STR_SHOW, Hook_Show)

			Region._MSQ_Hooked = true
		end
	end
end

----------------------------------------
-- API
---

-- Sets the button's empty status.
function Core.API:SetEmpty(Button, IsEmpty)
	if type(Button) ~= TYPE_TABLE then
		if Core.Debug then
			error("Bad argument to API method 'SetEmpty'. 'Button' must be a button object.", 2)
		end
		return
	end

	SetEmpty(Button, IsEmpty)
end
