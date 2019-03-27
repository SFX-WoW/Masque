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

local error, hooksecurefunc, pairs, random, type = error, hooksecurefunc, pairs, random, type

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

-- Returns a random table key.
local function Random(v)
	if type(v) == "table" and #v > 1 then
		local i = random(1, #v)
		return v[i]
	end
end

----------------------------------------
-- Icon Layer
---

local function SkinIcon(Button, Region, Skin, xScale, yScale)
	Region:SetParent(Button)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetDrawLayer(Skin.DrawLayer or "BACKGROUND", Skin.DrawLevel or 0)
	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))


	local Point, RelPoint = Skin.Point or "CENTER", Skin.RelPoint or Point
	local OffsetX, OffsetY = Skin.OffsetX or 0, Skin.OffsetY or 0

	Region:ClearAllPoints()
	Region:SetPoint(Point, Button, RelPoint, OffsetX, OffsetY)
	-- Mask support added in 7.2. @InfusOnWoW
	if Skin.Mask then
		if not Region.__MSQ_Mask then
			Region.__MSQ_Mask = Button:CreateMaskTexture()
		end
		local Mask = Region.__MSQ_Mask
		Mask:SetTexture(Skin.Mask)
		Mask:SetSize(GetSize(Skin.MaskWidth or Skin.Width, Skin.MaskHeight or Skin.Height, xScale, yScale))
		Mask:SetPoint(Skin.MaskPoint or Point, Button, Skin.MaskRelPoint or RelPoint, MaskOffsetX or OffsetX, MaskOffsetY or OffsetY)
		if not Mask.active then
			Region:AddMaskTexture(Mask)
			Mask.active = true
		end
	else
		local Mask = Region.__MSQ_Mask
		if Mask and Mask.active then
			Region:RemoveMaskTexture(Mask)
			Mask.active = false
		end
	end
end

----------------------------------------
-- Border Layer
---

local SkinBorder

do
	-- Default Color
	local BaseColor = {0, 1, 0, 0.35}

	-- Hook to counter color changes.
	local function Hook_SetVertexColor(Region, ...)
		if Region.__ExitHook then return end
		Region.__ExitHook = true
		Region:SetVertexColor(GetColor(Region.__MSQ_Color))
		Region.__ExitHook = nil
	end

	-- Skins the Border layer.
	function SkinBorder(Button, Region, Skin, Color, xScale, yScale, IsActionButton)
		if Skin.Hide then
			Region:SetTexture("")
			Region:Hide()
			return
		end
		local Texture = Skin.Texture or Region:GetTexture()
		Region:SetTexture(Texture)
		Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
		Region:SetBlendMode(Skin.BlendMode or "ADD")
		Region:SetDrawLayer(Skin.DrawLayer or "OVERLAY", Skin.DrawLevel or 0)
		if IsActionButton then
			Region.__MSQ_Color = Color or Skin.Color or BaseColor
			if not Region.__MSQ_Hooked then
				hooksecurefunc(Region, "SetVertexColor", Hook_SetVertexColor)
				Region.__MSQ_Hooked = true
			end
			Hook_SetVertexColor(Region)
		end
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

		local Point = Skin.Point or "CENTER"
		local RelPoint = Skin.RelPoint or Point

		Region:ClearAllPoints()
		Region:SetPoint(Point, Button, RelPoint, Skin.OffsetX or 0, Skin.OffsetY or 0)
	end
end

----------------------------------------
-- Texture Layer
---

-- Draw Layers
local Layers = {
		Pushed = "ARTWORK",
		Disabled = "ARTWORK",
		Flash = "ARTWORK",
		Checked = "OVERLAY",
		AutoCastable = "OVERLAY",
		Highlight = "HIGHLIGHT",
		IconBorder = false,
		IconOverlay = false,
}

local SkinTexture

do
	-- Draw Levels
	local Levels = {
		Pushed = 0,
		Disabled = 0,
		Flash = 1,
		Checked = 0,
		AutoCastable = 1,
		Highlight = 0,
	}

	-- Skins a texture layer.
	function SkinTexture(Button, Region, Layer, Skin, Color, xScale, yScale)
		if Layers[Layer] then
			if Skin.Hide then
				Region:SetTexture("")
				Region:Hide()
				return
			end
			local Texture = Skin.Texture or Region:GetTexture()
			Region:SetTexture(Texture)
			Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
			Region:SetBlendMode(Skin.BlendMode or "BLEND")
			Region:SetDrawLayer(Skin.DrawLayer or Layers[Layer], Skin.DrawLevel or Levels[Layer])
			Region:SetVertexColor(GetColor(Color or Skin.Color))
		end
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

		local Point = Skin.Point or "CENTER"
		local RelPoint = Skin.RelPoint or Point

		Region:ClearAllPoints()
		Region:SetPoint(Point, Button, RelPoint, Skin.OffsetX or 0, Skin.OffsetY or 0)
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

		-- Icon
		local Icon = Regions.Icon
		if Icon then
			SkinIcon(Button, Icon, Skin.Icon, xScale, yScale)
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

		-- Border
		local Border = Regions.Border
		if Border then
			SkinBorder(Button, Border, Skin.Border, Colors.Border, xScale, yScale, IsActionButton)
		end
		-- Textures
		for Layer in pairs(Layers) do
			local Region = Regions[Layer]
			if Region then
				SkinTexture(Button, Region, Layer, Skin[Layer], Colors[Layer], xScale, yScale)
			end
		end

		----------------------------------------
		-- Gloss
		---

		if type(Gloss) ~= "number" then
			Gloss = (Gloss and 1) or 0
		end

		SkinRegion("Gloss", Gloss, Button, Skin.Gloss, Colors.Gloss, xScale, yScale)

		-- Text
		for Layer in pairs(Justify) do
			local Region = Regions[Layer]
			if Region then
				SkinText(Button, Region, Layer, Skin[Layer], Colors[Layer], xScale, yScale)
			end
		end

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
