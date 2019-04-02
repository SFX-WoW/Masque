--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Regions\Normal.lua
	* Author.: StormFX

	'Normal' Region

	* See Skins\Regions.lua for region defaults.

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Lua
---

local error, random, type = error, random, type

----------------------------------------
-- Locals
---

-- @ Core\Utility: Size, Points, Color, Coords
local GetSize, SetPoints, GetColor, GetTexCoords = Core.Utility()

-- @ Core\Core
local SkinRegion = Core.SkinRegion

local Base = {}

----------------------------------------
-- Hook
---

-- Catches changes to a button's 'Normal' texture.
-- * The default behavior for action buttons is to set the 'Normal' region's
--   alpha to 0.5, but the PetBar and some add-ons still change the texture.
local function Hook_SetNormalTexture(Button, Texture)
	local Region = Button.__MSQ_Normal
	local Normal = Button:GetNormalTexture()

	if Normal ~= Region then
		Normal:SetTexture()
		Normal:Hide()
	end

	local Skin = Button.__MSQ_NormalSkin
	local SkinTexture = Button.__MSQ_Random or Skin.Texture or Texture

	if Skin.Hide then
		Region:SetTexture()
		Region:Hide()
	else
		Region:SetTexture(SkinTexture)
		Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
		Region:SetVertexColor(GetColor(Button.__MSQ_NormalColor))
	end
end

----------------------------------------
-- Region-Skinning Function
---

-- Skins the 'Normal' layer of a button.
function SkinRegion.Normal(Region, Button, Skin, Color, xScale, yScale)
	Region = Region or Button:GetNormalTexture()

	local Texture = (Region and Region:GetTexture()) or [[Interface\Buttons\UI-Quickslot2]]
	local Custom = Base[Button]

	-- States Enabled
	if Skin.UseStates then
		if Custom then
			Custom:SetTexture()
			Custom:Hide()
		end

		if not Region then return end

	-- States Disabled
	else
		-- Hide the native region.
		if Region then
			Region:SetTexture()
			Region:Hide()
		end

		Region = Custom or Button:CreateTexture()
		Base[Button] = Region
	end

	Button.__MSQ_Normal = Region

	local Textures = Skin.Textures
	local Random

	if type(Textures) == "table" and #Textures > 0 then
		local i = random(1, #Textures)
		Random = Textures[i]
	end

	Button.__MSQ_Random = Random

	local SkinTexture = Random or Skin.Texture or Texture

	Color = Color or Skin.Color
	Button.__MSQ_NormalColor = Color

	Button.__MSQ_NormalSkin = Skin

	if not Button.__MSQ_NormalHook then
		hooksecurefunc(Button, "SetNormalTexture", Hook_SetNormalTexture)
		Button.__MSQ_NormalHook = true
	end

	if Skin.Hide then
		if Region then
			Region:SetTexture()
			Region:Hide()
		end

		return
	end

	Region:SetTexture(SkinTexture)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

	Region:SetVertexColor(GetColor(Color))
	Region:SetBlendMode(Skin.BlendMode or "BLEND")

	Region:SetDrawLayer(Skin.DrawLayer or "ARTWORK", Skin.DrawLevel or 0)

	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

	SetPoints(Region, Button, Skin, nil, Skin.SetAllPoints)

	Region:Show()
end

----------------------------------------
-- API
---

-- Retrieves the 'Normal' region of a button.
function Core.API:GetNormal(Button)
	if type(Button) ~= "table" then
		if Core.db.profile.Debug then
			error("Bad argument to API method 'GetNormal'. 'Button' must be a button object.", 2)
		end
		return
	end

	return Button.__MSQ_Normal or Button:GetNormalTexture()
end
