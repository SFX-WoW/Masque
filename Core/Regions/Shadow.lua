--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Shadow.lua
	* Author.: StormFX

	'Shadow' Region

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

----------------------------------------
-- Locals
---

local Cache = {}

----------------------------------------
-- Helpers
---

-- Skins or creates the 'Shadow' region of a button.
local function Add_Shadow(Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG
	local Region = _mcfg.Shadow

	if not Region then
		local i = #Cache

		if i > 0 then
			Region = Cache[i]
			Cache[i] = nil
		else
			Region = Button:CreateTexture()
		end

		_mcfg.Shadow = Region
	end

	Region:SetParent(Button)
	Region:SetTexture(Skin.Texture)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	Region:SetVertexColor(GetColor(Color or Skin.Color))
	Region:SetDrawLayer(Skin.DrawLayer or "ARTWORK", Skin.DrawLevel or -1)
	Region:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))

	SetSkinPoint(Region, Button, Skin, Skin.SetAllPoints)

	if _mcfg.IsEmpty then
		Region:Hide()
	else
		Region:Show()
	end
end

-- Removes the 'Shadow' region from a button.
local function Remove_Shadow(Button)
	local _mcfg = Button._MSQ_CFG
	local Region = _mcfg.Shadow

	if Region then
		Region:SetTexture()
		Region:Hide()

		Cache[#Cache + 1] = Region
		_mcfg.Shadow = nil
	end
end

----------------------------------------
-- Core
---

-- Internal color handler for the `Shadow` region.
function Core.SetColor_Shadow(Region, Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG

	Region = Region or _mcfg.Shadow

	if Region then
		Skin = _mcfg:GetTypeSkin(Button, Skin)
		Region:SetVertexColor(GetColor(Color or Skin.Color))
	end
end

-- Internal skin handler for the `Shadow` region.
function Core.Skin_Shadow(Enabled, Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG

	Skin = _mcfg:GetTypeSkin(Button, Skin)

	if Enabled and (not Skin.Hide) and Skin.Texture then
		Add_Shadow(Button, Skin, Color)
	else
		Remove_Shadow(Button)
	end
end

----------------------------------------
-- API
---

-- Retrieves the 'Shadow' region of a button.
function Core.API:GetShadow(Button)
	if type(Button) ~= "table" then
		if Core.Debug then
			error("Bad argument to API method 'GetShadow'. 'Button' must be a button object.", 2)
		end
		return
	end

	local _mcfg = Button._MSQ_CFG
	return _mcfg and _mcfg.Shadow
end
