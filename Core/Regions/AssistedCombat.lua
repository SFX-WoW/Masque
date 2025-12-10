--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\AssistedCombat.lua
	* Author.: StormFX

	Assisted Combat Regions

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local error, type = error, type

----------------------------------------
-- WoW API
---

if not AssistedCombatManager then return end

----------------------------------------
-- Internal
---

-- @ Core\Utility
local GetFlipBookAnimation, GetTexCoords = Core.GetFlipBookAnimation, Core.GetTexCoords

----------------------------------------
-- Locals
---

-- Base Strings
local BASE_ATLAS = "RotationHelper_Ants_Flipbook"
local BASE_UID = "_uID_ACH"

-- Misc Strings
local STR_MODERN = "Modern"

-- Type Strings
local TYPE_STRING = "string"
local TYPE_TABLE = "table"

-- Internal Settings
-- Use the texture coordinates of the first frame.
local MSQ_COORDS = {0, 0.1640625, 0, 0.1640625}
local MSQ_FRAME_SIZE = 84
local MSQ_SIZE = 45

-- Default Masque Textures
-- Size: 512 x 512
-- Grid: 6 Rows, 5 Columns, 30 Frames

-- FlipBook Style Cache
local FlipBooks = {
	["Circle"] = {
		Texture = [[Interface\AddOns\Masque\Textures\Circle\AssistedCombatHighlight-Ants]],
		TexCoords = MSQ_COORDS,
		Width = MSQ_SIZE,
		Height = MSQ_SIZE,
		FrameWidth = MSQ_FRAME_SIZE,
		FrameHeight = MSQ_FRAME_SIZE,
	},
	["Hexagon"] = {
		Texture = [[Interface\AddOns\Masque\Textures\Hexagon\AssistedCombatHighlight-Ants]],
		TexCoords = MSQ_COORDS,
		Width = MSQ_SIZE,
		Height = MSQ_SIZE,
		FrameWidth = MSQ_FRAME_SIZE,
		FrameHeight = MSQ_FRAME_SIZE,
	},
	["Hexagon-Rotated"] = {
		Texture = [[Interface\AddOns\Masque\Textures\Hexagon-Rotated\AssistedCombatHighlight-Ants]],
		TexCoords = MSQ_COORDS,
		Width = MSQ_SIZE,
		Height = MSQ_SIZE,
		FrameWidth = MSQ_FRAME_SIZE,
		FrameHeight = MSQ_FRAME_SIZE,
	},
	["Modern"] = {
		Texture = [[Interface\AddOns\Masque\Textures\Modern\AssistedCombatHighlight-Ants]],
		TexCoords = MSQ_COORDS,
		Width = MSQ_SIZE,
		Height = MSQ_SIZE,
		FrameWidth = MSQ_FRAME_SIZE,
		FrameHeight = MSQ_FRAME_SIZE,
	},
	["Square"] = {
		Texture = [[Interface\AddOns\Masque\Textures\Square\AssistedCombatHighlight-Ants]],
		TexCoords = MSQ_COORDS,
		Width = MSQ_SIZE,
		Height = MSQ_SIZE,
		FrameWidth = MSQ_FRAME_SIZE,
		FrameHeight = MSQ_FRAME_SIZE,
	},
}

----------------------------------------
-- Helpers
---

-- Fixes a texture glitch when an animation is stopped.
-- Mimics a Blizzard fix.
local function FixGlitch(AnimGroup)
	if AnimGroup and (not AnimGroup:IsPlaying()) then
		AnimGroup:Play()
		AnimGroup:Stop()
	end
end

-- Resets an `AssistedCombatHighlight` flipbook to the Blizzard style.
local function Reset_AssistedCombatHighlight(Region, Button)
	local _mcfg = Button._MSQ_CFG

	Region:SetAtlas(BASE_ATLAS)
	Region:SetSize(_mcfg:GetSize(53, 53))

	local AnimGroup = Region.Anim
	local Animation = GetFlipBookAnimation(AnimGroup)

	Animation:SetFlipBookFrameWidth(0)
	Animation:SetFlipBookFrameHeight(0)

	FixGlitch(AnimGroup)

	-- Unset the uID
	_mcfg:UpdateUID(BASE_UID, true)
end

