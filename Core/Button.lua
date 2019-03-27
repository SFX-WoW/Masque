--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Button.lua
	* Author.: StormFX, JJSheets

	Button

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Lua
---

local error, hooksecurefunc, pairs, type = error, hooksecurefunc, pairs, type

----------------------------------------
-- Locals
---

-- @ Core\Utility: Size, Points, Color, Coords
local GetSize, SetPoints, GetColor, GetTexCoords = Core.Utility()
local GetScale = Core.GetScale

local Skins = Core.Skins
local __MTT = {}

----------------------------------------
-- Utility
---

local GetShape

do
	-- List of valid shapes.
	local Shapes = {
		Circle = "Circle",
		Square = "Square",
	}

	-- Validates and returns a shape.
	function GetShape(Shape)
		return Shape and Shapes[Shape] or "Square"
	end
end

----------------------------------------
-- Text Layer
---

local SkinText

-- Horizontal Justification
local Justify = {
	HotKey = "RIGHT",
	Count = "RIGHT",
	Name = "CENTER",
	Duration = "CENTER",
}

do
	-- Point
	local Point = {
		Count = "BOTTOMRIGHT",
		Name = "BOTTOM",
		Duration = "TOP",
	}

	-- Relative Point
	local RelPoint = {
		Name = "BOTTOM",
		Count = "BOTTOMRIGHT",
		Duration = "BOTTOM",
	}

	-- Hook to counter add-ons that call HotKey.SetPoint after Masque has skinned the region.
	local function Hook_SetPoint(Region, ...)
		if Region.__ExitHook then return end
		Region.__ExitHook = true
		local Skin = Region.__MSQ_Skin
		Region:SetPoint("TOPLEFT", Region.__MSQ_Button, "TOPLEFT", Skin.OffsetX or 0, Skin.OffsetY or 0)
		Region.__ExitHook = nil
	end

	-- Skins a text layer.
	function SkinText(Button, Region, Layer, Skin, Color, xScale, yScale)
		Region:SetJustifyH(Skin.JustifyH or Justify[Layer])
		Region:SetJustifyV(Skin.JustifyV or "MIDDLE")
		Region:SetDrawLayer(Skin.DrawLayer or "OVERLAY")
		Region:SetSize(GetSize(Skin.Width, Skin.Height or 10, xScale, yScale))
		Region:ClearAllPoints()
		if Layer == "HotKey" then
			Region.__MSQ_Button = Button
			Region.__MSQ_Skin = Skin
			if not Region.__MSQ_Hooked then
				hooksecurefunc(Region, "SetPoint", Hook_SetPoint)
				Region.__MSQ_Hooked = true
			end
			Hook_SetPoint(Region)
		else
			Region:SetVertexColor(GetColor(Color or Skin.Color))
			Region:SetPoint(Point[Layer], Button, RelPoint[Layer], Skin.OffsetX or 0, Skin.OffsetY or 0)
		end
	end
end

----------------------------------------
-- Button Skinning Function
---

do
	local SkinRegion = Core.SkinRegion

	-- Applies a skin to a button and its associated layers.
	function Core.SkinButton(Button, Regions, SkinID, Backdrop, Shadow, Gloss, Colors, IsActionButton)
		if not Button then return end

		----------------------------------------
		-- Set Up
		---

		-- Button Type
		local bType = Button.__MSQ_bType

		-- Skin
		local Skin = (SkinID and Skins[SkinID]) or Skins["Classic"]

		-- Color
		if type(Colors) ~= "table" then
			Colors = __MTT
		end

		-- Scale
		local xScale, yScale = GetScale(Button)

		-- Shape
		Button.__MSQ_Shape = GetShape(Skin.Shape)

		----------------------------------------
		-- Backdrop
		---

		Button.FloatingBG = Button.FloatingBG or Regions.Backdrop

		SkinRegion("Backdrop", Backdrop, Button, Skin.Backdrop, Colors.Backdrop, xScale, yScale)

		----------------------------------------
		-- Icon
		---

		local Icon = Regions.Icon

		if Icon then
			SkinRegion("Icon", Icon, Button, Skin.Icon, xScale, yScale)
		end

		----------------------------------------
		-- Shadow
		---

		SkinRegion("Shadow", Shadow, Button, Skin.Shadow, Colors.Shadow, xScale, yScale)

		----------------------------------------
		-- Normal
		---

		local Normal = Regions.Normal

		if Normal ~= false then
			SkinRegion("Normal", Normal, Button, Skin.Normal, Colors.Normal, xScale, yScale)
		end

		----------------------------------------
		-- Other Regions
		---

		local Layers = RegList[bType]

		-- Iterate the regions for this button type.
		for Layer, Info in pairs(Layers) do
			local nType = Info.nType

			-- Only process regions with an internal type.
			if nType then
				local Region = Regions[Layer]

				-- Skin the region, if available.
				if Region then
					if nType == "Text" then
						SkinRegion("Text", Region, Button, Layer, Skin[Layer], xScale, yScale)
					else
						SkinRegion(nType, Region, Button, Layer, Skin[Layer], Colors[Layer], xScale, yScale)
					end
				end
			end
		end

		----------------------------------------
		-- Gloss
		---

		if type(Gloss) ~= "number" then
			Gloss = (Gloss and 1) or 0
		end

		SkinRegion("Gloss", Gloss, Button, Skin.Gloss, Colors.Gloss, xScale, yScale)

		----------------------------------------
		-- Cooldown
		---

		local Cooldown = Regions.Cooldown

		if Cooldown then
			SkinRegion("Cooldown", Cooldown, Button, Skin.Cooldown, Colors.Cooldown, xScale, yScale)
		end

		----------------------------------------
		-- Action Button Only
		---

		if bType ~= "Action" then return end

		----------------------------------------
		-- ChargeCooldown
		---

		local Charge = Button.chargeCooldown

		-- Set this so it can be accessed later.
		local ChargeSkin = Skin.ChargeCooldown
		Button.__MSQ_ChargeSkin = ChargeSkin

		if Charge then
			SkinRegion("Cooldown", Charge, Button, ChargeSkin, nil, xScale, yScale)
		end

		----------------------------------------
		-- AutoCastShine
		---

		local Shine = Regions.AutoCastShine

		if Shine then
			Button.__MSQ_Shine = Shine
			SkinRegion("Frame", Shine, Button, Skin.AutoCastShine, xScale, yScale)
		end

		----------------------------------------
		-- SpellAlert
		---

		SkinRegion("SpellAlert", Button)
	end
end
