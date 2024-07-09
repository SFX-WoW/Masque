--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Normal.lua
	* Author.: StormFX

	'Normal' Region

	* See Skins\Default.lua for region defaults.

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local error, type = error, type

----------------------------------------
-- WoW API
---

local hooksecurefunc, random = hooksecurefunc, random

----------------------------------------
-- Internal
---

-- @ Core\Utility
local GetColor, GetSize, GetTexCoords = Core.GetColor, Core.GetSize, Core.GetTexCoords
local GetTypeSkin, SetSkinPoint = Core.GetTypeSkin, Core.SetSkinPoint

-- @ Skins\Blizzard_*
local DEFAULT_SKIN = Core.DEFAULT_SKIN.Normal

----------------------------------------
-- Locals
---

local DEFAULT_ATLAS = DEFAULT_SKIN.Atlas
local DEFAULT_COLOR = DEFAULT_SKIN.Color
local DEFAULT_TEXTURE = DEFAULT_SKIN.Texture
local USE_ATLAS_SIZE = DEFAULT_SKIN.UseAtlasSize

----------------------------------------
-- UpdateNormal
---

-- Updates the 'Normal' texture of a region.
local function UpdateNormal(Button, IsEmpty)
	IsEmpty = IsEmpty or Button.__MSQ_Empty

	local Region = Button.__MSQ_Normal
	local Region_Skin = Button.__MSQ_Normal_Skin

	if Region and (Region_Skin and not Region_Skin.Hide) then
		local Skin_Atlas = Region_Skin.Atlas
		local Skin_Texture = Button.__MSQ_Random_Texture or Region_Skin.Texture
		local Skin_Color = Button.__MSQ_Normal_Color or DEFAULT_COLOR
		local Skin_Coords

		local Use_Empty = Button.__MSQ_Empty_Type and IsEmpty

		Skin_Color = (Use_Empty and Region_Skin.EmptyColor) or Skin_Color

		if Skin_Atlas then
			Skin_Atlas = (Use_Empty and Region_Skin.EmptyAtlas) or Skin_Atlas
			Region:SetAtlas(Skin_Atlas, Region_Skin.UseAtlasSize)
		elseif Skin_Texture then
			Skin_Texture = (Use_Empty and Region_Skin.EmptyTexture) or Skin_Texture
			Skin_Coords = (Use_Empty and Region_Skin.EmptyCoords) or Region_Skin.TexCoords
			Region:SetTexture(Skin_Texture)
		elseif DEFAULT_ATLAS then
			Region:SetAtlas(DEFAULT_ATLAS, USE_ATLAS_SIZE)
		elseif DEFAULT_TEXTURE then
			Skin_Coords = DEFAULT_SKIN.TexCoords
			Region:SetTexture(DEFAULT_TEXTURE)
		end

		Region:SetTexCoord(GetTexCoords(Skin_Coords))
		Region:SetVertexColor(GetColor(Skin_Color))
	end
end

----------------------------------------
-- Hook
---

-- Counters changes to a button's 'Normal' Texture or Atlas.
-- * The behavior of changing the texture when a button is empty is only used
--   by Classic UI in the case of Pet buttons. Some add-ons still use this
--   behavior for other button types, so it needs to be countered.
-- * In Dragonflight, the UpdateButtonArt method swaps the `Normal` Atlas for one with
--   Edit Mode indicators, so we need to counter that, too.
-- * See `UpdateNormal` above.
local function Hook_SetNormal(Button, Texture)
	local Region_Skin = Button.__MSQ_Normal_Skin
	if not Region_Skin then return end

	local Normal = Button:GetNormalTexture()
	local Region = Button.__MSQ_Normal

	-- Hide the original texture if using a custom texture.
	if Normal and (Normal ~= Region) then
		Normal:SetTexture()
		Normal:Hide()
	end

	-- Counter changes to the region being hidden.
	if Region_Skin.Hide then
		Region:SetTexture()
		Region:Hide()
	end

	UpdateNormal(Button)
end

----------------------------------------
-- Core
---

-- Skins the `Normal` layer of a button and sets up any necessary hooks.
function Core.SkinNormal(Region, Button, Skin, Color, xScale, yScale)
	local IsButton = Button.GetNormalTexture

	local New_Normal = Button.__MSQ_New_Normal
	local Old_Normal = IsButton and Button:GetNormalTexture()

	-- Catch add-ons using a custom `Normal` texture.
	if (Region and Old_Normal) and (Region ~= Old_Normal) then
		Old_Normal:SetTexture()
		Old_Normal:Hide()
	else
		Region = Region or Old_Normal
	end

	Skin = GetTypeSkin(Button, Button.__MSQ_bType, Skin)

	-- States Enabled
	if Skin.UseStates then
		if New_Normal then
			New_Normal:SetTexture()
			New_Normal:Hide()
		end

		if not Region then return end

	-- States Disabled
	else
		if Region then
			-- Fix for BT4's Pet buttons.
			Region:SetAlpha(0)
			Region:SetTexture()
			Region:Hide()
		end

		Region = New_Normal or Button:CreateTexture()
		Button.__MSQ_New_Normal = Region
	end

	Button.__MSQ_Normal = Region
	Button.__MSQ_Normal_Skin = Skin
	Button.__MSQ_Normal_Color = Color or Skin.Color or DEFAULT_COLOR

	if Skin.Hide then
		if Region then
			Region:SetTexture()
			Region:Hide()
		end
		return
	end

	local Skin_Textures = Skin.Textures
	local Random_Texture

	if type(Skin_Textures) == "table" and #Skin_Textures > 0 then
		local i = random(1, #Skin_Textures)
		Random_Texture = Skin_Textures[i]
	end

	Button.__MSQ_Random_Texture = Random_Texture

	-- Counter the BT4 fix above.
	Region:SetAlpha(1)

	UpdateNormal(Button)

	if not Button.__MSQ_Enabled then
		Button.__MSQ_Normal = nil
		Button.__MSQ_Normal_Skin = nil
		Button.__MSQ_Normal_Color = nil
		Button.__MSQ_Random_Texture = nil
	end

	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	Region:SetDrawLayer(Skin.DrawLayer or "ARTWORK", Skin.DrawLevel or 0)

	if not Skin.UseAtlasSize then
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale, Button))
	end

	SetSkinPoint(Region, Button, Skin, nil, Skin.SetAllPoints)

	Region:Show()

	if IsButton and Button.__MSQ_Empty_Type and not Button.__MSQ_Normal_Hook then
		hooksecurefunc(Button, "SetNormalAtlas", Hook_SetNormal)
		hooksecurefunc(Button, "SetNormalTexture", Hook_SetNormal)

		Button.__MSQ_Normal_Hook = true
	end
end

----------------------------------------
-- Core
---

-- Sets the color of the 'Normal' region.
function Core.SetNormalColor(Region, Button, Skin, Color)
	Region = Region or Button.__MSQ_Normal

	if Region then
		Skin = GetTypeSkin(Button, Button.__MSQ_bType, Skin)
		Button.__MSQ_Normal_Color = Color or Skin.Color or DEFAULT_COLOR

		UpdateNormal(Button)
	end
end

Core.UpdateNormal = UpdateNormal

----------------------------------------
-- API
---

-- Retrieves the 'Normal' region of a button.
function Core.API:GetNormal(Button)
	if type(Button) ~= "table" then
		if Core.Debug then
			error("Bad argument to API method 'GetNormal'. 'Button' must be a button object.", 2)
		end
		return
	end

	return Button.__MSQ_Normal or Button:GetNormalTexture()
end
