--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Regions\Icon.lua
	* Author.: StormFX

	'Icon' Region

	* See Skins\Regions.lua for region defaults.

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Locals
---

-- @ Core\Utility
local GetSize, SetPoints = Core.GetSize, Core.SetPoints
local GetTexCoords = Core.GetTexCoords

-- @ Core\Core
local SkinRegion = Core.SkinRegion

----------------------------------------
-- Region
---

-- Skins 'Icon' region of a button.
function SkinRegion.Icon(Region, Button, Skin, xScale, yScale)
	Region:SetParent(Button)

	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

	Region:SetDrawLayer(Skin.DrawLayer or "BACKGROUND", Skin.DrawLevel or 0)

	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

	SetPoints(Region, Button, Skin, nil, Skin.SetAllPoints)

	local Mask = Region.__MSQ_Mask
	local SkinMask = Skin.Mask

	if SkinMask then
		if not Mask then
			Mask = Button:CreateMaskTexture()
			Region.__MSQ_Mask = Mask
		end

		Mask:SetTexture(SkinMask)
		Mask:SetAllPoints(Region)

		if not Mask.active then
			Region:AddMaskTexture(Mask)
			Mask.active = true
		end
	else
		if Mask and Mask.active then
			Region:RemoveMaskTexture(Mask)
			Mask.active = false
		end
	end
end
