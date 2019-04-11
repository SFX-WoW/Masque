--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Skins\Regions.lua
	* Author.: StormFX

	Region Defaults

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Region Defaults
-- * A list of default values for regions when not specified by a skin.
---

do
	-- * Color -> Defaults to {1, 1, 1, 1}
	-- * BlendMode -> Defaults to "BLEND"
	-- * Point -> Defaults to "CENTER"
	-- * RelPoint -> Defaults to Point
	-- * OffsetX, OffsetY -> Default to 0

	-- * UseColor -> Use :SetColorTexture() if a color but no texture is provided.
	-- * Hide -> Region will be hidden if it exists.
	-- * CanHide -> Allow the region to be hidden.
	-- * NoColor -> Do not allow color changes.
	-- * NoTexture -> Do not allow texture changes.

	-- * Type -> Must match the game's internal type, for validation.
	-- * Ignore -> Ignore when looking for regions.
	-- * Iterate -> Include in iteration.

	-- * Regions with dedicated functions have their settings hard-coded, so are commented out.

	local Regions = {
		Backdrop = {
			Name = "FloatingBG",
			Type = "Texture",

			-- Texture = [[Interface\Buttons\UI-Quickslot]],
			-- Color = {1, 1, 1, 0.6},
			-- DrawLayer = "BACKGROUND",
			-- DrawLevel = -1,

			CanHide = true,
			-- UseColor = true,
		},
		Icon = {
			Key = "icon",
			Name = "Icon",
			Type = "Texture",

			Item = {
				Key = "icon",
				Name = "IconTexture",
				Type = "Texture",
			},

			-- DrawLayer = "BACKGROUND",
			-- DrawLevel = 0,

			-- NoColor = true,
			-- NoTexture = true,
		},
		Shadow = {
			-- DrawLayer = "ARTWORK",
			-- DrawLevel = -1,

			Ignore = true,
			CanHide = true,
		},
		Normal = {
			--Key = "NormalTexture", -- Conflicts with some add-ons.
			Func = "GetNormalTexture",
			Name = "NormalTexture",
			Type = "Texture",

			-- Texture = "Interface\\Buttons\\UI-Quickslot2",
			-- EmptyTexture = "Interface\\Buttons\\UI-Quickslot",
			-- DrawLayer = "ARTWORK",
			-- DrawLevel = 0,

			CanHide = true,
		},
		Disabled = {
			Func = "GetDisabledTexture",
			Type = "Texture",

			Iterate = true,
			Hide = true,
		},
		Pushed = {
			Func = "GetPushedTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
			DrawLayer = "ARTWORK",
			DrawLevel = 0,

			Iterate = true,
			UseColor = true,
		},
		Flash = {
			-- Key = "Flash", -- Conflicts with item buttons.
			Name = "Flash",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-QuickslotRed]],
			DrawLayer = "ARTWORK",
			DrawLevel = 1,

			Iterate = true,
			UseColor = true,
		},
		HotKey = {
			Key = "HotKey",
			Name = "HotKey",
			Type = "FontString",

			--FontObject = "NumberFontNormalSmallGray",
			JustifyH = "RIGHT",
			DrawLayer = "ARTWORK",
			Point = "TOPRIGHT",
			OffsetX = 1,
			OffsetY = -3,

			Iterate = true,
			NoColor = true,
		},
		Count = {
			Key = "Count",
			Name = "Count",
			Type = "FontString",

			--FontObject = "NumberFontNormal",
			JustifyH = "RIGHT",
			DrawLayer = "ARTWORK",
			Point = "BOTTOMRIGHT",
			OffsetX = -2,
			OffsetY = 2,

			Iterate = true,
			NoColor = true,

			Aura = {
				Key = "count",
				Name = "Count",
				Type = "FontString",

				--FontObject = "NumberFontNormal",
				JustifyH = "RIGHT",
				DrawLayer = "ARTWORK",
				Point = "BOTTOMRIGHT",
				OffsetX = -2,
				OffsetY = 2,

				Iterate = true,
				NoColor = true,
			},
		},
		Duration = {
			Key = "duration",
			Name = "Duration",
			Type = "FontString",

			--FontObject = "GameFontNormalSmall",
			JustifyH = "CENTER",
			Point = "TOP",
			RelPoint = "BOTTOM",
			DrawLayer = "ARTWORK",

			Iterate = true,
			NoColor = true,
		},
		Checked = {
			Func = "GetCheckedTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\CheckButtonHilight]],
			BlendMode = "ADD",
			DrawLayer = "OVERLAY",
			DrawLevel = 0,

			Iterate = true,
		},
		Border = {
			Key = "Border",
			Name = "Border",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-ActionButton-Border]],
			BlendMode = "ADD",
			DrawLayer = "OVERLAY",
			DrawLevel = 0,

			Iterate = true,
			NoColor = true,

			-- Nested Settings
			Aura = {
				Name = "Border",
				Type = "Texture",

				Texture = [[Interface\Buttons\UI-ActionButton-Border]],
				BlendMode = "ADD",
				DrawLayer = "OVERLAY",
				DrawLevel = 0,

				Iterate = true,
				NoColor = true,
			},
			Debuff = {
				Name = "Border",
				Type = "Texture",

				Texture = [[Interface\Buttons\UI-Debuff-Overlays]],
				TexCoords = {0.296875, 0.5703125, 0, 0.515625},
				DrawLayer = "OVERLAY",
				DrawLevel = 0,

				Iterate = true,
				NoColor = true,
			},
			Enchant = {
				Name = "Border",
				Type = "Texture",

				Texture = [[Interface\Buttons\UI-TempEnchant-Border]],
				DrawLayer = "OVERLAY",
				DrawLevel = 0,

				Iterate = true,
			},
			Item = {
				Key = "Border",
				Name = "Border",
				Type = "Texture",

				Texture = [[Interface\Common\WhiteIconFrame]],
				DrawLayer = "OVERLAY",
				DrawLevel = 0,

				Iterate = true,
				NoColor = true,
			},
		},
		IconBorder = {
			Key = "IconBorder",
			Type = "Texture",

			-- Texture = [[Interface\Common\WhiteIconFrame]],
			-- RelicTexture = [[Interface\Artifacts\RelicIconFrame]],
			-- DrawLayer = "OVERLAY",
			-- DrawLevel = 0,

			-- Iterate = true,
			-- NoColor = true,
			-- NoTexture = true,
		},
		SlotHighlight = {
			Key = "SlotHighlightTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\CheckButtonHilight]],
			BlendMode = "ADD",
			DrawLayer = "OVERLAY",
			DrawLevel = 0,

			Iterate = true,
		},
		Gloss = {
			-- DrawLayer = "OVERLAY",
			-- DrawLevel = 0,

			Ignore = true,
			CanHide = true,
		},
		IconOverlay = {
			Key = "IconOverlay",
			Type = "Texture",

			-- Atlas = "AzeriteIconFrame",
			-- AtlasInfo = {
				-- Atlas = "AzeriteIconFrame",
				-- UseSize = false,
				-- Texture = [[Interface\Azerite\Azerite]],
				-- TexCoords = {0.59375, 0.84375, 0.800781, 0.863281},
				-- Width = 64,
				-- Height = 64,
			-- },
			DrawLayer = "OVERLAY",
			DrawLevel = 1,

			Iterate = true,
			NoColor = true,
			NoTexture = true,
		},
		NewAction = {
			Key = "NewActionTexture",
			Type = "Texture",

			Atlas = "bags-newitem",
			-- AtlasInfo = {
				-- Atlas = "bags-newitem",
				-- UseSize = false,
				-- Texture = [[Interface\ContainerFrame\Bags]],
				-- TexCoords = {0.363281, 0.535156, 0.00390625, 0.175781},
				-- Width = 44,
				-- Height = 44,
			-- },
			BlendMode = "ADD",
			DrawLayer = "OVERLAY",
			DrawLevel = 1,

			Iterate = true,
		},
		SpellHighlight = {
			Key = "SpellHighlightTexture",
			Type = "Texture",

			Atlas = "bags-newitem",
			-- AtlasInfo = {
				-- Atlas = "bags-newitem",
				-- UseSize = false,
				-- Texture = [[Interface\ContainerFrame\Bags]],
				-- TexCoords = {0.363281, 0.535156, 0.00390625, 0.175781},
				-- Width = 44,
				-- Height = 44,
			-- },
			BlendMode = "ADD",
			DrawLayer = "OVERLAY",
			DrawLevel = 1,

			Iterate = true,
		},
		-- * Only used by Pet Action Buttons.
		AutoCastable = {
			--Key = "AutoCastable", -- Causes issues with PetBars.
			Name = "AutoCastable",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
			DrawLayer = "OVERLAY",
			DrawLevel = 1,

			Iterate = true,
		},
		--[[
		JunkIcon = {
			Atlas = "bags-junkcoin",
			UseAtlasSize = true,
			-- AtlasInfo = {
				-- Atlas = "bags-junkcoin",
				-- UseSize = true,
				-- Texture = "Interface\\ContainerFrame\\Bags",
				-- TexCoords = {0.863281, 0.941406, 0.28125, 0.351562},
				-- Width = 20,
				-- Height = 18,
			-- },
			Point = "TOPLEFT",
			DrawLayer = "OVERLAY",
			DrawLevel = 1,

			NoColor = true,
			NoTexture = true,
		},
		UpgradeIcon = {
			Atlas = "bags-greenarrow",
			UseAtlasSize = true,
			-- AtlasInfo = {
				-- Atlas = "bags-greenarrow",
				-- UseSize = true,
				-- Texture = "Interface\\ContainerFrame\\Bags",
				-- TexCoords = {0.3125, 0.390625, 0.648438, 0.734375},
				-- Width = 20,
				-- Height = 22,
			-- },
			Point = "TOPLEFT",
			DrawLayer = "OVERLAY",
			DrawLevel = 1,

			NoColor = true,
			NoTexture = true,
		},
		QuestIcon = {
			Point = "TOP",
			-- Texture = "Interface\\ContainerFrame\\UI-Icon-QuestBorder"-- Active > TEXTURE_ITEM_QUEST_BORDER
			-- Texture = "Interface\\ContainerFrame\\UI-Icon-QuestBang", -- Inactive > TEXTURE_ITEM_QUEST_BANG
			DrawLayer = "OVERLAY",
			DrawLevel = 2,

			NoColor = true,
			NoTexture = true,
		},
		]]
		NewItem = {
			Key = "NewItemTexture",
			Type = "Texture",

			-- Atlas = "bags-glow-green",
			-- UseAtlasSize = true,
			-- AtlasInfo = {
				-- Atlas = "bags-glow-green",
				-- UseSize = true,
				-- Texture = [[Interface\ContainerFrame\Bags]],
				-- TexCoords = {0.703125, 0.855469, 0.00390625, 0.15625},
				-- Width = 39,
				-- Height = 39,
			-- },
			-- BlendMode = "ADD",
			DrawLayer = "OVERLAY",
			DrawLevel = 2,

			Iterate = true,
			NoColor = true,
			NoTexture = true,
		},
		SearchOverlay = {
			Key = "searchOverlay",
			Name = "SearchOverlay",
			Type = "Texture",

			Color = {0, 0, 0, 0.8},
			DrawLayer = "OVERLAY",
			DrawLevel = 4,

			Iterate = true,
			UseColor = true,
			SetAllPoints = true,
		},
		ContextOverlay = {
			Key = "ItemContextOverlay",
			Type = "Texture",

			Color = {0, 0, 0, 0.8},
			DrawLayer = "OVERLAY",
			DrawLevel = 5,

			Iterate = true,
			UseColor = true,
			SetAllPoints = true,
		},
		Name = {
			Key = "Name",
			Name = "Name",
			Type = "FontString",

			--FontObject = "GameFontHighlightSmallOutline",
			JustifyH = "CENTER",
			DrawLayer = "OVERLAY",
			Point = "BOTTOM",
			OffsetY = 2,

			Iterate = true,
			NoColor = true,
		},
		Highlight = {
			Func = "GetHighlightTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\ButtonHilight-Square]],
			BlendMode = "ADD",
			DrawLayer = "HIGHLIGHT",
			DrawLevel = 0,

			Iterate = true,
		},
		AutoCastShine = {
			--Key = "AutoCastShine", -- Causes issues with PetBars.
			Name = "Shine",
			Type = "Frame",
		},
		Cooldown = {
			Key = "cooldown",
			Name = "Cooldown",
			Type = "Cooldown",
		},
		ChargeCooldown = {
			Key = "chargeCooldown",
			Type = "Cooldown",
		},
	}

	----------------------------------------
	-- Action Type
	---

	local Action = {
		Backdrop = Regions.Backdrop,
		Icon = Regions.Icon,
		Normal = Regions.Normal,
		Disabled = Regions.Disabled, -- Unused
		Pushed = Regions.Pushed,
		Flash = Regions.Flash,
		Checked = Regions.Checked,
		HotKey = Regions.HotKey,
		Count = Regions.Count,
		Border = Regions.Border,
		NewAction = Regions.NewAction,
		SpellHighlight = Regions.SpellHighlight,
		AutoCastable = Regions.AutoCastable,
		Name = Regions.Name,
		Highlight = Regions.Highlight,
		AutoCastShine = Regions.AutoCastShine,
		Cooldown = Regions.Cooldown,
		ChargeCooldown = Regions.ChargeCooldown,
	}

	----------------------------------------
	-- Item Type
	---

	local Item = {
		Icon = Regions.Icon.Item,
		Normal = Regions.Normal,
		Disabled = Regions.Disabled,
		Pushed = Regions.Pushed,
		IconBorder = Regions.IconBorder,
		Border = Regions.Border.Item, -- Backwards-Compatibility
		SlotHighlight = Regions.SlotHighlight,
		IconOverlay = Regions.IconOverlay,
		-- JunkIcon = Regions.JunkIcon,
		-- UpgradeIcon = Regions.UpgradeIcon,
		-- QuestIcon = Regions.QuestIcon,
		NewItem = Regions.NewItem,
		SearchOverlay = Regions.SearchOverlay,
		ContextOverlay = Regions.ContextOverlay,
		Count = Regions.Count,
		Highlight = Regions.Highlight,
		Cooldown = Regions.Cooldown,
		ChargeCooldown = Regions.ChargeCooldown,
	}

	----------------------------------------
	-- Aura Type
	---

	local Aura = {
		Icon = Regions.Icon,
		Normal = Regions.Normal, -- Unused
		Disabled = Regions.Disabled, -- Unused
		Pushed = Regions.Pushed, -- Unused
		Border = Regions.Border.Aura,
		Count = Regions.Count.Aura,
		Duration = Regions.Duration,
		Highlight = Regions.Highlight, -- Unused
		Cooldown = Regions.Cooldown,
		ChargeCooldown = Regions.ChargeCooldown,
	}

	----------------------------------------
	-- Debuff Type
	---

	local Debuff = {
		Icon = Regions.Icon,
		Normal = Regions.Normal, -- Unused
		Disabled = Regions.Disabled, -- Unused
		Pushed = Regions.Pushed, -- Unused
		Border = Regions.Border.Debuff,
		Count = Regions.Count.Aura,
		Duration = Regions.Duration,
		Highlight = Regions.Highlight, -- Unused
		Cooldown = Regions.Cooldown,
		ChargeCooldown = Regions.ChargeCooldown,
	}

	----------------------------------------
	-- Enchant Type
	---

	local Enchant = {
		Icon = Regions.Icon,
		Normal = Regions.Normal, -- Unused
		Disabled = Regions.Disabled, -- Unused
		Pushed = Regions.Pushed, -- Unused
		Border = Regions.Border.Enchant,
		Count = Regions.Count.Aura,
		Duration = Regions.Duration,
		Highlight = Regions.Highlight, -- Unused
		Cooldown = Regions.Cooldown,
		ChargeCooldown = Regions.ChargeCooldown,
	}

	----------------------------------------
	-- Core
	---

	Core.RegDefs = Regions

	-- Reference Table
	Core.RegList = {
		Legacy = Regions,
		Action = Action,
		Item = Item,
		Aura = Aura,
		Buff = Aura,
		Debuff = Debuff,
		Enchant = Enchant,
	}
end
