--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\AutoCast.lua
	* Author.: StormFX

	AutoCast Frame

]]

local _, Core = ...

----------------------------------------
-- Internal
---

-- @ Core\Utility
local ClearSetPoint, GetColor, GetSize = Core.ClearSetPoint, Core.GetColor, Core.GetSize
local GetTexCoords = Core.GetTexCoords

-- @ Skins\Blizzard_*
local DEFAULT_SKIN = Core.DEFAULT_SKIN

----------------------------------------
-- Utility
---

-- Applies a skin to a texture region.
local function ApplySkin(Region, Button, Anchor, Skin, Default, xScale, yScale, IsMask)
	local Texture = Skin.Texture

	-- Custom
	if Texture then
		if IsMask then
			Region:SetTexture(Texture, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		else
			Region:SetTexture(Texture)
		end

		Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

	-- Default
	else
		local Atlas = Default.Atlas

		if Atlas then
			Region:SetAtlas(Atlas)
		else
			Region:SetTexture(Default.Texture)
			Region:SetTexCoord(GetTexCoords(Default.TexCoords))
		end
	end

	if not IsMask then
		Region:SetVertexColor(GetColor(Skin.Color))

		Region:SetBlendMode(Skin.BlendMode or Default.BlendMode)
		Region:SetDrawLayer(Skin.DrawLayer or Default.DrawLayer, Skin.DrawLevel or Default.DrawLevel)
	end

	local SetAllPoints = Skin.SetAllPoints

	if not SetAllPoints then
		local Width = Skin.Width or Default.Width
		local Height = Skin.Height or Default.Height

		Region:SetSize(GetSize(Width, Height, xScale, yScale, Button))
	end

	ClearSetPoint(Region, Skin.Point, Anchor, Skin.RelPoint, Skin.OffsetX, Skin.OffsetY, SetAllPoints)
end

----------------------------------------
-- Classic
---

-- Skins the AutoCastShine region used prior to 11.0.
local function SkinAutoCastShine(Frame, Button, Skin, xScale, yScale)
	-- AutoCast Frame
	local Frame_Skin = Skin.AutoCastShine
	local Default = DEFAULT_SKIN.AutoCastShine

	local SetAllPoints = Frame_Skin.SetAllPoints

	if not SetAllPoints then
		local Width = Frame_Skin.Width or Default.Width
		local Height = Frame_Skin.Height or Default.Height

		Frame:SetSize(GetSize(Width, Height, xScale, yScale, Button))
	end

	ClearSetPoint(Frame, Frame_Skin.Point, Button, Frame_Skin.RelPoint, Frame_Skin.OffsetX, Frame_Skin.OffsetY, SetAllPoints)

	-- AutoCast Corners
	ApplySkin(Button.AutoCastable, Button, Button, Skin.AutoCastable, DEFAULT_SKIN.AutoCastable, xScale, yScale)
end

----------------------------------------
-- Retail
---

-- Skins the AutoCastOverlay region in 11.0+.
local function SkinAutoCastOverlay(Frame, Button, Skin, xScale, yScale)
	-- AutoCast Frame
	local Frame_Skin = Skin.AutoCast_Frame
	local Default = DEFAULT_SKIN.AutoCast_Frame

	local SetAllPoints = Frame_Skin.SetAllPoints

	if not SetAllPoints then
		local Width = Frame_Skin.Width or Default.Width
		local Height = Frame_Skin.Height or Default.Height

		Frame:SetSize(GetSize(Width, Height, xScale, yScale, Button))
	end

	ClearSetPoint(Frame, Frame_Skin.Point, Button, Frame_Skin.RelPoint, Frame_Skin.OffsetX, Frame_Skin.OffsetY, SetAllPoints)

	-- AutoCast Shine
	ApplySkin(Frame.Shine, Button, Frame, Skin.AutoCast_Shine, DEFAULT_SKIN.AutoCast_Shine, xScale, yScale)

	-- AutoCast Shine Mask
	ApplySkin(Frame.Mask, Button, Frame, Skin.AutoCast_Mask, DEFAULT_SKIN.AutoCast_Mask, xScale, yScale, true)

	-- AutoCast Corners
	ApplySkin(Frame.Corners, Button, Frame, Skin.AutoCast_Corners, DEFAULT_SKIN.AutoCast_Corners, xScale, yScale)
end

----------------------------------------
-- Core
---

Core.SkinAutoCast = function(Button, Skin, xScale, yScale)
	local AutoCastOverlay = Button.AutoCastOverlay
	local AutoCastShine = Button.AutoCastShine

	-- Retail
	if AutoCastOverlay then
		SkinAutoCastOverlay(AutoCastOverlay, Button, Skin, xScale, yScale)

	-- Classic
	elseif AutoCastShine then
		SkinAutoCastShine(AutoCastShine, Button, Skin, xScale, yScale)
	end
end
