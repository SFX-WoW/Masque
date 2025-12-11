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

-- @ Skins\Defaults
local SkinRoot = Core.SKIN_BASE

-- @ Core\Utility
local GetColor, GetTexCoords, SetSkinPoint = Core.GetColor, Core.GetTexCoords, Core.SetSkinPoint

----------------------------------------
-- Locals
---

local BASE_BLEND = SkinRoot.BlendMode
local BASE_SIZE = SkinRoot.Size
local BASE_WRAP = SkinRoot.WrapMode

----------------------------------------
-- Helpers
---

-- Skins an `AutoCast` frame.
local function Skin_AutoCastFrame(Frame, Button, Skin, Default)
	local _mcfg = Button._MSQ_CFG
	local SetAllPoints = Skin.SetAllPoints

	if not SetAllPoints then
		local BaseSize = Default.Size or BASE_SIZE

		local Width = Skin.Width or BaseSize
		local Height = Skin.Height or BaseSize

		Frame:SetSize(_mcfg:GetSize(Width, Height))
	end

	SetSkinPoint(Frame, Button, Skin, SetAllPoints)
end

-- Skins an `AutoCast` texture.
local function Skin_AutoCastTexture(Region, Button, Anchor, Skin, Default, IsMask)
	local _mcfg = Button._MSQ_CFG
	local Texture = Skin.Texture

	-- Custom
	if Texture then
		if IsMask then
			Region:SetTexture(Texture, BASE_WRAP, BASE_WRAP)
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
		Region:SetBlendMode(Skin.BlendMode or BASE_BLEND)
		Region:SetDrawLayer(Skin.DrawLayer or Default.DrawLayer, Skin.DrawLevel or Default.DrawLevel)
	end

	local SetAllPoints = Skin.SetAllPoints

	if not SetAllPoints then
		local BaseSize = Default.Size or BASE_SIZE

		local Width = Skin.Width or BaseSize
		local Height = Skin.Height or BaseSize

		Region:SetSize(_mcfg:GetSize(Width, Height))
	end

	SetSkinPoint(Region, Button, Skin, SetAllPoints, Anchor)
end

-- Skins the Classic `AutoCast`.
local function Skin_AutoCastShine(Frame, Button, Skin)
	-- Frame
	Skin_AutoCastFrame(Frame, Button, Skin.AutoCastShine, SkinRoot.AutoCastShine)

	-- Corners
	local Corners = Button.AutoCastable or Frame.Corners

	if Corners then
		Skin_AutoCastTexture(Corners, Button, Button, Skin.AutoCastable, SkinRoot.AutoCastable)
	end
end

-- Skins the Retail `AutoCast`.
local function Skin_AutoCastOverlay(Frame, Button, Skin)
	-- Frame
	Skin_AutoCastFrame(Frame, Button, Skin.AutoCast_Frame, SkinRoot.AutoCast_Frame)

	-- Corners
	local Corners = Frame.Corners

	if Corners then
		Skin_AutoCastTexture(Corners, Button, Frame, Skin.AutoCast_Corners, SkinRoot.AutoCast_Corners)
	end

	-- Shine
	Skin_AutoCastTexture(Frame.Shine, Button, Frame, Skin.AutoCast_Shine, SkinRoot.AutoCast_Shine)

	-- Shine Mask
	Skin_AutoCastTexture(Frame.Mask, Button, Frame, Skin.AutoCast_Mask, SkinRoot.AutoCast_Mask, true)
end

----------------------------------------
-- Core
---

-- Internal skin handler for the `AutoCast` region.
function Core.Skin_AutoCast(Button, Skin)
	local Frame = Button.AutoCastOverlay or Button.AutoCastShine

	if not Frame then return end

	-- Modern
	if Frame.Shine then
		Skin_AutoCastOverlay(Frame, Button, Skin)

	-- Classic
	-- Account for AutoCastShine and AutoCastOverlay
	elseif Button.AutoCastable or Frame.Corners then
		Skin_AutoCastShine(Frame, Button, Skin)
	end
end
