--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Backdrop.lua
	* Author.: StormFX

	'Backdrop' Region

	* See Skins\Default.lua for region defaults.

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local error, type = error, type

----------------------------------------
-- Internal
---

-- @ Skins\Blizzard_*
local DEFAULT_SKIN = Core.DEFAULT_SKIN.Backdrop

-- @ Core\Utility
local GetColor, GetSize, GetTexCoords = Core.GetColor, Core.GetSize, Core.GetTexCoords
local GetTypeSkin, SetSkinPoint = Core.GetTypeSkin, Core.SetSkinPoint

-- @ Core\Regions\Mask
local SkinMask = Core.SkinMask

----------------------------------------
-- Locals
---

local DEFAULT_COLOR = DEFAULT_SKIN.Color
local DEFAULT_TEXTURE = DEFAULT_SKIN.Texture

local Cache = {}

----------------------------------------
-- Functions
---

-- Removes the 'Backdrop' region from a button.
local function RemoveBackdrop(Region, Button)
	Region = Region or Button.__MSQ_Backdrop

	if Region then
		Region:Hide()

		if Button.__MSQ_Backdrop then
			-- Remove the button mask.
			local Button_Mask = Button.__MSQ_Mask

			if Button_Mask and Region.__MSQ_Button_Mask then
				Region:RemoveMaskTexture(Button_Mask)
				Region.__MSQ_Button_Mask = nil
			end

			Region:SetTexture()

			Cache[#Cache + 1] = Region
			Button.__MSQ_Backdrop = nil
		end
	end
end

-- Skins or creates the 'Backdrop' region of a button.
local function AddBackdrop(Region, Button, Skin, Color, xScale, yScale)
	Button.FloatingBG = Region
	Region = Region or Button.__MSQ_Backdrop

	if not Region then
		local i = #Cache

		if i > 0 then
			Region = Cache[i]
			Cache[i] = nil
		else
			Region = Button:CreateTexture()
		end

		Button.__MSQ_Backdrop = Region
	end

	Region:SetParent(Button)
	Color = Color or Skin.Color

	local Skin_Atlas = Skin.Atlas
	local UseAtlasSize = Skin.UseAtlasSize

	if Skin.UseColor then
		Region:SetTexture()
		Region:SetVertexColor(1, 1, 1, 1)
		Region:SetColorTexture(GetColor(Color or DEFAULT_COLOR))
	else
		local Coords

		if Skin_Atlas then
			Region:SetAtlas(Skin_Atlas, UseAtlasSize)
		else
			Coords = Skin.TexCoords
			Region:SetTexture(Skin.Texture or DEFAULT_TEXTURE)
		end

		Region:SetTexCoord(GetTexCoords(Coords))
		Region:SetVertexColor(GetColor(Color or DEFAULT_COLOR))
	end

	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	Region:SetDrawLayer(Skin.DrawLayer or "BACKGROUND", Skin.DrawLevel or -1)

	if not UseAtlasSize then
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale, Button))
	end

	SetSkinPoint(Region, Button, Skin, nil, Skin.SetAllPoints)
	Region:Show()

	-- Mask
	SkinMask(Region, Button, Skin, xScale, yScale)
end

----------------------------------------
-- Core
---

-- Sets the color of the 'Backdrop' region.
function Core.SetBackdropColor(Region, Button, Skin, Color)
	Region = Region or Button.__MSQ_Backdrop

	if Region then
		Skin = GetTypeSkin(Button, Button.__MSQ_bType, Skin)
		Color = Color or Skin.Color

		if Skin.UseColor then
			Region:SetColorTexture(GetColor(Color or DEFAULT_COLOR))
		else
			Region:SetVertexColor(GetColor(Color or DEFAULT_COLOR))
		end
	end
end

-- Add or removes a 'Backdrop' region.
function Core.SkinBackdrop(Enabled, Region, Button, Skin, Color, xScale, yScale)
	Skin = GetTypeSkin(Button, Button.__MSQ_bType, Skin)

	if Enabled and not Skin.Hide then
		AddBackdrop(Region, Button, Skin, Color, xScale, yScale)
	else
		RemoveBackdrop(Region, Button)
	end
end

----------------------------------------
-- API
---

-- Retrieves the 'Backdrop' region of a button.
function Core.API:GetBackdrop(Button)
	if type(Button) ~= "table" then
		if Core.Debug then
			error("Bad argument to API method 'GetBackdrop'. 'Button' must be a button object.", 2)
		end
		return
	end

	return Button.FloatingBG or Button.__MSQ_Backdrop
end
