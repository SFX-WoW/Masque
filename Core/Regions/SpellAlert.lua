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
-- Internal
---

local WOW_RETAIL = Core.WOW_RETAIL

-- @ Core\Utility
local GetFlipBookAnimation = Core.GetFlipBookAnimation

----------------------------------------
-- Locals
---

-- Default Masque Textures
-- Size: 512 x 512
-- Grid: 6 Rows, 5 Columns, 30 Frames

-- Internal Settings
local SIZE_ALTGLOW = 49
local SIZE_CLASSIC = 64
local SIZE_MODERN = 84

-- Overlay Textures
local Overlays = {
	Circle = {
		Ants = [[Interface\AddOns\Masque\Textures\Circle\SpellAlert-Ants]],
		Glow = [[Interface\AddOns\Masque\Textures\Circle\SpellAlert-Glow]],
	},
	Square = {
		Ants = [[Interface\SpellActivationOverlay\IconAlertAnts]],
		Glow = [[Interface\SpellActivationOverlay\IconAlert]],
	},
}

-- AltGlow Settings
local AltGlows = {
	["Circle"] = {
		Texture = [[Interface\AddOns\Masque\Textures\Circle\SpellAlert-AltGlow]],
		Width = SIZE_ALTGLOW,
		Height = SIZE_ALTGLOW,
	},
	["Hexagon"] = {
		Texture = [[Interface\AddOns\Masque\Textures\Hexagon\SpellAlert-AltGlow]],
		Width = SIZE_ALTGLOW,
		Height = SIZE_ALTGLOW,
	},
	["Hexagon-Rotated"] = {
		Texture = [[Interface\AddOns\Masque\Textures\Hexagon-Rotated\SpellAlert-AltGlow]],
		Width = SIZE_ALTGLOW,
		Height = SIZE_ALTGLOW,
	},
	["Modern"] = {
		Texture = [[Interface\AddOns\Masque\Textures\Modern\SpellAlert-AltGlow]],
		Width = SIZE_ALTGLOW,
		Height = SIZE_ALTGLOW,
	},
	["Square"] = {
		Texture = [[Interface\AddOns\Masque\Textures\Square\SpellAlert-AltGlow]],
		Width = SIZE_ALTGLOW,
		Height = SIZE_ALTGLOW,
	},
}

-- Flipbook Settings
local FlipBooks = {
	["Classic"] = {
		["Circle"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Circle\SpellAlert-Loop-Classic]],
			FrameHeight = SIZE_CLASSIC,
			FrameWidth = SIZE_CLASSIC,
		},
		["Hexagon"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Hexagon\SpellAlert-Loop-Classic]],
			FrameHeight = SIZE_CLASSIC,
			FrameWidth = SIZE_CLASSIC,
		},
		["Hexagon-Rotated"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Hexagon-Rotated\SpellAlert-Loop-Classic]],
			FrameHeight = SIZE_CLASSIC,
			FrameWidth = SIZE_CLASSIC,
		},
		["Modern"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Modern\SpellAlert-Loop-Classic]],
			FrameHeight = SIZE_CLASSIC,
			FrameWidth = SIZE_CLASSIC,
		},
		["Square"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Square\SpellAlert-Loop-Classic]],
			FrameHeight = SIZE_CLASSIC,
			FrameWidth = SIZE_CLASSIC,
		},
	},
	["Modern"] = {
		["Circle"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Circle\SpellAlert-Loop-Modern]],
			FrameHeight = SIZE_MODERN,
			FrameWidth = SIZE_MODERN,
		},
		["Hexagon"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Hexagon\SpellAlert-Loop-Modern]],
			FrameHeight = SIZE_MODERN,
			FrameWidth = SIZE_MODERN,
		},
		["Hexagon-Rotated"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Hexagon-Rotated\SpellAlert-Loop-Modern]],
			FrameHeight = SIZE_MODERN,
			FrameWidth = SIZE_MODERN,
		},
		["Modern"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Modern\SpellAlert-Loop-Modern]],
			FrameHeight = SIZE_MODERN,
			FrameWidth = SIZE_MODERN,
		},
		["Square"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Square\SpellAlert-Loop-Modern]],
			FrameHeight = SIZE_MODERN,
			FrameWidth = SIZE_MODERN,
		},
	},
	["Modern-Lite"] = {
		["Circle"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Circle\SpellAlert-Loop-Modern-Lite]],
			FrameHeight = SIZE_MODERN,
			FrameWidth = SIZE_MODERN,
		},
		["Hexagon"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Hexagon\SpellAlert-Loop-Modern-Lite]],
			FrameHeight = SIZE_MODERN,
			FrameWidth = SIZE_MODERN,
		},
		["Hexagon-Rotated"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Hexagon-Rotated\SpellAlert-Loop-Modern-Lite]],
			FrameHeight = SIZE_MODERN,
			FrameWidth = SIZE_MODERN,
		},
		["Modern"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Modern\SpellAlert-Loop-Modern-Lite]],
			FrameHeight = SIZE_MODERN,
			FrameWidth = SIZE_MODERN,
		},
		["Square"] = {
			LoopTexture = [[Interface\AddOns\Masque\Textures\Square\SpellAlert-Loop-Modern-Lite]],
			FrameHeight = SIZE_MODERN,
			FrameWidth = SIZE_MODERN,
		},
	},
}

