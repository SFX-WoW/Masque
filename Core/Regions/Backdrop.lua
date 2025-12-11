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

-- @ Skins\Defaults
local SkinRoot = Core.SKIN_BASE

-- @ Core\Utility
local GetColor, GetTexCoords, SetSkinPoint = Core.GetColor, Core.GetTexCoords, Core.SetSkinPoint

-- @ Core\Regions\Mask
local Skin_Mask = Core.Skin_Mask

----------------------------------------
-- Locals
---

local SkinBase = SkinRoot.Backdrop

-- Skin Defaults
local BASE_BLEND = SkinRoot.BlendMode -- "BLEND"
local BASE_COLOR = SkinBase.Color -- {0, 0, 0, 0.5}
local BASE_LAYER = SkinBase.DrawLayer -- "BACKGROUND"
local BASE_LEVEL = SkinBase.DrawLevel -- -1
local BASE_SIZE = SkinRoot.Size -- 36
local BASE_TEXTURE = SkinBase.Texture -- [[Interface\AddOns\Masque\Textures\Backdrop\Slot-Modern]]
local BASE_TEXTURES = SkinBase.Textures -- [[Interface\AddOns\Masque\Textures\Backdrop\*]]

-- Type Strings
local TYPE_TABLE = "table"

-- Unused Backdrop Textures
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
		Region:SetColorTexture(GetColor(Color or BASE_COLOR))

	else
		local Coords

		if Skin_Atlas then
			Region:SetAtlas(Skin_Atlas, UseSize)
		else
			local Texture = Skin.Texture

			if not Texture then
				local bType = _mcfg.bType

				Texture = BASE_TEXTURES[bType] or BASE_TEXTURE
			end

			Coords = Skin.TexCoords
			Region:SetTexture(Texture)
		end

		Region:SetTexCoord(GetTexCoords(Coords))
		Region:SetVertexColor(GetColor(Color))
	end

	Region:SetBlendMode(Skin.BlendMode or BASE_BLEND)
	Region:SetDrawLayer(Skin.DrawLayer or BASE_LAYER, Skin.DrawLevel or BASE_LEVEL)

	local SetAllPoints = Skin.SetAllPoints

	if (not SetAllPoints) and (not UseSize) then
		local Width = Skin.Width or BASE_SIZE
		local Height = Skin.Height or BASE_SIZE

		Region:SetSize(_mcfg:GetSize(Width, Height))
	end

	SetSkinPoint(Region, Button, Skin, SetAllPoints)
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

		if Button_Mask and Region._MSQ_ButtonMask then
			Region:RemoveMaskTexture(Button_Mask)
			Region._MSQ_ButtonMask = nil
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
			Region:SetColorTexture(GetColor(Color or BASE_COLOR))
		else
			Region:SetVertexColor(GetColor(Color))
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
	if type(Button) ~= TYPE_TABLE then
		if Core.Debug then
			error("Bad argument to API method 'GetBackdrop'. 'Button' must be a button object.", 2)
		end
		return
	end

	local _mcfg = Button._MSQ_CFG
	return Button.FloatingBG or (_mcfg and _mcfg.Backdrop)
end
