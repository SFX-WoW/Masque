--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Skins\Regions.lua
	* Author.: StormFX

	Regions Settings

]]

local _, Core = ...
local WOW_RETAIL = Core.WOW_RETAIL
local WOW_CLASSIC = not WOW_RETAIL

----------------------------------------
-- Region Settings

-- * Key - The string button key that holds the region reference.
-- * Func - The string name of the button method that returns the region reference.
-- * Name - The string suffix of the global key that holds the region reference.
-- * Type - Must match the game's internal type, for validation.

-- * UseColor - Use :SetColorTexture() if the skin provides a color but no texture.
-- * Hide - Region will be hidden if it exists.
-- * CanHide - Allow the region to be hidden.
-- * CanMask - Allow the region to be masked.
-- * NoColor - Do not allow color changes.
-- * NoTexture - Do not allow texture changes.

-- * Ignore - Ignore when looking for regions. @ Core\Group
-- * Iterate - Include in iteration. @ Core\Button
---

----------------------------------------
-- Base Configuration
---

local baseConfig = {
	--IconMask = {}, -- [ ActionButtonTemplate ]

	-- [ BACKGROUND, -1 ]

	Backdrop = { -- [ Custom ]
		CanHide = true,
		Ignore = true,
	},

	-- [ BACKGROUND, 0 ]

	Icon = { -- [ ActionButtonTemplate ]
		Key = "icon",
		Name = "Icon",
		Type = "Texture",
		CanMask = true,
		NoColor = true,
		NoTexture = true,
		Aura = { -- [ AuraButtonArtTemplate ]
			Key = "Icon",
			Type = "Texture",
			CanMask = true,
			NoColor = true,
			NoTexture = true,
		},
		Item = { -- [ ItemButtonTemplate ]
			Key = "icon",
			Name = "IconTexture",
			Type = "Texture",
			CanMask = true,
			NoColor = true,
			NoTexture = true,
		},
	},
	--SlotBackground = {} -- [ ActionButtonTemplate ]
	--SlotArt = {}, -- [ ActionButtonTemplate ][ RETAIL_ONLY ]

	-- [ BACKGROUND, Text ]

	Duration = { -- [ AuraButtonArtTemplate ]
		Key = "Duration",
		Type = "FontString",
		Iterate = true,
		NoColor = true,
	},

	-- [ ARTWORK, -1 ]

	Shadow = { -- [ Custom ]
		CanHide = true,
		Ignore = true,
	},

	-- [ ARTWORK, 0 ]

	Normal = { -- [ Button, ActionButtonTemplate ]
		Func = "GetNormalTexture",
		--Key = "NormalTexture", -- Conflicts with some add-ons and button types.
		Name = "NormalTexture",
		Type = "Texture",
		CanHide = true,
		Item = { -- [ Button, ItemButtonTemplate ]
			Func = "GetNormalTexture",
			Key = (WOW_RETAIL and "NormalTexture") or nil,
			Name = "NormalTexture",
			Type = "Texture",
			CanHide = true,
		},
	},
	Disabled = { -- [ Button ]
		Func = "GetDisabledTexture",
		Type = "Texture",
		CanHide = true,
		Hide = true,
		Iterate = true,
	},
	Pushed = { -- [ Button, ActionButtonTemplate ]
		Func = "GetPushedTexture",
		Key = "PushedTexture",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
		Item = { -- [ ItemButtonTemplate ]
			Func = "GetPushedTexture",
			Key = (WOW_RETAIL and "PushedTexture") or nil,
			Type = "Texture",
			CanMask = true,
			Iterate = true,
			UseColor = true,
		},
	},
	Checked = { -- [ CheckButton, ActionButtonTemplate ]
		Func = "GetCheckedTexture",
		Key = "CheckedTexture",
		Type = "Texture",
		Iterate = true,
	},

	-- [ ARTWORK, 1 ]

	Flash = { -- [ ActionButtonTemplate ]
		Key = "Flash",
		Name = "Flash",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
		Item = { -- [ ItemButtonTemplate ][TEST]
			Key = "flash",
			Type = "Texture",
			CanMask = true,
			Iterate = true,
			UseColor = true,
		},
	},

	-- [ OVERLAY, 0 ]

	Border = { -- [ ActionButtonTemplate ]
		Key = "Border",
		Name = "Border",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
		Aura = { -- [ Fallback, Unused Natively ]
			Key = "Border",
			Name = "Border",
			Type = "Texture",
			Iterate = true,
			NoColor = true,
		},
	},
	DebuffBorder = { -- [ AuraButtonArtTemplate ]
		Key = "DebuffBorder",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
	},
	EnchantBorder = { -- [ AuraButtonArtTemplate ]
		Key = "TempEnchantBorder",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
	},
	IconBorder = { -- [ ItemButtonTemplate ]
		Key = "IconBorder",
		Type = "Texture",
		NoColor = true,
	},

	-- [ OVERLAY, 1 ]

	NewAction = { -- [ ActionButtonTemplate ]
		Key = "NewActionTexture",
		Type = "Texture",
		Iterate = true,
	},
	SpellHighlight = { -- [ ActionButtonTemplate ]
		Key = "SpellHighlightTexture",
		Type = "Texture",
		Iterate = true,
	},
	IconOverlay = { -- [ ItemButtonTemplate ]
		Key = "IconOverlay",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
		NoTexture = true,
	},
	UpgradeIcon = { -- [ ContainerFrameItemButtonTemplate ]
		Key = "UpgradeIcon",
		Type = "Texture",
		Iterate = true,
	},
	Gloss = { -- [ Custom ]
		Ignore = true,
		CanHide = true,
	},

	IconOverlay2 = { -- [ ItemButtonTemplate ][ RETAIL_ONLY ]
		Key = "IconOverlay2",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
		NoTexture = true,
	},
	NewItem = { -- [ ContainerFrameItemButtonTemplate ]
		Key = "NewItemTexture",
		Type = "Texture",
		NoColor = true,
	},
	QuestBorder = { -- [ ContainerFrameItemButtonTemplate ]
		Key = (WOW_RETAIL and "IconQuestTexture") or nil,
		Name = "IconQuestTexture",
		Type = "Texture",
	},

	-- [ OVERLAY, 4 ]

	SearchOverlay = { -- [ ItemButtonTemplate ]
		Key = "searchOverlay",
		Name = "SearchOverlay",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
	},

	-- [ OVERLAY, 5 ]

	ContextOverlay = { -- [ ItemButtonTemplate ][ RETAIL_ONLY ]
		Key = "ItemContextOverlay",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
	},
	JunkIcon = { -- [ ContainerFrameItemButtonTemplate ]
		Key = "JunkIcon",
		Type = "Texture",
		Iterate = true,
	},

	-- [ OVERLAY, 6 ]

	SlotHighlight = { -- [ ItemButton, BaseBagSlotButtonTemplate ][ RETAIL_ONLY ]
		Key = "SlotHighlightTexture",
		Type = "Texture",
		Iterate = true,
	},

	-- [ OVERLAY, Text ]

	Name = { -- [ ActionButtonTemplate ]
		Key = "Name",
		Name = "Name",
		Type = "FontString",
		Iterate = true,
		NoColor = true,
	},

	-- [ HIGHLIGHT, 0 ]

	Highlight = { -- [ Button, ActionButtonTemplate ]
		Func = "GetHighlightTexture",
		Key = "HighlightTexture",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
		Item = {
			Func = "GetHighlightTexture",
			Key = (WOW_RETAIL and "HighlightTexture") or nil,
			Type = "Texture",
			CanMask = true,
			Iterate = true,
			UseColor = true,
		},
	},

	-- [ TextOverlayContainer ]

	Count = { -- [ ActionButtonTemplate, ItemButtonTemplate ]
		Key = "Count",
		Name = "Count",
		Type = "FontString",
		Iterate = true,
		NoColor = true,
		Aura = { -- [ AuraButtonArtTemplate ]
			Key = "Count",
			Type = "FontString",
			Iterate = true,
			NoColor = true,
		},
	},
	HotKey = { -- [ ActionButtonTemplate ]
		Key = "HotKey",
		Name = "HotKey",
		Type = "FontString",
		Iterate = true,
		NoColor = true,
	},

	-- [ AutoCastOverlay ]

	-- AutoCast (Classic)
	AutoCastable = { -- [ ActionButtonTemplate ][DEPRECATED]
		Key = "AutoCastable",
		Type = "Texture",
		Iterate = true,
	},
	AutoCastShine = { -- [ ActionButtonTemplate ][DEPRECATED]
		--Key = "AutoCastShine", -- Causes issues with Pet bars.
		Name = "Shine",
		Type = "Frame",
	},

	-- AutoCast (Retail)
	AutoCast_Frame = { -- [ AutoCastOverlayTemplate ]
		Key = "AutoCastOverlay",
		Type = "Frame",
	},
	AutoCast_Shine = { -- [ AutoCastOverlayTemplate ][ RETAIL_ONLY ]
		Key = "Shine",
		Parent = "AutoCastOverlay",
		Type = "Texture",
	},
	AutoCast_Mask = { -- [ AutoCastOverlayTemplate ][ RETAIL_ONLY ]
		Key = "Shine",
		Parent = "AutoCastOverlay",
		Type = "Texture",
	},
	AutoCast_Corners = { -- [ AutoCastOverlayTemplate ]
		Key = "Shine",
		Parent = "AutoCastOverlay",
		Type = "Texture",
	},

	-- [ Cooldowns ]

	Cooldown = {
		Key = "cooldown",
		Name = "Cooldown",
		Type = "Cooldown",
		Item = {
			Key = (WOW_RETAIL and "Cooldown") or nil,
			Name = "Cooldown",
			Type = "Cooldown",
		},
	},
	CooldownLoC = {
		Key = "lossOfControlCooldown",
		Type = "Cooldown",
	},
	ChargeCooldown = {
		Key = "chargeCooldown",
		Type = "Cooldown",
	},
}

