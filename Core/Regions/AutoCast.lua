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
local GetColor, GetTexCoords, SetSkinPoint = Core.GetColor, Core.GetTexCoords, Core.SetSkinPoint

-- @ Skins\Blizzard_*
local DEF_SKIN = Core.DEFAULT_SKIN

----------------------------------------
-- Helpers
---

-- Skins an `AutoCast` texture region.
local function Skin_AutoCastTexture(Region, Button, Anchor, Skin, Default, IsMask)
	local _mcfg = Button._MSQ_CFG
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

		Region:SetSize(_mcfg:GetSize(Width, Height))
	end

	SetSkinPoint(Region, Button, Skin, SetAllPoints, Anchor)
end

-- Skins the Classic `AutoCast` regions.
local function Skin_AutoCastShine(Frame, Button, Skin)
	local _mcfg = Button._MSQ_CFG

	-- AutoCast Frame
	local Frame_Skin = Skin.AutoCastShine
	local Default = DEF_SKIN.AutoCastShine

	local SetAllPoints = Frame_Skin.SetAllPoints

	if not SetAllPoints then
		local Width = Frame_Skin.Width or Default.Width
		local Height = Frame_Skin.Height or Default.Height

		Frame:SetSize(_mcfg:GetSize(Width, Height))
	end

	SetSkinPoint(Frame, Button, Skin, SetAllPoints)

	-- AutoCast Corners
	Skin_AutoCastTexture(Button.AutoCastable, Button, Button, Skin.AutoCastable, DEF_SKIN.AutoCastable)
end

-- Skins the Retail `AutoCast` regions.
local function Skin_AutoCastOverlay(Frame, Button, Skin)
	local _mcfg = Button._MSQ_CFG

	-- AutoCast Frame
	local Frame_Skin = Skin.AutoCast_Frame
	local Default = DEF_SKIN.AutoCast_Frame

	local SetAllPoints = Frame_Skin.SetAllPoints

	if not SetAllPoints then
		local Width = Frame_Skin.Width or Default.Width
		local Height = Frame_Skin.Height or Default.Height

		Frame:SetSize(_mcfg:GetSize(Width, Height))
	end

	SetSkinPoint(Frame, Button, Skin, SetAllPoints)

	-- AutoCast Corners
	Skin_AutoCastTexture(Frame.Corners, Button, Frame, Skin.AutoCast_Corners, DEF_SKIN.AutoCast_Corners)

	-- AutoCast Shine Mask
	Skin_AutoCastTexture(Frame.Mask, Button, Frame, Skin.AutoCast_Mask, DEF_SKIN.AutoCast_Mask, true)

	-- AutoCast Shine
	Skin_AutoCastTexture(Frame.Shine, Button, Frame, Skin.AutoCast_Shine, DEF_SKIN.AutoCast_Shine)
end

----------------------------------------
-- Core
---

-- Internal skin handler for the `AutoCast` region.
function Core.Skin_AutoCast(Button, Skin)
	local AutoCastOverlay = Button.AutoCastOverlay
	local AutoCastShine = Button.AutoCastShine

	-- Retail
	if AutoCastOverlay then
		Skin_AutoCastOverlay(AutoCastOverlay, Button, Skin)

	-- Classic
	elseif AutoCastShine then
		Skin_AutoCastShine(AutoCastShine, Button, Skin)
	end
end
