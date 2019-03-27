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

----------------------------------------
-- Normal
---

do
	-- Post-Hook to catch changes to a button's 'Normal' texture.
	-- * The default behavior for action buttons is to set the 'Normal' region's
	--   alpha to 0.5, but the PetBar and some add-ons still change the texture.
	local function Hook_SetNormalTexture(Button, Texture)
		local Region = Button.__MSQ_Normal

		-- Native Region
		local Normal = Button:GetNormalTexture()

		-- Hide the native region if it's not being used.
		if Normal ~= Region then
			Normal:SetTexture()
			Normal:Hide()
		end

		local Skin = Button.__MSQ_NormalSkin
		local SkinTexture = Button.__MSQ_Random or Skin.Texture or Texture

		-- Hide
		if Skin.Hide then
			Region:SetTexture()
			Region:Hide()

		-- Update
		else
			Region:SetTexture(SkinTexture)
			Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
			Region:SetVertexColor(GetColor(Button.__MSQ_NormalColor))
		end
	end

	----------------------------------------
	-- Region-Skinning Function
	---

	local SkinRegion = Core.SkinRegion
	local Base = {}

	-- Skins the 'Normal' layer of a button.
	function SkinRegion.Normal(Region, Button, Skin, Color, xScale, yScale)
		-- Native Region
		Region = Region or Button:GetNormalTexture()

		-- Get the current texture before changing regions.
		local Texture = (Region and Region:GetTexture()) or [[Interface\Buttons\UI-Quickslot2]]

		-- Custom Region
		local Custom = Base[Button]

		-- States Enabled
		if Skin.UseStates then
			if Custom then
				Custom:SetTexture()
				Custom:Hide()
			end

			-- Exit if there's no region.
			if not Region then return end

		-- States Disabled
		else
			-- Hide the native region.
			if Region then
				Region:SetTexture()
				Region:Hide()
			end

			-- Assign or create a custom region.
			Region = Custom or Button:CreateTexture()
			Base[Button] = Region
		end

		-- Store the region.
		Button.__MSQ_Normal = Region

		-- Random Texture
		local Textures = Skin.Textures
		local Random

		if type(Textures) == "table" and #Textures > 0 then
			local i = random(1, #Textures)
			Random = Textures[i]
		end

		Button.__MSQ_Random = Random

		-- Texture
		local SkinTexture = Random or Skin.Texture or Texture

		-- Color
		Color = Color or Skin.Color
		Button.__MSQ_NormalColor = Color

		-- Store the skin
		Button.__MSQ_NormalSkin = Skin

		-- Hook the button.
		if not Button.__MSQ_NormalHook then
			hooksecurefunc(Button, "SetNormalTexture", Hook_SetNormalTexture)
			Button.__MSQ_NormalHook = true
		end

		-- Hide the region.
		if Skin.Hide then
			if Region then
				Region:SetTexture()
				Region:Hide()
			end

			-- Exit
			return
		end

		-- Texture
		Region:SetTexture(SkinTexture)
		Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

		-- Color
		Region:SetVertexColor(GetColor(Color))
		Region:SetBlendMode(Skin.BlendMode or "BLEND")

		-- Level
		Region:SetDrawLayer(Skin.DrawLayer or "ARTWORK", Skin.DrawLevel or 0)

		-- Size
		Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

		-- Position
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
end
