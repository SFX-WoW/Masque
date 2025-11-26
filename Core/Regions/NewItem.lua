--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\NewItem.lua
	* Author.: StormFX

	'NewItem' Region

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
local DEF_SKIN = Core.DEFAULT_SKIN.NewItem

----------------------------------------
-- Locals
---

local DEF_ATLAS = DEF_SKIN.Atlas
local DEF_COLOR = DEF_SKIN.Color

local Atlas_Colors = {
	["bags-glow-white"] = {1, 1, 1, 1},
	["bags-glow-green"] = {0.12, 1, 0, 1},
	["bags-glow-blue"] = {0, 0.44, 0.87, 1},
	["bags-glow-purple"] = {0.64, 0.21, 0.93, 1},
	["bags-glow-orange"] = {1, 0.5, 0, 1},
	["bags-glow-artifact"] = {0.9, 0.8, 0.5, 1},
	["bags-glow-heirloom"] = {0, 0.8, 1, 1},
}

----------------------------------------
-- Hook
---

-- Counters atlas changes when using a static skin texture.
local function Hook_SetAtlas(Region, Atlas, UseAtlasSize)
	if Region._Exit_Hook or (not Region._MSQ_Skin) then
		return
	end

	Atlas = Atlas or DEF_ATLAS
	Region._MSQ_Atlas = Atlas

	local Skin = Region._MSQ_Skin

	local Skin_Atlas = Skin.Atlas
	local Skin_Texture = Skin.Texture
	local Skin_Coords

	if Skin_Atlas then
		Region._Exit_Hook = true
		Region:SetAtlas(Skin_Atlas, Skin.UseAtlasSize)
		Region._Exit_Hook = nil

	elseif Skin_Texture then
		Skin_Coords = Skin.TexCoords
		Region:SetTexture(Skin_Texture)
	end

	Region:SetTexCoord(GetTexCoords(Skin_Coords))
	Region:SetVertexColor(GetColor(Atlas_Colors[Atlas]))
end

----------------------------------------
-- Core
---

-- Internal skin handler for the `NewItem` region.
function Core.Skin_NewItem(Region, Button, Skin)
	local _mcfg = Button._MSQ_CFG

	Skin = _mcfg:GetTypeSkin(Button, Skin)

	local Region_Atlas = Region._MSQ_Atlas or Region:GetAtlas() or DEF_ATLAS

	Region._MSQ_Atlas = Region_Atlas
	Region._MSQ_Skin = Skin

	local Skin_Atlas = Skin.Atlas
	local UseSize = Skin.UseAtlasSize

	local Skin_Texture = Skin.Texture
	local Skin_Coords

	if Skin_Atlas then
		Hook_SetAtlas(Region, Region_Atlas)

	elseif Skin_Texture then
		Skin_Coords = Skin.TexCoords

		Region:SetTexture(Skin_Texture)
		Region:SetVertexColor(GetColor(Atlas_Colors[Region_Atlas]))

	else
		Region._MSQ_Skin = nil
		UseSize = DEF_SKIN.UseAtlasSize

		Region:SetAtlas(Region_Atlas, UseSize)
		Region:SetVertexColor(GetColor(DEF_COLOR))
	end

	Region:SetTexCoord(GetTexCoords(Skin_Coords))
	Region:SetBlendMode(Skin.BlendMode or "ADD")
	Region:SetDrawLayer(Skin.DrawLayer or "OVERLAY", Skin.DrawLevel or 2)

	if (not UseSize) then
		Region:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))
	end

	SetSkinPoint(Region, Button, Skin, Skin.SetAllPoints)

	-- Hook
	if not Region._MSQ_Hooked then
		hooksecurefunc(Region, "SetAtlas", Hook_SetAtlas)
		Region._MSQ_Hooked = true
	end
end
