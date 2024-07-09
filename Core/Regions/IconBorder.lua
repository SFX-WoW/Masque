--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\IconBorder.lua
	* Author.: StormFX

	IconBorder Region

	* See Skins\Default.lua for region defaults.

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
local DEFAULT_SKIN = Core.DEFAULT_SKIN.IconBorder

-- @ Core\Utility
local GetSize, GetTexCoords, SetSkinPoint = Core.GetSize, Core.GetTexCoords, Core.SetSkinPoint
local GetTypeSkin = Core.GetTypeSkin

----------------------------------------
-- Locals
---

local DEFAULT_TEXTURE = DEFAULT_SKIN.Texture
local RELIC_TEXTURE = DEFAULT_SKIN.RelicTexture

----------------------------------------
-- Hook
---

-- Counters texture changes for artifact items.
local function Hook_SetTexture(Region, Texture)
	if Region.__Exit_Hook or not Region.__MSQ_Skin then
		return
	end

	Region.__Exit_Hook = true

	local Region_Skin = Region.__MSQ_Skin
	local Skin_Texture = Region_Skin.Texture

	if Texture == RELIC_TEXTURE then
		Skin_Texture = Region_Skin.RelicTexture or Skin_Texture or Texture
		Region.__MSQ_Texture = Texture
	else
		Skin_Texture = Skin_Texture or DEFAULT_TEXTURE
		Region.__MSQ_Texture = DEFAULT_TEXTURE
	end

	Region:SetTexture(Skin_Texture)
	Region.__Exit_Hook = nil
end

----------------------------------------
-- Core
---

-- Skins the 'IconBorder' region of a button.
function Core.SkinIconBorder(Region, Button, Skin, xScale, yScale)
	Skin = GetTypeSkin(Button, Button.__MSQ_bType, Skin)

	local Region_Texture = Region.__MSQ_Texture or Region:GetTexture()

	if Region_Texture ~= DEFAULT_TEXTURE and Region_Texture ~= RELIC_TEXTURE then
		Region_Texture = DEFAULT_TEXTURE
	end

	Region.__MSQ_Texture = Region_Texture

	if Button.__MSQ_Enabled then
		Region.__MSQ_Skin = Skin
		Hook_SetTexture(Region, Region_Texture)
	else
		Region.__MSQ_Skin = nil
		Region:SetTexture(Region_Texture)
	end

	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	Region:SetDrawLayer(Skin.DrawLayer or "OVERLAY", Skin.DrawLevel or 0)
	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

	SetSkinPoint(Region, Button, Skin, nil, Skin.SetAllPoints)

	if not Region.__MSQ_Hooked then
		hooksecurefunc(Region, "SetTexture", Hook_SetTexture)
		Region.__MSQ_Hooked = true
	end
end
