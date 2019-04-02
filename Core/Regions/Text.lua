--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Regions\Text.lua
	* Author.: StormFX

	Text Regions

	* See Skins\Regions.lua for region defaults.

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Locals
---

-- @ Skins\Regions
local Defaults = Core.RegDefs

-- @ Core\Utility: Size, Points, Color, Coords
local GetSize, SetPoints = Core.Utility()

-- @ Core\Core
local SkinRegion = Core.SkinRegion

----------------------------------------
-- Hook
---

-- Hook to counter calls to SetPoint() after the HotKey region has been skinned.
local function Hook_SetPoint(Region, ...)
	if Region.__ExitHook then return end
	Region.__ExitHook = true

	SetPoints(Region, Region.__MSQ_Button, Region.__MSQ_Skin, Defaults.HotKey)

	Region.__ExitHook = nil
end

----------------------------------------
-- Region-Skinning Function
---

-- Skins a text layer of a button.
function SkinRegion.Text(Region, Button, Layer, Skin, xScale, yScale)
	local Default = Defaults[Layer]

	Region:SetJustifyH(Skin.JustifyH or Default.JustifyH)
	Region:SetJustifyV(Skin.JustifyV or "MIDDLE")

	Region:SetDrawLayer(Skin.DrawLayer or Default.DrawLayer)

	Region:SetSize(GetSize(Skin.Width, Skin.Height or 10, xScale, yScale))

	if Layer == "HotKey" then
		Region.__MSQ_Button = Button
		Region.__MSQ_Skin = Skin

		if not Region.__MSQ_Hooked then
			hooksecurefunc(Region, "SetPoint", Hook_SetPoint)
			Region.__MSQ_Hooked = true
		end

		Hook_SetPoint(Region)
	else
		SetPoints(Region, Button, Skin, Default)
	end
end
