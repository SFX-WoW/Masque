--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\SlotIcon.lua
	* Author.: StormFX

	'SlotIcon' Region

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local error, type = error, type

----------------------------------------
-- Internal
---

-- @ Core\Utility
local GetColor, GetTexCoords, SetSkinPoint = Core.GetColor, Core.GetTexCoords, Core.SetSkinPoint

-- @ Core\Regions\Mask
local Skin_Mask = Core.Skin_Mask

----------------------------------------
-- Locals
---

local DEF_TEXTURE = [[Interface\Icons\INV_Misc_Bag_08]]

----------------------------------------
-- Helpers
---

-- Skins or creates the 'SlotIcon' region of a button.
local function Add_SlotIcon(Button, Skin)
	local _mcfg = Button._MSQ_CFG
	local Region = _mcfg.SlotIcon

	if not Region then
		Region = Button:CreateTexture()
		_mcfg.SlotIcon = Region
	end

	Region:SetParent(Button)
	Region:SetTexture(Skin.Texture or DEF_TEXTURE)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	Region:SetVertexColor(GetColor(Skin.Color))
	Region:SetDrawLayer(Skin.DrawLayer or "BACKGROUND", Skin.DrawLevel or 0)
	Region:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))

	SetSkinPoint(Region, Button, Skin, nil, Skin.SetAllPoints)
	Skin_Mask(Button, Skin, Region)

	Region:Show()
end

-- Removes the 'SlotIcon' region from a button.
local function Remove_SlotIcon(Button)
	local _mcfg = Button._MSQ_CFG
	local Region = _mcfg.SlotIcon

	if Region then
		Region:SetTexture()
		Region:Hide()
	end
end

----------------------------------------
-- Core
---

-- Internal skin handler for the `SlotIcon` region.
function Core.Skin_SlotIcon(Enabled, Button, Skin)
	if Enabled and (not Skin.Hide) and Skin.Texture then
		Add_SlotIcon(Button, Skin)
	else
		Remove_SlotIcon(Button)
	end
end

----------------------------------------
-- API
---

-- Retrieves the 'SlotIcon' region of a button.
function Core.API:GetSlotIcon(Button)
	if type(Button) ~= "table" then
		if Core.Debug then
			error("Bad argument to API method 'GetGloss'. 'Button' must be a button object.", 2)
		end
		return
	end

	local _mcfg = Button._MSQ_CFG
	return _mcfg and _mcfg.SlotIcon
end