-- Skins an `AssistedCombatHighlight` flipbook.
local function Skin_AssistedCombatHighlight(Region, Button, Skin)
	local _mcfg = Button._MSQ_CFG

	local Shape = _mcfg.Shape or STR_MODERN
	local Style = FlipBooks[Shape] or FlipBooks.Modern

	Region:SetTexture(Style.Texture)
	Region:SetTexCoord(GetTexCoords(Style.TexCoords or MSQ_COORDS))

	local Width = Style.Width
	local Height = Style.Height

	if Skin then
		Width = Skin.Width or Width
		Height = Skin.Height or Height
	end

	Region:SetSize(_mcfg:GetSize(Width, Height))

	local AnimGroup = Region.Anim
	local Animation = GetFlipBookAnimation(AnimGroup)

	-- Force the flipbook frame size.
	Animation:SetFlipBookFrameWidth(Style.FrameWidth or MSQ_FRAME_SIZE)
	Animation:SetFlipBookFrameHeight(Style.FrameHeight or MSQ_FRAME_SIZE)

	FixGlitch(AnimGroup)

	-- Update the uID.
	_mcfg:UpdateUID(BASE_UID)
end

----------------------------------------
-- Core
---

-- Updates an `AssistedCombatHighlight` flipbook.
local function Update_AssistedCombatHighlight(Region, Button)
	if not Region then return end

	local _mcfg = Button._MSQ_CFG
	local AnimGroup = Region.Anim

	local Skin  = _mcfg.Skin
	Skin = Skin and Skin.AssistedCombatHighlight

	if _mcfg.Enabled then
		-- Blizzard Skin
		if _mcfg.BaseSkin then
			if _mcfg:NeedsUpdate(BASE_UID, true) then
				Reset_AssistedCombatHighlight(Region, Button)
			end

		-- Custom Skin
		elseif _mcfg:NeedsUpdate(BASE_UID) then
			Skin_AssistedCombatHighlight(Region, Button, Skin)
		end

	elseif _mcfg:NeedsUpdate(BASE_UID, true) then
		Reset_AssistedCombatHighlight(Region, Button)
	end

	FixGlitch(AnimGroup)
end

-- Internal skin handler for the `AssistedCombatHighlight` region.
Core.Update_AssistedCombatHighlight = Update_AssistedCombatHighlight

----------------------------------------
-- Hook
---

-- Updates the `AssistedCombatHighlight` when created after the button is skinned.
local function Hook_AssistedCombatHighlight(Parent, Button)
	local Frame = Button.AssistedCombatHighlightFrame

	if not Frame then return end

	local _mcfg = Button._MSQ_CFG

	-- Make sure `SkinButton` has been called.
	if (not _mcfg) or (not _mcfg.Scale) then return end

	Update_AssistedCombatHighlight(Frame.Flipbook, Button)
end

-- @ Interface\AddOns\Blizzard_ActionBar\Mainline\AssistedCombatManager.lua
hooksecurefunc(AssistedCombatManager, "SetAssistedHighlightFrameShown", Hook_AssistedCombatHighlight)

----------------------------------------
-- API
---

local API = Core.API

-- Adds a custom `AssistedCombatHighlight` style.
function API:AddAssistedCombatHighlightStyle(Shape, Data)
	local Debug = Core.Debug

	if (type(Shape) ~= TYPE_STRING) or FlipBooks[Shape] then
		if Debug then
			error("Bad argument to API method 'AddAssistedCombatHighlightStyle'. 'Shape' must be a unique string.", 2)
		end
		return

	elseif (type(Data) ~= TYPE_TABLE) then
		if Debug then
			error("Bad argument to API method 'AddAssistedCombatHighlightStyle'. 'Data' must be a table.", 2)
		end
		return
	end

	FlipBooks[Shape] = Data
end

-- Returns an `AssistedCombatHighlight` style.
function API:GetAssistedCombatHighlightStyle(Shape)
	if type(Shape) ~= TYPE_STRING then
		if Core.Debug then
			error("Bad argument to API method 'GetAssistedCombatHighlightStyle'. 'Shape' must be a string.", 2)
		end
		return
	end

	return FlipBooks[Shape]
end

-- API wrapper for the Hook_AssistedCombatHighlight function.
-- Only call this if not using the AssistedCombatManager.
function API:UpdateAssistedCombatHighlight(Button)
	if type(Button) ~= TYPE_TABLE then
		return
	end

	Hook_AssistedCombatHighlight(nil, Button)
end
