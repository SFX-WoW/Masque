--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Regions\Frame.lua
	* Author.: StormFX

	Frame Regions

	* See Skins\Regions.lua for region defaults.

]]

-- GLOBALS: hooksecurefunc

local _, Core = ...

----------------------------------------
-- Lua
---

local type = type

----------------------------------------
-- Locals
---

-- @ Core\Utility
local GetSize, SetPoints = Core.GetSize, Core.SetPoints
local GetColor, GetScale = Core.GetColor, Core.GetScale

-- @ Core\Core
local SkinRegion = Core.SkinRegion

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

----------------------------------------
-- Frame
---

-- Skins a frame region of a button.
local function SkinFrame(Region, Button, Skin, xScale, yScale)
	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))
	SetPoints(Region, Button, Skin, nil, Skin.SetAllPoints)
end

----------------------------------------
-- Hooks
---

-- Hook to counter color changes.
local function Hook_SetSwipeColor(Region, r, g, b)
	if Region.__SwipeHook then return end
	Region.__SwipeHook = true

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

	if Region:GetDrawSwipe() then
		Region:SetSwipeTexture(Skin.Texture or Swipe[Shape])
		Region.__MSQ_Color = Color or Skin.Color or SwipeColor.Normal

		if not Region.__MSQ_SwipeHook then
			hooksecurefunc(Region, "SetSwipeColor", Hook_SetSwipeColor)
			Region.__MSQ_SwipeHook = true
		end

		Hook_SetSwipeColor(Region)

		if not Region.__MSQ_EdgeHook then
			hooksecurefunc(Region, "SetEdgeTexture", Hook_SetEdgeTexture)
			Region.__MSQ_EdgeHook = true
		end
	end

	Hook_SetEdgeTexture(Region)
	Region:SetUseCircularEdge(Shape == "Circle")

	SkinFrame(Region, Button, Skin, xScale, yScale)
end

----------------------------------------
-- ChargeCooldown
---

-- Updates the 'ChargeCooldown' frame of a button.
local function UpdateCharge(Button)
	local Region = Button.chargeCooldown
	local Skin = Button.__MSQ_ChargeSkin

	if not Region or not Skin then
		return
	end

	SkinCooldown(Region, Button, Skin, nil, GetScale(Button))
end

hooksecurefunc("StartChargeCooldown", UpdateCharge)

----------------------------------------
-- Regions
---

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
