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

local _G, pairs, type = _G, pairs, type

----------------------------------------
-- WoW API
---

local hooksecurefunc = hooksecurefunc
local GetContainerNumSlots = ContainerFrame_GetContainerNumSlots or C_Container.GetContainerNumSlots

----------------------------------------
-- Internal
---

-- @ Skins\Blizzard_*
local DEF_SKIN = Core.DEFAULT_SKIN

-- @ Skins\Skins
local Skin_Data = Core.Skins

-- @ Skins\Regions
local ActionTypes, AuraTypes, EmptyTypes = Core.ActionTypes, Core.AuraTypes, Core.EmptyTypes
local ItemTypes, RegTypes = Core.ItemTypes, Core.RegTypes

-- @ Core\Core
local GetMasqueConfig = Core.GetMasqueConfig

-- @ Core\Regions\Icon
local SetEmpty = Core.SetEmpty

-- @ Core\Regions\*
local Skin_AutoCast, Skin_Backdrop, Skin_Cooldown = Core.Skin_AutoCast, Core.Skin_Backdrop, Core.Skin_Cooldown
local Skin_Gloss, Skin_Icon, Skin_IconBorder = Core.Skin_Gloss, Core.Skin_Icon, Core.Skin_IconBorder
local Skin_Mask, Skin_NewItem, Skin_Normal = Core.Skin_Mask, Core.Skin_NewItem, Core.Skin_Normal
local Skin_QuestBorder, Skin_Shadow, Skin_Text = Core.Skin_QuestBorder, Core.Skin_Shadow, Core.Skin_Text
local Skin_Texture, Update_SpellAlert, Update_AssistedCombatHighlight = Core.Skin_Texture, Core.Update_SpellAlert, Core.Update_AssistedCombatHighlight

----------------------------------------
-- Locals
---

local Empty_Table = {}

local IsBackground = {
	[136511] = true,
	["Interface\\PaperDoll\\UI-PaperDoll-Slot-Bag"] = true,
	[4701874] = true,
	["Interface\\ContainerFrame\\BagsItemSlot2x"] = true,
}

----------------------------------------
-- Helpers
---

-- Toggles the `Icon` backdrops on item buttons.
local function SetItemButtonTexture(Button, Limit)
	local Region = Button.Icon or Button.icon or _G[Button:GetName().."IconTexture"]

	local Texture = Region:GetTexture()
	local Alpha, IsEmpty = 1, nil

	if IsBackground[Texture] then
		Alpha = 0
		IsEmpty = true
	end

	Region:SetAlpha(Alpha)
	SetEmpty(Button, IsEmpty, Limit)
end

-- Toggles the button art on action buttons.
local function UpdateButtonArt(Button)
	local _mcfg = Button._MSQ_CFG
	local Enabled = _mcfg and _mcfg.Enabled

	local Slot_Art, Slot_Background = Button.SlotArt, Button.SlotBackground

	if Enabled then
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

-- Updates the state textures on bag buttons.
local function UpdateTextures(Button, Limit)
	local _mcfg = Button._MSQ_CFG
	local Skin = _mcfg and _mcfg.Skin

	if not Skin then return end

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

	if Normal then
		Skin_Normal(Normal, Button, Skin.Normal, _mcfg.Color_Normal)
	end

	if Pushed then
		Skin_Texture("Pushed", Pushed, Button, Skin.Pushed, _mcfg.Color_Pushed)
	end

	if Highlight then
		Skin_Texture("Highlight", Highlight, Button, Skin.Highlight, _mcfg.Color_Highlight)
	end

	if SlotHighlight then
		Skin_Texture("SlotHighlight", SlotHighlight, Button, Skin.SlotHighlight, _mcfg.Color_SlotHighlight)
	end
end

----------------------------------------
-- Hooks
---

-- Hook to counter 'Icon' backdrops for item buttons.
-- @ Interface/AddOns/Blizzard_ItemButton/Mainline/ItemButtonTemplate.lua
local function Hook_SetItemButtonTexture(Button, Texture)
	if Button._MSQ_Exit_SetItemButtonTexture then return end

	SetItemButtonTexture(Button)
end

