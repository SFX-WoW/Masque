--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Button.lua
	* Author.: StormFX, JJSheets

	Button-Skinning API

]]

local _, Core = ...

----------------------------------------
-- Lua
---

local pairs, type = pairs, type

----------------------------------------
-- Internal
---

-- @ Masque
local Masque = Core.AddOn

-- @ Skins\Skins
local Skins = Core.Skins
local DEFAULT_SKIN = Core.DEFAULT_SKIN

-- @ Skins\Regions
local RegTypes = Core.RegTypes
local AuraTypes = Core.AuraTypes
local ItemTypes = Core.ItemTypes

-- @ Core\Utility
local GetScale, GetTypeSkin = Core.GetScale, Core.GetTypeSkin

-- @ Core\Regions\*
local SkinBackdrop, SkinCooldown, SkinFrame = Core.SkinBackdrop, Core.SkinCooldown, Core.SkinFrame
local SkinGloss, SkinIcon, SkinIconBorder = Core.SkinGloss, Core.SkinIcon, Core.SkinIconBorder
local SkinMask, SkinNewItem, SkinNormal = Core.SkinMask, Core.SkinNewItem, Core.SkinNormal
local SkinQuestBorder, SkinShadow, SkinText = Core.SkinQuestBorder, Core.SkinShadow, Core.SkinText
local SkinTexture, UpdateSpellAlert = Core.SkinTexture, Core.UpdateSpellAlert

----------------------------------------
-- Locals
---

local __Empty = {}

-- Hook to counter 10.0 `Action` button texture changes.
local function Hook_UpdateArt(Button, HideDivider)
	local Pushed = Button.PushedTexture
	if not Pushed then return end

	local SlotArt, SlotBackground = Button.SlotArt, Button.SlotBackground

	if SlotArt then SlotArt:Hide() end
	if SlotBackground then SlotBackground:Hide() end

	SkinTexture("Pushed", Pushed, Button.__MSQ_Skin.Pushed, Button, Button.__MSQ_PushedColor, GetScale(Button))
end

-- Hook to counter 10.0 `Bag` button texture changes.
local function Hook_UpdateTextures(Button)
	local Pushed = Button:GetPushedTexture()
	local Highlight = Button:GetHighlightTexture()
	local SlotHighlight = Button.SlotHighlightTexture

	local xScale, yScale = GetScale(Button)

	SkinTexture("Pushed", Pushed, Button.__MSQ_Skin.Pushed, Button, Button.__MSQ_PushedColor, xScale, yScale)
	SkinTexture("Highlight", Highlight, Button.__MSQ_Skin.Highlight, Button, Button.__MSQ_HighlightColor, xScale, yScale)
	SkinTexture("SlotHighlight", SlotHighlight, Button.__MSQ_Skin.SlotHighlight, Button, Button.__MSQ_SlotHighlightColor, xScale, yScale)
end

-- List of methods to hook.
local Hook_Methods = {
	UpdateArt = Hook_UpdateArt,
	UpdateTextures = Hook_UpdateTextures,
}

----------------------------------------
-- Core
---

-- Applies a skin to a button and its associated layers.
function Core.SkinButton(Button, Regions, SkinID, Backdrop, Shadow, Gloss, Colors, Pulse)
	if not Button then return end

	local bType = Button.__MSQ_bType
	local Skin, Disabled

	if SkinID then
		Skin = Skins[SkinID] or Skins.Classic
	else
		local Addon = Button.__MSQ_Addon or false
		Skin = Skins[Addon] or DEFAULT_SKIN
		Disabled = true
		Pulse = true
	end

	Button.__MSQ_Enabled = (not Disabled and true) or nil
	Button.__MSQ_IsAura = AuraTypes[bType]
	Button.__MSQ_IsItem = ItemTypes[bType]
	Button.__MSQ_Shape = Skin.Shape

	if Disabled or type(Colors) ~= "table" then
		Colors = __Empty
	end

	local xScale, yScale = GetScale(Button)

	-- Mask
	local Mask = Skin.Mask

	if Mask then
		Mask = GetTypeSkin(Button, bType, Mask)
		SkinMask(nil, Button, Mask, xScale, yScale)
	end

	-- Backdrop
	local FloatingBG = Button.FloatingBG or Regions.Backdrop

	if Disabled then
		Backdrop = (FloatingBG and true) or false
	end

	SkinBackdrop(Backdrop, FloatingBG, Button, Skin.Backdrop, Colors.Backdrop, xScale, yScale)

	-- Icon
	local Icon = Regions.Icon

	if Icon then
		SkinIcon(Icon, Button, Skin.Icon, xScale, yScale)
	end

	-- Shadow
	Shadow = (Shadow and not Disabled) or false
	SkinShadow(Shadow, Button, Skin.Shadow, Colors.Shadow, xScale, yScale)

	-- Normal
	local Normal = Regions.Normal

	if Normal ~= false then
		SkinNormal(Normal, Button, Skin.Normal, Colors.Normal, xScale, yScale)
	end

	-- FontStrings and Textures
	local Layers = RegTypes[bType] or RegTypes.Legacy

	for Layer, Info in pairs(Layers) do
		if Info.Iterate then
			local Region = Regions[Layer]
			local Type = Info.Type

			if Region then
				if Type == "FontString" then
					SkinText(Layer, Region, Button, Skin[Layer], xScale, yScale)
				else
					SkinTexture(Layer, Region, Button, Skin[Layer], Colors[Layer], xScale, yScale)
				end
			end
		end
	end

	-- Update Hooks
	for Method, Hook in pairs(Hook_Methods) do
		if Button[Method] then
			local Hooked = Masque:IsHooked(Button, Method)

			if Hooked and Disabled then
				Masque:Unhook(Button, Method)
				Button.__MSQ_ArtHook = nil
			elseif not Hooked then
				Masque:SecureHook(Button, Method, Hook)
				Button.__MSQ_ArtHook = true
			end
		end
	end

	-- IconBorder
	local IconBorder = Regions.IconBorder

	if IconBorder then
		SkinIconBorder(IconBorder, Button, Skin.IconBorder, xScale, yScale)
	end

	-- Gloss
	Gloss = (Gloss and not Disabled) or false
	SkinGloss(Gloss, Button, Skin.Gloss, Colors.Gloss, xScale, yScale)

	-- NewItem
	local NewItem = Regions.NewItem

	if NewItem then
		SkinNewItem(NewItem, Button, Skin.NewItem, xScale, yScale)
	end

	-- QuestBorder
	local QuestBorder = Regions.QuestBorder

	if QuestBorder then
		SkinQuestBorder(QuestBorder, Button, Skin.QuestBorder, xScale, yScale)
	end

	-- Cooldown
	local Cooldown = Regions.Cooldown

	if Cooldown then
		SkinCooldown(Cooldown, Button, Skin.Cooldown, Colors.Cooldown, xScale, yScale, Pulse)
	end

	-- ChargeCooldown
	local Charge = Regions.ChargeCooldown or Button.chargeCooldown
	local ChargeSkin = Skin.ChargeCooldown

	Button.__MSQ_ChargeSkin = ChargeSkin

	if Charge then
		SkinCooldown(Charge, Button, ChargeSkin, nil, xScale, yScale, Pulse)
	end

	-- AutoCastShine
	local Shine = Regions.AutoCastShine

	if Shine then
		SkinFrame(Shine, Button, Skin.AutoCastShine, xScale, yScale)
	end

	-- SpellAlert
	UpdateSpellAlert(Button)
end
