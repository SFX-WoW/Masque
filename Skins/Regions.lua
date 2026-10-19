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

local Legacy = {
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

	Count = { -- [ ActionButtonTemplate ]
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
		Item = { -- [ ItemButtonTemplate ]
			Key = "Count",
			Name = "Count",
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
-- "Action" Types
---

local Action = {
	Backdrop = Legacy.Backdrop,
	Icon = Legacy.Icon,
	Normal = Legacy.Normal,
	Disabled = Legacy.Disabled, -- Unused
	Pushed = Legacy.Pushed,
	Flash = Legacy.Flash,
	HotKey = Legacy.HotKey,
	Count = Legacy.Count,
	Checked = Legacy.Checked,
	Border = Legacy.Border,
	AutoCastable = Legacy.AutoCastable,
	NewAction = Legacy.NewAction,
	SpellHighlight = Legacy.SpellHighlight,
	Name = Legacy.Name,
	Highlight = Legacy.Highlight,
	AutoCast_Frame = Legacy.AutoCast_Frame,
	AutoCast_Shine = Legacy.AutoCast_Shine,
	AutoCast_Mask = Legacy.AutoCast_Mask,
	AutoCast_Corners = Legacy.AutoCast_Corners,
	AutoCastShine = Legacy.AutoCastShine,
	Cooldown = Legacy.Cooldown,
	CooldownLoC = Legacy.CooldownLoC,
	ChargeCooldown = Legacy.ChargeCooldown,
}

----------------------------------------
-- "Aura" Types
---

local Aura = {
	Icon = Legacy.Icon.Aura,
	Normal = Legacy.Normal, -- Unused
	Disabled = Legacy.Disabled, -- Unused
	Pushed = Legacy.Pushed, -- Unused
	Count = Legacy.Count.Aura,
	Duration = Legacy.Duration,
	Border = Legacy.Border.Aura,
	DebuffBorder = (WOW_RETAIL and Legacy.DebuffBorder) or nil, -- Retail Only
	EnchantBorder = (WOW_RETAIL and Legacy.EnchantBorder) or nil, -- Retail Only
	Highlight = Legacy.Highlight, -- Unused
	Cooldown = Legacy.Cooldown,
	ChargeCooldown = Legacy.ChargeCooldown,
}

local Debuff = {
	Icon = Legacy.Icon.Aura,
	Normal = Legacy.Normal, -- Unused
	Disabled = Legacy.Disabled, -- Unused
	Pushed = Legacy.Pushed, -- Unused
	Count = Legacy.Count.Aura,
	Duration = Legacy.Duration,
	Border = Legacy.Border.Debuff,
	DebuffBorder = (WOW_RETAIL and Legacy.DebuffBorder) or nil, -- Retail Only
	Highlight = Legacy.Highlight, -- Unused
	Cooldown = Legacy.Cooldown,
	ChargeCooldown = Legacy.ChargeCooldown,
}

local Enchant = {
	Icon = Legacy.Icon.Aura,
	Normal = Legacy.Normal, -- Unused
	Disabled = Legacy.Disabled, -- Unused
	Pushed = Legacy.Pushed, -- Unused
	Count = Legacy.Count.Aura,
	Duration = Legacy.Duration,
	Border = Legacy.Border.Enchant,
	EnchantBorder = (WOW_RETAIL and Legacy.EnchantBorder) or nil, -- Retail Only
	Highlight = Legacy.Highlight, -- Unused
	Cooldown = Legacy.Cooldown,
	ChargeCooldown = Legacy.ChargeCooldown,
}

----------------------------------------
-- "Item" Types
---

local Item = {
	Icon = Legacy.Icon,
	Normal = Legacy.Normal,
	Disabled = Legacy.Disabled,
	Pushed = Legacy.Pushed,
	Count = Legacy.Count,
	Checked = Legacy.Checked, -- Some ItemButtons are CheckButtons
	Border = Legacy.Border, -- Backwards-Compatibility
	IconBorder = Legacy.IconBorder,
	SlotHighlight = (WOW_RETAIL and Legacy.SlotHighlight) or nil, -- Retail Only
	UpgradeIcon = Legacy.UpgradeIcon,
	IconOverlay = Legacy.IconOverlay,
	IconOverlay2 = (WOW_RETAIL and Legacy.IconOverlay2) or nil, -- Retail Only
	QuestBorder = Legacy.QuestBorder,
	NewItem = Legacy.NewItem,
	SearchOverlay = Legacy.SearchOverlay,
	ContextOverlay = (WOW_RETAIL and Legacy.ContextOverlay) or nil, -- Retail Only
	JunkIcon = Legacy.JunkIcon,
	Highlight = Legacy.Highlight.Item,
	Cooldown = Legacy.Cooldown.Item,
	ChargeCooldown = Legacy.ChargeCooldown,
}

----------------------------------------
-- Types Tables
---

local Types = {
	Legacy = Legacy,
	Action = Action,
	Aura = Aura,
	Backpack = Item,
	BagSlot = Item,
	Buff = Aura,
	Debuff = Debuff,
	Enchant = Enchant,
	Item = Item,
	KeyRing = Item,
	Pet = Action,
	Possess = Action,
	ReagentBag = Item,
	Stance = Action,
}

local BaseTypes = {
	Action = true,
	Aura = true,
	Item = true,
}

local EmptyTypes = {
	Action = true,
	BagSlot = true,
	Item = true,
	Pet = true,
	ReagentBag = true,
}

----------------------------------------
-- Core
---

Core.RegTypes = Types
Core.BaseTypes = BaseTypes
Core.EmptyTypes = EmptyTypes

Core.ActionTypes = {
	Action = true,
	Pet = true,
	Possess = true,
	Stance = true,
}
Core.AuraTypes = {
	Aura = true,
	Buff = true,
	Debuff = true,
	Enchant = true,
}
Core.ItemTypes = {
	Backpack = true,
	BagSlot = true,
	Item = true,
	KeyRing = true,
	ReagentBag = true,
}

----------------------------------------
-- API
---

-- Adds a custom button type.
-- * `Name` must be a unique string.
-- * `List` must be an indexed table of string region names.
-- * `BaseType` must be "Action", "Aura", "Item" or nil.
function Core.API:AddType(Name, List, BaseType)
	if type(Name) ~= "string" or Types[Name] then
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

		elseif not BaseTypes[BaseType] then
			if Core.Debug then
				error("Bad argument to API method 'AddType'. 'BaseType' must be a valid type.", 2)
			end
			return
		end
	end

	local cache = {}

	for i = 1, #List do
		local key = List[i]
		local base = Legacy[key]

		if base then
			cache[key] = (BaseType and base[BaseType]) or base
		end
	end

	Types[Name] = cache

	if BaseType then
		if BaseTypes[BaseType] then
			local typeList = Core[BaseType.."Types"]
			typeList[Name] = true
		end

		EmptyTypes[Name] = EmptyTypes[BaseType]
	end
end