-- Hook to counter action button texture changes.
-- @ Interface/AddOns/Blizzard_ActionBar/Mainline/ActionButton.lua
local function Hook_UpdateButtonArt(Button)
	if Button._MSQ_Exit_UpdateButtonArt then return end

	local _mcfg = Button._MSQ_CFG

	UpdateButtonArt(Button)

	local Enabled = _mcfg and _mcfg.Enabled

	if not Enabled then return end

	local Skin = _mcfg.Skin

	if Skin then
		local Normal = Button:GetNormalTexture()
		local Pushed = Button:GetPushedTexture()

		if Normal then
			Skin_Normal(Normal, Button, Skin.Normal, _mcfg.Color_Normal)
		end

		if Pushed then
			Skin_Texture("Pushed", Pushed, Button, Skin.Pushed, _mcfg.Color_Pushed)
		end
	end
end

-- Hook to counter `HotKey` position changes.
-- @ Interface/AddOns/Blizzard_ActionBar/Mainline/ActionButton.lua
local function Hook_UpdateHotKeys(Button, ActionButtonType)
	if Button._MSQ_Exit_UpdateHotKeys then return end

	local _mcfg = Button._MSQ_CFG
	local Enabled = _mcfg and _mcfg.Enabled

	if not Enabled then return end

	local HotKey = Button.HotKey
	local Skin = _mcfg.Skin

	if (HotKey and HotKey:GetText() ~= "") and Skin then
		Skin_Text("HotKey", HotKey, Button, Skin.HotKey)
	end
end

-- Hook to counter bag button state texture changes.
-- @ Interface/AddOns/Blizzard_ActionBar/Mainline/MainMenuBarBagButtons.lua
local function Hook_UpdateTextures(Button)
	if Button._MSQ_Exit_UpdateTextures then return end

	UpdateTextures(Button)
end

----------------------------------------
-- Core
---

-- Blizzard Skins
local BaseSkin = {
	["Blizzard Classic"] = true,
	["Blizzard Modern"] = true,
}

-- List of methods to hook.
local Hook_Methods = {
	SetItemButtonTexture = Hook_SetItemButtonTexture,
	UpdateButtonArt = Hook_UpdateButtonArt,
	UpdateHotKeys = Hook_UpdateHotKeys,
	UpdateTextures = Hook_UpdateTextures,
}

