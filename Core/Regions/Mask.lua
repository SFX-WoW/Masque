--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Mask.lua
	* Author.: StormFX

	Button/Region Mask

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local type = type

----------------------------------------
-- Internal
---

-- @ Skins\Defaults
local SkinRoot = Core.SKIN_BASE

-- @ Core\Utility
local SetSkinPoint = Core.SetSkinPoint

----------------------------------------
-- Locals
---

-- @ Skins\Defaults
local BASE_WRAP = SkinRoot.WrapMode

-- Type Strings
local TYPE_STRING = "string"
local TYPE_TABLE = "table"

----------------------------------------
-- Helpers
---

-- Skins a region mask.
local function Skin_RegionMask(Region, Button, Skin)
	local _mcfg = Button._MSQ_CFG
	local Button_Mask = _mcfg.ButtonMask
	local Mask_Skin = Skin.Mask

	--[[ Button Mask Fallback ]]

	-- Use the button mask if there's no region mask available.
	if Skin.UseMask and Button_Mask and (not Mask_Skin) then
		if not Region._MSQ_ButtonMask then
			Region:AddMaskTexture(Button_Mask)
			Region._MSQ_ButtonMask = Button_Mask
		end

		return
	end

	-- Button Mask Removal
	if Button_Mask then
		Region:RemoveMaskTexture(Button_Mask)
		Region._MSQ_ButtonMask = nil
	end

	--[[ Region Mask ]]

	local Region_Mask = Region._MSQ_Mask

	-- Region Mask Removal
	if not Mask_Skin then
		if Region._MSQ_RegionMask then
			Region:RemoveMaskTexture(Region_Mask)
			Region._MSQ_RegionMask = nil
		end

		return
	end

	-- Region Mask Creation
	if not Region_Mask then
		Region_Mask = Button:CreateMaskTexture()
		Region._MSQ_Mask = Region_Mask
	end

	local sType = type(Mask_Skin)

	-- Skin Table
	if sType == TYPE_TABLE then
		local Atlas, Texture = Mask_Skin.Atlas, Mask_Skin.Texture

		if Atlas then
			local UseSize = Mask_Skin.UseAtlasSize

			Region_Mask:SetAtlas(Atlas, UseSize)

			if not UseSize then
				Region_Mask:SetSize(_mcfg:GetSize(Mask_Skin.Width, Mask_Skin.Height))
			end

			SetSkinPoint(Region_Mask, Region, Mask_Skin, Mask_Skin.SetAllPoints)

		elseif Texture then
			local WrapH = Mask_Skin.WrapH or BASE_WRAP
			local WrapV = Mask_Skin.WrapV or BASE_WRAP

			Region_Mask:SetTexture(Texture, WrapH, WrapV)
			Region_Mask:SetSize(_mcfg:GetSize(Mask_Skin.Width, Mask_Skin.Height))

			SetSkinPoint(Region_Mask, Region, Mask_Skin, Mask_Skin.SetAllPoints)
		end

	-- Texture Path
	elseif sType == TYPE_STRING then
		Region_Mask:SetTexture(Mask_Skin, BASE_WRAP, BASE_WRAP)
		Region_Mask:SetAllPoints(Region)

	-- Exit
	else
		return
	end

	if not Region._MSQ_RegionMask then
		Region:AddMaskTexture(Region_Mask)
		Region._MSQ_RegionMask = Region_Mask
	end
end

-- Skins a button mask.
local function Skin_ButtonMask(Button, Skin)
	local _mcfg = Button._MSQ_CFG
	local Button_Mask = _mcfg.ButtonMask or Button:CreateMaskTexture()

	_mcfg.ButtonMask = Button_Mask

	local sType = type(Skin)

	-- Skin Table
	if sType == TYPE_TABLE then
		local Atlas, Texture = Skin.Atlas, Skin.Texture

		if Atlas then
			local UseSize = Skin.UseAtlasSize

			Button_Mask:SetAtlas(Atlas, UseSize)

			if not UseSize then
				Button_Mask:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))
			end

			SetSkinPoint(Button_Mask, Button, Skin, Skin.SetAllPoints)

		elseif Texture then
			local WrapH = Skin.WrapH or BASE_WRAP
			local WrapV = Skin.WrapV or BASE_WRAP

			Button_Mask:SetTexture(Texture, WrapH, WrapV)
			Button_Mask:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))

			SetSkinPoint(Button_Mask, Button, Skin, Skin.SetAllPoints)
		end

	-- Texture Path
	elseif sType == TYPE_STRING then
		Button_Mask:SetTexture(Skin, BASE_WRAP, BASE_WRAP)
		Button_Mask:SetAllPoints(Button)
	end
end

----------------------------------------
-- Core
---

-- Internal skin handler for the `Mask` region.
function Core.Skin_Mask(Button, Skin, Region)
	local _mcfg = Button._MSQ_CFG
	local CircleMask = Button.CircleMask

	if CircleMask and _mcfg.IsItem then
		if Region then
			Region:RemoveMaskTexture(CircleMask)
		end

		CircleMask:SetTexture()
	end

	_mcfg.ButtonMask = _mcfg.ButtonMask or Button.IconMask

	if Region then
		Skin_RegionMask(Region, Button, Skin)
	else
		Skin_ButtonMask(Button, Skin)
	end
end
