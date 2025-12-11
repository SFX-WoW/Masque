--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\QuestBorder.lua
	* Author.: StormFX

	Quest Item Border Texture

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
local GetColor, GetTexCoords, SetSkinPoint = Core.GetColor, Core.GetTexCoords, Core.SetSkinPoint

----------------------------------------
-- Locals
---

local SkinBase = SkinRoot.QuestBorder

-- Skin Defaults
local BASE_BLEND = SkinRoot.BlendMode -- "BLEND"
local BASE_BORDER = SkinBase.Border -- [[Interface\ContainerFrame\UI-Icon-QuestBang]]
local BASE_LAYER = SkinBase.DrawLayer -- "OVERLAY"
local BASE_LEVEL = SkinBase.DrawLevel -- 2
local BASE_SIZE = SkinRoot.Size -- 36
local BASE_TEXTURE = SkinBase.Texture -- [[Interface\ContainerFrame\UI-Icon-QuestBorder]]

-- String Constants
local HOOK_TEXTURE = "SetTexture"

----------------------------------------
-- Hook
---

-- Counters changes to a button's 'QuestBorder' texture.
local function Hook_SetTexture(Region, Texture)
	if Region._Exit_Hook or (not Region._MSQ_Skin) then
		return
	end

	Region._Exit_Hook = true

	local Skin = Region._MSQ_Skin
	local Skin_Texture = Skin.Texture

	if Texture == BASE_TEXTURE then
		Skin_Texture = Skin_Texture or Texture
		Region._MSQ_Texture = Texture

	else
		Skin_Texture = Skin.Border or BASE_BORDER
		Region._MSQ_Texture = BASE_BORDER
	end

	Region:SetTexture(Skin_Texture)
	Region._Exit_Hook = nil
end

----------------------------------------
-- Core
---

-- Internal skin handler for the `QuestBorder` region.
function Core.Skin_QuestBorder(Region, Button, Skin)
	local _mcfg = Button._MSQ_CFG

	Skin = _mcfg:GetTypeSkin(Button, Skin)

	local Texture = Region._MSQ_Texture or Region:GetTexture()

	if _mcfg.Enabled then
		Region._MSQ_Skin = Skin
		Region._MSQ_Texture = Texture

		Hook_SetTexture(Region, Texture)
	else
		Region._MSQ_Skin = nil
		Region._MSQ_Texture = nil

		Region:SetTexture(Texture)
	end

	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetVertexColor(GetColor(Skin.Color))
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
