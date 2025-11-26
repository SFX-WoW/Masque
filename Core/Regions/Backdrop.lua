--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Backdrop.lua
	* Author.: StormFX

	'Backdrop' Region

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local error, type = error, type

----------------------------------------
-- Internal
---

-- @ Skins\Blizzard_*
local DEF_SKIN = Core.DEFAULT_SKIN.Backdrop

-- @ Core\Utility
local GetColor, GetTexCoords, SetSkinPoint = Core.GetColor, Core.GetTexCoords, Core.SetSkinPoint

-- @ Core\Regions\Mask
local Skin_Mask = Core.Skin_Mask

----------------------------------------
-- Locals
---

local DEF_COLOR = DEF_SKIN.Color
local DEF_TEXTURE = DEF_SKIN.Texture

local Cache = {}

----------------------------------------
-- Helpers
---

-- Skins or creates the 'Backdrop' region of a button.
local function Add_Backdrop(Region, Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG

	Button.FloatingBG = Region
	Region = Region or _mcfg.Backdrop

	if not Region then
		local i = #Cache

		if i > 0 then
			Region = Cache[i]
			Cache[i] = nil
		else
			Region = Button:CreateTexture()
		end

		_mcfg.Backdrop = Region
	end

	Region:SetParent(Button)
	Color = Color or Skin.Color

	local Skin_Atlas = Skin.Atlas
	local UseSize = Skin.UseAtlasSize

	if Skin.UseColor then
		Region:SetTexture()
		Region:SetVertexColor(1, 1, 1, 1)
		Region:SetColorTexture(GetColor(Color or DEF_COLOR))

	else
		local Coords

		if Skin_Atlas then
			Region:SetAtlas(Skin_Atlas, UseSize)
		else
			Coords = Skin.TexCoords
			Region:SetTexture(Skin.Texture or DEF_TEXTURE)
		end

		Region:SetTexCoord(GetTexCoords(Coords))
		Region:SetVertexColor(GetColor(Color or DEF_COLOR))
	end

	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	Region:SetDrawLayer(Skin.DrawLayer or "BACKGROUND", Skin.DrawLevel or -1)

	if not UseSize then
		Region:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))
	end

	SetSkinPoint(Region, Button, Skin, Skin.SetAllPoints)
	Region:Show()

	-- Mask
	Skin_Mask(Button, Skin, Region)
end

-- Removes the 'Backdrop' region from a button.
local function Remove_Backdrop(Region, Button)
	local _mcfg = Button._MSQ_CFG
	Region = Region or _mcfg.Backdrop

	if not Region then return end

	Region:Hide()

	if _mcfg.Backdrop then
		-- Remove the button mask.
		local Button_Mask = _mcfg.ButtonMask

		if Button_Mask and Region._MSQ_bMask then
			Region:RemoveMaskTexture(Button_Mask)
			Region._MSQ_bMask = nil
		end

		Region:SetTexture()

		Cache[#Cache + 1] = Region
		_mcfg.Backdrop = nil
	end
end

----------------------------------------
-- Core
---

-- Internal color handler for the `Backdrop` region.
function Core.SetColor_Backdrop(Region, Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG

	Region = Region or _mcfg.Backdrop

	if Region then
		Skin = _mcfg:GetTypeSkin(Button, Skin)
		Color = Color or Skin.Color

		if Skin.UseColor then
			Region:SetColorTexture(GetColor(Color or DEF_COLOR))
		else
			Region:SetVertexColor(GetColor(Color or DEF_COLOR))
		end
	end
end

-- Internal skin handler for the `Backdrop` region.
function Core.Skin_Backdrop(Enabled, Region, Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG

	Skin = _mcfg:GetTypeSkin(Button, Skin)

	if Enabled and (not Skin.Hide) then
		Add_Backdrop(Region, Button, Skin, Color)
	else
		Remove_Backdrop(Region, Button)
	end
end

----------------------------------------
-- API
---

-- Retrieves the 'Backdrop' region of a button.
function Core.API:GetBackdrop(Button)
	if type(Button) ~= "table" then
		if Core.Debug then
			error("Bad argument to API method 'GetBackdrop'. 'Button' must be a button object.", 2)
		end
		return
	end

	local _mcfg = Button._MSQ_CFG
	return Button.FloatingBG or (_mcfg and _mcfg.Backdrop)
end
