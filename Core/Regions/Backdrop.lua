--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Regions\Backdrop.lua
	* Author.: StormFX

	'Backdrop' Region

	* See .docs\Regions.lua for FrameXML defaults.

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

local GetColor, GetSize, GetTexCoords = Core.GetColor, Core.GetSize, Core.GetTexCoords

----------------------------------------
-- Backdrop
---

do
	local Cache = {}

	-- Removes the 'Backdrop' region from a button.
	local function RemoveBackdrop(Button)
		local Region = Button.FloatingBG or Button.__MSQ_Backdrop

		if Region then
			Region:Hide()

			-- Cache the region if not native.
			if Button.__MSQ_Backdrop then
				Region:SetTexture("")

				-- Cache the region.
				Cache[#Cache + 1] = Region
				Button.__MSQ_Backdrop = nil
			end
		end
	end

	-- Adds a 'Backdrop' region to a button.
	local function AddBackdrop(Button, Skin, Color, xScale, yScale)
		local Region = Button.FloatingBG or Button.__MSQ_Backdrop

		-- Assign a region.
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

		-- Texture
		if Texture then
			Region:SetTexture(Texture)
			Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
			Region:SetVertexColor(GetColor(Color))
		else
			Region:SetTexture("")

			-- Color
			if Color then
				Region:SetColorTexture(GetColor(Color))

			-- Default
			else
				Region:SetColorTexture(1, 1, 1, 0.6)
			end
		end

		Region:SetBlendMode(Skin.BlendMode or "BLEND")

		-- Size/Position
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))
		Region:SetDrawLayer(Skin.DrawLayer or "BACKGROUND", Skin.DrawLevel or -1)

		local Point = Skin.Point or "CENTER"
		local RelPoint = Skin.RelPoint or Point

		Region:ClearAllPoints()
		Region:SetPoint(Point, Button, RelPoint, Skin.OffsetX or 0, Skin.OffsetY or 0)

		Region:Show()
	end

	----------------------------------------
	-- Core
	---

	-- Add or removes a 'Backdrop' region.
	function Core.SkinBackdrop(Button, Enabled, Skin, Color, xScale, yScale)
		if Enabled and not Skin.Hide then
			AddBackdrop(Button, Skin, Color, xScale, yScale)
		else
			RemoveBackdrop(Button)
		end
	end

	----------------------------------------
	-- API
	---

	-- Wrapper to return the 'Backdrop' region of a button.
	function Core.API:GetBackdrop(Button)
		if type(Button) ~= "table" then
			if Core.Debug then
				error("Bad argument to API method 'GetBackdrop'. 'Button' must be a button object.", 2)
			end
			return
		end

		return Button.FloatingBG or Button.__MSQ_Backdrop
	end
end
