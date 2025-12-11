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

-- @ Core\Utility
local GetColor, GetTexCoords, SetSkinPoint = Core.GetColor, Core.GetTexCoords, Core.SetSkinPoint

-- @ Core\Regions\Mask
local Skin_Mask = Core.Skin_Mask

-- @ Skins\Blizzard_*
local DEF_SKIN = Core.DEFAULT_SKIN

-- @ Skins\Regions
local Settings = Core.RegTypes.Legacy

----------------------------------------
-- Locals
---

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
	local Def_Skin = DEF_SKIN[Layer]

	Def_Skin = _mcfg:GetTypeSkin(Button, Def_Skin)

	if (not Config.NoTexture) then
		local Atlas = Skin.Atlas
		local Texture = Skin.Texture

		Color = Color or Skin.Color

		if Store_Color[Layer] then
			local Key = "Color_"..Layer
			_mcfg[Key] = Color
		end

		local Set_Color = not Config.NoColor
		local Use_Color = Config.UseColor
		local Skin_Coords

		-- Skin
		if Skin.UseColor and Use_Color then
			Region:SetTexture()
			Region:SetVertexColor(1, 1, 1, 1)
			Region:SetColorTexture(GetColor(Color))

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
				Region:SetVertexColor(GetColor(Def_Skin.Color))
			end

		-- Default
		else
			Atlas = Def_Skin.Atlas
			Texture = Def_Skin.Texture

			if Atlas then
				local UseSize = Def_Skin.UseAtlasSize

				Region:SetAtlas(Atlas, UseSize)
				Resize = not UseSize

				if Set_Color then
					Region:SetVertexColor(GetColor(Def_Skin.Color))
				end

			elseif Texture then
				Skin_Coords = Def_Skin.TexCoords
				Region:SetTexture(Def_Skin.Texture)

				if Set_Color then
					Region:SetVertexColor(GetColor(Def_Skin.Color))
				end

			elseif Use_Color then
				Region:SetTexture()
				Region:SetVertexColor(1, 1, 1, 1)
				Region:SetColorTexture(GetColor(Def_Skin.Color))
			end
		end

		Region:SetTexCoord(GetTexCoords(Skin_Coords))
	end

	Region:SetBlendMode(Skin.BlendMode or Def_Skin.BlendMode or "BLEND")

	if Layer == "Highlight" then
		Region:SetDrawLayer("HIGHLIGHT", Skin.DrawLevel or Def_Skin.DrawLevel or 0)
	else
		Region:SetDrawLayer(Skin.DrawLayer or Def_Skin.DrawLayer, Skin.DrawLevel or Def_Skin.DrawLevel or 0)
	end

	if Resize then
		Region:SetSize(_mcfg:GetSize(Skin.Width, Skin.Height))
	end

	SetSkinPoint(Region, Button, Skin, SetAllPoints, Button, Default)

	-- Mask
	if Config.CanMask then
		Skin_Mask(Button, Skin, Region)
	end
end