-- Internal skin handler for buttons.
function Core.SkinButton(Button, Regions, SkinID, Backdrop, Shadow, Gloss, Colors, Scale, Pulse)
	if not Button then return end

	-- Get the button's settings table.
	local _mcfg = GetMasqueConfig(Button)

	-- Force an update.
	_mcfg:ForceUpdate()

	local bType = _mcfg.bType
	local Enabled = true
	local Skin

	if SkinID then
		Skin = Skin_Data[SkinID] or DEF_SKIN
		_mcfg.Skin = Skin

	else
		local Addon = _mcfg.Addon or false

		Skin = Skin_Data[Addon] or DEF_SKIN
		SkinID = Skin.SkinID or false

		_mcfg.Skin = nil

		Enabled = nil
		Pulse = true
	end

	-- Update the basics
	_mcfg.Shape = Skin.Shape
	_mcfg.Enabled = Enabled
	_mcfg.BaseSkin = BaseSkin[SkinID]

	Scale = Scale or 1

	_mcfg:UpdateScale(Button, Scale)

	local IsActionType = ActionTypes[bType]

	-- Set/remove type flags.
	_mcfg.IsAction = IsActionType
	_mcfg.IsAura = AuraTypes[bType]
	_mcfg.IsItem = ItemTypes[bType]
	_mcfg.IsEmptyType = EmptyTypes[bType]

	local Disabled = not Enabled

	if Disabled or type(Colors) ~= "table" then
		Colors = Empty_Table
	end

	-- [[ Mask ]]

	local Mask_Skin = Skin.Mask

	if Mask_Skin then
		if type(Mask_Skin) == "table" then
			Mask_Skin = _mcfg:GetTypeSkin(Button, Mask_Skin)
		end

		Skin_Mask(Button, Mask_Skin)
	end

	-- [[ Backdrop ]]

	local FloatingBG = Button.FloatingBG or Regions.Backdrop

	if Disabled then
		Backdrop = (FloatingBG and true) or false
	end

	Skin_Backdrop(Backdrop, FloatingBG, Button, Skin.Backdrop, Colors.Backdrop)

	-- [[ Icon ]]

	local Hide_Icon

	if bType == "Backpack" then
		local Normal_Skin = _mcfg:GetTypeSkin(Button, Skin.Normal)
		local Normal_Atlas = Normal_Skin.Atlas

		if (type(Normal_Atlas) == "string") and (Normal_Atlas:lower() == "bag-main") then
			Hide_Icon = true
		end
	end

	local Icon = Regions.Icon

	if Icon then
		Skin_Icon(Icon, Button, Skin.Icon, Hide_Icon)
	end

	-- [[ Shadow ]]

	Shadow = (Shadow and Enabled) or nil

	Skin_Shadow(Shadow, Button, Skin.Shadow, Colors.Shadow)

	-- [[ Normal ]]

	local Normal = Regions.Normal

	if Normal ~= false then
		Skin_Normal(Normal, Button, Skin.Normal, Colors.Normal)
	end

	-- [[ IconBorder ]]

	local IconBorder = Regions.IconBorder

	if IconBorder then
		Skin_IconBorder(IconBorder, Button, Skin.IconBorder)
	end

	-- [[ Gloss ]]

	Gloss = (Gloss and Enabled) or nil
	Skin_Gloss(Gloss, Button, Skin.Gloss, Colors.Gloss)

	-- [[ NewItem ]]

	local NewItem = Regions.NewItem

	if NewItem then
		Skin_NewItem(NewItem, Button, Skin.NewItem)
	end

	-- [[ QuestBorder ]]

	local QuestBorder = Regions.QuestBorder

	if QuestBorder then
		Skin_QuestBorder(QuestBorder, Button, Skin.QuestBorder)
	end

	-- [[ Iteration ]]

	local Layers = RegTypes[bType] or RegTypes.Legacy

	for Layer, Info in pairs(Layers) do
		if Info.Iterate then
			local Region = Regions[Layer]

			if Region then
				-- Text
				if Info.Type == "FontString" then
					Skin_Text(Layer, Region, Button, Skin[Layer])

				-- Texture
				else
					Skin_Texture(Layer, Region, Button, Skin[Layer], Colors[Layer])
				end
			end
		end
	end

	-- [[ Type-Specific Functions ]]

	-- Toggle item button backdrops.
	if Button.SetItemButtonTexture then
		SetItemButtonTexture(Button, true)
	end

	-- Update action button art.
	if Button.UpdateButtonArt then
		UpdateButtonArt(Button)
	end

	-- Update bag button textures.
	if Button.UpdateTextures then
		UpdateTextures(Button, true)
	end

	-- [[ Hooks ]]

	for Method, Hook in pairs(Hook_Methods) do
		if Button[Method] then
			local Hook_Key = "_MSQ_Hook_"..Method
			local Exit_Key = "_MSQ_Exit_"..Method

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

	-- [[ Cooldown ]]

	local Cooldown = Regions.Cooldown

	if Cooldown then
		Skin_Cooldown(Cooldown, Button, Skin.Cooldown, Colors.Cooldown, Pulse)
	end

	-- [[ LoC Cooldown ]]

	if IsActionType then
		local CooldownLoC = Regions.CooldownLoC

		if CooldownLoC then
			Skin_Cooldown(CooldownLoC, Button, Skin.CooldownLoC, nil, nil, true)
		end
	end

	-- [[ ChargeCooldown ]]

	local ChargeCooldown = Regions.ChargeCooldown or Button.chargeCooldown
	local ChargeCooldown_Skin = Skin.ChargeCooldown

	_mcfg.Skin_ChargeCooldown = ChargeCooldown_Skin

	if ChargeCooldown then
		Skin_Cooldown(ChargeCooldown, Button, ChargeCooldown_Skin)
	end

	-- [[ AutoCast ]]

	if IsActionType then
		Skin_AutoCast(Button, Skin)
	end

	-- [[ SpellAlert ]]

	Update_SpellAlert(Button)

	-- [[ AssistedCombatHighlight ]]

	local AssistedCombatHighlight = Button.AssistedCombatHighlightFrame

	if AssistedCombatHighlight then
		Update_AssistedCombatHighlight(AssistedCombatHighlight.Flipbook, Button)
	end
end
