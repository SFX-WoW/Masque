--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Cooldown.lua
	* Author.: StormFX

	Cooldown Frame

	* See Skins\Default.lua for region defaults.

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local type = type

----------------------------------------
-- WoW API
---

local hooksecurefunc = hooksecurefunc

----------------------------------------
-- Internal
---

local WOW_RETAIL = Core.WOW_RETAIL

-- @ Skins\Blizzard_*
local Default = Core.DEFAULT_SKIN.Cooldown

-- @ Core\Utility
local GetColor, GetScale, GetTypeSkin = Core.GetColor, Core.GetScale, Core.GetTypeSkin

-- @ Core\Regions\Frame
local SkinFrame = Core.SkinFrame

----------------------------------------
-- Locals
---

local DEF_COLOR = Default.Color
local DEF_PULSE = [[Interface\Cooldown\star4]]
local DEF_EDGE = (WOW_RETAIL and [[Interface\Cooldown\UI-HUD-ActionBar-SecondaryCooldown]]) or [[Interface\Cooldown\edge]]
local DEF_EDGE_LOC = (WOW_RETAIL and [[Interface\Cooldown\UI-HUD-ActionBar-LoC]]) or [[Interface\Cooldown\edge-LoC]]

local MSQ_EDGE = [[Interface\AddOns\Masque\Textures\Cooldown\Edge]]
local MSQ_EDGE_LOC = [[Interface\AddOns\Masque\Textures\Cooldown\Edge-LoC]]

local MSQ_SWIPE_CIRCLE = [[Interface\AddOns\Masque\Textures\Cooldown\Swipe-Circle]]

----------------------------------------
-- Hooks
---

-- Counters color changes triggered by LoC events.
local function Hook_SetSwipeColor(Region, r, g, b)
	if Region.__SwipeHook or not Region.__MSQ_Color then
		return
	end

	Region.__SwipeHook = true

	if r == 0.17 and g == 0 and b == 0 then
		Region:SetSwipeColor(0.2, 0, 0, 0.8)
	else
		Region:SetSwipeColor(GetColor(Region.__MSQ_Color))
	end

	Region.__SwipeHook = nil
end

-- Counters texture changes triggered by LoC events.
local function Hook_SetEdgeTexture(Region, Texture)
	if Region.__EdgeHook or not Region.__MSQ_Color then
		return
	end

	Region.__EdgeHook = true

	if Texture == DEF_EDGE_LOC then
		Region:SetEdgeTexture(MSQ_EDGE_LOC)
	else
		Region:SetEdgeTexture(Region.__MSQ_Edge or MSQ_EDGE)
	end

	Region.__EdgeHook = nil
end

----------------------------------------
-- Cooldown
---

-- Skins a cooldown frame.
local function SkinCooldown(Region, Button, Skin, Color, xScale, yScale, Pulse)
	Skin = GetTypeSkin(Button, Button.__MSQ_bType, Skin)
	local IsRound = false

	if (Button.__MSQ_Shape == "Circle") or Skin.IsRound then
		IsRound = true
	end

	if Button.__MSQ_Enabled then
		-- Cooldown
		if Region:GetDrawSwipe() then
			Region.__MSQ_Color = Color or Skin.Color or DEF_COLOR
			Region.__MSQ_Edge = Skin.EdgeTexture or MSQ_EDGE

			Region:SetSwipeTexture(Skin.Texture or (IsRound and MSQ_SWIPE_CIRCLE) or "")
			Hook_SetSwipeColor(Region)
			Hook_SetEdgeTexture(Region)

			if not Region.__MSQ_Hooked then
				hooksecurefunc(Region, "SetSwipeColor", Hook_SetSwipeColor)
				hooksecurefunc(Region, "SetEdgeTexture", Hook_SetEdgeTexture)
				Region.__MSQ_Hooked = true
			end

		-- ChargeCooldown
		else
			Region:SetEdgeTexture(Skin.EdgeTexture or MSQ_EDGE)
		end
	else
		Region.__MSQ_Color = nil

		if Region:GetDrawSwipe() then
			Region:SetSwipeTexture("", 0, 0, 0, 0.8)
		end

		Region:SetEdgeTexture(DEF_EDGE)
	end

	Region:SetBlingTexture(Skin.PulseTexture or DEF_PULSE)
	Region:SetDrawBling(Pulse)
	Region:SetUseCircularEdge(IsRound)

	SkinFrame(Region, Button, Skin, xScale, yScale)
end

----------------------------------------
-- Charge Cooldown
---

-- Updates a charge cooldown frame.
local function UpdateCharge(Button)
	local Region = Button.chargeCooldown
	local Skin = Button.__MSQ_ChargeSkin

	if not Region or not Skin then
		return
	end

	SkinCooldown(Region, Button, Skin, nil, GetScale(Button))

	if not Button.__MSQ_Enabled then
		Button.__MSQ_ChargeSkin = nil
	end
end

-- @ FrameXML\ActionButton.lua
hooksecurefunc("StartChargeCooldown", UpdateCharge)

----------------------------------------
-- Core
---

Core.SkinCooldown = SkinCooldown

-- Sets the swipe color of a cooldown frame.
function Core.SetCooldownColor(Region, Button, Skin, Color)
	if Region and Button.__MSQ_Enabled then
		Skin = GetTypeSkin(Button, Button.__MSQ_bType, Skin)
		Region.__MSQ_Color = Color or Skin.Color or DEF_COLOR
		Hook_SetSwipeColor(Region)
	end
end

-- Updates the pulse setting for cooldown frames.
function Core.SetPulse(Button, Pulse)
	local Regions = Button.__Regions

	local Cooldown = Regions and Regions.Cooldown
	local ChargeCooldown = Regions and Regions.ChargeCooldown

	if Cooldown then
		Cooldown:SetDrawBling(Pulse)
	end
	if ChargeCooldown then
		ChargeCooldown:SetDrawBling(Pulse)
	end
end

----------------------------------------
-- API
---

-- Allows add-ons to update charge cooldown frames when not using the native API.
function Core.API:UpdateCharge(Button)
	if type(Button) ~= "table" then
		return
	end

	UpdateCharge(Button)
end
