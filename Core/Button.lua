--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Button.lua
	* Author.: StormFX, JJSheets

	Button-Skinning API

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local pairs, type = pairs, type

----------------------------------------
-- WoW API
---

local hooksecurefunc = hooksecurefunc
local GetContainerNumSlots = ContainerFrame_GetContainerNumSlots or C_Container.GetContainerNumSlots

----------------------------------------
-- Internal
---

-- @ Masque
local WOW_RETAIL = Core.WOW_RETAIL

-- @ Skins\Blizzard_*
local DEFAULT_SKIN = Core.DEFAULT_SKIN

-- @ Skins\Skins
local Skin_Data = Core.Skins

-- @ Skins\Regions
local ActionTypes, AuraTypes, EmptyTypes = Core.ActionTypes, Core.AuraTypes, Core.EmptyTypes
local ItemTypes, RegTypes = Core.ItemTypes, Core.RegTypes

-- @ Core\Utility
local GetScale, GetTypeSkin = Core.GetScale, Core.GetTypeSkin

-- @ Core\Regions\Icon
local SetEmpty = Core.SetEmpty

-- @ Core\Regions\*
local SkinAutoCast, SkinBackdrop, SkinCooldown = Core.SkinAutoCast, Core.SkinBackdrop, Core.SkinCooldown
local SkinGloss, SkinIcon, SkinIconBorder = Core.SkinGloss, Core.SkinIcon, Core.SkinIconBorder
local SkinMask, SkinNewItem, SkinNormal = Core.SkinMask, Core.SkinNewItem, Core.SkinNormal
local SkinQuestBorder, SkinShadow, SkinSlotIcon = Core.SkinQuestBorder, Core.SkinShadow, Core.SkinSlotIcon
local SkinText, SkinTexture, UpdateSpellAlert = Core.SkinText, Core.SkinTexture, Core.UpdateSpellAlert

----------------------------------------
-- Locals
---

local Empty_Table = {}
local Is_Background = {
	[136511] = true,
	["Interface\\PaperDoll\\UI-PaperDoll-Slot-Bag"] = true,
	[4701874] = true,
	["Interface\\ContainerFrame\\BagsItemSlot2x"] = true,
}

-- Work-around for a bug introduced in 11.1.0.
local function GetIconTexture(Button)
	return Button.Icon or Button.icon or _G[Button:GetName().."IconTexture"]
end

----------------------------------------
-- Functions
---

-- Function to toggle the icon backdrops.
local function SetIconBackdrop(Button, Limit)
	local Region = GetIconTexture(Button)

	local Texture = Region:GetTexture()
	local Alpha, IsEmpty = 1, nil

	if Is_Background[Texture] then
		Alpha = 0
		IsEmpty = true
	end

	Region:SetAlpha(Alpha)
	SetEmpty(Button, IsEmpty, Limit)
end

-- Function to toggle the button art.
local function UpdateButtonArt(Button)
	local Slot_Art, Slot_Background = Button.SlotArt, Button.SlotBackground

	if Button.__MSQ_Enabled then
		if Slot_Art then
			Slot_Art:SetTexture()
			Slot_Art:Hide()
		end
		if Slot_Background then
			Slot_Background:SetTexture()
			Slot_Background:Hide()
		end
	else
		if Slot_Art then
			Slot_Art:SetAtlas("UI-HUD-ActionBar-IconFrame-Slot")
		end
		if Slot_Background then
			Slot_Background:SetAtlas("UI-HUD-ActionBar-IconFrame-Background")
		end
	end
end

-- Function to update the textures.
local function UpdateTextures(Button, Limit)
	local Skin = Button.__MSQ_Skin

	if Skin then
		local IsEmpty
		local BagID = Button.GetBagID and Button:GetBagID()

		if BagID then
			local Size = GetContainerNumSlots(BagID)
			IsEmpty = (Size == 0) or nil
		end

		SetEmpty(Button, IsEmpty, Limit)

		local Normal = Button:GetNormalTexture()
		local Pushed = Button:GetPushedTexture()
		local Highlight = Button:GetHighlightTexture()
		local SlotHighlight = Button.SlotHighlightTexture

		local xScale, yScale = GetScale(Button)

		if Normal then
			SkinNormal(Normal, Button, Skin.Normal, Button.__MSQ_Normal_Color, xScale, yScale)
		end
		if Pushed then
			SkinTexture("Pushed", Pushed, Button, Skin.Pushed, Button.__MSQ_Pushed_Color, xScale, yScale)
		end
		if Highlight then
			SkinTexture("Highlight", Highlight, Button, Skin.Highlight, Button.__MSQ_Highlight_Color, xScale, yScale)
		end
		if SlotHighlight then
			SkinTexture("SlotHighlight", SlotHighlight, Button, Skin.SlotHighlight, Button.__MSQ_SlotHighlight_Color, xScale, yScale)
		end
	end
end

----------------------------------------
-- Hooks
---

-- Hook to counter 10.0 Icon backdrops.
local function Hook_SetItemButtonTexture(Button, Texture)
	if Button.__MSQ_Exit_SetItemButtonTexture then return end

	SetIconBackdrop(Button)
end

-- Hook to counter 10.0 Action button texture changes.
local function Hook_UpdateButtonArt(Button)
	if Button.__MSQ_Exit_UpdateArt then return end

	UpdateButtonArt(Button)

	if not Button.__MSQ_Enabled then return end

	local Skin = Button.__MSQ_Skin

	if Skin then
		local Normal = Button.NormalTexture
		local Pushed = Button.PushedTexture
		local xScale, yScale = GetScale(Button)

		if Normal then
			SkinNormal(Normal, Button, Skin.Normal, Button.__MSQ_Normal_Color, xScale, yScale)
		end
		if Pushed then
			SkinTexture("Pushed", Pushed, Button, Skin.Pushed, Button.__MSQ_Pushed_Color, xScale, yScale)
		end
	end
