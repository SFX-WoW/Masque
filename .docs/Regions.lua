-- 8.1.5.29737

local Regions = {

	----------------------------------------
	-- ActionButton
	-- * Unsupported: FlyoutArrow, FlyoutBorder, FlyoutBorderShadow
	---

	-- @CheckButton
	Action = {
		Width = 36,                                                       -- Default
		Height = 36,                                                      -- Default

		----------------------------------------
		-- Backdrop                                                       --[1]--[DONE]
		---

		-- @ MultiBarButtonTemplate, MultiActionBars.xml
		-- * Used only on MultiBar buttons.
		Backdrop = {
			Name = "FloatingBG",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-Quickslot]],                 -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 0.4},                                       -- Default, XML Alpha
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "BACKGROUND",                                     -- XML
			DrawLevel = -1,                                               -- XML
			Width = 66,                                                   -- Calculated
			Height = 66,                                                  -- Calculated
			Points = {
				{ -- [1]
					Point = "TOPLEFT",                                    -- XML
					OffsetX = -15,                                        -- XML
					OffsetY = 15,                                         -- XML
				},
				{ -- [2]
					Point = "BOTTOMRIGHT",                                -- XML
					OffsetX = 15,                                         -- XML
					OffsetY = -15,                                        -- XML
				},
			},
		},

		----------------------------------------
		-- Icon                                                           --[2]--[DONE]
		---

		-- @ ActionButtonTemplate, ActionButtonTemplate.xml
		Icon = {
			Key = "icon",
			Name = "Icon",
			Type = "Texture",

			TexCoords = {0, 1, 0, 1},                                     -- Default
			DrawLayer = "BACKGROUND",                                     -- XML
			DrawLevel = 0,                                                -- XML
			Width = 36,                                                   -- Inherited
			Height = 36,                                                  -- Inherited
			Point = "TOPLEFT",                                            -- Default
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- Normal                                                         --[3]--[DONE]
		---

		-- @ Button, ActionButtonTemplate.xml
		-- * Visible in default state.
		-- * Hidden in the "pushed" state.
		Normal = {
			Key = "NormalTexture",
			Func = "GetNormalTexture",
			Name = "NormalTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-Quickslot2]],                -- XML
			EmptyTexture = [[Interface\Buttons\UI-Quickslot]],            -- Lua
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			EmptyColor = {1, 1, 1, 0.5},                                  -- Lua
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "ARTWORK",                                        -- Default
			DrawLevel = 0,                                                -- Default
			Width = 66,                                                   -- Calculated
			Height = 66,                                                  -- Calculated
			Points = {
				{ -- [1]
					Point = "TOPLEFT",                                    -- XML
					OffsetX = -15,                                        -- XML
					OffsetY = 15,                                         -- XML
				},
				{ -- [2]
					Point = "BOTTOMRIGHT",                                -- XML
					OffsetX = 15,                                         -- XML
					OffsetY = -15,                                        -- XML
				},
			},
		},

		----------------------------------------
		-- Disabled                                                       --[4]--[DONE]
		---

		-- @ Button
		-- * Visible in the "disabled" state.
		-- * Unused.
		Disabled = {
			Func = "GetDisabledTexture",
			Type = "Texture",
			Hide = true,
		},

		----------------------------------------
		-- Pushed                                                         --[5]--[DONE]
		---

		-- @ Button, ActionButtonTemplate.xml
		-- * Visible in the "pushed" state.
		Pushed = {
			Func = "GetPushedTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-Quickslot-Depress]],         -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "ARTWORK",                                        -- Default
			DrawLevel = 0,                                                -- Default
			Width = 36,                                                   -- Inherited
			Height = 36,                                                  -- Inherited
			Point = "TOPLEFT",                                            -- Default
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- Flash                                                          --[6]--[DONE]
		---

		-- @ ActionButtonTemplate, ActionButtonTemplate.xml
		-- * Flashes in the "active" state.
		Flash = {
			Key = "Flash",
			Name = "Flash",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-QuickslotRed]],              -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "ARTWORK",                                        -- XML
			DrawLevel = 1,                                                -- XML
			Width = 36,                                                   -- Inherited
			Height = 36,                                                  -- Inherited
			Point = "TOPLEFT",                                            -- Default
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- HotKey                                                         --[7]--[DONE]
		---

		-- @ ActionButtonTemplate, ActionButtonTemplate.xml
		HotKey = {
			Key = "HotKey",
			Name = "HotKey",
			Type = "Text",

			FontObject = "NumberFontNormalSmallGray",                     -- XML
			--Color = {0.6, 0.6, 0.6, 1},                                 -- XML (FontObject), Do Not Modify
			JustifyH = "RIGHT",                                           -- XML
			JustifyV = "MIDDLE",                                          -- Default
			DrawLayer = "ARTWORK",                                        -- XML
			DrawLevel = 2,                                                -- XML
			Width = 36,                                                   -- XML
			Height = 10,                                                  -- XML
			Point = "TOPLEFT",                                            -- XML
			OffsetX = 1,                                                  -- XML
			OffsetY = -3,                                                 -- XML
		},

		----------------------------------------
		-- Count                                                          --[8]--[DONE]
		---

		-- @ ActionButtonTemplate, ActionButtonTemplate.xml
		Count = {
			Key = "Count",
			Name = "Count",
			Type = "Text",

			FontObject = "NumberFontNormal",                              -- XML
			Color = {1, 1, 1, 1},                                         -- XML (FontObject)
			JustifyH = "RIGHT",                                           -- XML
			JustifyV = "MIDDLE",                                          -- Default
			DrawLayer = "ARTWORK",                                        -- XML
			DrawLevel = 2,                                                -- XML
			Width = 1,                                                    -- In-Game
			Height = 1,                                                   -- In-Game
			Point = "BOTTOMRIGHT",                                        -- XML
			OffsetX = -2,                                                 -- XML
			OffsetY = 2,                                                  -- XML
		},

		----------------------------------------
		-- Checked                                                        --[10]--[DONE]
		---

		-- @ CheckButton, ActionButtonTemplate.xml
		-- * Visible in the "checked" state.
		Checked = {
			Func = "GetCheckedTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\CheckButtonHilight]],           -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "ADD",                                            -- XML
			DrawLayer = "OVERLAY",                                        -- In-Game
			DrawLevel = 0,                                                -- Default
			Width = 36,                                                   -- Inherited
			Height = 36,                                                  -- Inherited
			Point = "TOPLEFT",                                            -- Default
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- Border                                                         --[9]--[DONE]
		---

		-- @ ActionButtonTemplate, ActionButtonTemplate.xml
		-- * Equipped Item Border
		Border = {
			Key = "Border",
			Name = "Border",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-ActionButton-Border]],       -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "ADD",                                            -- XML
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 0,                                                -- Default
			Width = 62,                                                   -- XML
			Height = 62,                                                  -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- Name                                                          --[11]--[DONE]
		---

		-- @ ActionButtonTemplate, ActionButtonTemplate.xml
		Name = {
			Key = "Name",
			Name = "Name",
			Type = "Text",

			FontObject = "GameFontHighlightSmallOutline",                 -- XML
			Color = {1, 1, 1, 1},                                         -- XML (FontObject)
			JustifyH = "CENTER",                                          -- Default
			JustifyV = "MIDDLE",                                          -- Default
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 0,                                                -- Default
			Width = 36,                                                   -- XML
			Height = 10,                                                  -- XML
			Point = "BOTTOM",                                             -- XML
			OffsetX = 0,                                                  -- XML
			OffsetY = 2,                                                  -- XML
		},

		----------------------------------------
		-- NewAction                                                      --[12]--[DONE]
		---

		-- @ ActionButtonTemplate, ActionButtonTemplate.xml
		NewAction = {
			Key = "NewActionTexture",
			Type = "Texture",

			Atlas = {                                                     -- XML
				ID = "bags-newitem",
				UseSize = false,                                          -- XML
				Texture = [[Interface\ContainerFrame\Bags]],
				TexCoords = {0.363281, 0.535156, 0.00390625, 0.175781},
				Width = 44,
				Height = 44,
			},
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "ADD",                                            -- XML
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 1,                                                -- XML
			Width = 44,                                                   -- XML
			Height = 44,                                                  -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- SpellHighlight                                                 --[13]--[DONE]
		---

		-- @ ActionButtonTemplate, ActionButtonTemplate.xml
		SpellHighlight = {
			Key = "SpellHighlightTexture",
			Type = "Texture",

			Atlas = {                                                     -- XML
				ID = "bags-newitem",
				UseSize = false,                                          -- XML

				Texture =[[Interface\ContainerFrame\Bags]],
				TexCoords = {0.363281, 0.535156, 0.00390625, 0.175781},

				Width = 44,                                               -- XML
				Height = 44,                                              -- XML
			},
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "ADD",                                            -- XML
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 1,                                                -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- AutoCastable                                                   --[14]--[DONE]
		---

		-- @ ActionButtonTemplate, ActionButtonTemplate.xml
		AutoCastable = {
			Key = "AutoCastable",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],       -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 1,                                                -- XML
			Width = 58,                                                   -- XML
			Height = 58,                                                  -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- Highlight                                                      --[15]--[DONE]
		---

		-- @ Button, ActionButtonTemplate.xml
		-- * Visible on mouse-over.
		Highlight = {
			Func = "GetHighlightTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\ButtonHilight-Square]],         -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "ADD",                                            -- XML
			DrawLayer = "HIGHLIGHT",                                      -- In-Game
			DrawLevel = 0,                                                -- Default
			Width = 36,                                                   -- Inherited
			Height = 36,                                                  -- Inherited
			Point = "TOPLEFT",                                            -- Default
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- AutoCastShine                                                  --[F1]--[DONE]
		---

		-- @ ActionButtonTemplate, ActionButtonTemplate.xml
		AutoCastShine = {
			Key = "AutoCastShine",
			Name = "Shine",
			Type = "Frame",

			Width = 28,                                                   -- XML
			Height = 28,                                                  -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- XML
			OffsetY = 0,                                                  -- XML
		},

		----------------------------------------
		-- Cooldown                                                       --[F2]--[DONE]
		---

		-- @ ActionButtonTemplate, ActionButtonTemplate.xml
		Cooldown = {
			Key = "cooldown",
			Name = "Cooldown",
			Type = "Frame",

			SwipeColor = {0, 0, 0, 0.8},                                  -- Normal
			--SwipeColor = {0.17, 0, 0, 0.8},                             -- LoC
			--SwipeColor = {1, 1, 1, 0.8},                                -- XML
			Width = 36,                                                   -- XML
			Height = 36,                                                  -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- XML
			OffsetY = -1,                                                 -- XML
		},

		----------------------------------------
		-- ChargeCooldown                                                 --[F3]--[DONE]
		---

		-- @ ActionButton.lua
		ChargeCooldown = {
			Key = "chargeCooldown",
			Type = "Frame",

			Width = 36,                                                   -- Lua / SetAllPoints
			Height = 36,                                                  -- Lua / SetAllPoints

			SetAllPoints = true,                                          -- Lua
		},
	},

	----------------------------------------
	-- AuraButton
	---

	-- @Button
	Aura = {
		Width = 30,
		Height = 30,

		----------------------------------------
		-- Icon                                                           --[1]--[DONE]
		---

		-- @ AuraButton, BuffFrame.xml
		Icon = {
			Name = "Icon",
			Type = "Texture",

			TexCoords = {0, 1, 0, 1},                                     -- Default
			DrawLayer = "BACKGROUND",                                     -- XML
			DrawLevel = 0,                                                -- Default
			Width = 30,                                                   -- Inherited
			Height = 30,                                                  -- Inherited
			Point = "TOPLEFT",                                            -- Default
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- Count                                                          --[2]--[DONE]
		---

		-- @ AuraButton, BuffFrame.xml
		Count = {
			Key = "count",
			Name = "Count",
			Type = "Text",

			FontObject = "NumberFontNormal",                              -- XML
			Color = {1, 1, 1, 1},                                         -- XML (FontObject)
			JustifyH = "CENTER",                                          -- Default
			JustifyV = "MIDDLE",                                          -- Default
			DrawLayer = "BACKGROUND",                                     -- XML
			DrawLevel = 0,                                                -- Default
			Width = 1,                                                    -- In-Game
			Height = 1,                                                   -- In-Game
			Point = "BOTTOMRIGHT",                                        -- XML
			OffsetX = -2,                                                 -- XML
			OffsetY = 2,                                                  -- XML
		},

		----------------------------------------
		-- Duration                                                       --[3]--[DONE]
		---

		-- @ AuraButton, BuffFrame.xml
		Duration = {
			Key = "duration",
			Name = "Duration",
			Type = "Text",

			FontObject = "GameFontNormalSmall",                           -- XML
			Color = {1, 1, 1, 1},                                         -- XML (FontObject)
			JustifyH = "CENTER",                                          -- Default
			JustifyV = "MIDDLE",                                          -- Default
			DrawLayer = "BACKGROUND",                                     -- XML
			DrawLevel = 0,                                                -- Default
			Width = 12,                                                   -- In-Game
			Height = 11,                                                  -- In-Game
			Point = "TOP",                                                -- XML
			RelPoint = "BOTTOM",                                          -- XML
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- DebuffBorder                                                   --[4]--[DONE]
		---

		-- @ DebuffButtonTemplate, BuffFrame.xml
		DebuffBorder = {
			Name = "Border",
			Type = "Texture",
			Texture = [[Interface\Buttons\UI-Debuff-Overlays]],           -- XML
			TexCoords = {0.296875, 0.5703125, 0, 0.515625},               -- XML
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 0,                                                -- Default
			Width = 33,                                                   -- XML
			Height = 32,                                                  -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- EnchantBorder                                                  --[4]--[DONE]
		---

		-- @ TempEnchantButtonTemplate, BuffFrame.xml
		EnchantBorder = {
			Name = "Border",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-TempEnchant-Border]],        -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 0,                                                -- Default
			Width = 32,                                                   -- XML
			Height = 32,                                                  -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- Normal                                                         --[X]--[DONE]
		---

		-- @ Button
		-- * Unused.
		Normal = {
			Func = "GetNormalTexture",
			Type = "Texture",
			Hide = true,
		},

		----------------------------------------
		-- Pushed                                                         --[X]--[DONE]
		---

		-- @ Button
		-- * Unused.
		Pushed = {
			Func = "GetPushedTexture",
			Type = "Texture",
			Hide = true,
		},

		----------------------------------------
		-- Disabled                                                       --[X]--[DONE]
		---

		-- @ Button
		-- * Unused.
		Disabled = {
			Func = "GetDisabledTexture",
			Type = "Texture",
			Hide = true,
		},

		----------------------------------------
		-- Highlight                                                      --[X]--[DONE]
		---

		-- @ Button
		-- * Unused.
		Highlight = {
			Func = "GetHighlightTexture",
			Type = "Texture",
			Hide = true,
		},
	},

	----------------------------------------
	-- ItemButton
	-- * Unsupported: Stock (Vendor)
	---

	-- @Button
	Item = {
		Width = 37,
		Height = 37,

		----------------------------------------
		-- Icon                                                           --[1]--[DONE]
		---

		-- @ ItemButton, ItemButtonTemplate.xml
		Icon = {
			Key = "icon",
			Name = "IconTexture",
			Type = "Texture",

			TexCoords = {0, 1, 0, 1},                                     -- Default
			DrawLayer = "BORDER",                                         -- XML
			DrawLevel = 0,                                                -- Default
			Width = 37,                                                   -- Inherited
			Height = 37,                                                  -- Inherited
			Point = "TOPLEFT",                                            -- Default
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- Normal                                                         --[2]--[DONE]
		---

		-- @ Button, ItemButtonTemplate.xml
		-- * Visible in default state.
		-- * Hidden in the "pushed" state.
		Normal = {
			Name = "NormalTexture",
			Func = "GetNormalTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-Quickslot2]],                -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			EmptyTexture = [[Interface\Buttons\UI-Quickslot]],            -- In-Game
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "ARTWORK",                                        -- Default
			DrawLevel = 0,                                                -- Default
			Width = 64,                                                   -- XML
			Height = 64,                                                  -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- XML
			OffsetY = -1,                                                 -- XML
		},

		----------------------------------------
		-- Pushed                                                         --[3]--[DONE]
		---

		-- @ Button, ItemButtonTemplate.xml
		-- * Visible in the "pushed" state.
		Pushed = {
			Func = "GetPushedTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\UI-Quickslot-Depress]],         -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "ARTWORK",                                        -- Default
			DrawLevel = 0,                                                -- Default
			Width = 37,                                                   -- Inherited
			Height = 37,                                                  -- Inherited
			Point = "TOPLEFT",                                            -- Default
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- Count                                                          --[4]--[DONE]
		---

		-- @ ItemButton, ItemButtonTemplate.xml
		Count = {
			Key = "count",
			Name = "Count",
			Type = "Text",

			FontObject = "NumberFontNormal",                              -- XML
			Color = {1, 1, 1, 1},                                         -- XML (FontObject)
			JustifyH = "RIGHT",                                           -- XML
			JustifyV = "MIDDLE",                                          -- Default
			DrawLayer = "ARTWORK",                                        -- XML
			DrawLevel = 2,                                                -- XML
			Width = 1,                                                    -- In-Game
			Height = 1,                                                   -- In-Game
			Point = "BOTTOMRIGHT",                                        -- XML
			OffsetX = -5,                                                 -- XML
			OffsetY = 2,                                                  -- XML
		},

		----------------------------------------
		-- IconBorder                                                     --[5]--[DONE]
		---

		-- @ ItemButton, ItemButtonTemplate.xml
		IconBorder = {
			Key = "IconBorder",
			Type = "Texture",

			Texture = [[Interface\Common\WhiteIconFrame]],                -- XML, Changes to [[Interface\Artifacts\RelicIconFrame]] if it's an artifact.
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 0,                                                -- Default
			Width = 37,                                                   -- XML
			Height = 37,                                                  -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- SlotHighlight                                                   --[6]--[DONE]
		---

		-- @ BagSlotButton, MainMenuBarBagButtons.xml
		SlotHighlight = {
			Key = "SlotHighlightTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\CheckButtonHilight]],           -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "ADD",                                            -- XML
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 0,                                                -- Default
			Width = 30,                                                   -- XML / SetAllPoints, 40 @Backpack
			Height = 30,                                                  -- XML / SetAllPoints, 40 @Backpack

			SetAllPoints = true,                                          -- XML
		},

		----------------------------------------
		-- IconOverlay                                                    --[7]--[DONE]
		---

		-- @ ItemButton, ItemButtonTemplate.xml
		IconOverlay = {
			Key = "IconOverlay",
			Type = "Texture",

			Atlas = {                                                     -- Lua
				ID = "AzeriteIconFrame",
				UseSize = false,

				Texture = [[Interface\Azerite\Azerite]],
				TexCoords = {0.59375, 0.84375, 0.800781, 0.863281},

				Width = 64,
				Height = 64,
			},
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 1,                                                -- XML
			Width = 37,                                                   -- XML
			Height = 37,                                                  -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- JunkIcon                                                       --[8]--[DONE]
		---

		-- @ ContainerFrameItemButtonTemplate, ContainerFrame.xml
		JunkIcon = {
			Key = "JunkIcon",
			Type = "Texture",

			Atlas = {                                                     -- XML
				ID = "bags-junkcoin",
				UseSize = true,                                           -- XML

				Texture = [[Interface\ContainerFrame\Bags]],
				TexCoords = {0.863281, 0.941406, 0.28125, 0.351562},

				Width = 20,
				Height = 18,
			},
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 1,                                                -- XML
			Point = "TOPLEFT",                                            -- XML
			OffsetX = 1,                                                  -- XML
			OffsetY = 0,                                                  -- XML
		},

		----------------------------------------
		-- UpgradeIcon                                                    --[9]--[DONE]
		---

		-- @ ContainerFrameItemButtonTemplate, ContainerFrame.xml
		UpgradeIcon = {
			Key = "JunkIcon",
			Type = "Texture",

			Atlas = {                                                     -- XML
				ID = "bags-greenarrow",
				UseSize = true,                                           -- XML

				Texture = [[Interface\ContainerFrame\Bags]],
				TexCoords = {0.3125, 0.390625, 0.648438, 0.734375},

				Width = 20,
				Height = 22,
			},
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 1,                                                -- XML
			Point = "TOPLEFT",                                            -- XML
			OffsetX = 0,                                                  -- XML
			OffsetY = 0,                                                  -- XML
		},

		----------------------------------------
		-- QuestIcon                                                      --[10]--[DONE]
		---

		-- @ ContainerFrameItemButtonTemplate, ContainerFrame.xml
		QuestIcon = {
			Key = "IconQuestTexture",
			Type = "Texture",

			--Texture = [[Interface\\ContainerFrame\\UI-Icon-QuestBorder]]-- Active   TEXTURE_ITEM_QUEST_BORDER
			--Texture = [[Interface\\ContainerFrame\\UI-Icon-QuestBang]], -- Inactive TEXTURE_ITEM_QUEST_BANG
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 2,                                                -- XML
			Width = 37,                                                   -- XML
			Height = 38,                                                  -- XML
			Point = "TOP",                                                -- XML
			OffsetX = 0,                                                  -- XML
			OffsetY = 0,                                                  -- XML
		},

		----------------------------------------
		-- NewItem                                                        --[11]--[DONE]
		---

		-- @ ContainerFrameItemButtonTemplate, ContainerFrame.xml
		NewItem = {
			Key = "NewItemTexture",
			Type = "Texture",

			Atlas = {                                                     -- XML
				ID = "bags-glow-green",
				UseSize = true,                                           -- XML

				Texture = [[Interface\ContainerFrame\Bags]],
				TexCoords = {0.703125, 0.855469, 0.00390625, 0.15625},

				Width = 39,
				Height = 39,
			},
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "ADD",                                            -- XML
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 2,                                                -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- XML
			OffsetY = 0,                                                  -- XML
		},

		----------------------------------------
		-- SearchOverlay                                                  --[12]--[DONE]
		---

		-- @ ItemButton, ItemButtonTemplate.xml
		SearchOverlay = {
			Key = "searchOverlay",
			Name = "SearchOverlay",
			Type = "Texture",

			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {0, 0, 0, 0.8},                                       -- XML
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 4,                                                -- XML
			Width = 37,                                                   -- XML / SetAllPoints
			Height = 37,                                                  -- XML / SetAllPoints

			SetAllPoints = true,                                          -- XML
		},

		----------------------------------------
		-- ItemContextOverlay                                             --[13]--[DONE]
		---

		-- @ ItemButton, ItemButtonTemplate.xml
		-- Unavailable in Classic.
		ItemContextOverlay = {
			Key = "ItemContextOverlay",
			Type = "Texture",

			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {0, 0, 0, 0.8},                                       -- XML
			BlendMode = "BLEND",                                          -- Default
			DrawLayer = "OVERLAY",                                        -- XML
			DrawLevel = 5,                                                -- XML
			Width = 37,                                                   -- XML / SetAllPoints
			Height = 37,                                                  -- XML / SetAllPoints

			SetAllPoints = true,                                          -- XML
		},

		----------------------------------------
		-- Highlight                                                      --[14]--[DONE]
		---

		-- @ Button, , ItemButtonTemplate.xml
		-- * Visible on mouse-over.
		Highlight = {
			Func = "GetHighlightTexture",
			Type = "Texture",

			Texture = [[Interface\Buttons\ButtonHilight-Square]],         -- XML
			TexCoords = {0, 1, 0, 1},                                     -- Default
			Color = {1, 1, 1, 1},                                         -- Default
			BlendMode = "ADD",                                            -- XML
			DrawLayer = "HIGHLIGHT",                                      -- In-Game
			DrawLevel = 0,                                                -- Default
			Width = 37,                                                   -- Inherited
			Height = 37,                                                  -- Inherited
			Point = "TOPLEFT",                                            -- Default
			OffsetX = 0,                                                  -- Default
			OffsetY = 0,                                                  -- Default
		},

		----------------------------------------
		-- Cooldown                                                       --[F2]--[DONE]
		---

		-- @ ContainerFrameItemButtonTemplate, ContainerFrame.xml
		Cooldown = {
			Name = "Cooldown",
			Type = "Frame",

			SwipeColor = {0, 0, 0, 0.8},                                  -- Normal
			--SwipeColor = {0.17, 0, 0, 0.8},                             -- LoC
			--SwipeColor = {1, 1, 1, 0.8},                                -- XML
			Width = 36,                                                   -- XML
			Height = 36,                                                  -- XML
			Point = "CENTER",                                             -- XML
			OffsetX = 0,                                                  -- XML
			OffsetY = -1,                                                 -- XML
		},
	},
}
