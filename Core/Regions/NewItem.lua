--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\NewItem.lua
	* Author.: StormFX

	'NewItem' Region

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
local DEFAULT_SKIN = Core.DEFAULT_SKIN.NewItem

----------------------------------------
-- Locals
---

local DEFAULT_ATLAS = DEFAULT_SKIN.Atlas
local DEFAULT_COLOR = DEFAULT_SKIN.Color

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
	if Region.__Exit_Hook or not Region.__MSQ_Skin then
		return
	end

	Atlas = Atlas or DEFAULT_ATLAS
	Region.__MSQ_Atlas = Atlas

	local Region_Skin = Region.__MSQ_Skin
	local Skin_Atlas = Region_Skin.Atlas
	local Skin_Texture = Region_Skin.Texture
	local Skin_Coords

	if Skin_Atlas then
		Region.__Exit_Hook = true
		Region:SetAtlas(Skin_Atlas, Region_Skin.UseAtlasSize)
		Region.__Exit_Hook = nil
	elseif Skin_Texture then
		Skin_Coords = Region_Skin.TexCoords
		Region:SetTexture(Skin_Texture)
	end

	Region:SetTexCoord(GetTexCoords(Skin_Coords))
	Region:SetVertexColor(GetColor(Atlas_Colors[Atlas]))
end

----------------------------------------
-- Core
---

-- Skins the 'NewItem' region of a button.
function Core.SkinNewItem(Region, Button, Skin, xScale, yScale)
	Skin = GetTypeSkin(Button, Button.__MSQ_bType, Skin)

	local Region_Atlas = Region.__MSQ_Atlas or Region:GetAtlas() or DEFAULT_ATLAS

	Region.__MSQ_Atlas = Region_Atlas
	Region.__MSQ_Skin = Skin

	local Skin_Atlas = Skin.Atlas
	local UseAtlasSize = Skin.UseAtlasSize

	local Skin_Texture = Skin.Texture
	local Skin_Coords

	if Skin_Atlas then
		Hook_SetAtlas(Region, Region_Atlas)
	elseif Skin_Texture then
		Skin_Coords = Skin.TexCoords

		Region:SetTexture(Skin_Texture)
		Region:SetVertexColor(GetColor(Atlas_Colors[Region_Atlas]))
	else
		Region.__MSQ_Skin = nil
		UseAtlasSize = DEFAULT_SKIN.UseAtlasSize

		Region:SetAtlas(Region_Atlas, UseAtlasSize)
		Region:SetVertexColor(GetColor(DEFAULT_COLOR))
	end

	Region:SetTexCoord(GetTexCoords(Skin_Coords))
	Region:SetBlendMode(Skin.BlendMode or "ADD")
	Region:SetDrawLayer(Skin.DrawLayer or "OVERLAY", Skin.DrawLevel or 2)

	if not UseAtlasSize then
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))
	end

	SetSkinPoint(Region, Button, Skin, nil, Skin.SetAllPoints)

	-- Hook
	if not Region.__MSQ_Hooked then
		hooksecurefunc(Region, "SetAtlas", Hook_SetAtlas)
		Region.__MSQ_Hooked = true
	end
end
