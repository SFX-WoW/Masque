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

----------------------------------------
-- Shadow
---

do
	-- Storage
	local Cache = {}

	-- Removes the 'Shadow' region from a button.
	local function RemoveShadow(Button)
		local Region = Button.__MSQ_Shadow

		if Region then
			Region:SetTexture()
			Region:Hide()

			-- Cache the region.
			Cache[#Cache + 1] = Region
			Button.__MSQ_Shadow = nil
		end
	end

	-- Adds a 'Shadow' region to a button.
	local function AddShadow(Button, Skin, Color, xScale, yScale)
		local Region = Button.__MSQ_Shadow

	-- Adds a 'Gloss' region to a button.
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

		-- Texture
		Region:SetTexture(Skin.Texture)
		Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

		-- Color
		Region:SetVertexColor(GetColor(Color or Skin.Color))
		Region:SetBlendMode(Skin.BlendMode or "BLEND")

		-- Level
		local DrawLayer = Skin.DrawLayer
		local DrawLevel = Skin.DrawLevel

		if DrawLayer then
			DrawLevel = Skin.DrawLevel or 0
		end

		Region:SetDrawLayer(DrawLayer or "ARTWORK", DrawLevel or -1)

		-- Size
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

		-- Position
		SetPoints(Region, Button, Skin, nil, Skin.SetAllPoints)

		-- Hide if the button's empty.
		if Button.__MSQ_Empty then
			Region:Hide()
		else
			Region:Show()
		end
	end

	----------------------------------------
	-- Region-Skinning Function
	---

	local SkinRegion = Core.SkinRegion

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
end
