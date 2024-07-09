--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Texture.lua
	* Author.: StormFX

	Texture Regions

	* See Skins\Default.lua for region defaults.

]]

local _, Core = ...

----------------------------------------
-- Internal
---

-- @ Core\Utility
local GetColor, GetSize, GetTexCoords = Core.GetColor, Core.GetSize, Core.GetTexCoords
local GetTypeSkin, SetSkinPoint = Core.GetTypeSkin, Core.SetSkinPoint

-- @ Core\Regions\Mask
local SkinMask = Core.SkinMask

-- @ Skins\Blizzard_*
local DEFAULT_SKIN = Core.DEFAULT_SKIN

-- @ Skins\Regions
local Settings = Core.RegTypes.Legacy

----------------------------------------
-- locals
---

-- Regions we need to store the colors for.
local Store_Color = {
	Pushed = true,
	Highlight = true,
	SlotHighlight = true,
}

----------------------------------------
-- Core
---

-- Skins a texture region of a button.
function Core.SkinTexture(Layer, Region, Button, Skin, Color, xScale, yScale)
	local bType = Button.__MSQ_bType
	local Config = Settings[Layer]

	Skin = GetTypeSkin(Button, bType, Skin)
	Config = Config[bType] or Config

	if Config.CanHide and Skin.Hide then
		Region:SetTexture()
		Region:Hide()
		return
	end

	local Resize = true
	local Default_Skin = DEFAULT_SKIN[Layer]

	Default_Skin = GetTypeSkin(Button, bType, Default_Skin)

	if not Config.NoTexture then
		local Skin_Atlas = Skin.Atlas
		local Skin_Texture = Skin.Texture

		Color = Color or Skin.Color

		if Store_Color[Layer] then
			local Color_Key = "__MSQ_"..Layer.."_Color"
			Button[Color_Key] = Color
		end

		local Set_Color = not Config.NoColor
		local Use_Color = Config.UseColor
		local Skin_Coords

		-- Skin
		if Skin.UseColor and Use_Color then
			Region:SetTexture()
			Region:SetVertexColor(1, 1, 1, 1)
			Region:SetColorTexture(GetColor(Color))
		elseif Skin_Texture then
			Skin_Coords = Skin.TexCoords
			Region:SetTexture(Skin_Texture)

			if Set_Color then
				Region:SetVertexColor(GetColor(Color))
			end
		elseif Skin_Atlas then
			local UseAtlasSize = Skin.UseAtlasSize

			Region:SetAtlas(Skin_Atlas, UseAtlasSize)
			Resize = not UseAtlasSize

			if Set_Color then
				Region:SetVertexColor(GetColor(Default_Skin.Color))
			end

		-- Default
		else
			Skin_Atlas = Default_Skin.Atlas
			Skin_Texture = Default_Skin.Texture

			if Skin_Atlas then
				local UseAtlasSize = Skin.UseAtlasSize
				Region:SetAtlas(Skin_Atlas, UseAtlasSize)
				Resize = not UseAtlasSize

				if Set_Color then
					Region:SetVertexColor(GetColor(Default_Skin.Color))
				end
			elseif Skin_Texture then
				Skin_Coords = Default_Skin.TexCoords
				Region:SetTexture(Default_Skin.Skin_Texture)

				if Set_Color then
					Region:SetVertexColor(GetColor(Default_Skin.Color))
				end
			elseif Use_Color then
				Region:SetTexture()
				Region:SetVertexColor(1, 1, 1, 1)
				Region:SetColorTexture(GetColor(Default_Skin.Color))
			end
		end

		Region:SetTexCoord(GetTexCoords(Skin_Coords))
	end

	Region:SetBlendMode(Skin.BlendMode or Default_Skin.BlendMode or "BLEND")

	if Layer == "Highlight" then
		Region:SetDrawLayer("HIGHLIGHT", Skin.DrawLevel or Default_Skin.DrawLevel or 0)
	else
		Region:SetDrawLayer(Skin.DrawLayer or Default_Skin.DrawLayer, Skin.DrawLevel or Default_Skin.DrawLevel or 0)
	end

	if Resize then
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale, Button))
	end

	local SetAllPoints = Skin.SetAllPoints or (not Skin.Point and Default_Skin.SetAllPoints)

	SetSkinPoint(Region, Button, Skin, Default_Skin, SetAllPoints)

	-- Mask
	if Config.CanMask then
		SkinMask(Region, Button, Skin, xScale, yScale)
	end
end

-- Sets the color of a texture region.
function Core.SetTextureColor(Layer, Region, Button, Skin, Color)
	if Region then
		local bType = Button.__MSQ_bType
		local Config = Settings[Layer]

		Skin = GetTypeSkin(Button, bType, Skin)
		Config = Config[bType] or Config
		Color = Color or Skin.Color

		if Skin.UseColor and Config.UseColor then
			Region:SetVertexColor(1, 1, 1, 1)
			Region:SetColorTexture(GetColor(Color))
		else
			Region:SetVertexColor(GetColor(Color))
		end
	end
end
