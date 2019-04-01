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

-- @ Core\Utility: Size, Points, Color, Coords
local GetSize, SetPoints, GetColor, GetTexCoords = Core.Utility()

----------------------------------------
-- Textures
---

do
	-- @ Skins\Regions
	local Defaults = Core.RegDefs

	----------------------------------------
	-- Region-Skinning Function
	---

	-- @ Core\Core
	local SkinRegion = Core.SkinRegion

	-- Skins a texture region of a button.
	function SkinRegion.Texture(Region, Button, Layer, Skin, Color, xScale, yScale)
		if Skin.Hide then
			Region:SetTexture("")
			Region:Hide()
			return
		end

		-- Region Defaults
		local Default = Defaults[Layer]

		-- Nested Border Defaults/Skins
		if Layer == "Border" then
			local bType = Button.__MSQ_bType

			Skin = Skin[bType] or Skin
			Default = Default[bType] or Default
		end

		-- Texture Check
		if not Default.NoTexture then
			--Skin
			local Texture = Skin.Texture
			Color = Color or Skin.Color

			-- Checks
			local SetColor = not Default.NoColor
			local UseColor = Default.UseColor

			-- Color Only
			if Skin.UseColor and UseColor then
				Region:SetTexture()
				Region:SetColorTexture(GetColor(Color))
				Region:SetBlendMode(Skin.BlendMode or "BLEND")

			-- Texture
			elseif Texture then
				Region:SetTexture(Texture)
				Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

				-- Color Check
				if SetColor then
					Region:SetVertexColor(GetColor(Color))
					Region:SetBlendMode(Skin.BlendMode or "BLEND")
				end

			-- Default
			else
				local Atlas = Default.Atlas
				Texture = Default.Texture

				-- Atlas
				if Atlas then
					Region:SetAtlas(Atlas)

					-- Color Check
					if SetColor then
						Region:SetVertexColor(GetColor(Default.Color))
						Region:SetBlendMode(Default.BlendMode or "BLEND")
					end

				-- Texture
				elseif Texture then
					Region:SetTexture(Default.Texture)
					Region:SetTexCoord(GetTexCoords(Default.TexCoords))

					-- Color Check
					if SetColor then
						Region:SetVertexColor(GetColor(Default.Color))
						Region:SetBlendMode(Default.BlendMode or "BLEND")
					end

				-- Color Only
				elseif UseColor then
					Region:SetTexture()
					Region:SetColorTexture(GetColor(Default.Color))
					Region:SetBlendMode(Default.BlendMode or "BLEND")
				end
			end
		end

		-- Level
		local DrawLayer = Skin.DrawLayer
		local DrawLevel

		if DrawLayer then
			DrawLevel = Skin.DrawLevel or 0
		end

		Region:SetDrawLayer(DrawLayer or Default.DrawLayer, DrawLevel or Default.DrawLevel or 0)

		-- Size
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

		-- Position
		local SetAllPoints = Skin.SetAllPoints or (not Skin.Point and Default.SetAllPoints)
		SetPoints(Region, Button, Skin, Default, SetAllPoints)
	end
end
