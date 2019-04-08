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

	-- * Regions with dedicated functions have their settings hard-coded and so are
	--   commented out.

	local Defaults = {
		Backdrop = {
			-- Texture = "Interface\\Buttons\\UI-Quickslot",
			-- Color = {1, 1, 1, 0.6},
			-- DrawLayer = "BACKGROUND",
			-- DrawLevel = -1,

			CanHide = true,
			-- UseColor = true,
		},
		Icon = {
			-- DrawLayer = "BACKGROUND",
			-- DrawLevel = 0,

			-- NoColor = true,
			-- NoTexture = true,
		},
		Shadow = {
			-- DrawLayer = "ARTWORK",
			-- DrawLevel = -1,

			CanHide = true,
		},
		Normal = {
			-- Texture = "Interface\\Buttons\\UI-Quickslot2",
			-- EmptyTexture = "Interface\\Buttons\\UI-Quickslot",
			-- DrawLayer = "ARTWORK",
			-- DrawLevel = 0,

			CanHide = true,
		},
		Disabled = {
			Hide = true,
		},
		Pushed = {
			Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
			DrawLayer = "ARTWORK",
			DrawLevel = 0,

			UseColor = true,
		},
		Flash = {
			Texture = [[Interface\Buttons\UI-QuickslotRed]],
			DrawLayer = "ARTWORK",
			DrawLevel = 1,

			UseColor = true,
		},
		HotKey = {
			--FontObject = "NumberFontNormalSmallGray",
			JustifyH = "RIGHT",
			DrawLayer = "ARTWORK",
			Point = "TOPRIGHT",
			OffsetX = 1,
			OffsetY = -3,

			NoColor = true,
		},
		Count = {
			--FontObject = "NumberFontNormal",
			JustifyH = "RIGHT",
			DrawLayer = "ARTWORK",
			Point = "BOTTOMRIGHT",
			OffsetX = -2,
			OffsetY = 2,

			NoColor = true,
		},
		Duration = {
			--FontObject = "GameFontNormalSmall",
			JustifyH = "CENTER",
			Point = "TOP",
			RelPoint = "BOTTOM",
			DrawLayer = "ARTWORK",

			NoColor = true,
		},
		Checked = {
			Texture = [[Interface\Buttons\CheckButtonHilight]],
			BlendMode = "ADD",
			DrawLayer = "OVERLAY",
			DrawLevel = 0,
		},
		Border = { -- Default at the root.
			Texture = [[Interface\Buttons\UI-ActionButton-Border]],
			BlendMode = "ADD",
			DrawLayer = "OVERLAY",
			DrawLevel = 0,

			NoColor = true,

			-- Nested Settings
			Item = {
				Texture = [[Interface\Common\WhiteIconFrame]],
				DrawLayer = "OVERLAY",
				DrawLevel = 0,

				NoColor = true,
			},
			Debuff = {
				Texture = [[Interface\Buttons\UI-Debuff-Overlays]],
				TexCoords = {0.296875, 0.5703125, 0, 0.515625},
				DrawLayer = "OVERLAY",
				DrawLevel = 0,

				NoColor = true,
			},
			Enchant = {
				Texture = [[Interface\Buttons\UI-TempEnchant-Border]],
				DrawLayer = "OVERLAY",
				DrawLevel = 0,
			},
		},
		IconBorder = {
			Texture = [[Interface\Common\WhiteIconFrame]],
			RelicTexture = [[Interface\Artifacts\RelicIconFrame]],
			DrawLayer = "OVERLAY",
			DrawLevel = 0,

			NoColor = true,
			NoTexture = true,
		},
		SlotHighlight = {
			Texture = [[Interface\Buttons\CheckButtonHilight]],
			BlendMode = "ADD",
			DrawLayer = "OVERLAY",
			DrawLevel = 0,
		},
		Gloss = {
			-- DrawLayer = "OVERLAY",
			-- DrawLevel = 0,

			CanHide = true,
		},
		IconOverlay = {
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

			NoColor = true,
			NoTexture = true,
		},
		NewAction = {
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
		},
		SpellHighlight = {
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
		},
		AutoCastable = {
			Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
			DrawLayer = "OVERLAY",
			DrawLevel = 1,
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

			NoColor = true,
			NoTexture = true,
		},
		SearchOverlay = {
			Color = {0, 0, 0, 0.8},
			DrawLayer = "OVERLAY",
			DrawLevel = 4,

			UseColor = true,
			SetAllPoints = true,
		},
		ContextOverlay = {
			Color = {0, 0, 0, 0.8},
			DrawLayer = "OVERLAY",
			DrawLevel = 5,

			UseColor = true,
			SetAllPoints = true,
		},
		Name = {
			--FontObject = "GameFontHighlightSmallOutline",
			JustifyH = "CENTER",
			DrawLayer = "OVERLAY",
			Point = "BOTTOM",
			OffsetY = 2,

			NoColor = true,
		},
		Highlight = {
			Texture = [[Interface\Buttons\ButtonHilight-Square]],
			BlendMode = "ADD",
			DrawLayer = "HIGHLIGHT",
			DrawLevel = 0,
		},
		AutoCastShine = {
		},
		Cooldown = {
		},
		ChargeCooldown = {
		},
	}

	----------------------------------------
	-- Core
	---

	Core.RegDefs = Defaults

end

----------------------------------------
-- Region List
-- * A list of regions for various button types.
---

