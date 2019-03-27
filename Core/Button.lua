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

local pairs, type = pairs, type

----------------------------------------
-- Locals
---

-- @ Core\Utility
local GetScale, SkinRegion = Core.GetScale, Core.SkinRegion

-- @ Skins\Skins
local Skins, __Empty = Core.Skins, Core.__Empty

-- @ Skins\Regions
local RegList = Core.RegList

----------------------------------------
-- Button
---

do
	-- List of valid shapes.
	local Shapes = {
		Circle = "Circle",
		Square = "Square",
	}

	-- Validates and returns a shape.
	local function GetShape(Shape)
		return Shape and Shapes[Shape] or "Square"
	end

	----------------------------------------
	-- Button-Skinning Function
	---

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
			Colors = __Empty
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
