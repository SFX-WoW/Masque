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
	Backdrop = { -- [ ActionButtonTemplate / Custom ][ BACKGROUND, -1 ]
		Name = "FloatingBG",
		Type = "Texture",
		CanHide = true,
		CanMask = true,
		UseColor = true,
	},
	Icon = { -- [ ActionButtonTemplate ][ BACKGROUND, 0 ]
		Key = "icon",
		Name = "Icon",
		Type = "Texture",
		CanMask = true,
		NoColor = true,
		NoTexture = true,
		Aura = { -- [ AuraButtonArtTemplate / AuraButtonTemplate ][ BACKGROUND, 0 ]
			Key = (WOW_RETAIL and "Icon") or nil, -- Retail Only
			Name = "Icon",
			Type = "Texture",
			CanMask = true,
			NoColor = true,
			NoTexture = true,
		},
		Item = { -- [ ItemButtonTemplate ][ BORDER, 0 ]
			Key = "icon",
			Name = "IconTexture",
			Type = "Texture",
			CanMask = true,
			NoColor = true,
			NoTexture = true,
		},
	},
	Shadow = { -- [ Custom ][ ARTWORK, -1 ]
		CanHide = true,
		Ignore = true,
	},
	Normal = { -- [ Button ][ ARTWORK, 0 ]
		Func = "GetNormalTexture",
		--Key = "NormalTexture", -- Conflicts with some add-ons and button types.
		Name = "NormalTexture",
		Type = "Texture",
		CanHide = true,
	},
	Disabled = { -- [ Button ][ ARTWORK, 0 ]
		Func = "GetDisabledTexture",
		Type = "Texture",
		CanHide = true,
		Hide = true,
		Iterate = true,
	},
	Pushed = { -- [ Button ][ ARTWORK, 0 ]
		Func = "GetPushedTexture",
		Key = (WOW_RETAIL and "PushedTexture") or nil,
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
	},
	Flash = { -- [ ActionButtonTemplate ][ ARTWORK, 1 ]
		-- Key = "Flash", -- Conflicts with item buttons.
		Name = "Flash",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
	},
	Checked = { -- [ CheckButton ][ ARTWORK, 0 ]
		Func = "GetCheckedTexture",
		Key = (WOW_RETAIL and "CheckedTexture") or nil,
		Type = "Texture",
		Iterate = true,
	},
	SlotHighlight = { -- [ BaseBagSlotButtonTemplate ][ OVERLAY, 6 ][ RETAIL_ONLY ]
		Key = "SlotHighlightTexture",
		Type = "Texture",
		Iterate = true,
	},
	Border = { -- [ ActionButtonTemplate ][ OVERLAY, 0 ]
		Key = "Border",
		Name = "Border",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
		Aura = { -- [ Fallback ][ OVERLAY, 0 ]
			Name = "Border",
			Type = "Texture",
			Iterate = true,
			NoColor = true,
		},
		Debuff = { -- [ DebuffButtonTemplate ][ OVERLAY, 0 ][ CLASSIC_ONLY ]
			Name = "Border",
			Type = "Texture",
			Iterate = true,
			NoColor = true,
		},
		Enchant = { -- [ TempEnchantButtonTemplate ][ OVERLAY, 0 ][ CLASSIC_ONLY ]
			Name = "Border",
			Type = "Texture",
			Iterate = true,
			NoColor = true,
		},
	},
	DebuffBorder = { -- [ AuraButtonArtTemplate ][ OVERLAY, 0 ][ RETAIL_ONLY ]
		Key = "DebuffBorder",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
	},
	EnchantBorder = { -- [ AuraButtonArtTemplate ][ OVERLAY, 0 ][ RETAIL_ONLY ]
		Key = "TempEnchantBorder",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
	},
	IconBorder = { -- [ ItemButtonTemplate ][ OVERLAY, 0 ]
		Key = "IconBorder",
		Type = "Texture",
		NoColor = true,
	},
	Gloss = { -- [ Custom ][ OVERLAY, 1 ]
		Ignore = true,
		CanHide = true,
	},
	NewAction = { -- [ ActionButtonTemplate ][ OVERLAY, 1 ]
		Key = "NewActionTexture",
		Type = "Texture",
		Iterate = true,
	},
	SpellHighlight = { -- [ ActionButtonTemplate ][ OVERLAY, 1 ]
		Key = "SpellHighlightTexture",
		Type = "Texture",
		Iterate = true,
	},
	IconOverlay = { -- [ ItemButtonTemplate ][ OVERLAY, 1 ]
		Key = "IconOverlay",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
		NoTexture = true,
	},
	IconOverlay2 = { -- [ ItemButtonTemplate ][ OVERLAY, 2 ][ RETAIL_ONLY ]
		Key = "IconOverlay2",
		Type = "Texture",
		Iterate = true,
		NoColor = true,
		NoTexture = true,
	},
	NewItem = { -- [ ContainerFrameItemButtonTemplate ][ OVERLAY, 2 ]
		Key = "NewItemTexture",
		Type = "Texture",
		NoColor = true,
	},
	QuestBorder = { -- [ ContainerFrameItemButtonTemplate ][ OVERLAY, 2 ]
		Key = (WOW_RETAIL and "IconQuestTexture") or nil,
		Name = "IconQuestTexture",
		Type = "Texture",
	},
	UpgradeIcon = { -- [ ContainerFrameItemButtonTemplate ][ OVERLAY, 1 ]
		Key = "UpgradeIcon",
		Type = "Texture",
		Iterate = true,
	},
	ContextOverlay = { -- [ ItemButtonTemplate ][ OVERLAY, 5 ][ RETAIL_ONLY ]
		Key = "ItemContextOverlay",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
	},
	SearchOverlay = { -- [ ItemButtonTemplate ][ OVERLAY, 4 ]
		Key = "searchOverlay",
		Name = "SearchOverlay",
		Type = "Texture",
		CanMask = true,
		Iterate = true,
		UseColor = true,
	},
	JunkIcon = { -- [ ContainerFrameItemButtonTemplate ][ OVERLAY, 5/1 ]
		Key = "JunkIcon",
		Type = "Texture",
		Iterate = true,
	},
	Duration = { -- [ AuraButtonArtTemplate / AuraButtonTemplate ][ BACKGROUND ]
		Key = (WOW_RETAIL and "Duration") or "duration",
		Name = (WOW_CLASSIC and "Duration") or nil,
		Type = "FontString",
		Iterate = true,
		NoColor = true,
	},
	Name = { -- [ ActionButtonTemplate ][ OVERLAY ]
		Key = "Name",
		Name = "Name",
		Type = "FontString",
		Iterate = true,
		NoColor = true,
	},
	Highlight = { -- [ Button ][ HIGHLIGHT, 0 ]
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
	-- [ TextOverlayContainer ]
	Count = { -- [ ActionButtonTemplate ][ OVERLAY / ARTWORK ]
		Key = "Count",
		Name = "Count",
		Type = "FontString",
		Iterate = true,
		NoColor = true,
		Aura = { -- [ AuraButtonArtTemplate/AuraButtonTemplate ][ BACKGROUND ]
			Key = (WOW_RETAIL and "Count") or "count",
			Name = (WOW_CLASSIC and "Count") or nil,
			Type = "FontString",
			Iterate = true,
			NoColor = true,
		},
		Item = { -- [ ItemButtonTemplate ][ ARTWORK ]
			Key = "Count",
			Name = "Count",
			Type = "FontString",
			Iterate = true,
			NoColor = true,
		},
	},
	HotKey = { -- [ ActionButtonTemplate ][ OVERLAY / ARTWORK ]
		Key = "HotKey",
		Name = "HotKey",
		Type = "FontString",
		Iterate = true,
		NoColor = true,
	},
	-- [ AutoCast (Classic) ]
	AutoCastable = { -- [ ActionButtonTemplate ][ OVERLAY, 1 ]
		Key = "AutoCastable",
		Type = "Texture",
		Iterate = true,
	},
	AutoCastShine = { -- [ ActionButtonTemplate ]
		--Key = "AutoCastShine", -- Causes issues with Pet bars.
		Name = "Shine",
		Type = "Frame",
	},
	-- [ AutoCast (Retail) ]
	AutoCast_Frame = { -- [ AutoCastOverlayTemplate ]
		Key = "AutoCastOverlay",
		Type = "Frame",
	},
	AutoCast_Shine = { -- [ AutoCastOverlayTemplate ][ OVERLAY, 0 ]
		Key = "Shine",
		Parent = "AutoCastOverlay",
		Type = "Texture",
	},
	AutoCast_Mask = { -- [ AutoCastOverlayTemplate ]
		Key = "Shine",
		Parent = "AutoCastOverlay",
		Type = "Texture",
	},
	AutoCast_Corners = { -- [ AutoCastOverlayTemplate ][ OVERLAY, 1 ]
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