-- List of flipbooks.
local FlipBook_List = {
	[0] = "None",
	["Classic"] = "Classic",
	["Modern"] = "Modern",
	["Modern-Lite"] = "Modern Lite",
}

----------------------------------------
-- Helpers
---

-- Skins a spell alert overlay.
local function Skin_Overlay(Region, Button, Skin)
	local _mcfg = Button._MSQ_CFG

	local Shape = _mcfg.Shape or "Square"

	-- Update the skin if the shape has changed.
	if _mcfg.OverlayShape ~= Shape then
		local Paths = Overlays[Shape] or Overlays.Square

		local Ants_Texture = (Skin and Skin.Ants) or Paths.Ants
		local Glow_Texture = (Skin and Skin.Glow) or Paths.Glow

		Region.ants:SetTexture(Ants_Texture)
		Region.innerGlow:SetTexture(Glow_Texture)
		Region.innerGlowOver:SetTexture(Glow_Texture)
		Region.outerGlow:SetTexture(Glow_Texture)
		Region.outerGlowOver:SetTexture(Glow_Texture)
		Region.spark:SetTexture(Glow_Texture)

		_mcfg.OverlayShape = Shape
	end
end

-- Updates an animation.
local function Update_Animation(Animation, Style)
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

-- Updates a start animation.
local function Update_StartAnimination(Region)
	local AnimGroup = Region and Region.ProcStartAnim
	local FlipAnim = AnimGroup and GetFlipBookAnimation(AnimGroup)

	if FlipAnim then
		-- Disabled
		if Region._No_Start or Region._Loop_Only then
			FlipAnim:SetDuration(0)
			Region.ProcStartFlipbook:Hide()

		-- Enabled
		else
			FlipAnim:SetDuration(0.7)
			Region.ProcStartFlipbook:Show()
		end
	end
end

-- Resets spell alert flipbooks.
local function Reset_FlipBooks(Region, Button, Width, Height)
	Region._Loop_Only = nil

	-- [ ProcStart ]

	local Start_Group = Region.ProcStartAnim
	local Start_Animation = Start_Group and GetFlipBookAnimation(Start_Group)
	local Start_Flipbook = Region.ProcStartFlipbook

	-- Verify there's a start animation.
	if Start_Flipbook and Start_Animation then
		Start_Flipbook:SetAtlas("UI-HUD-ActionBar-Proc-Start-Flipbook")
		Start_Flipbook:ClearAllPoints()
		Start_Flipbook:SetPoint("CENTER")

		local Button_Width, Button_Height = Button:GetSize()

		-- Default + Skin Size
		if Width and Height then
			-- Set the frame size relative to the skin.
			Region:SetSize(Width, Height)

			local Width = 160 * (Width / (Button_Width * 1.4))
			local Height = 160 * (Height / (Button_Height * 1.4))

			Start_Flipbook:SetSize(Width, Height)

		-- Default
		else
			-- Set the frame size relative to the button.
			Region:SetSize(Button_Width * 1.4, Button_Height * 1.4)

			-- Defaults to 150 x 150, causing visual scaling-up on transition.
			Start_Flipbook:SetSize(160, 160)

		end

		Update_Animation(Start_Animation)
	end

	-- [ ProcLoop ]

	-- Loop Animation
	local Loop_Group = Region.ProcLoop
	local Loop_Animation = Loop_Group and GetFlipBookAnimation(Loop_Group)

	Region.ProcLoopFlipbook:SetAtlas("UI-HUD-ActionBar-Proc-Loop-Flipbook")
	Update_Animation(Loop_Animation)

	-- [ AltGlow ]

	local AltGlow = Region.ProcAltGlow

	if AltGlow then
		AltGlow:SetAtlas("UI-HUD-RotationHelper-ProcAltGlow", true)
	end
