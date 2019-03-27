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

-- @ Core\Utility: Size, Points, Color, Coords
local GetSize, SetPoints, _, GetTexCoords = Core.Utility()

----------------------------------------
-- Icon
---

do
	----------------------------------------
	-- Region-Skinning Function
	---

	-- @ Core\Utility
	local SkinRegion = Core.SkinRegion

	-- Skins 'Icon' region of a button.
	function SkinRegion.Icon(Region, Button, Skin, xScale, yScale)
		Region:SetParent(Button)

		-- Texture
		Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

		-- Level
		Region:SetDrawLayer(Skin.DrawLayer or "BACKGROUND", Skin.DrawLevel or 0)

		-- Size
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

		-- Position
		SetPoints(Region, Button, Skin, nil, Skin.SetAllPoints)

		-- Mask
		local Mask = Region.__MSQ_Mask
		local SkinMask = Skin.Mask

		if SkinMask then
			if not Mask then
				Mask = Button:CreateMaskTexture()
				Region.__MSQ_Mask = Mask
			end

			-- Texture
			Mask:SetTexture(SkinMask)

			-- Position
			Mask:SetAllPoints(Region)

			-- Enable the mask.
			if not Mask.active then
				Region:AddMaskTexture(Mask)
				Mask.active = true
			end
		else
			-- Disable the mask.
			if Mask and Mask.active then
				Region:RemoveMaskTexture(Mask)
				Mask.active = false
			end
		end
	end
end
