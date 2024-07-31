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
	-- [[ BACKGROUND, -1 ]]

	-- [CLASSIC_ONLY]
	-- Only used on MultiBar buttons.
	Backdrop = {
		Name = "FloatingBG",
		Type = "Texture",
		CanHide = true,
		CanMask = true,
		UseColor = true,
	},

	-- [[ BACKGROUND, 0 ]]

	Icon = {
		Key = "icon",
		Name = "Icon",
		Type = "Texture",
		CanMask = true,
		NoColor = true,
		NoTexture = true,
		Aura = {
			Key = (WOW_RETAIL and "Icon") or nil, -- Retail Only
			Name = "Icon",
			Type = "Texture",
			CanMask = true,
			NoColor = true,
			NoTexture = true,
		},
		-- ItemButton: BORDER, 0
		Item = {
			Key = "icon",
			Name = "IconTexture",
			Type = "Texture",
			CanMask = true,
			NoColor = true,
			NoTexture = true,
		},
	},
	--[RETAIL_ONLY, UNSUPPORTED]
	-- Handled in the region file.
	-- IconMask = nil,
	--[RETAIL_ONLY, UNSUPPORTED]
	-- Handled in the button file.
	-- SlotArt = nil,
	--[RETAIL_ONLY, UNSUPPORTED]
	-- Handled in the button file.
	-- SlotBackground = nil,
	--[CUSTOM, RETAIL_ONLY]
	SlotIcon = {
		CanHide = true,
		CanMask = true,
		Ignore = true,
	},

	-- [[ ARTWORK, -1 ]]

	--[CUSTOM]
	Shadow = {
		CanHide = true,
		Ignore = true,
	},

	-- [[ ARTWORK, 0 ]]

	Normal = {
		Func = "GetNormalTexture",
		--Key = "NormalTexture", -- Conflicts with some add-ons and button types.
		Name = "NormalTexture",
		Type = "Texture",
		CanHide = true,
	},
	Disabled = {
		Func = "GetDisabledTexture",
		Type = "Texture",
		CanHide = true,
		Hide = true,
		Iterate = true,
	},
	Pushed = {
		Func = "GetPushedTexture",
		Key = (WOW_RETAIL and "PushedTexture") or nil,
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
	},

	-- [[ ARTWORK, 1 ]]

	-- [Retail]
	-- ExtraActionButtonTemplate: OVERLAY, 0
	Flash = {
		-- Key = "Flash", -- Conflicts with item buttons.
		Name = "Flash",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
	},
	-- [UNSUPPORTED]
	-- FlyoutBorder = nil, --[?]
	-- [UNSUPPORTED]
	-- FlyoutBorderShadow = nil,

	-- [[ ARTWORK, 2 ]]

	-- [UNSUPPORTED]
	-- FlyoutArrow = nil, --[?]

	-- [[ ARTWORK, * ]]

	-- AuraButtonArtTemplate: BACKGROUND
	Duration = {
		Key = (WOW_RETAIL and "Duration") or "duration",
		Name = (WOW_CLASSIC and "Duration") or nil,
		Type = "FontString",
		Iterate = true,
		NoColor = true,
	},

	-- [[ OVERLAY, 0 ]]

	Checked = {
		Func = "GetCheckedTexture",
		Key = (WOW_RETAIL and "CheckedTexture") or nil,
		Type = "Texture",
		Iterate = true,
	},
	-- [Retail]
	-- BaseBagSlotButtonTemplate: OVERLAY, 6
	SlotHighlight = {
		Key = "SlotHighlightTexture",
		Type = "Texture",
		Iterate = true,
	},
	Border = {
		Key = "Border",
		Name = "Border",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
		Aura = {
			Name = "Border",
			Type = "Texture",
			Iterate = true,
			NoColor = true,
		},
		-- [CLASSIC_ONLY]
		Debuff = {
			Name = "Border",
			Type = "Texture",
			Iterate = true,
			NoColor = true,
		},
		-- [CLASSIC_ONLY]
		Enchant = {
			Name = "Border",
			Type = "Texture",
			Iterate = true,
			NoColor = true,
		},
	},
	-- [RETAIL_ONLY]
	DebuffBorder = {
		Key = "DebuffBorder",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
	},
	-- [RETAIL_ONLY]
	EnchantBorder = {
		Key = "TempEnchantBorder",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
	},
	IconBorder = {
		Key = "IconBorder",
		Type = "Texture",
		NoColor = true,
	},

	-- [[ OVERLAY, 1 ]]

	--[CUSTOM]
	Gloss = {
		Ignore = true,
		CanHide = true,
	},
	NewAction = {
		Key = "NewActionTexture",
		Type = "Texture",
		Iterate = true,
	},
	-- [Retail]
	-- PetActionButtonTemplate: OVERLAY, 0
	SpellHighlight = {
		Key = "SpellHighlightTexture",
		Type = "Texture",
		Iterate = true,
	},
	-- [UNSUPPORTED]
	-- LevelLinkLockIcon = nil,
	-- [CLASSIC_ONLY]
	-- Only used by Pet buttons.
	AutoCastable = {
		Key = "AutoCastable",
		Type = "Texture",
		Iterate = true,
	},
	IconOverlay = {
		Key = "IconOverlay",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
		NoTexture = true,
	},
	UpgradeIcon = {
		Key = "UpgradeIcon",
		Type = "Texture",
		Iterate = true,
	},

	-- [[ OVERLAY, 2 ]]

	QuestBorder = {
		Key = (WOW_RETAIL and "IconQuestTexture") or nil,
		Name = "IconQuestTexture",
		Type = "Texture",
	},
	NewItem = {
		Key = "NewItemTexture",
		Type = "Texture",
		NoColor = true,
	},
	-- [RETAIL_ONLY]
	IconOverlay2 = {
		Key = "IconOverlay2",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
		NoTexture = true,
	},

	-- [[ OVERLAY, 4 ]]

	SearchOverlay = {
		Key = "searchOverlay",
		Name = "SearchOverlay",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
	},

	-- [[ OVERLAY, 5 ]]

	JunkIcon = {
		Key = "JunkIcon",
		Type = "Texture",
		Iterate = true,
	},
	-- [RETAIL_ONLY]
	ContextOverlay = {
		Key = "ItemContextOverlay",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
	},

	-- [[ OVERLAY, * ]]

	Name = {
		Key = "Name",
		Name = "Name",
		Type = "FontString",
		Iterate = true,
		NoColor = true,
	},

	-- [[ HIGHLIGHT, 0 ]]

	Highlight = {
		Key = (WOW_RETAIL and "HighlightTexture") or nil,
		Func = "GetHighlightTexture",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
		Item = {
			Func = "GetHighlightTexture",
			Type = "Texture",
			CanMask = true,
			Iterate = true,
			UseColor = true,
		},
	},

	-- [[ FRAMES ]]

	-- [ Cooldown ]

	Cooldown = {
		Key = "cooldown",
		Name = "Cooldown",
		Type = "Cooldown",
		Item = {
			Name = "Cooldown",
			Type = "Cooldown",
		},
	},
	ChargeCooldown = {
		Key = "chargeCooldown",
		Type = "Cooldown",
	},

	-- [ AutoCastOverlay ][RETAIL_ONLY]
	-- Only used by Pet buttons.

	AutoCast_Frame = {
		Key = "AutoCastOverlay",
		Type = "Frame",
	},
	AutoCast_Shine = {
		Key = "Shine",
		Parent = "AutoCastOverlay",
		Type = "Texture",
	},
	AutoCast_Mask = {
		Key = "Shine",
		Parent = "AutoCastOverlay",
		Type = "Texture",
	},
	AutoCast_Corners = {
		Key = "Shine",
		Parent = "AutoCastOverlay",
		Type = "Texture",
	},

	-- [ AutoCastShine][CLASSIC_ONLY]
	-- Only used by Pet buttons.

	AutoCastShine = {
		--Key = "AutoCastShine", -- Causes issues with Pet bars.
		Name = "Shine",
		Type = "Frame",
	},

	-- [ TextOverlayContainer ][RETAIL_ONLY]

	-- [[ OVERLAY, 0 ]]

	-- [Retail]
	-- ExtraActionButtonTemplate: ARTWORK
	-- [Classic]
	-- ActionButtonTemplate: ARTWORK
	HotKey = {
		Key = "HotKey",
		Name = "HotKey",
		Type = "FontString",
		Iterate = true,
		NoColor = true,
	},
	-- [Classic]
	-- ActionButtonTemplate: ARTWORK
	Count = {
		Key = "Count",
		Name = "Count",
		Type = "FontString",
		Iterate = true,
		NoColor = true,
		-- AuraButtonArtTemplate: BACKGROUND
		Aura = {
			Key = (WOW_RETAIL and "Count") or "count",
			Name = (WOW_CLASSIC and "Count") or nil,
			Type = "FontString",
			Iterate = true,
			NoColor = true,
		},
		-- ItemButtonTemplate: ARTWORK
		Item = {
			Key = "count",
			Name = "Count",
			Type = "FontString",
			Iterate = true,
			NoColor = true,
		},
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
	Pet = true,
	ReagentBag = true,
	Item = true,
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
	ReagentBag = true,
}

----------------------------------------
-- API
---

-- Adds a custom button type.
function Core.API:AddType(Name, List, Type)
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
	elseif Type and type(Type) ~= "string" then
		if Core.Debug then
			error("Bad argument to API method 'AddType'. 'Type' must be a string.", 2)
		end
		return
	end

	local Cache = {}

	for i = 1, #List do
		local Key = List[i]
		local Root = Legacy[Key]

		if Root then
			Cache[Key] = (Type and Root[Type]) or Root
		end
	end

	Types[Name] = Cache

	if Type then
		if BaseTypes[Type] then
			local TypeList = Core[Type.."Types"]
			TypeList[Name] = true
		end

		EmptyTypes[Name] = EmptyTypes[Type]
	end
end