----------------------------------------
-- Action Button Configuration
---

local actionConfig = {
	Backdrop = baseConfig.Backdrop,
	Icon = baseConfig.Icon,
	Normal = baseConfig.Normal,
	Disabled = baseConfig.Disabled, -- Unused
	Pushed = baseConfig.Pushed,
	Checked = baseConfig.Checked,
	Flash = baseConfig.Flash,
	Border = baseConfig.Border,
	NewAction = baseConfig.NewAction,
	SpellHighlight = baseConfig.SpellHighlight,
	Name = baseConfig.Name,
	Highlight = baseConfig.Highlight,
	Count = baseConfig.Count,
	HotKey = baseConfig.HotKey,
	AutoCastable = baseConfig.AutoCastable,
	AutoCastShine = baseConfig.AutoCastShine,
	AutoCast_Frame = baseConfig.AutoCast_Frame,
	AutoCast_Shine = baseConfig.AutoCast_Shine,
	AutoCast_Mask = baseConfig.AutoCast_Mask,
	AutoCast_Corners = baseConfig.AutoCast_Corners,
	Cooldown = baseConfig.Cooldown,
	CooldownLoC = baseConfig.CooldownLoC,
	ChargeCooldown = baseConfig.ChargeCooldown,
}

----------------------------------------
-- Aura Button Configuration
---

