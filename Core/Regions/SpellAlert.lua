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

local error, ipairs, type = error, ipairs, type

----------------------------------------
-- WoW API
---

local ActionButton_HideOverlayGlow = ActionButton_HideOverlayGlow

----------------------------------------
-- Internal
---

-- @ Core\Utility
local GetColor, GetScale, GetSize = Core.GetColor, Core.GetScale, Core.GetSize

----------------------------------------
-- Locals
---

-- Classic Spell Alerts
local Overlays = {
	Circle = {
		Glow = [[Interface\AddOns\Masque\Textures\SpellAlert\Classic\IconAlert-Circle]],
		Ants = [[Interface\AddOns\Masque\Textures\SpellAlert\Classic\IconAlertAnts-Circle]],
	},
	Square = {
		Glow = [[Interface\SpellActivationOverlay\IconAlert]],
		Ants = [[Interface\SpellActivationOverlay\IconAlertAnts]],
	},
}

-- Modern Spell Alerts
local DEFAULT_COLOR = {1, 0.9, 0.5}
local DEFAULT_SIZE = 64

local FlipBooks = {
	["Circle"] = {
		LoopTexture = [[Interface\AddOns\Masque\Textures\SpellAlert\Circle\Loop]],
		Color = DEFAULT_COLOR,
		FrameHeight = DEFAULT_SIZE,
		FrameWidth = DEFAULT_SIZE,
	},
	["Hexagon"] = {
		LoopTexture = [[Interface\AddOns\Masque\Textures\SpellAlert\Hexagon\Loop]],
		Color = DEFAULT_COLOR,
		FrameHeight = DEFAULT_SIZE,
		FrameWidth = DEFAULT_SIZE,
	},
	["Hexagon-Rotated"] = {
		LoopTexture = [[Interface\AddOns\Masque\Textures\SpellAlert\Hexagon-Rotated\Loop]],
		Color = DEFAULT_COLOR,
		FrameHeight = DEFAULT_SIZE,
		FrameWidth = DEFAULT_SIZE,
	},
	["Modern"] = {
		LoopTexture = [[Interface\AddOns\Masque\Textures\SpellAlert\Modern\Loop]],
		Color = DEFAULT_COLOR,
		FrameHeight = DEFAULT_SIZE,
		FrameWidth = DEFAULT_SIZE,
	},
	["Square"] = {
		LoopTexture = [[Interface\AddOns\Masque\Textures\SpellAlert\Square\Loop]],
		Color = DEFAULT_COLOR,
		FrameHeight = DEFAULT_SIZE,
		FrameWidth = DEFAULT_SIZE,
	},
}

----------------------------------------
-- Utility
---

-- Returns the flipbook animation from an animation group and sets the parent key.
local function GetFlipBook(...)
	local Animations = {...}

	for _, Animation in ipairs(Animations) do
		if Animation:GetObjectType() == "FlipBook" then
			Animation:SetParentKey("FlipAnim")
			return Animation
		end
	end
end

-- Applies style settings to a flipbook animation.
local function UpdateFlipBook(Animation, Style)
	-- Custom
	if Style then
		Animation:SetFlipBookFrameHeight(Style.FrameHeight or 0)
		Animation:SetFlipBookFrameWidth(Style.FrameWidth or 0)
		Animation:SetFlipBookFrames(Style.Frames or 30)
		Animation:SetFlipBookRows(Style.Rows or 6)
		Animation:SetFlipBookColumns(Style.Columns or 5)

	-- Default
	else
		Animation:SetFlipBookFrameHeight(0)
		Animation:SetFlipBookFrameWidth(0)
		Animation:SetFlipBookFrames(30)
		Animation:SetFlipBookRows(6)
		Animation:SetFlipBookColumns(5)
	end
end

