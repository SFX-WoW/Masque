--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Text.lua
	* Author.: StormFX

	Text Regions

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local type = type

----------------------------------------
-- Internal
---

-- @ Skins\Blizzard_*
local DEF_SKIN = Core.DEFAULT_SKIN

----------------------------------------
-- Core
---

-- Internal skin handler for text regions.
function Core.Skin_Text(Layer, Region, Button, Skin)
	local _mcfg = Button._MSQ_CFG

	Skin = _mcfg:GetTypeSkin(Button, Skin)

	local Default = DEF_SKIN[Layer]
	Default = Default[_mcfg.bType] or Default

	local Skin_Wrap = (Skin.Wrap and true) or false

	Region:SetJustifyH(Skin.JustifyH or Default.JustifyH)
	Region:SetJustifyV(Skin.JustifyV or Default.JustifyV)
	Region:SetWordWrap(Skin_Wrap)
	Region:SetDrawLayer(Skin.DrawLayer or Default.DrawLayer)
	Region:SetSize(_mcfg:GetSize(Skin.Width or 36, Skin.Height or 0))

	local Skin_Anchor = Skin.Anchor or Default.Anchor
	local Anchor = Button

	if Skin_Anchor then
		local Regions = _mcfg.Regions

		if type(Regions) == "table" then
			Anchor = Regions[Skin_Anchor] or Anchor
		end
	end

	local Point, RelPoint = Default.Point, Default.RelPoint
	local OffsetX, OffsetY = 0, 0

	if Skin then
		Point = Skin.Point or Point
		RelPoint = Skin.RelPoint or RelPoint
		OffsetX = Skin.OffsetX or OffsetX
		OffsetY = Skin.OffsetY or OffsetY
	end

	Region:SetPoint(Point, Anchor, RelPoint, OffsetX, OffsetY)
end
