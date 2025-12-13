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

-- @ Skins\Defaults
local SkinRoot = Core.SKIN_BASE

-- @ Core\Utility
local GetColor, SetSkinPoint = Core.GetColor, Core.SetSkinPoint

----------------------------------------
-- Locals
---

local SkinBase = SkinRoot.Cooldown

-- Skin Defaults
local BASE_COLOR = SkinBase.Color -- {0, 0, 0, 0.8}
local BASE_EDGE = SkinBase.Edge -- [[Interface\AddOns\Masque\Textures\Square\Edge]]
local BASE_EDGE_LOC = SkinBase.EdgeLoC -- [[Interface\AddOns\Masque\Textures\Square\Edge-LoC]]
local BASE_PULSE = SkinBase.Pulse -- [[Interface\Cooldown\star4]]
local BASE_SIZE = SkinRoot.Size -- 36
local BASE_SWIPE = SkinBase.Swipe -- [[Interface\AddOns\Masque\Textures\Square\Mask]]
local BASE_SWIPE_CIRCLE = SkinBase.SwipeCircle -- [[Interface\AddOns\Masque\Textures\Circle\Mask]]

-- String Constants
local HOOK_EDGE = "SetEdgeTexture"
local HOOK_SWIPE = "SetSwipeColor"
local STR_CIRCLE = "Circle"

-- Type Strings
local TYPE_TABLE = "table"

-- Defaiult LoC Edge Textures
local LOC_TEXTURE ={
	["Interface\\Cooldown\\UI-HUD-ActionBar-SecondaryCooldown"] = true,
	["Interface\\Cooldown\\edge"] = true,
}

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

	-- LoC Color
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

	-- LoC Texture
	if LOC_TEXTURE[Texture] then
		Region:SetEdgeTexture(BASE_EDGE_LOC)
	else
		Region:SetEdgeTexture(Region._MSQ_Edge or BASE_EDGE)
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

	local IsRound = (_mcfg.Shape == STR_CIRCLE) or Skin.IsRound

	if _mcfg.Enabled then
		-- Cooldown
		if Region:GetDrawSwipe() then
			Region._MSQ_Color = Color or Skin.Color or BASE_COLOR
			Region._MSQ_Edge = Skin.EdgeTexture or BASE_EDGE

			Region:SetSwipeTexture(Skin.Texture or (IsRound and BASE_SWIPE_CIRCLE) or BASE_SWIPE)

			Hook_SetSwipeColor(Region)
			Hook_SetEdgeTexture(Region)

			if not Region._MSQ_Hooked then
				hooksecurefunc(Region, HOOK_SWIPE, Hook_SetSwipeColor)
				hooksecurefunc(Region, HOOK_EDGE, Hook_SetEdgeTexture)

				Region._MSQ_Hooked = true
			end

		-- ChargeCooldown
		else
			Region:SetEdgeTexture(Skin.EdgeTexture or BASE_EDGE)
		end

	else
		Region._MSQ_Color = nil

		if Region:GetDrawSwipe() then
			Region:SetSwipeTexture("", 0, 0, 0, 0.8)
		end

		Region:SetEdgeTexture(BASE_EDGE)
	end

	Region:SetBlingTexture(Skin.PulseTexture or BASE_PULSE)
	Region:SetDrawBling(Pulse)
	Region:SetUseCircularEdge(IsRound)

	local SetAllPoints = Skin.SetAllPoints

	if not SetAllPoints then
		local Width = Skin.Width or BASE_SIZE
		local Height = Skin.Height or BASE_SIZE

		Region:SetSize(_mcfg:GetSize(Width, Height))
	end

	SetSkinPoint(Region, Button, Skin, SetAllPoints)
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

if StartChargeCooldown then
	-- @ Interface/AddOns/Blizzard_ActionBar/*/ActionButton.lua
	hooksecurefunc("StartChargeCooldown", Update_ChargeCooldown)
end

----------------------------------------
-- Core
---

-- Internal color handler for the `Cooldown` frame.
function Core.SetColor_Cooldown(Region, Button, Skin, Color)
	if Region then
		local _mcfg = Button._MSQ_CFG

		if _mcfg.Enabled then
			Skin = _mcfg:GetTypeSkin(Button, Skin)
			Region._MSQ_Color = Color or Skin.Color or BASE_COLOR

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
	if type(Button) ~= TYPE_TABLE then
		return
	end

	Update_ChargeCooldown(Button)
end

-- Deprecated
API.UpdateCharge = API.UpdateChargeCooldown
