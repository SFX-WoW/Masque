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

-- @ Core\Utility
local GetColor, GetTexCoords, SetSkinPoint = Core.GetColor, Core.GetTexCoords, Core.SetSkinPoint

-- @ Skins\Blizzard_*
local DEF_SKIN = Core.DEFAULT_SKIN.QuestBorder

----------------------------------------
-- Locals
---

local DEF_TEXTURE = DEF_SKIN.Texture
local DEF_BORDER = DEF_SKIN.Border

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

	if Texture == DEF_TEXTURE then
		Skin_Texture = Skin_Texture or Texture
		Region._MSQ_Texture = Texture

	else
		Skin_Texture = Skin.Border or DEF_BORDER
		Region._MSQ_Texture = DEF_BORDER
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
	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	Region:SetDrawLayer(Skin.DrawLayer or "OVERLAY", Skin.DrawLevel or 0)
	Region:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))

	SetSkinPoint(Region, Button, Skin, nil, Skin.SetAllPoints)

	if not Region._MSQ_Hooked then
		hooksecurefunc(Region, "SetTexture", Hook_SetTexture)
		Region._MSQ_Hooked = true
	end
end