do
	-- * Type -> Must match the game's internal type, for validation.
	-- * nType -> Internal type used for iteration.

	----------------------------------------
	-- Legacy
	---

	local Legacy = {
		Backdrop = {
			Name = "FloatingBG",
			Type = "Texture",
		},
		Icon = {
			Key = "icon",
			Name = "Icon",
			Type = "Texture",
		},
		Normal = {
			--Key = "NormalTexture", -- Conflicts with some add-ons.
			Func = "GetNormalTexture",
			Name = "NormalTexture",
			Type = "Texture",
		},
		Disabled = {
			Func = "GetDisabledTexture",
			Type = "Texture",
			nType = "Texture",
		},
		Pushed = {
			Func = "GetPushedTexture",
			Type = "Texture",
			nType = "Texture",
		},
		Flash = {
			-- Key = "Flash", -- Conflicts with item buttons.
			Name = "Flash",
			Type = "Texture",
			nType = "Texture",
		},
		HotKey = {
			Key = "HotKey",
			Name = "HotKey",
			Type = "FontString",
			nType = "Text",
		},
		Count = {
			Key = "Count",
			Name = "Count",
			Type = "FontString",
			nType = "Text",
		},
		Duration = {
			Key = "duration",
			Name = "Duration",
			Type = "FontString",
			nType = "Text",
		},
		Checked = {
			Func = "GetCheckedTexture",
			Type = "Texture",
			nType = "Texture",
		},
		Border = {
			Key = "Border",
			Name = "Border",
			Type = "Texture",
			nType = "Texture",
		},
		Name = {
			Key = "Name",
			Name = "Name",
			Type = "FontString",
			nType = "Text",
		},
		Highlight = {
			Func = "GetHighlightTexture",
			Type = "Texture",
			nType = "Texture",
		},
		Cooldown = {
			Key = "cooldown",
			Name = "Cooldown",
			Type = "Cooldown",
		},
	}

	----------------------------------------
	-- Action Button
	---

	local Action = {
		Backdrop = Legacy.Backdrop,
		Icon = Legacy.Icon,
		Normal = Legacy.Normal,
		Disabled = Legacy.Disabled, -- Unused
		Pushed = Legacy.Pushed,
		Flash = Legacy.Flash,
		Checked = Legacy.Checked,
		Border = Legacy.Border,
		HotKey = Legacy.HotKey,
		Count = Legacy.Count,
		Name = Legacy.Name,
		NewAction = {
			Key = "NewActionTexture",
			Type = "Texture",
			nType = "Texture",
		},
		SpellHighlight = {
			Key = "SpellHighlightTexture",
			Type = "Texture",
			nType = "Texture",
		},
		-- * Only used by Pet Action Buttons.
		AutoCastable = {
			--Key = "AutoCastable", -- Causes issues with PetBars.
			Name = "AutoCastable",
			Type = "Texture",
			nType = "Texture",
		},
		Highlight = Legacy.Highlight,
		-- * Only used by Pet Action Buttons.
		AutoCastShine = {
			--Key = "AutoCastShine", -- Causes issues with PetBars.
			Name = "Shine",
			Type = "Frame",
		},
		Cooldown = Legacy.Cooldown,
	}

	----------------------------------------
	-- Item Button
	---

	local Item = {
		Icon = {
			Key = "icon",
			Name = "IconTexture",
			Type = "Texture",
		},
		Normal = Legacy.Normal,
		Disabled = Legacy.Disabled, -- Unused
		Pushed = Legacy.Pushed,
		IconBorder = {
			Key = "IconBorder",
			Type = "Texture",
			nType = "Texture",
		},
		Border = Legacy.Border, -- Backwards-compatibility.
		SlotHighlight = {
			Key = "SlotHighlightTexture",
			Type = "Texture",
			nType = "Texture",
		},
		IconOverlay = {
			Key = "IconOverlay",
			Type = "Texture",
			nType = "Texture",
		},
		--[[
		JunkIcon = {
			Key = "JunkIcon",
			Type = "Texture",
		},
		UpgradeIcon = {
			Key = "UpgradeIcon",
			Type = "Texture",
		},
		QuestIcon = {
			Key = "IconQuestTexture",
			Type = "Texture",
			Texture = false,
		},
		]]
		NewItem = {
			Key = "NewItemTexture",
			Type = "Texture",
			nType = "Texture",
		},
		SearchOverlay = {
			Key = "searchOverlay",
			Name = "SearchOverlay",
			Type = "Texture",
			nType = "Texture",
		},
		ContextOverlay = {
			Key = "ItemContextOverlay",
			Type = "Texture",
			nType = "Texture",
		},
		Count = Legacy.Count,
		Highlight = Legacy.Highlight,
		Cooldown = Legacy.Cooldown,
	}

	----------------------------------------
	-- Aura Button
	---

	local Aura = {
		Icon = {
			Name = "Icon",
			Type = "Texture",
		},
		Normal = Legacy.Normal, -- Unused
		Disabled = Legacy.Disabled, -- Unused
		Pushed = Legacy.Pushed, -- Unused
		Border = {
			Name = "Border",
			Type = "Texture",
			nType = "Texture",
		},
		Count = {
			Key = "count",
			Name = "Count",
			Type = "FontString",
		},
		Duration = Legacy.Duration,
		Highlight = Legacy.Highlight, -- Unused
		Cooldown = Legacy.Cooldown,
	}

	----------------------------------------
	-- Core
	---

	-- Reference Table
	Core.RegList = {
		Legacy = Legacy,
		Action = Action,
		Item = Item,
		Aura = Aura,
		Debuff = Aura,
		Enchant = Aura,
	}
end
