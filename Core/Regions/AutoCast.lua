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
local SkinBase = Core.SKIN_BASE

-- @ Core\Utility
local GetColor, GetTexCoords, SetSkinPoint = Core.GetColor, Core.GetTexCoords, Core.SetSkinPoint

----------------------------------------
-- Locals
---

local FRAME_BASE = SkinBase.AutoCast_Frame
local SHINE_BASE = SkinBase.AutoCast_Shine
local MASK_BASE = SkinBase.AutoCast_Mask
local CORNER_BASE = SkinBase.AutoCast_Corners

local BASE_BLEND = SkinBase.BlendMode
local BASE_SIZE = SkinBase.Size
local BASE_WRAP = SkinBase.WrapMode

----------------------------------------
-- Helper
---

-- Skins a texture.
local function SkinTexture(Region, Button, Frame, Skin, Default, IsMask)
	local texture = Skin.Texture

	-- Custom
	if texture then
		local wrap = IsMask and BASE_WRAP or nil

		Region:SetTexture(texture, wrap, wrap)
		Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

	-- Default
	else
		local atlas = Default.Atlas

		if atlas then
			Region:SetAtlas(atlas)
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

	local setAllPoints = Skin.SetAllPoints

	if not setAllPoints then
		local size = Default.Size or BASE_SIZE

		Region:SetSize(Button._MSQ_CFG:GetScaleSize(Skin.Width or size, Skin.Height or size))
	end

	SetSkinPoint(Region, Button, Skin, setAllPoints, Frame)
end

----------------------------------------
-- Core
---

-- Internal skin handler for the `AutoCast` region.
function Core.Skin_AutoCast(Button, Skin)
	local frame = Button.AutoCastOverlay

	if not frame then return end

	local shine = frame.Shine

	-- [ Frame ]
	local frameBase = FRAME_BASE
	local frameSkin = Skin.AutoCast_Frame

	if not shine then
		-- [ Classic Only ]
		frameBase = frameBase.Classic or frameBase
		frameSkin = frameSkin.Classic or frameSkin
	end

	local setAllPoints = frameSkin.SetAllPoints

	if not setAllPoints then
		frame:SetSize(Button._MSQ_CFG:GetScaleSize(frameSkin.Width or frameBase.Size, frameSkin.Height or frameBase.Size))
	end

	SetSkinPoint(frame, Button, frameSkin, setAllPoints)

	-- [ Shine ]
	if shine then
		-- [ Retail Only ]
		SkinTexture(shine, Button, frame, Skin.AutoCast_Shine, SHINE_BASE)
		SkinTexture(frame.Mask, Button, frame, Skin.AutoCast_Mask, MASK_BASE, true)
	end

	-- [ Corners ]
	local corners = frame.Corners

	if corners then
		local base = CORNER_BASE
		local skin = Skin.AutoCast_Corners

		if not shine then
			-- [ Classic Only ]
			base = base.Classic or base
			skin = skin.Classic or skin
		end

		SkinTexture(corners, Button, frame, skin, base)
	end
end