local auraConfig = {
	Icon = baseConfig.Icon.Aura,
	Duration = baseConfig.Duration,
	Normal = baseConfig.Normal, -- Unused
	Disabled = baseConfig.Disabled, -- Unused
	Pushed = baseConfig.Pushed, -- Unused
	Border = baseConfig.Border.Aura,
	DebuffBorder = baseConfig.DebuffBorder,
	EnchantBorder = baseConfig.EnchantBorder,
	Highlight = baseConfig.Highlight, -- Unused
	Count = baseConfig.Count.Aura,
	Cooldown = baseConfig.Cooldown,
	ChargeCooldown = baseConfig.ChargeCooldown,
}

----------------------------------------
-- Item Button Configuration
---

local itemConfig = {
	Icon = baseConfig.Icon,
	Normal = baseConfig.Normal.Item,
	Disabled = baseConfig.Disabled,
	Pushed = baseConfig.Pushed.Item,
	Checked = baseConfig.Checked, -- Classic Bag Buttons
	Border = baseConfig.Border, -- Backwards-Compatibility
	IconBorder = baseConfig.IconBorder,
	IconOverlay = baseConfig.IconOverlay,
	UpgradeIcon = baseConfig.UpgradeIcon,
	IconOverlay2 = (WOW_RETAIL and baseConfig.IconOverlay2) or nil, -- Retail Only
	NewItem = baseConfig.NewItem,
	QuestBorder = baseConfig.QuestBorder,
	SearchOverlay = baseConfig.SearchOverlay,
	ContextOverlay = (WOW_RETAIL and baseConfig.ContextOverlay) or nil, -- Retail Only
	JunkIcon = baseConfig.JunkIcon,
	SlotHighlight = (WOW_RETAIL and baseConfig.SlotHighlight) or nil, -- Retail Only
	Highlight = baseConfig.Highlight.Item,
	Count = baseConfig.Count,
	Cooldown = baseConfig.Cooldown.Item,
	ChargeCooldown = baseConfig.ChargeCooldown,
}

