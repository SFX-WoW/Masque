--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Regions\Texture.lua
	* Author.: StormFX

	Texture Regions

	* See Skins\Regions.lua for region defaults.

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Locals
---

-- @ Skins\Regions
local Defaults = Core.RegDefs

-- @ Core\Utility
local GetSize, SetPoints = Core.GetSize, Core.SetPoints
local GetColor, GetTexCoords = Core.GetColor, Core.GetTexCoords

-- @ Core\Core
local SkinRegion = Core.SkinRegion

----------------------------------------
-- Region
---

-- Skins a texture region of a button.
function SkinRegion.Texture(Region, Button, Layer, Skin, Color, xScale, yScale)
	if Skin.Hide then
		Region:SetTexture()
		Region:Hide()
		return
	end

	local Default = Defaults[Layer]

	if Layer == "Border" then
		local bType = Button.__MSQ_bType

		Skin = Skin[bType] or Skin
		Default = Default[bType] or Default
	end

	if not Default.NoTexture then
		local Texture = Skin.Texture
		Color = Color or Skin.Color

		local SetColor = not Default.NoColor
		local UseColor = Default.UseColor

		if Skin.UseColor and UseColor then
			Region:SetTexture()
			Region:SetColorTexture(GetColor(Color))
			Region:SetBlendMode(Skin.BlendMode or "BLEND")

		elseif Texture then
			Region:SetTexture(Texture)
			Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

			if SetColor then
				Region:SetVertexColor(GetColor(Color))
				Region:SetBlendMode(Skin.BlendMode or "BLEND")
			end

		else
			local Atlas = Default.Atlas
			Texture = Default.Texture

			if Atlas then
				Region:SetAtlas(Atlas)

				if SetColor then
					Region:SetVertexColor(GetColor(Default.Color))
					Region:SetBlendMode(Default.BlendMode or "BLEND")
				end

			elseif Texture then
				Region:SetTexture(Default.Texture)
				Region:SetTexCoord(GetTexCoords(Default.TexCoords))

				if SetColor then
					Region:SetVertexColor(GetColor(Default.Color))
					Region:SetBlendMode(Default.BlendMode or "BLEND")
				end

			elseif UseColor then
				Region:SetTexture()
				Region:SetColorTexture(GetColor(Default.Color))
				Region:SetBlendMode(Default.BlendMode or "BLEND")
			end
		end
	end

	local DrawLayer = Skin.DrawLayer
	local DrawLevel

	if DrawLayer then
		DrawLevel = Skin.DrawLevel or 0
	end

	Region:SetDrawLayer(DrawLayer or Default.DrawLayer, DrawLevel or Default.DrawLevel or 0)

	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

	local SetAllPoints = Skin.SetAllPoints or (not Skin.Point and Default.SetAllPoints)
	SetPoints(Region, Button, Skin, Default, SetAllPoints)
end
