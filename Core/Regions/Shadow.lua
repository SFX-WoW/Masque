--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Regions\Shadow.lua
	* Author.: StormFX

	'Shadow' Region

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Lua
---

local error, type = error, type

----------------------------------------
-- Locals
---

-- @ Core\Utility: Size, Points, Color, Coords
local GetSize, SetPoints, GetColor, GetTexCoords = Core.Utility()

-- @ Core\Core
local SkinRegion = Core.SkinRegion

local Cache = {}

----------------------------------------
-- Functions
---

-- Removes the 'Shadow' region from a button.
local function RemoveShadow(Button)
	local Region = Button.__MSQ_Shadow

	if Region then
		Region:SetTexture()
		Region:Hide()

		Cache[#Cache + 1] = Region
		Button.__MSQ_Shadow = nil
	end
end

-- Adds a 'Shadow' region to a button.
local function AddShadow(Button, Skin, Color, xScale, yScale)
	local Region = Button.__MSQ_Shadow

	if not Region then
		local i = #Cache

		if i > 0 then
			Region = Cache[i]
			Cache[i] = nil
		else
			Region = Button:CreateTexture()
		end

		Button.__MSQ_Shadow = Region
	end

	Region:SetParent(Button)

	Region:SetTexture(Skin.Texture)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

	Region:SetVertexColor(GetColor(Color or Skin.Color))
	Region:SetBlendMode(Skin.BlendMode or "BLEND")

	local DrawLayer = Skin.DrawLayer
	local DrawLevel

	if DrawLayer then
		DrawLevel = Skin.DrawLevel or 0
	end

	Region:SetDrawLayer(DrawLayer or "ARTWORK", DrawLevel or -1)

	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

	SetPoints(Region, Button, Skin, nil, Skin.SetAllPoints)

	if Button.__MSQ_Empty then
		Region:Hide()
	else
		Region:Show()
	end
end

----------------------------------------
-- Region-Skinning Function
---

-- Add or removes a 'Shadow' region.
function SkinRegion.Shadow(Enabled, Button, Skin, Color, xScale, yScale)
	if Enabled and not Skin.Hide and Skin.Texture then
		AddShadow(Button, Skin, Color, xScale, yScale)
	else
		RemoveShadow(Button)
	end
end

----------------------------------------
-- API
---

-- Retrieves the 'Shadow' region of a button.
function Core.API:GetShadow(Button)
	if type(Button) ~= "table" then
		if Core.Debug then
			error("Bad argument to API method 'GetShadow'. 'Button' must be a button object.", 2)
		end
		return
	end

	return Button.__MSQ_Shadow
end