-- Updates the start animation.
local function UpdateStartAnimation(Region)
	local Start_Group = Region.ProcStartAnim
	local Start_Animation = Start_Group.FlipAnim or GetFlipBook(Start_Group:GetAnimations())

	-- Disable the start animation.
	if Region.__Skip_Start or Region.__Loop_Only then
		Start_Animation:SetDuration(0)
		Region.ProcStartFlipbook:Hide()

	-- Enable the start animation.
	else
		Start_Animation:SetDuration(0.7)
		Region.ProcStartFlipbook:Show()
	end
end

----------------------------------------
-- Overlay
---

-- Skins legacy spell alerts.
local function SkinOverlay(Region, Button, Skin)
	local Shape = Button.__MSQ_Shape

	if Region.__MSQ_Shape ~= Shape then
		local Base = Overlays.Square
		local Paths = (Shape and Overlays[Shape]) or Base

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
-- FlipBook
---

-- Skins modern spell alerts.
local function SkinFlipBook(Region, Button, Skin, xScale, yScale)
	-- ProcStart
	local Start_Group = Region.ProcStartAnim
	local Start_Animation = Start_Group.FlipAnim or GetFlipBook(Start_Group:GetAnimations())
	local Start_Flipbook = Region.ProcStartFlipbook

	-- ProcLoop
	local Loop_Animation = Region.ProcLoop.FlipAnim
	local Loop_Flipbook = Region.ProcLoopFlipbook

	if Skin then
		-- [ Alert Frame ]

		-- Get the skin size relative to scaling.
		local Skin_Width, Skin_Height = GetSize(Skin.Width, Skin.Height, xScale, yScale, Button)

		-- Set the frame size relative to the button.
		Skin_Width = Skin_Width * 1.4
		Skin_Height = Skin_Height * 1.4

		Region:SetSize(Skin_Width, Skin_Height)

		-- [ Animations ]

		local Shape = Button.__MSQ_Shape
		local Style = Shape and FlipBooks[Shape]

		if Style then
			local Loop_Texture = Style.LoopTexture

			-- [ Start Animation ]

			local Start_Texture = Style.StartTexture

			if not Start_Texture then
				Start_Texture = Loop_Texture
				Region.__Loop_Only = true
			else
				Region.__Loop_Only = nil
			end

			Start_Flipbook:SetTexture(Start_Texture)
			Start_Flipbook:SetVertexColor(GetColor(Style.Color))

			Start_Flipbook:ClearAllPoints()
			Start_Flipbook:SetAllPoints()

			UpdateFlipBook(Start_Animation, Style)
			UpdateStartAnimation(Region)

			-- [ Loop Animation ]

			Loop_Flipbook:SetTexture(Loop_Texture)
			Loop_Flipbook:SetVertexColor(GetColor(Style.Color))

			UpdateFlipBook(Loop_Animation, Style)

		-- Default
		else
			Region.__Loop_Only = nil

			-- [ Start Animation ]

			Start_Flipbook:SetAtlas("UI-HUD-ActionBar-Proc-Start-Flipbook")
			Start_Flipbook:SetVertexColor(1, 1, 1)

			Start_Flipbook:ClearAllPoints()
			Start_Flipbook:SetPoint("CENTER")

			-- Texture size relative to the button size.
			local Scale_Width, Scale_Height = Button:GetSize()
			local Width = 160 * (Skin_Width / (Scale_Width * 1.4))
			local Height = 160 * (Skin_Height / (Scale_Height * 1.4))

			Start_Flipbook:SetSize(Width, Height)

			UpdateFlipBook(Start_Animation)
			UpdateStartAnimation(Region)

			-- [ Loop Animation ]

			Loop_Flipbook:SetAtlas("UI-HUD-ActionBar-Proc-Loop-Flipbook")
			Loop_Flipbook:SetVertexColor(1, 1, 1)

			UpdateFlipBook(Loop_Animation)
		end

	-- Default
	else
		Region.__Loop_Only = nil

		-- [ Alert Frame ]

		local Width, Height = Button:GetSize()

		Region:SetSize(Width * 1.4, Height * 1.4)

		-- [ Start Animation ]

		Start_Flipbook:SetAtlas("UI-HUD-ActionBar-Proc-Start-Flipbook")
		Start_Flipbook:SetVertexColor(1, 1, 1)

		Start_Flipbook:ClearAllPoints()
		Start_Flipbook:SetPoint("CENTER")

		-- Defaults to 150 x 150, causing visual scaling-up on transition.
		Start_Flipbook:SetSize(160, 160)

		UpdateFlipBook(Start_Animation)
		UpdateStartAnimation(Region)

		-- [ Loop Animation ]

		Loop_Flipbook:SetAtlas("UI-HUD-ActionBar-Proc-Loop-Flipbook")
		Loop_Flipbook:SetVertexColor(1, 1, 1)

		UpdateFlipBook(Loop_Animation)
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

	local Start_Group = Region.ProcStartAnim

	-- Modern Spell Alerts
	if Start_Group then
		local Scale = Button.__MSQ_Scale
		local Active = Region.__MSQ_Skin
		local Option = Core.db.profile.Effects.SpellAlert

		Region.__Skip_Start = (Option == 2 and true) or nil

		-- Update the skin if necessary.
		if not Active or (Active ~= Skin) or (Scale ~= Region.__MSQ_Scale) then
			SkinFlipBook(Region, Button, Skin, GetScale(Button))

		-- Update the start animation.
		else
			UpdateStartAnimation(Region)
		end

		-- Addresses a bug where the loop texture is visible during the start animation.
		Region.ProcLoopFlipbook:SetAlpha(0)

		-- Disable spell alerts completely.
		if Option == 0 then
			ActionButton_HideOverlayGlow(Button)
			return
		end

	-- Classic Spell Alerts
	elseif Region.spark then
		SkinOverlay(Region, Button, Skin)
	end
