--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\SpellAlert.lua
	* Author.: StormFX

	'SpellAlert' Region

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local error, type = error, type

----------------------------------------
-- WoW API
---

local ActionButton_HideOverlayGlow, C_Timer_After = _G.ActionButton_HideOverlayGlow, _G.C_Timer.After

----------------------------------------
-- Internal
---

-- @ Core\Utility
local GetScale, GetSize, GetTexCoords = Core.GetScale, Core.GetSize, Core.GetTexCoords

-- @ Core\Regions\Frame
local SkinFrame = Core.SkinFrame

----------------------------------------
-- Locals
---

local Alerts = {
	Square = {
		Glow = [[Interface\SpellActivationOverlay\IconAlert]],
		Ants = [[Interface\SpellActivationOverlay\IconAlertAnts]],
	},
	Circle = {
		Glow = [[Interface\AddOns\Masque\Textures\SpellAlert\IconAlert-Circle]],
		Ants = [[Interface\AddOns\Masque\Textures\SpellAlert\IconAlertAnts-Circle]],
	},
}

----------------------------------------
-- Overlay
---

-- Skins legacy spell alerts.
local function SkinOverlay(Region, Button, Skin)
	local Shape = Button.__MSQ_Shape

	if Region.__MSQ_Shape ~= Shape then
		local Base = Alerts.Square
		local Paths = (Shape and Alerts[Shape]) or Base

		local Ants = (Skin and Skin.Ants) or Paths.Ants or Base.Ants
		local Glow = (Skin and Skin.Glow) or Paths.Glow or Base.Glow

		Region.innerGlow:SetTexture(Glow)
		Region.innerGlowOver:SetTexture(Glow)
		Region.outerGlow:SetTexture(Glow)
		Region.outerGlowOver:SetTexture(Glow)
		Region.spark:SetTexture(Glow)
		Region.ants:SetTexture(Ants)

		Region.__MSQ_Shape = Shape
	end
end

----------------------------------------
-- SpellAlert
---

-- Skins modern spell alerts.
local function SkinSpellAlert(Region, Button, Skin, xScale, yScale)
	local Start_Flipbook = Region.ProcStartFlipbook
	local Loop_Flipbook = Region.ProcLoopFlipbook

	if Skin then
		-- [ Alert Frame ]
		-- Get the skin size relative to scaling.
		local Skin_Width, Skin_Height = GetSize(Skin.Width, Skin.Height, xScale, yScale, Button)

		-- Set the frame size relative to the button.
		Skin_Width = Skin_Width * 1.4
		Skin_Height = Skin_Height * 1.4

		Region:SetSize(Skin_Width, Skin_Height)

		-- [ Start Animation ]
		local Start_Skin = Skin.Start
		local Start_Texture = Start_Skin and Start_Skin.Texture

		-- Custom
		if Start_Texture then
			Start_Flipbook:SetTexture(Start_Texture)
			Start_Flipbook:SetTexCoord(GetTexCoords(Start_Skin.TexCoords))

		-- Default
		else
			Start_Flipbook:SetAtlas("UI-HUD-ActionBar-Proc-Start-Flipbook")
		end

		-- Set the start texture size, relative to the button size.
		local Scale_Width, Scale_Height = Button:GetSize()
		local Width = 160 * (Skin_Width / (Scale_Width * 1.4))
		local Height = 160 * (Skin_Height / (Scale_Height * 1.4))

		Start_Flipbook:SetSize(Width, Height)

		-- [ Loop Animation ]
		local Loop_Skin = Skin.Loop
		local Loop_Texture = Loop_Skin and Loop_Skin.Texture

		-- Custom
		if Loop_Texture then
			Loop_Flipbook:SetTexture(Loop_Texture)
			Loop_Flipbook:SetTexCoord(GetTexCoords(Loop_Skin.TexCoords))

		-- Default
		else
			Loop_Flipbook:SetAtlas("UI-HUD-ActionBar-Proc-Loop-Flipbook")
		end

	-- Default
	else
		local Width, Height = Button:GetSize()

		Region:SetSize(Width * 1.4, Height * 1.4)

		Start_Flipbook:SetAtlas("UI-HUD-ActionBar-Proc-Start-Flipbook")
		Loop_Flipbook:SetAtlas("UI-HUD-ActionBar-Proc-Loop-Flipbook")

		-- Defaults to 150 x 150, causing visual scaling-up on transition.
		Start_Flipbook:SetSize(160, 160) 
	end

	Region.__MSQ_Skin = Skin or true
	Region.__MSQ_Scale = Button.__MSQ_Scale
end

----------------------------------------
-- Update/Hook
---

-- Hook to update spell alerts.
local function UpdateSpellAlert(Button)
	local Region = Button.SpellActivationAlert or Button.overlay

	if not Region then return end

	local Skin = Button.__MSQ_Skin
	Skin = Skin and Skin.SpellAlert

	local Flash = Region.ProcStartAnim

	-- New Style
	if Flash then
		local Scale = Button.__MSQ_Scale
		local Active = Region.__MSQ_Skin

		-- Update the skin if necessary.
		if not Active or (Active ~= Skin) or (Scale ~= Region.__MSQ_Scale) then 
			SkinSpellAlert(Region, Button, Skin, GetScale(Button))
		end

		local Option = Core.db.profile.Effects.SpellAlert

		-- Disable spell alerts completely.
		if Option == 0 then
			ActionButton_HideOverlayGlow(Button)
			return

		-- Hide the circular flash of the starting animation. 
		elseif Option == 2 then
			if Flash:IsPlaying() then
				Region:SetAlpha(0)
			end

			C_Timer_After(0.26, function()
				Region:SetAlpha(1)
			end)
		end

	-- Still used by LibActionButton-1.0.
	elseif Region.spark then
		local Skin = Button.__MSQ_Skin

		SkinOverlay(Region, Button, Skin and Skin.SpellAlert)
	end
end

-- @ FrameXML\ActionButton.lua
_G.hooksecurefunc("ActionButton_ShowOverlayGlow", UpdateSpellAlert)

----------------------------------------
-- Core
---

Core.UpdateSpellAlert = UpdateSpellAlert

----------------------------------------
-- API
---

local API = Core.API

-- API wrapper for the UpdateSpellAlert function.
function API:UpdateSpellAlert(Button)
	if type(Button) ~= "table" then
		return
	end

	UpdateSpellAlert(Button)
end

----------------------------------------
-- Deprecated
---

-- Adds or overwrites a spell alert texture set.
function API:AddSpellAlert(Shape, Glow, Ants)
	if type(Shape) ~= "string" then
		if Core.Debug then
			error("Bad argument to API method 'AddSpellAlert'. 'Shape' must be a string.", 2)
		end
		return
	end

	local Paths = Alerts[Shape] or {}

	if type(Glow) == "string" then
		Paths.Glow = Glow
	end

	if type(Ants) == "string" then
		Paths.Ants = Ants
	end

	Alerts[Shape] = Paths
end

-- Returns a spell alert texture set.
function API:GetSpellAlert(Shape)
	if type(Shape) ~= "string" then
		if Core.Debug then
			error("Bad argument to API method 'GetSpellAlert'. 'Shape' must be a string.", 2)
		end
		return
	end

	local Paths = Alerts[Shape]

	if Paths then
		return Paths.Glow, Paths.Ants
	end
end
