--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Utility.lua
	* Author.: StormFX

	Utility Functions

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Lua
---

local type = type

----------------------------------------
-- Utility
---

-- Returns a set of color values.
function Core.GetColor(Color, Alpha)
	if type(Color) == "table" then
		return Color[1] or 1, Color[2] or 1, Color[3] or 1, Alpha or Color[4] or 1
	else
		return 1, 1, 1, Alpha or 1
	end
end

-- Returns the x and y scale of a button.
function Core.GetScale(Button)
	local x = (Button:GetWidth() or 36) / 36
	local y = (Button:GetHeight() or 36) / 36
	return x, y
end

-- Returns the height and width of a region.
function Core.GetSize(Width, Height, xScale, yScale)
	local w = (Width or 36) * xScale
	local h = (Height or 36) * yScale
	return w, h
end

-- Returns a set of texture coordinates.
function Core.GetTexCoords(Coords)
	if type(Coords) == "table" then
		return Coords[1] or 0, Coords[2] or 1, Coords[3] or 0, Coords[4] or 1
	else
		return 0, 1, 0, 1
	end
end
