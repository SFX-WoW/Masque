--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Texture.lua
	* Author.: StormFX

	Texture Regions

]]

local _, Core = ...

----------------------------------------
-- Internal
---

-- @ Skins\Defaults
local SkinRoot = Core.SKIN_BASE

-- @ Skins\Regions
local Settings = Core.RegTypes.Legacy

-- @ Core\Utility
local GetColor, GetTexCoords, SetSkinPoint = Core.GetColor, Core.GetTexCoords, Core.SetSkinPoint

-- @ Core\Regions\Mask
local Skin_Mask = Core.Skin_Mask

----------------------------------------
-- Locals
---

-- Skin Defaults
local BASE_BLEND = SkinRoot.BlendMode -- "BLEND"
local BASE_SIZE = SkinRoot.Size

-- String Constants
local STR_COLOR = "Color_"
local STR_HIGHLIGHT = "Highlight"

-- Regions that need their color stored.
local Store_Color = {
	Pushed = true,
	Highlight = true,
	SlotHighlight = true,
}

----------------------------------------
-- Core
---

-- Sets the color of a texture region.
function Core.SetColor_Texture(Layer, Region, Button, Skin, Color)
	if Region then
		local _mcfg = Button._MSQ_CFG
		local bType = _mcfg.bType
		local Config = Settings[Layer]

		Skin = _mcfg:GetTypeSkin(Button, Skin)

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

-- Internal skin handler for texture regions.
function Core.Skin_Texture(Layer, Region, Button, Skin, Color)
	local _mcfg = Button._MSQ_CFG
	local bType = _mcfg.bType

	local Config = Settings[Layer]

	Skin = _mcfg:GetTypeSkin(Button, Skin)
	Config = Config[bType] or Config

	if Config.CanHide and Skin.Hide then
		Region:SetTexture()
		Region:Hide()
		return
	end

	local Resize = true
	local Default = SkinRoot[Layer]

	Default = Default[bType] or Default

	if (not Config.NoTexture) then
		local Atlas = Skin.Atlas
		local Texture = Skin.Texture
		local BaseColor = Default.Color

		Color = Color or Skin.Color

		if Store_Color[Layer] then
			local Key = STR_COLOR..Layer
			_mcfg[Key] = Color
		end

		local Set_Color = not Config.NoColor
		local Use_Color = Config.UseColor
		local Skin_Coords

		-- Skin
		if Skin.UseColor and Use_Color then
			Region:SetTexture()
			Region:SetVertexColor(1, 1, 1, 1)
			Region:SetColorTexture(GetColor(Color or BaseColor))

		elseif Texture then
			Skin_Coords = Skin.TexCoords
			Region:SetTexture(Texture)

			if Set_Color then
				Region:SetVertexColor(GetColor(Color))
			end

		elseif Atlas then
			local UseSize = Skin.UseAtlasSize

			Region:SetAtlas(Atlas, UseSize)
			Resize = not UseSize

			if Set_Color then
				Region:SetVertexColor(GetColor(Color))
			end

		-- Default
		else
			Atlas = Default.Atlas
			Texture = Default.Texture

			if Atlas then
				local UseSize = Default.UseAtlasSize

				Region:SetAtlas(Atlas, UseSize)
				Resize = not UseSize

				if Set_Color then
					Region:SetVertexColor(GetColor(BaseColor))
				end

			elseif Texture then
				Skin_Coords = Default.TexCoords
				Region:SetTexture(Default.Texture)

				if Set_Color then
					Region:SetVertexColor(GetColor(BaseColor))
				end

			elseif Use_Color then
				Region:SetTexture()
				Region:SetVertexColor(1, 1, 1, 1)
				Region:SetColorTexture(GetColor(BaseColor))
			end
		end

		Region:SetTexCoord(GetTexCoords(Skin_Coords))
	end

	Region:SetBlendMode(Skin.BlendMode or Default.BlendMode or BASE_BLEND)

	if Layer == STR_HIGHLIGHT then
		Region:SetDrawLayer(Default.DrawLayer, Skin.DrawLevel or Default.DrawLevel)
	else
		Region:SetDrawLayer(Skin.DrawLayer or Default.DrawLayer, Skin.DrawLevel or Default.DrawLevel)
	end

	local SetAllPoints = Skin.SetAllPoints or (not Skin.Point and Default.SetAllPoints)

	if (not SetAllPoints) and Resize then
		local Size = Default.Size or BASE_SIZE

		local Width = Skin.Width or Size
		local Height = Skin.Height or Size

		Region:SetSize(_mcfg:GetSize(Width, Height))
	end

	SetSkinPoint(Region, Button, Skin, SetAllPoints, Button, Default)

	-- Mask
	if Config.CanMask then
		Skin_Mask(Button, Skin, Region)
	end
end