end

-- Skins spell alert flipbooks.
local function Skin_FlipBooks(Region, Button, Skin, UpdateUID)
	local _mcfg = Button._MSQ_CFG
	local Reset = true
	local Width, Height

	if Skin then
		local Style = _mcfg.SpellAlertStyle
		local Style_Enabled = Style and (Style ~= 0)

		-- Nested Skins
		local Style_Skin = (Style_Enabled and Skin[Style]) or Skin

		-- [ Alert Frame ]

		-- Get the frame's skin size relative to scaling.
		Width, Height = _mcfg:GetSize(Style_Skin.Width, Style_Skin.Height)

		-- Set the frame size relative to the button.
		Width = Width * 1.4
		Height = Height * 1.4

		Region:SetSize(Width, Height)

		-- [ Animations ]

		local Shape = _mcfg.Shape
		local Shape_Style

		if Shape and Style_Enabled then
			local Style_Data = FlipBooks[Style]

			if Style_Data then
				Shape_Style = Style_Data[Shape]
			end
		end

		if Shape_Style then
			-- Don't reset.
			Reset = nil

			local Loop_Texture = Shape_Style.LoopTexture

			-- [ ProcStart ]

			local Start_Group = Region.ProcStartAnim
			local Start_Animation = Start_Group and GetFlipBookAnimation(Start_Group)
			local Start_Flipbook = Region.ProcStartFlipbook

			-- Verify there's a start animation.
			if Start_Flipbook and Start_Animation then
				local Start_Texture = Shape_Style.StartTexture

				if Start_Texture then
					Region._Loop_Only = nil
				else
					Start_Texture = Loop_Texture
					Region._Loop_Only = true
				end

				Start_Flipbook:SetTexture(Start_Texture)
				Start_Flipbook:ClearAllPoints()
				Start_Flipbook:SetAllPoints()

				Update_Animation(Start_Animation, Shape_Style)
			end

			-- [ ProcLoop ]

			local Loop_Group = Region.ProcLoop
			local Loop_Animation = Loop_Group and GetFlipBookAnimation(Loop_Group)

			Region.ProcLoopFlipbook:SetTexture(Loop_Texture)
			Update_Animation(Loop_Animation, Shape_Style)

			-- [ AltGlow ]

			local AltGlow = Region.ProcAltGlow

			if AltGlow then
				local Glow_Style = AltGlows[Shape] or AltGlows.Modern
				local Glow_Skin = Skin.AltGlow

				local Glow_Width = SIZE_ALTGLOW
				local Glow_Height = SIZE_ALTGLOW

				if Glow_Skin then
					Glow_Width = Glow_Skin.Width or Glow_Width
					Glow_Height = Glow_Skin.Height or Glow_Height
				end

				AltGlow:SetTexture(Glow_Style.Texture)
				AltGlow:SetTexCoord(0, 1, 0, 1)
				AltGlow:SetSize(_mcfg:GetSize(Glow_Width, Glow_Height))
			end
		end
	end

	if Reset then
		Reset_FlipBooks(Region, Button, Width, Height)
	end

	-- Update the uID if the skin changed.
	if UpdateUID then
		_mcfg:UpdateUID("_uID_SAA")
	end
end

