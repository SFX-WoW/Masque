--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Normal.lua
	* Author.: StormFX

	'Normal' Region

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
local GetColor, GetTexCoords, SetSkinPoint = Core.GetColor, Core.GetTexCoords, Core.SetSkinPoint

-- @ Skins\Blizzard_*
local DEF_SKIN = Core.DEFAULT_SKIN.Normal

----------------------------------------
-- Locals
---

local DEF_ATLAS = DEF_SKIN.Atlas
local DEF_COLOR = DEF_SKIN.Color
local DEF_TEXTURE = DEF_SKIN.Texture
local DEF_USESIZE = DEF_SKIN.UseAtlasSize

----------------------------------------
-- Helpers
---

-- Updates the 'Normal' texture of a region.
local function Update_Normal(Button, IsEmpty)
	local _mcfg = Button._MSQ_CFG
	IsEmpty = IsEmpty or _mcfg.IsEmpty

	local Region = _mcfg.Normal
	local Skin = _mcfg.Skin_Normal

	if Region and (Skin and not Skin.Hide) then
		local Atlas = Skin.Atlas
		local Texture = _mcfg.Normal_Random or Skin.Texture
		local Color = _mcfg.Color_Normal or DEF_COLOR
		local Coords

		local UseEmpty = _mcfg.IsEmptyType and IsEmpty

		Color = (UseEmpty and Skin.EmptyColor) or Color

		if Atlas then
			Atlas = (UseEmpty and Skin.EmptyAtlas) or Atlas
			Region:SetAtlas(Atlas, Skin.UseAtlasSize)

		elseif Texture then
			Texture = (UseEmpty and Skin.EmptyTexture) or Texture
			Coords = (UseEmpty and Skin.EmptyCoords) or Skin.TexCoords
			Region:SetTexture(Texture)

		elseif DEF_ATLAS then
			Region:SetAtlas(DEF_ATLAS, DEF_USESIZE)

		elseif DEF_TEXTURE then
			Coords = DEF_SKIN.TexCoords
			Region:SetTexture(DEF_TEXTURE)
		end

		Region:SetTexCoord(GetTexCoords(Coords))
		Region:SetVertexColor(GetColor(Color))
	end
end

----------------------------------------
-- Hook
---

-- Counters changes to a button's 'Normal' texture.
-- * The behavior of changing the texture when a button is empty is only used
--   by the UI in Classic in the case of Pet buttons. Some add-ons still use this behavior
--   for other button types, so it needs to be countered.
-- * In Retail, the UpdateButtonArt method swaps the `Normal` atlas for one with
--   Edit Mode indicators, so we need to counter that, too.
-- * See `Update_Normal` above.
local function Hook_SetNormal(Button, Texture)
	local _mcfg = Button._MSQ_CFG
	local Skin = _mcfg and _mcfg.Skin_Normal

	if not Skin then return end

	local Normal = Button:GetNormalTexture()
	local Region = _mcfg and _mcfg.Normal

	-- Hide the original texture if using a custom texture.
	if Normal and (Normal ~= Region) then
		Normal:SetTexture()
		Normal:Hide()
	end

	-- Counter changes to the region being hidden.
	if Skin.Hide then
		Region:SetTexture()
		Region:Hide()
	end

	Update_Normal(Button)
end

----------------------------------------
-- Core
---

-- Internal color handler for the `Normal` region.
function Core.SetColor_Normal(Region, Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG

	Region = Region or _mcfg.Normal

	if Region then
		Skin = _mcfg:GetTypeSkin(Button, Skin)
		_mcfg.Color_Normal = Color or Skin.Color or DEF_COLOR

		Update_Normal(Button)
	end
end

-- Internal skin handler for the `Normal` region.
function Core.Skin_Normal(Region, Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG
	local IsButton = Button.GetNormalTexture

	local New_Normal = _mcfg.Normal_Custom
	local Old_Normal = IsButton and Button:GetNormalTexture()

	-- Catch add-ons using a custom `Normal` texture.
	if (Region and Old_Normal) and (Region ~= Old_Normal) then
		Old_Normal:SetTexture()
		Old_Normal:Hide()

	else
		Region = Region or Old_Normal
	end

	Skin = _mcfg:GetTypeSkin(Button, Skin)

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
		_mcfg.Normal_Custom = Region
	end

	_mcfg.Normal = Region
	_mcfg.Skin_Normal = Skin
	_mcfg.Color_Normal = Color or Skin.Color or DEF_COLOR

	if Skin.Hide then
		if Region then
			Region:SetTexture()
			Region:Hide()
		end
		return
	end

	local Texture_List = Skin.Textures
	local Random_Texture

	if (type(Texture_List) == "table") and (#Texture_List > 0) then
		local i = random(1, #Texture_List)
		Random_Texture = Texture_List[i]
	end

	_mcfg.Normal_Random = Random_Texture

	-- Counter the BT4 fix above.
	Region:SetAlpha(1)

	Update_Normal(Button)

	if not _mcfg.Enabled then
		_mcfg.Normal = nil
		_mcfg.Skin_Normal = nil
		_mcfg.Color_Normal = nil
		_mcfg.Normal_Random = nil
	end

	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	Region:SetDrawLayer(Skin.DrawLayer or "ARTWORK", Skin.DrawLevel or 0)

	if not Skin.UseAtlasSize then
		Region:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))
	end

	SetSkinPoint(Region, Button, Skin, Skin.SetAllPoints)

	Region:Show()

	if IsButton and _mcfg.IsEmptyType and (not _mcfg.Normal_Hook) then
		hooksecurefunc(Button, "SetNormalAtlas", Hook_SetNormal)
		hooksecurefunc(Button, "SetNormalTexture", Hook_SetNormal)

		_mcfg.Normal_Hook = true
	end
end

Core.Update_Normal = Update_Normal

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

	local _mcfg = Button._MSQ_CFG
	return (_mcfg and _mcfg.Normal) or Button:GetNormalTexture()
end
