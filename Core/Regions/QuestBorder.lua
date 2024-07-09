--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\QuestBorder.lua
	* Author.: StormFX

	Quest Item Border Texture

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

-- @ Core\Utility
local GetColor, GetSize, GetTexCoords = Core.GetColor, Core.GetSize, Core.GetTexCoords
local GetTypeSkin, SetSkinPoint = Core.GetTypeSkin, Core.SetSkinPoint

-- @ Skins\Blizzard_*
local DEFAULT_SKIN = Core.DEFAULT_SKIN.QuestBorder

----------------------------------------
-- Locals
---

local DEFAULT_TEXTURE = DEFAULT_SKIN.Texture
local DEFAULT_BORDER = DEFAULT_SKIN.Border

----------------------------------------
-- Hook
---

-- Counters texture changes for the quest border texture.
local function Hook_SetTexture(Region, Texture)
	if Region.__Exit_Hook or not Region.__MSQ_Skin then
		return
	end

	Region.__Exit_Hook = true

	local Region_Skin = Region.__MSQ_Skin
	local Skin_Texture = Region_Skin.Texture

	if Texture == DEFAULT_TEXTURE then
		Skin_Texture = Skin_Texture or Texture
		Region.__MSQ_Texture = Texture
	else
		Skin_Texture = Region_Skin.Border or DEFAULT_BORDER
		Region.__MSQ_Texture = DEFAULT_BORDER
	end

	Region:SetTexture(Skin_Texture)
	Region.__Exit_Hook = nil
end

----------------------------------------
-- Core
---

-- Skins the 'QuestBorder' region of a button.
function Core.SkinQuestBorder(Region, Button, Skin, xScale, yScale)
	Skin = GetTypeSkin(Button, Button.__MSQ_bType, Skin)

	local Texture = Region.__MSQ_Texture or Region:GetTexture()

	if Button.__MSQ_Enabled then
		Region.__MSQ_Skin = Skin
		Region.__MSQ_Texture = Texture

		Hook_SetTexture(Region, Texture)
	else
		Region.__MSQ_Skin = nil
		Region.__MSQ_Texture = nil

		Region:SetTexture(Texture)
	end

	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetVertexColor(GetColor(Skin.Color))
	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	Region:SetDrawLayer(Skin.DrawLayer or "OVERLAY", Skin.DrawLevel or 0)
	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

	SetSkinPoint(Region, Button, Skin, nil, Skin.SetAllPoints)

	if not Region.__MSQ_Hooked then
		hooksecurefunc(Region, "SetTexture", Hook_SetTexture)
		Region.__MSQ_Hooked = true
	end
end