----------------------------------------
-- Types Tables
---

-- Registered Types
local typeConfig = {
	-- Base
	Default = baseConfig,
	-- Action
	Action = actionConfig,
	Pet = actionConfig,
	Possess = actionConfig,
	Stance = actionConfig,
	-- Aura
	Aura = auraConfig,
	Buff = auraConfig,
	Debuff = auraConfig,
	Enchant = auraConfig,
	-- Item
	Backpack = itemConfig,
	BagSlot = itemConfig,
	Item = itemConfig,
	KeyRing = itemConfig,
	ReagentBag = itemConfig,
}

-- Base Types
local isBaseType = {
	Action = true,
	Aura = true,
	Item = true,
}

-- Empty Types
local isEmptyType = {
	Action = true,
	BagSlot = true,
	Item = true,
	Pet = true,
	ReagentBag = true,
}

-- Custom Types
local isCustomType = {}

-- Unspecified Base Types
local isDefaultType = {}

-- Type Validation
local isType = {
	Action = {
		Action = true,
		Pet = true,
		Possess = true,
		Stance = true,
	},
	Aura = {
		Aura = true,
		Buff = true,
		Debuff = true,
		Enchant = true,
	},
	Item = {
		Backpack = true,
		BagSlot = true,
		Item = true,
		KeyRing = true,
		ReagentBag = true,
	},
}

----------------------------------------
-- Core
---

Core.TypeConfig = typeConfig

Core.isBaseType = isBaseType
Core.isActionType = isType.Action
Core.isAuraType = isType.Aura
Core.isItemType = isType.Item

Core.isEmptyType = isEmptyType
Core.isCustomType = isCustomType
Core.isDefaultType = isDefaultType

----------------------------------------
-- API
---

-- Adds a custom button type.
-- * `Name` must be a unique string.
-- * `List` must be an indexed table of string region names.
-- * `BaseType` must be "Action", "Aura", "Item" or nil.
function Core.API:AddType(Name, List, BaseType)
	if type(Name) ~= "string" or typeConfig[Name] then
		if Core.Debug then
			error("Bad argument to API method 'AddType'. 'Name' must be a unique string.", 2)
		end
		return

	elseif type(List) ~= "table" or #List < 1 then
		if Core.Debug then
			error("Bad argument to API method 'AddType'. 'List' must be an indexed table.", 2)
		end
		return

	elseif BaseType then
		if type(BaseType) ~= "string" then
			if Core.Debug then
				error("Bad argument to API method 'AddType'. 'BaseType' must be a string.", 2)
			end
			return

		elseif not isBaseType[BaseType] then
			if Core.Debug then
				error("Bad argument to API method 'AddType'. 'BaseType' must be a valid type.", 2)
			end
			return
		end
	end

	local cache = {}

	for i = 1, #List do
		local key = List[i]
		local base = baseConfig[key]

		if base then
			cache[key] = (BaseType and base[BaseType]) or base
		end
	end

	typeConfig[Name] = cache
	isCustomType[Name] = true

	if BaseType then
		local typeList = isType[BaseType]

		typeList[Name] = true
		isEmptyType[Name] = isEmptyType[BaseType]
	else
		isDefaultType[Name] = true
	end
end
