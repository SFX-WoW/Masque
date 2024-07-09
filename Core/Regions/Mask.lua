--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Regions\Mask.lua
	* Author.: StormFX

	Button/Region Mask

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local type = type

----------------------------------------
-- Internal
---

-- @ Core\Utility
local GetSize, SetSkinPoint = Core.GetSize, Core.SetSkinPoint

-- @ Skins\Regions
local Item_Types = Core.ItemTypes

----------------------------------------
-- Core
---

-- Skins a button or region mask.
function Core.SkinMask(Region, Button, Skin, xScale, yScale)
	local bType = Button.__MSQ_bType
	local Bag_Type = bType and Item_Types[bType]

	local Button_Mask = Button.__MSQ_Mask or Button.IconMask
	local Circle_Mask = Button.CircleMask

	-- Disable the bag slot mask in 10.0 to enable custom masks.
	if Bag_Type and Circle_Mask then
		local Icon = Button.icon

		if Icon then
			Icon:RemoveMaskTexture(Circle_Mask)
		end

		Circle_Mask:SetTexture()
	end

	-- Region Mask
	if Region then
		local Skin_Mask = Skin.Mask

		-- Enable the button mask if the region skin doesn't provide one.
		if Skin.UseMask and Button_Mask and not Skin_Mask then
			if not Region.__MSQ_Button_Mask then
				Region:AddMaskTexture(Button_Mask)
				Region.__MSQ_Button_Mask = true
			end

		-- Disable the button mask.
		elseif Button_Mask then
			Region:RemoveMaskTexture(Button_Mask)
			Region.__MSQ_Button_Mask = nil
		end

		-- Region Mask
		local Region_Mask = Region.__MSQ_Mask
		local Mask_Type = type(Skin_Mask)

		-- Enable the region mask.
		if Skin_Mask then
			if not Region_Mask then
				Region_Mask = Button:CreateMaskTexture()
				Region.__MSQ_Mask = Region_Mask
			end

			-- Skin Table
			if Mask_Type == "table" then
				local Atlas, Texture = Skin_Mask.Atlas, Skin_Mask.Texture

				if Atlas then
					local UseAtlasSize = Skin_Mask.UseAtlasSize

					Button_Mask:SetAtlas(Atlas, UseAtlasSize)

					if not UseAtlasSize then
						Button_Mask:SetSize(GetSize(Skin_Mask.Width, Skin_Mask.Height, xScale, yScale, Button))
					end

					SetSkinPoint(Region_Mask, Region, Skin_Mask, nil, Skin_Mask.SetAllPoints)
				elseif Texture then
					Region_Mask:SetTexture(Texture, Skin_Mask.WrapH, Skin_Mask.WrapV)
					Region_Mask:SetSize(GetSize(Skin_Mask.Width, Skin_Mask.Height, xScale, yScale, Button))

					SetSkinPoint(Region_Mask, Region, Skin_Mask, nil, Skin_Mask.SetAllPoints)
				end

			-- Texture Path
			elseif Mask_Type == "string" then
				Region_Mask:SetTexture(Skin_Mask, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
				Region_Mask:SetAllPoints(Region)

			-- Exit
			else
				return
			end

			if not Region.__MSQ_Region_Mask then
				Region:AddMaskTexture(Region_Mask)
				Region.__MSQ_Region_Mask = true
			end

		-- Disable the region mask.
		elseif Region.__MSQ_Region_Mask then
			Region:RemoveMaskTexture(Region_Mask)
			Region.__MSQ_Region_Mask = nil
		end

	-- Button Mask
	else
		Button_Mask = Button_Mask or Button:CreateMaskTexture()
		Button.__MSQ_Mask = Button_Mask

		local Type = type(Skin)

		-- Skin Table
		if Type == "table" then
			local Atlas, Texture = Skin.Atlas, Skin.Texture

			if Atlas then
				local UseAtlasSize = Skin.UseAtlasSize

				Button_Mask:SetAtlas(Atlas, UseAtlasSize)

				if not UseAtlasSize then
					Button_Mask:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale, Button))
				end

				SetSkinPoint(Button_Mask, Button, Skin, nil, Skin.SetAllPoints)
			elseif Texture then
				Button_Mask:SetTexture(Texture, Skin.WrapH, Skin.WrapV)
				Button_Mask:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale, Button))

				SetSkinPoint(Button_Mask, Button, Skin, nil, Skin.SetAllPoints)
			end

		-- Texture Path
		elseif Type == "string" then
			Button_Mask:SetTexture(Skin, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			Button_Mask:SetAllPoints(Button)
		end
	end
end
