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

-- @ Skins\Defaults
local SkinRoot = Core.SKIN_BASE

-- @ Core\Utility
local GetTexCoords, SetSkinPoint = Core.GetTexCoords, Core.SetSkinPoint

----------------------------------------
-- Locals
---

local SkinBase = SkinRoot.IconBorder

-- Skin Defaults
local BASE_BLEND = SkinRoot.BlendMode -- "BLEND"
local BASE_LAYER = SkinBase.DrawLayer -- "OVERLAY"
local BASE_LEVEL = SkinBase.DrawLevel -- 0
local BASE_SIZE = SkinRoot.Size -- 36
local BASE_RELIC = SkinBase.RelicTexture -- [[Interface\Artifacts\RelicIconFrame]]
local BASE_TEXTURE = SkinBase.Texture -- [[Interface\Common\WhiteIconFrame]]

-- String Constants
local HOOK_TEXTURE = "SetTexture"

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

	if Texture == BASE_RELIC then
		Skin_Texture = Skin.RelicTexture or Skin_Texture or Texture
		Region._MSQ_Texture = Texture

	else
		Skin_Texture = Skin_Texture or BASE_TEXTURE
		Region._MSQ_Texture = BASE_TEXTURE
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

	if (Texture ~= BASE_TEXTURE) and (Texture ~= BASE_RELIC) then
		Texture = BASE_TEXTURE
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
	Region:SetBlendMode(Skin.BlendMode or BASE_BLEND)
	Region:SetDrawLayer(Skin.DrawLayer or BASE_LAYER, Skin.DrawLevel or BASE_LEVEL)

	local SetAllPoints = Skin.SetAllPoints

	if not SetAllPoints then
		local Width = Skin.Width or BASE_SIZE
		local Height = Skin.Height or BASE_SIZE

		Region:SetSize(_mcfg:GetSize(Width, Height))
	end

	SetSkinPoint(Region, Button, Skin, SetAllPoints)

	if not Region._MSQ_Hooked then
		hooksecurefunc(Region, HOOK_TEXTURE, Hook_SetTexture)
		Region._MSQ_Hooked = true
	end
end
