--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Gloss.lua
	* Author.: StormFX

	'Gloss' Region

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

----------------------------------------
-- Locals
---

local SkinBase = SkinRoot.Gloss

-- Skin Defaults
local BASE_BLEND = SkinRoot.BlendMode -- "BLEND"
local BASE_LAYER = SkinBase.DrawLayer -- "OVERLAY"
local BASE_LEVEL = SkinBase.DrawLevel -- 1
local BASE_SIZE = SkinRoot.Size -- 36

-- Type Strings
local TYPE_TABLE = "table"

-- Unused Gloss Textures
local Cache = {}

----------------------------------------
-- Helpers
---

-- Skins or creates the 'Gloss' region of a button.
local function Add_Gloss(Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG
	local Region = _mcfg.Gloss

	if not Region then
		local i = #Cache

		if i > 0 then
			Region = Cache[i]
			Cache[i] = nil
		else
			Region = Button:CreateTexture()
		end

		_mcfg.Gloss = Region
	end

	Region:SetParent(Button)
	Region:SetTexture(Skin.Texture)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetBlendMode(Skin.BlendMode or BASE_BLEND)
	Region:SetVertexColor(GetColor(Color or Skin.Color))
	Region:SetDrawLayer(Skin.DrawLayer or BASE_LAYER, Skin.DrawLevel or BASE_LEVEL)

	local SetAllPoints = Skin.SetAllPoints

	if not SetAllPoints then
		local Width = Skin.Width or BASE_SIZE
		local Height = Skin.Height or BASE_SIZE

		Region:SetSize(_mcfg:GetSize(Width, Height))
	end

	SetSkinPoint(Region, Button, Skin, SetAllPoints)

	if _mcfg.IsEmpty then
		Region:Hide()
	else
		Region:Show()
	end
end

-- Removes the 'Gloss' region from a button.
local function Remove_Gloss(Button)
	local _mcfg = Button._MSQ_CFG
	local Region = _mcfg.Gloss

	if Region then
		Region:SetTexture()
		Region:Hide()

		Cache[#Cache + 1] = Region
		_mcfg.Gloss = nil
	end
end

----------------------------------------
-- Core
---

-- Internal color handler for the `Gloss` region.
function Core.SetColor_Gloss(Region, Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG

	Region = Region or _mcfg.Gloss

	if Region then
		Skin = _mcfg:GetTypeSkin(Button, Skin)
		Region:SetVertexColor(GetColor(Color or Skin.Color))
	end
end

-- Internal skin handler for the `Gloss` region.
function Core.Skin_Gloss(Enabled, Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG

	Skin = _mcfg:GetTypeSkin(Button, Skin)

	if Enabled and (not Skin.Hide) and Skin.Texture then
		Add_Gloss(Button, Skin, Color)
	else
		Remove_Gloss(Button)
	end
end

----------------------------------------
-- API
---

-- Retrieves the 'Gloss' region of a button.
function Core.API:GetGloss(Button)
	if type(Button) ~= TYPE_TABLE then
		if Core.Debug then
			error("Bad argument to API method 'GetGloss'. 'Button' must be a button object.", 2)
		end
		return
	end

	local _mcfg = Button._MSQ_CFG
	return _mcfg and _mcfg.Gloss
end
