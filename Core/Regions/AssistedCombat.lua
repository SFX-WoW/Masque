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
-- Internal
---

if not Core.WOW_RETAIL then return end

-- @ Core\Utility
local GetTexCoords = Core.GetTexCoords

----------------------------------------
-- Locals
---

-- Default Masque Textures
-- Size: 512 x 512
-- Grid: 6 Rows, 5 Columns, 30 Frames

-- Internal Settings
-- Use the texture coordinates of the first frame.
local MSQ_COORDS = {0, 0.1640625, 0, 0.1640625}
local MSQ_FRAME_SIZE = 84
local MSQ_SIZE = 45

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
-- Assisted Combat Highlight
---

-- Fixes a texture glitch when an animation is stopped.
-- Mimics a Blizzard fix.
local function FixGlitch(AnimGroup)
	if AnimGroup and (not AnimGroup:IsPlaying()) then
		AnimGroup:Play()
		AnimGroup:Stop()
	end
end

-- Resets an Assisted Combat Highlight flipbook to the Blizzard style.
local function Reset_AssistedCombatHighlight(Region, Button)
	local _mcfg = Button._MSQ_CFG

	Region:SetAtlas("RotationHelper_Ants_Flipbook")
	Region:SetSize(_mcfg:GetSize(53, 53))

	local AnimGroup = Region.Anim
	local Animation = AnimGroup:GetAnimations()

	Animation:SetFlipBookFrameWidth(0)
	Animation:SetFlipBookFrameHeight(0)

	FixGlitch(AnimGroup)

	-- Unset the uID
	_mcfg:UpdateUID("_uID_ACH", true)
end

-- Skins an Assisted Combat Highlight flipbook.
local function Skin_AssistedCombatHighlight(Region, Button, Skin)
	local _mcfg = Button._MSQ_CFG

	local Shape = _mcfg.Shape or "Modern"
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
	local Animation = AnimGroup:GetAnimations()

	-- Force the flipbook frame size.
	Animation:SetFlipBookFrameWidth(Style.FrameWidth or MSQ_FRAME_SIZE)
	Animation:SetFlipBookFrameHeight(Style.FrameHeight or MSQ_FRAME_SIZE)

	FixGlitch(AnimGroup)

	-- Update the uID.
	_mcfg:UpdateUID("_uID_ACH")
end

----------------------------------------
-- Core
---

-- Updates an Assisted Combat Highlight flipbook.
local function Update_AssistedCombatHighlight(Region, Button)
	if not Region then return end

	local _mcfg = Button._MSQ_CFG
	local AnimGroup = Region.Anim

	local Skin  = _mcfg.Skin
	Skin = (Skin and Skin.AssistedCombatHighlight) or Skin

	if _mcfg.Enabled then
		-- Blizzard Skin
		if _mcfg.NoEffects then
			if _mcfg:NeedsUpdate("_uID_ACH", true) then
				Reset_AssistedCombatHighlight(Region, Button)
			end

		-- Custom Skin
		elseif _mcfg:NeedsUpdate("_uID_ACH") then
			Skin_AssistedCombatHighlight(Region, Button, Skin)
		end

	elseif _mcfg:NeedsUpdate("_uID_ACH", true) then
		Reset_AssistedCombatHighlight(Region, Button)
	end

	FixGlitch(AnimGroup)
end

Core.Update_AssistedCombatHighlight = Update_AssistedCombatHighlight

----------------------------------------
-- Hook
---

-- Updates the Assisted Combat Highlight when created after the button is skinned.
local function Hook_AssistedCombatHighlight(Parent, Button)
	local _mcfg = Button._MSQ_CFG
	local Frame = Button.AssistedCombatHighlightFrame

	if (not _mcfg) or (not Frame) then return end

	Update_AssistedCombatHighlight(Frame.Flipbook, Button)
end

-- @ Interface\AddOns\Blizzard_ActionBar\Mainline\AssistedCombatManager.lua
hooksecurefunc(AssistedCombatManager, "SetAssistedHighlightFrameShown", Hook_AssistedCombatHighlight)

----------------------------------------
-- API
---

local API = Core.API

-- Adds a custom Assisted Combat Highlight style.
function API:AddAssistedCombatHighlightStyle(Shape, Data)
	local Debug = Core.Debug

	if (type(Shape) ~= "string") or FlipBooks[Shape] then
		if Debug then
			error("Bad argument to API method 'AddAssistedCombatHighlightStyle'. 'Shape' must be a unique string.", 2)
		end
		return

	elseif (type(Data) ~= "table") then
		if Debug then
			error("Bad argument to API method 'AddAssistedCombatHighlightStyle'. 'Data' must be a table.", 2)
		end
		return
	end

	FlipBooks[Shape] = Data
end

-- Returns an Assisted Combat Highlight style.
function API:GetAssistedCombatHighlightStyle(Shape)
	if type(Shape) ~= "string" then
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
	if type(Button) ~= "table" then
		return
	end

	Hook_AssistedCombatHighlight(nil, Button)
end
