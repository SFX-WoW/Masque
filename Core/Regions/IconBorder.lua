--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file or visit https://github.com/StormFX/Masque.

	* File...: Core\Regions\IconBorder.lua
	* Author.: StormFX

	Texture Regions

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

-- @ Skins\Default
local Default = Core.Skins.Default.IconBorder

-- @ Core\Utility
local GetSize, SetPoints = Core.GetSize, Core.SetPoints
local GetTexCoords = Core.GetTexCoords

----------------------------------------
-- Locals
---

local DEF_TEXTURE = Default.Texture
local DEF_RELIC_TEXTURE = Default.RelicTexture

----------------------------------------
-- Hook
---

-- Counters texture changes for artifact items.
local function Hook_SetTexture(Region, Texture)
	if Region.__ExitHook or not Region.__MSQ_Skin then
		return
	end

	Region.__ExitHook = true

	local Skin = Region.__MSQ_Skin
	local SkinTexture = Skin.Texture

	if Texture == DEF_RELIC_TEXTURE then
		SkinTexture = Skin.RelicTexture or SkinTexture or Texture
		Region.__MSQ_Texture = Texture
	else
		SkinTexture = SkinTexture or DEF_TEXTURE
		Region.__MSQ_Texture = DEF_TEXTURE
	end

	Region:SetTexture(SkinTexture)
	Region.__ExitHook = nil
end

----------------------------------------
-- Core
---

-- Skins the 'IconBorder' region of a button.
function Core.SkinIconBorder(Region, Button, Skin, xScale, yScale)
	local Texture = Region.__MSQ_Texture or Region:GetTexture()
	local SkinTexture = Skin.Texture

	if Texture == DEF_RELIC_TEXTURE then
		SkinTexture = Skin.RelicTexture or SkinTexture or Texture
	else
		SkinTexture = SkinTexture or DEF_TEXTURE
	end

	if Button.__MSQ_Enabled then
		Region.__MSQ_Skin = Skin
		Region.__MSQ_Texture = Texture

		Hook_SetTexture(Region, SkinTexture)
	else
		Region.__MSQ_Skin = nil
		Region.__MSQ_Texture = nil

		Region:SetTexture(SkinTexture)
	end

	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	Region:SetDrawLayer(Skin.DrawLayer or "OVERLAY", Skin.DrawLevel or 0)
	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))
	SetPoints(Region, Button, Skin, nil, Skin.SetAllPoints)

	if not Region.__MSQ_Hooked then
		hooksecurefunc(Region, "SetTexture", Hook_SetTexture)
		Region.__MSQ_Hooked = true
	end
end
