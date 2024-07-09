--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Text.lua
	* Author.: StormFX

	Text Regions

	* See Skins\Default.lua for region defaults.

]]

local _, Core = ...

----------------------------------------
-- Internal
---

-- @ Core\Utility
local GetSize, GetTypeSkin, SetSkinPoint = Core.GetSize, Core.GetTypeSkin, Core.SetSkinPoint

-- @ Skins\Blizzard_*
local DEFAULT_SKIN = Core.DEFAULT_SKIN

----------------------------------------
-- Core
---

-- Skins a text layer of a button.
function Core.SkinText(Layer, Region, Button, Skin, xScale, yScale)
	local bType = Button.__MSQ_bType

	Skin = GetTypeSkin(Button, bType, Skin)

	local Default_Skin = DEFAULT_SKIN[Layer]
	Default_Skin = Default_Skin[bType] or Default_Skin

	local Skin_Wrap = (Skin.Wrap and true) or false

	Region:SetJustifyH(Skin.JustifyH or Default_Skin.JustifyH)
	Region:SetJustifyV(Skin.JustifyV or "MIDDLE")
	Region:SetWordWrap(Skin_Wrap)
	Region:SetDrawLayer(Skin.DrawLayer or Default_Skin.DrawLayer)
	Region:SetSize(GetSize(Skin.Width or 36, Skin.Height or 0, xScale, yScale, Button))

	SetSkinPoint(Region, Button, Skin, Default_Skin)
end
