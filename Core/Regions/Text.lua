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

-- @ Skins\Defaults
local SkinRoot = Core.SKIN_BASE

-- @ Core\Utility
local SetSkinPoint = Core.SetSkinPoint

----------------------------------------
-- Core
---

-- Internal skin handler for text regions.
function Core.Skin_Text(Layer, Region, Button, Skin)
	local _mcfg = Button._MSQ_CFG

	Skin = _mcfg:GetTypeSkin(Button, Skin)

	local Default = SkinRoot[Layer]

	Default = Default[_mcfg.bType] or Default

	local Skin_Wrap = (Skin.Wrap and true) or false

	Region:SetJustifyH(Skin.JustifyH or Default.JustifyH)
	Region:SetJustifyV(Skin.JustifyV or Default.JustifyV)
	Region:SetWordWrap(Skin_Wrap)
	Region:SetDrawLayer(Skin.DrawLayer or Default.DrawLayer)
	Region:SetSize(_mcfg:GetSize(Skin.Width or Default.Width, Skin.Height or Default.Height))

	SetSkinPoint(Region, Button, Skin, nil, Button, Default)
end