end

-- @ FrameXML\ActionButton.lua
hooksecurefunc("ActionButton_ShowOverlayGlow", UpdateSpellAlert)

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
-- Overlays
---

-- Adds an overlay texture set.
function API:AddSpellAlert(Shape, Glow, Ants)
	if type(Shape) ~= "string" or Overlays[Shape] then
		if Core.Debug then
			error("Bad argument to API method 'AddSpellAlert'. 'Shape' must be a unique string.", 2)
		end
		return

	elseif Glow and type(Glow) ~= "string" then
		if Core.Debug then
			error("Bad argument to API method 'AddSpellAlert'. 'Glow' must be a string.", 2)
		end
		return

	elseif Ants and type(Ants) ~= "string" then
		if Core.Debug then
			error("Bad argument to API method 'AddSpellAlert'. 'Ants' must be a string.", 2)
		end
		return
	end

	local Paths = {}

	Paths.Glow = Glow
	Paths.Ants = Ants

	Overlays[Shape] = Paths
end

-- Returns an overlay texture set.
function API:GetSpellAlert(Shape)
	if type(Shape) ~= "string" then
		if Core.Debug then
			error("Bad argument to API method 'GetSpellAlert'. 'Shape' must be a string.", 2)
		end
		return
	end

	local Paths = Overlays[Shape]

	if Paths then
		return Paths.Glow, Paths.Ants
	end
end

----------------------------------------
-- FlipBooks
---

-- Adds a custom flipbook style.
function API:AddSpellAlertFlipBook(Shape, Data)
	if type(Shape) ~= "string" or FlipBooks[Shape] then
		if Core.Debug then
			error("Bad argument to API method 'AddSpellAlertFlipBook'. 'Shape' must be a unique string.", 2)
		end
		return

	elseif type(Data) ~= "table" then
		if Core.Debug then
			error("Bad argument to API method 'AddSpellAlertFlipBook'. 'Data' must be a table.", 2)
		end
		return
	end

	FlipBooks[Shape] = Data
end

-- Returns a flipbook style table.
function API:GetSpellAlertFlipBook(Shape)
	if type(Shape) ~= "string" then
		if Core.Debug then
			error("Bad argument to API method 'GetSpellAlertFlipBook'. 'Shape' must be a string.", 2)
		end
		return
	end

	return FlipBooks[Shape]
end
