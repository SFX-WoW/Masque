--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Regions\Frame.lua
	* Author.: StormFX

	Frame Regions

	* See Skins\Regions.lua for region defaults.

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Lua
---

local type = type

----------------------------------------
-- Locals
---

-- @ Core\Utility: Size, Points, Color, Coords
local GetSize, SetPoints, GetColor = Core.Utility()

-- @ Core\Utility
local GetScale = Core.GetScale

----------------------------------------
-- Frames
---

do
	----------------------------------------
	-- Frame
	---

	-- Skins a frame region of a button.
	local function SkinFrame(Region, Button, Skin, xScale, yScale)
		-- Size
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

		-- Position
		SetPoints(Region, Button, Skin, nil, Skin.SetAllPoints)
	end

	----------------------------------------
	-- Hooks
	---

	local Swipe = {
		Circle = [[Interface\AddOns\Masque\Textures\Cooldown\Swipe-Circle]],
		Square = [[Interface\AddOns\Masque\Textures\Cooldown\Swipe]],
	}
	local SwipeColor = {
		LoC = {0.2, 0, 0, 0.8},
		Normal = {0, 0, 0, 0.8},
	}
	local Edge = {
		LoC = [[Interface\AddOns\Masque\Textures\Cooldown\Edge-LoC]],
		Normal = [[Interface\AddOns\Masque\Textures\Cooldown\Edge]],
	}

	-- Hook to counter color changes.
	local function Hook_SetSwipeColor(Region, r, g, b)
		if Region.__SwipeHook then return end
		Region.__SwipeHook = true

		-- Default Loss-of-Control Color
		if r == 0.17 and g == 0 and b == 0 then
			Region:SetSwipeColor(GetColor(SwipeColor.LoC))
		else
			Region:SetSwipeColor(GetColor(Region.__MSQ_Color))
		end

		Region.__SwipeHook = nil
	end

	-- Hook to counter texture changes.
	local function Hook_SetEdgeTexture(Region, Texture)
		if Region.__EdgeHook then return end
		Region.__EdgeHook = true

		-- Default Loss-of-Control Texture
		if Texture == "Interface\\Cooldown\\edge-LoC" then
			Region:SetEdgeTexture(Edge.LoC)
		else
			Region:SetEdgeTexture(Edge.Normal)
		end

		Region.__EdgeHook = nil
	end

	----------------------------------------
	-- Cooldown
	---

	-- Skins the 'Cooldown' frame of a button.
	local function SkinCooldown(Region, Button, Skin, Color, xScale, yScale)
		local Shape = Button.__MSQ_Shape

		-- Normal Cooldown
		if Region:GetDrawSwipe() then
			-- Swipe Texture
			Region:SetSwipeTexture(Skin.Texture or Swipe[Shape])

			-- Store the swipe color.
			Region.__MSQ_Color = Color or Skin.Color or SwipeColor.Normal

			-- Hook SetSwipeColor
			if not Region.__MSQ_SwipeHook then
				hooksecurefunc(Region, "SetSwipeColor", Hook_SetSwipeColor)
				Region.__MSQ_SwipeHook = true
			end

			-- Swipe Color
			Hook_SetSwipeColor(Region)

			-- Hook SetEdgeTexture
			if not Region.__MSQ_EdgeHook then
				hooksecurefunc(Region, "SetEdgeTexture", Hook_SetEdgeTexture)
				Region.__MSQ_EdgeHook = true
			end
		end

		-- Edge Texture
		Hook_SetEdgeTexture(Region)
		Region:SetUseCircularEdge(Shape == "Circle")

		-- Frame
		SkinFrame(Region, Button, Skin, xScale, yScale)
	end

	----------------------------------------
	-- ChargeCooldown
	---

	-- Updates the 'ChargeCooldown' frame of a button.
	local function UpdateCharge(Button)
		local Region = Button.chargeCooldown
		local Skin = Button.__MSQ_ChargeSkin

		-- Exit if there's no charge or skin.
		if not Region or not Skin then
			return
		end

		SkinCooldown(Region, Button, Skin, nil, GetScale(Button))
	end

	-- Update Hook
	hooksecurefunc("StartChargeCooldown", UpdateCharge)

	----------------------------------------
	-- Region-Skinning Functions
	---

	-- @ Core\Core
	local SkinRegion = Core.SkinRegion

	SkinRegion.Frame = SkinFrame
	SkinRegion.Cooldown = SkinCooldown

	----------------------------------------
	-- API
	---

	-- Wrapper for UpdateCharge(), for add-ons not using the native API.
	function Core.API:UpdateCharge(Button)
		if type(Button) ~= "table" then
			return
		end

		UpdateCharge(Button)
	end
end