end

-- Hook to counter 10.0 HotKey position changes.
local function Hook_UpdateHotKeys(Button, ActionButtonType)
	if Button.__MSQ_Exit_UpdateHotKeys then return end

	local HotKey, Skin = Button.HotKey, Button.__MSQ_Skin

	if (HotKey and HotKey:GetText() ~= "") and Skin then
		SkinText("HotKey", HotKey, Button, Skin.HotKey, GetScale(Button))
	end
end

-- Hook to counter 10.0 Bag button texture changes.
local function Hook_UpdateTextures(Button)
	if Button.__MSQ_Exit_UpdateTextures then return end

	UpdateTextures(Button)
end

----------------------------------------
-- Core
---

-- List of methods to hook.
local Hook_Methods = {
	SetItemButtonTexture = Hook_SetItemButtonTexture,
	UpdateButtonArt = Hook_UpdateButtonArt,
	UpdateHotKeys = Hook_UpdateHotKeys,
	UpdateTextures = Hook_UpdateTextures,
}

-- Applies a skin to a button and its associated layers.
function Core.SkinButton(Button, Regions, SkinID, Backdrop, Shadow, Gloss, Colors, Scale, Pulse)
	if not Button then return end

	local bType = Button.__MSQ_bType
	local Skin, Disabled

	if SkinID then
		Skin = Skin_Data[SkinID] or DEFAULT_SKIN
		Button.__MSQ_Skin = Skin
	else
		local Addon = Button.__MSQ_Addon or false

		Skin = Skin_Data[Addon] or DEFAULT_SKIN
		Button.__MSQ_Skin = nil
		Disabled = true
		Pulse = true
	end

	local Enabled = not Disabled

	Button.__MSQ_Enabled = (Enabled and true) or nil
	Button.__MSQ_Scale = Scale
	Button.__MSQ_Shape = Skin.Shape

	-- Set/remove type flags.
	Button.__MSQ_IsAction = ActionTypes[bType]
	Button.__MSQ_IsAura = AuraTypes[bType]
	Button.__MSQ_IsItem = ItemTypes[bType]

	local Empty_Type = EmptyTypes[bType]
	Button.__MSQ_Empty_Type = Empty_Type

	if Disabled or type(Colors) ~= "table" then
		Colors = Empty_Table
	end

	local xScale, yScale = GetScale(Button)

	-- Mask
	local Skin_Mask = Skin.Mask

	if Skin_Mask then
		if type(Skin_Mask) == "table" then
			Skin_Mask = GetTypeSkin(Button, bType, Skin_Mask)
		end

		SkinMask(nil, Button, Skin_Mask, xScale, yScale)
	end

	-- Backdrop
	local FloatingBG = Button.FloatingBG or Regions.Backdrop

	if Disabled then
		Backdrop = (FloatingBG and true) or false
	end

	SkinBackdrop(Backdrop, FloatingBG, Button, Skin.Backdrop, Colors.Backdrop, xScale, yScale)

	-- Icon/SlotIcon
	if bType == "Backpack" and WOW_RETAIL then
		SkinSlotIcon(Enabled, Button, Skin.SlotIcon, xScale, yScale)
	else
		local Icon = Regions.Icon

		if Icon then
			SkinIcon(Icon, Button, Skin.Icon, xScale, yScale)
		end
	end

	-- Shadow
	Shadow = (Shadow and Enabled) or false
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

			if Region then
				if Info.Type == "FontString" then
					SkinText(Layer, Region, Button, Skin[Layer], xScale, yScale)
				else
					SkinTexture(Layer, Region, Button, Skin[Layer], Colors[Layer], xScale, yScale)
				end
			end
		end
	end

	-- Dragonflight Stuff
	if WOW_RETAIL then
		-- Toggle Icon backdrops.
		if Button.SetItemButtonTexture then
			SetIconBackdrop(Button, true)
		end

		-- Set the button art.
		if Button.UpdateButtonArt then
			UpdateButtonArt(Button)
		end

		-- Update the textures.
		if Button.UpdateTextures then
			UpdateTextures(Button, true)
		end

		-- Hooks
		for Method, Hook in pairs(Hook_Methods) do
			if Button[Method] then
				local Hook_Key = "__MSQ_Hook_"..Method
				local Exit_Key = "__MSQ_Exit_"..Method

				if Disabled then
					Button[Exit_Key] = true
				else
					if not Button[Hook_Key] then
						hooksecurefunc(Button, Method, Hook)
						Button[Hook_Key] = true
					end

					Button[Exit_Key] = nil
				end
			end
		end
	end

	-- IconBorder
	local IconBorder = Regions.IconBorder

	if IconBorder then
		SkinIconBorder(IconBorder, Button, Skin.IconBorder, xScale, yScale)
	end

	-- Gloss
	Gloss = (Gloss and Enabled) or false
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

	Button.__MSQ_Charge_Skin = ChargeSkin

	if Charge then
		SkinCooldown(Charge, Button, ChargeSkin, nil, xScale, yScale, Pulse)
	end

	-- AutoCast Frame
	if bType == "Pet" then
		SkinAutoCast(Button, Skin, xScale, yScale)
	end

	-- SpellAlert
	UpdateSpellAlert(Button)
end