-- Updates spell alert flipbooks.
local function Update_SpellActivationAlert(Button)
	local _mcfg = Button._MSQ_CFG
	local Region = Button.SpellActivationAlert

	if (not Region) or (not Region.ProcStartAnim) or (not _mcfg) then return end

	-- Animation Settings
	local db = Core.db.profile.SpellAlert 
	local State = db.State
	local Style = db.Style

	-- Set before the skin is applied.
	Region._No_Start = (State == 2 and true) or nil

	local bSkin = _mcfg.Skin
	local Skin = bSkin and bSkin.SpellAlert

	local Skin_Changed = _mcfg:NeedsUpdate("_uID_SAA")
	local Style_Changed = _mcfg.SpellAlertStyle ~= Style

	-- Update the flipbooks.
	if Skin_Changed or Style_Changed then
		_mcfg.SpellAlertStyle = Style
		Skin_FlipBooks(Region, Button, Skin, Skin_Changed)
	end

	-- Update the start animation.
	Update_StartAnimination(Region)

	-- Prevent the loop texture from being visible during the start animation.
	Region.ProcLoopFlipbook:SetAlpha(0)

	-- Disable spell alerts completely.
	-- Must be called after the skin is applied.
	if State == 0 then
		ActionButtonSpellAlertManager:HideAlert(Button)
		return
	end

end

----------------------------------------
-- Hooks
---

-- Hook for Retail spell alerts.
local function Hook_ShowAlert(Frame, Button)
	-- Account for API calls.
	if type(Button) ~= "table" then
		Button = Frame
	end

	Update_SpellActivationAlert(Button)
end

-- Hook for Classic spell alerts.
local function Hook_ShowOverlayGlow(Button)
	local Region = Button and Button.overlay

	if Region and Region.spark then
		local _mcfg = Button._MSQ_CFG
		local bSkin = _mcfg and _mcfg.Skin
		local Skin = bSkin and bSkin.SpellAlert

		Skin_Overlay(Region, Button, Skin)
	end
end

if Core.WOW_RETAIL then
	-- Retail
	-- @ Interface\AddOns\Blizzard_ActionBar\Mainline\ActionButton.lua
	hooksecurefunc(ActionButtonSpellAlertManager, "ShowAlert", Hook_ShowAlert)

else
	-- Classic
	-- @ Interface\AddOns\Blizzard_ActionBar\Classic\ActionButton.lua
	hooksecurefunc("ActionButton_ShowOverlayGlow", Hook_ShowOverlayGlow)
end

----------------------------------------
-- Core
---

-- Calls the appropriate update function.
local function Update_SpellAlert(Button)
	if Button.overlay then
		Hook_ShowOverlayGlow(Button)
	else
		Update_SpellActivationAlert(Button)
	end
end

Core.FlipBook_List = FlipBook_List

-- Internal skin handler for the `SpellAlert` region.
Core.Update_SpellAlert = Update_SpellAlert

----------------------------------------
-- API
---

local API = Core.API

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

-- Adds a custom flipbook set.
function API:AddSpellAlertFlipBook(Style, Shape, Data)
	if type(Style) ~= "string" then
		if Core.Debug then
			error("Bad argument to API method 'AddSpellAlertFlipBook'. 'Shape' must be a unique string.", 2)
		end
		return

	elseif type(Shape) ~= "string" then
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

	local Style_Data = FlipBooks[Style] or {}

	if Style_Data[Shape] then
		if Core.Debug then
			error("Bad argument to API method 'AddSpellAlertFlipBook'. A style for this shape already exists.", 2)
		end
		return
	end

	FlipBooks[Style][Shape] = Data
	FlipBook_List[Style] = FlipBook_List[Style] or Style
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

-- Returns a custom flipbook set.
function API:GetSpellAlertFlipBook(Style, Shape)
	if type(Style) ~= "string" then
		if Core.Debug then
			error("Bad argument to API method 'GetSpellAlertFlipBook'. 'Style' must be a string.", 2)
		end
		return

	elseif type(Shape) ~= "string" then
		if Core.Debug then
			error("Bad argument to API method 'GetSpellAlertFlipBook'. 'Shape' must be a string.", 2)
		end
		return
	end

	local Style_Data = FlipBooks[Style]
	return Style_Data and Style_Data[Shape]
end

-- API wrapper for the Update_SpellAlert function.
function API:UpdateSpellAlert(Button)
	if type(Button) ~= "table" then
		return
	end

	Update_SpellAlert(Button)
end
