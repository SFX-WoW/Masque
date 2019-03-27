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

-- @ Core\Utility: Size, Points, Color, Coords
local GetSize, SetPoints = Core.Utility()

----------------------------------------
-- Text
---

do
	local Defaults = Core.Defaults

	----------------------------------------
	-- Hook
	---

	-- Hook to counter calls to SetPoint() after HotKey region has been skinned.
	-- Stop doing this.
	local function Hook_SetPoint(Region, ...)
		if Region.__ExitHook then return end
		Region.__ExitHook = true

		SetPoints(Region, Region.__MSQ_Button, Region.__MSQ_Skin, Defaults.HotKey)

		Region.__ExitHook = nil
	end

	----------------------------------------
	-- Region-Skinning Function
	---

	local SkinRegion = Core.SkinRegion

	-- Skins a text layer of a button.
	function SkinRegion.Text(Region, Button, Layer, Skin, xScale, yScale)
		-- Region Defaults
		local Default = Defaults[Layer]

		-- Justify
		Region:SetJustifyH(Skin.JustifyH or Default.JustifyH)
		Region:SetJustifyV(Skin.JustifyV or "MIDDLE")

		-- Level
		Region:SetDrawLayer(Skin.DrawLayer or Default.DrawLayer)

		-- Size
		Region:SetSize(GetSize(Skin.Width, Skin.Height or 10, xScale, yScale))

		-- HotKey
		if Layer == "HotKey" then
			Region.__MSQ_Button = Button
			Region.__MSQ_Skin = Skin

			-- Hook SetPoint
			if not Region.__MSQ_Hooked then
				hooksecurefunc(Region, "SetPoint", Hook_SetPoint)
				Region.__MSQ_Hooked = true
			end

			Hook_SetPoint(Region)

		-- Etc
		else
			-- Position
			SetPoints(Region, Button, Skin, Default)
		end
	end
end
