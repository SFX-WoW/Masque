--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\IconBorder.lua
	* Author.: StormFX

	IconBorder Region

]]

local _, Core = ...

----------------------------------------
-- WoW API
---

local hooksecurefunc = hooksecurefunc

----------------------------------------
-- Internal
---

-- @ Skins\Blizzard_*
local DEF_SKIN = Core.DEFAULT_SKIN.IconBorder

-- @ Core\Utility
local GetTexCoords, SetSkinPoint = Core.GetTexCoords, Core.SetSkinPoint

----------------------------------------
-- Locals
---

local DEF_TEXTURE = DEF_SKIN.Texture
local REL_TEXTURE = DEF_SKIN.RelicTexture

----------------------------------------
-- Hook
---

-- Counters texture changes for artifact items.
local function Hook_SetTexture(Region, Texture)
	local Skin = Region._MSQ_Skin

	if Region._Exit_Hook or (not Skin) then
		return
	end

	Region._Exit_Hook = true

	local Skin_Texture = Skin.Texture

	if Texture == REL_TEXTURE then
		Skin_Texture = Skin.RelicTexture or Skin_Texture or Texture
		Region._MSQ_Texture = Texture

	else
		Skin_Texture = Skin_Texture or DEF_TEXTURE
		Region._MSQ_Texture = DEF_TEXTURE
	end

	Region:SetTexture(Skin_Texture)
	Region._Exit_Hook = nil
end

----------------------------------------
-- Core
---

-- Internal skin handler for the `IconBorder` region.
function Core.Skin_IconBorder(Region, Button, Skin)
	local _mcfg = Button._MSQ_CFG

	Skin = _mcfg:GetTypeSkin(Button, Skin)

	local Texture = Region._MSQ_Texture or Region:GetTexture()

	if (Texture ~= DEF_TEXTURE) and (Texture ~= REL_TEXTURE) then
		Texture = DEF_TEXTURE
	end

	Region._MSQ_Texture = Texture

	if _mcfg.Enabled then
		Region._MSQ_Skin = Skin
		Hook_SetTexture(Region, Texture)

	else
		Region._MSQ_Skin = nil
		Region:SetTexture(Texture)
	end

	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	Region:SetDrawLayer(Skin.DrawLayer or "OVERLAY", Skin.DrawLevel or 0)
	Region:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))

	SetSkinPoint(Region, Button, Skin, nil, Skin.SetAllPoints)

	if not Region._MSQ_Hooked then
		hooksecurefunc(Region, "SetTexture", Hook_SetTexture)
		Region._MSQ_Hooked = true
	end
end
