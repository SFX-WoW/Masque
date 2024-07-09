--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Frame.lua
	* Author.: StormFX

	Frame Region

]]

local _, Core = ...

----------------------------------------
-- Internal
---

-- @ Core\Utility
local GetSize, SetSkinPoint = Core.GetSize, Core.SetSkinPoint

----------------------------------------
-- Frame
---

-- Sets the size and points of a frame.
function Core.SkinFrame(Region, Button, Skin, xScale, yScale)
	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale, Button))
	SetSkinPoint(Region, Button, Skin, nil, Skin.SetAllPoints)
end
