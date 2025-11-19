--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Cooldown.lua
	* Author.: StormFX

	Cooldown Frame

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
local DEF_SKIN = Core.DEFAULT_SKIN.Cooldown

-- @ Core\Utility
local GetColor, SetSkinPoint = Core.GetColor, Core.SetSkinPoint

----------------------------------------
-- Locals
---

local DEF_COLOR = DEF_SKIN.Color
local DEF_PULSE = [[Interface\Cooldown\star4]]

local DEF_EDGE = (WOW_RETAIL and [[Interface\Cooldown\UI-HUD-ActionBar-SecondaryCooldown]]) or [[Interface\Cooldown\edge]]
local DEF_EDGE_LOC = (WOW_RETAIL and [[Interface\Cooldown\UI-HUD-ActionBar-LoC]]) or [[Interface\Cooldown\edge-LoC]]

local MSQ_EDGE = [[Interface\AddOns\Masque\Textures\Square\Edge]]
local MSQ_EDGE_LOC = [[Interface\AddOns\Masque\Textures\Square\Edge-LoC]]

local MSQ_SWIPE = [[Interface\AddOns\Masque\Textures\Square\Mask]]
local MSQ_SWIPE_CIRCLE = [[Interface\AddOns\Masque\Textures\Circle\Mask]]

----------------------------------------
-- Hooks
---

-- Counters color changes triggered by LoC events.
local function Hook_SetSwipeColor(Region, r, g, b)
	local Color = Region._MSQ_Color

	if Region._Swipe_Hook or (not Color) then
		return
	end

	Region._Swipe_Hook = true

	if r == 0.17 and g == 0 and b == 0 then
		Region:SetSwipeColor(0.2, 0, 0, 0.8)
	else
		Region:SetSwipeColor(GetColor(Color))
	end

	Region._Swipe_Hook = nil
end

-- Counters texture changes triggered by LoC events.
local function Hook_SetEdgeTexture(Region, Texture)
	if Region._Edge_Hook or (not Region._MSQ_Color) then
		return
	end

	Region._Edge_Hook = true

	if Texture == DEF_EDGE_LOC then
		Region:SetEdgeTexture(MSQ_EDGE_LOC)
	else
		Region:SetEdgeTexture(Region._MSQ_Edge or MSQ_EDGE)
	end

	Region._Edge_Hook = nil
end

----------------------------------------
-- Helpers
---

-- Skins a `Cooldown` frame.
local function Skin_Cooldown(Region, Button, Skin, Color, Pulse)
	local _mcfg = Button._MSQ_CFG

	Skin = _mcfg:GetTypeSkin(Button, Skin)

	local IsRound = (_mcfg.Shape == "Circle") or Skin.IsRound

	if _mcfg.Enabled then
		-- Cooldown
		if Region:GetDrawSwipe() then
			Region._MSQ_Color = Color or Skin.Color or DEF_COLOR
			Region._MSQ_Edge = Skin.EdgeTexture or MSQ_EDGE

			Region:SetSwipeTexture(Skin.Texture or (IsRound and MSQ_SWIPE_CIRCLE) or MSQ_SWIPE)

			Hook_SetSwipeColor(Region)
			Hook_SetEdgeTexture(Region)

			if not Region._MSQ_Hooked then
				hooksecurefunc(Region, "SetSwipeColor", Hook_SetSwipeColor)
				hooksecurefunc(Region, "SetEdgeTexture", Hook_SetEdgeTexture)

				Region._MSQ_Hooked = true
			end

		-- ChargeCooldown
		else
			Region:SetEdgeTexture(Skin.EdgeTexture or MSQ_EDGE)
		end

	else
		Region._MSQ_Color = nil

		if Region:GetDrawSwipe() then
			Region:SetSwipeTexture("", 0, 0, 0, 0.8)
		end

		Region:SetEdgeTexture(DEF_EDGE)
	end

	Region:SetBlingTexture(Skin.PulseTexture or DEF_PULSE)
	Region:SetDrawBling(Pulse)
	Region:SetUseCircularEdge(IsRound)

	local SetAllPoints = Skin.SetAllPoints

	if not SetAllPoints then
		Region:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))
	end

	SetSkinPoint(Region, Button, Skin, nil, SetAllPoints)
end

-- Updates a `ChargeCooldown` frame.
local function Update_ChargeCooldown(Button)
	local Region = Button.chargeCooldown

	if not Region then return end

	local _mcfg = Button._MSQ_CFG
	local Skin = _mcfg and _mcfg.Skin_ChargeCooldown

	if not Skin then return end

	Skin_Cooldown(Region, Button, Skin)

	if not _mcfg.Enabled then
		_mcfg.Skin_ChargeCooldown = nil
	end
end

-- @ Interface/AddOns/Blizzard_ActionBar/*/ActionButton.lua
hooksecurefunc("StartChargeCooldown", Update_ChargeCooldown)

----------------------------------------
-- Core
---

-- Internal color handler for the `Cooldown` frame.
function Core.SetColor_Cooldown(Region, Button, Skin, Color)
	if Region then
		local _mcfg = Button._MSQ_CFG

		if _mcfg.Enabled then
			Skin = _mcfg:GetTypeSkin(Button, Skin)
			Region._MSQ_Color = Color or Skin.Color or DEF_COLOR

			Hook_SetSwipeColor(Region)
		end
	end
end

-- Internal pulse handler for the `Cooldown` frame.
function Core.SetPulse(Button, Pulse)
	local _mcfg = Button._MSQ_CFG
	local Regions = _mcfg and _mcfg.Regions

	local Cooldown = Regions and Regions.Cooldown
	local ChargeCooldown = Regions and Regions.ChargeCooldown

	if Cooldown then
		Cooldown:SetDrawBling(Pulse)
	end

	if ChargeCooldown then
		ChargeCooldown:SetDrawBling(Pulse)
	end
end

-- Internal skin handler for the `Cooldown` frame.
Core.Skin_Cooldown = Skin_Cooldown

----------------------------------------
-- API
---

local API = Core.API

-- API wrapper for the Update_ChargeCooldown function.
-- Only call this if not using the native API.
function API:UpdateChargeCooldown(Button)
	if type(Button) ~= "table" then
		return
	end

	Update_ChargeCooldown(Button)
end

-- Deprecated
API.UpdateCharge = API.UpdateChargeCooldown
