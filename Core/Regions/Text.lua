--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Text.lua
	* Author.: StormFX

	Text Regions

]]

local _, Core = ...

----------------------------------------
-- Internal
---

-- @ Core\Utility
local SetSkinPoint = Core.SetSkinPoint

-- @ Skins\Blizzard_*
local DEF_SKIN = Core.DEFAULT_SKIN

----------------------------------------
-- Core
---

-- Internal skin handler for text regions.
function Core.Skin_Text(Layer, Region, Button, Skin)
	local _mcfg = Button._MSQ_CFG

	Skin = _mcfg:GetTypeSkin(Button, Skin)

	local Def_Skin = DEF_SKIN[Layer]
	Def_Skin = Def_Skin[_mcfg.bType] or Def_Skin

	local Skin_Wrap = (Skin.Wrap and true) or false

	Region:SetJustifyH(Skin.JustifyH or Def_Skin.JustifyH)
	Region:SetJustifyV(Skin.JustifyV or "MIDDLE")
	Region:SetWordWrap(Skin_Wrap)
	Region:SetDrawLayer(Skin.DrawLayer or Def_Skin.DrawLayer)
	Region:SetSize(_mcfg:GetSize(Skin.Width or 36, Skin.Height or 0))

	SetSkinPoint(Region, Button, Skin, Def_Skin)
end
