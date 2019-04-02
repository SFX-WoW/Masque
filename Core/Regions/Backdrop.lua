--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Regions\Backdrop.lua
	* Author.: StormFX

	'Backdrop' Region

	* See Skins\Regions.lua for region defaults.

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

-- Removes the 'Backdrop' region from a button.
local function RemoveBackdrop(Button)
	local Region = Button.FloatingBG or Button.__MSQ_Backdrop

	if Region then
		Region:Hide()

		if Button.__MSQ_Backdrop then
			Region:SetTexture()

			Cache[#Cache + 1] = Region
			Button.__MSQ_Backdrop = nil
		end
	end
end

-- Adds a 'Backdrop' region to a button.
local function AddBackdrop(Button, Skin, Color, xScale, yScale)
	local Region = Button.FloatingBG or Button.__MSQ_Backdrop

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

	local Texture = Skin.Texture
	Color = Color or Skin.Color

	if Skin.UseColor then
		Region:SetTexture()
		Region:SetColorTexture(GetColor(Color))

	elseif Texture then
		Region:SetTexture(Texture)
		Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
		Region:SetVertexColor(GetColor(Color))

	else
		Region:SetTexture([[Interface\Buttons\UI-Quickslot]])
		Region:SetTexCoord(0, 1, 0, 1)
		Region:SetVertexColor(1, 1, 1, 0.6)
	end

	Region:SetBlendMode(Skin.BlendMode or "BLEND")

	local DrawLayer = Skin.DrawLayer
	local DrawLevel = Skin.DrawLevel

	if DrawLayer then
		DrawLevel = Skin.DrawLevel or 0
	end

	Region:SetDrawLayer(DrawLayer or "BACKGROUND", DrawLevel or -1)

	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

	SetPoints(Region, Button, Skin, nil, Skin.SetAllPoints)

	Region:Show()
end

----------------------------------------
-- Region-Skinning Function
---

-- Add or removes a 'Backdrop' region.
function SkinRegion.Backdrop(Enabled, Button, Skin, Color, xScale, yScale)
	if Enabled and not Skin.Hide then
		AddBackdrop(Button, Skin, Color, xScale, yScale)
	else
		RemoveBackdrop(Button)
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
