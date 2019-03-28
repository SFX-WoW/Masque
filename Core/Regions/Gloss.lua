--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Regions\Gloss.lua
	* Author.: StormFX

	'Gloss' Region

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
-- Gloss
---

do
	-- Storage
	local Cache = {}

	-- Removes the 'Gloss' region from a button.
	local function RemoveGloss(Button)
		local Region = Button.__MSQ_Gloss

		if Region then
			Region:SetTexture()
			Region:Hide()

			-- Cache the region.
			Cache[#Cache + 1] = Region
			Button.__MSQ_Gloss = nil
		end
	end

	-- Adds a 'Gloss' region to a button.
	local function AddGloss(Button, Skin, Color, Alpha, xScale, yScale)
		local Region = Button.__MSQ_Gloss

		-- Assign or create a region.
		if not Region then
			local i = #Cache

			if i > 0 then
				Region = Cache[i]
				Cache[i] = nil
			else
				Region = Button:CreateTexture()
			end

			Button.__MSQ_Gloss = Region
		end

		Region:SetParent(Button)

		-- Texture
		Region:SetTexture(Skin.Texture)
		Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

		-- Color
		Region:SetBlendMode(Skin.BlendMode or "BLEND")
		Region:SetVertexColor(GetColor(Color or Skin.Color, Alpha))

		-- Level
		Region:SetDrawLayer(Skin.DrawLayer or "OVERLAY", Skin.DrawLevel or 0)

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

	-- @ Core\Core
	local SkinRegion = Core.SkinRegion

	-- Add or removes a 'Gloss' region.
	function SkinRegion.Gloss(Alpha, Button, Skin, Color, xScale, yScale)
		if Alpha > 0 and not Skin.Hide and Skin.Texture then
			AddGloss(Button, Skin, Color, Alpha, xScale, yScale)
		else
			RemoveGloss(Button)
		end
	end

	----------------------------------------
	-- API
	---

	-- Retrieves the 'Gloss' region of a button.
	function Core.API:GetGloss(Button)
		if type(Button) ~= "table" then
			if Core.Debug then
				error("Bad argument to API method 'GetGloss'. 'Button' must be a button object.", 2)
			end
			return
		end

		return Button.__MSQ_Gloss
	end
end
