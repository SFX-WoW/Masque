--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Skins\Dream.lua
	* Author.: StormFX, JJSheets

	"Dream" Skin

]]

local _, Core = ...

----------------------------------------
-- Internal
---

-- @ Locales\enUS
local L = Core.Locale

----------------------------------------
-- Locals
---

-- String Constants
local STR_ADD = "ADD"

-- Texture Strings
local TEX_DEBUFF = [[Interface\Buttons\UI-Debuff-Overlays]]
local TEX_ENCHANT = [[Interface\Buttons\UI-TempEnchant-Border]]

----------------------------------------
-- Dream
---

Core.AddSkin("Dream", {
	-- API_VERSION = Template.API_VERSION,
	Shape = "Square",
	Template = "Blizzard Classic",

	-- Info
	Authors = Core.Authors,
	Description = L["A square skin with trimmed icons and a semi-transparent background."],
	Discord = Core.Discord,
	-- Version = Template.Version,
	Websites = Core.Websites,

	-- Skin
	-- Mask = Template.Mask,
	Backdrop = {
		Color = {0, 0, 0, 0.5},
		UseColor = true,
	},
	Icon = {
		TexCoords = {0.08, 0.92, 0.08, 0.92},
		Width = 30,
		Height = 30,
	},
	-- Shadow = Template.Shadow,
	Normal = Core._Hidden,
	-- Disabled = Template.Disabled,
	Pushed = {
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
		DrawLevel = 1,
		Width = 32,
		Height = 32,
	},
	Flash = {
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
		TexCoords = {0.2, 0.8, 0.2, 0.8},
		Color = {1, 1, 1, 0.75},
		Width = 30,
		Height = 30,
	},
	Checked = {
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		BlendMode = STR_ADD,
		Width = 32,
		Height = 32,
	},
	SlotHighlight = "Checked",
	Border = {
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		BlendMode = STR_ADD,
		Width = 54,
		Height = 54,
		Debuff = {
			Texture = TEX_DEBUFF,
			TexCoords = {0.296875, 0.5703125, 0, 0.515625},
			Width = 36,
			Height = 34,
		},
		Enchant = {
			Texture = TEX_ENCHANT,
		},
		Item = {
			Texture = [[Interface\Common\WhiteIconFrame]],
			Width = 34,
			Height = 34,
		},
	},
	DebuffBorder = {
		Texture = TEX_DEBUFF,
		TexCoords = {0.296875, 0.5703125, 0, 0.515625},
		Width = 36,
		Height = 34,
	},
	EnchantBorder = {
		Texture = TEX_ENCHANT,
	},
	IconBorder = {
		Texture = [[Interface\Common\WhiteIconFrame]],
		RelicTexture = [[Interface\Artifacts\RelicIconFrame]],
		Width = 34,
		Height = 34,
	},
	-- Gloss = Template.Gloss,
	NewAction = {
		Atlas = "bags-newitem",
		BlendMode = STR_ADD,
		Width = 38,
		Height = 38,
	},
	SpellHighlight = "NewAction",
	IconOverlay = {
		Atlas = "AzeriteIconFrame",
		Width = 34,
		Height = 34,
	},
	IconOverlay2 = {
		Atlas = "ConduitIconFrame-Corners",
		Width = 34,
		Height = 34,
	},
	NewItem = {
		Atlas = "bags-glow-white",
		Width = 30,
		Height = 30,
	},
	QuestBorder = {
		Border = [[Interface\ContainerFrame\UI-Icon-QuestBang]],
		Texture = [[Interface\ContainerFrame\UI-Icon-QuestBorder]],
		Width = 32,
		Height = 32,
	},
	UpgradeIcon = {
		Atlas = "bags-greenarrow",
		UseAtlasSize = true,
		OffsetX = 1,
		OffsetY = -2,
	},
	ContextOverlay = {
		Color = {0, 0, 0, 0.8},
		Width = 32,
		Height = 32,
		UseColor = true,
	},
	SearchOverlay = "ContextOverlay",
	JunkIcon = {
		Atlas = "bags-junkcoin",
		UseAtlasSize = true,
		OffsetX = 2,
		OffsetY = -1,
	},
	-- Duration = Template.Duration,
	-- Name = Template.Name,
	Highlight = {
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
		Width = 30,
		Height = 30,
	},
	-- [ TextOverlayContainer (Retail) ]
	-- Count = Template.Count,
	-- HotKey = Template.HotKey,
	-- [ AutoCastShine (Classic) ]
	AutoCastable = {
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
		Width = 56,
		Height = 56,
		OffsetX = 0.5,
		OffsetY = -0.5,
	},
	AutoCastShine = {
		Width = 28,
		Height = 28,
		OffsetX = 0.5,
		OffsetY = -0.5,
	},
	-- [ AutoCastOverlay (Retail) ]
	-- AutoCast_Frame = Template.AutoCast_Frame,
	-- AutoCast_Shine = Template.AutoCast_Shine,
	AutoCast_Mask = {
		Texture = [[Interface\AddOns\Masque\Textures\Square\AutoCast-Mask]],
		Width = 28,
		Height = 28,
	},
	AutoCast_Corners = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Corners",
		Width = 32,
		Height = 32,
	},
	-- [ Cooldowns ]
	Cooldown = {
		Texture = [[Interface\AddOns\Masque\Textures\Square\Mask]],
		EdgeTexture = [[Interface\AddOns\Masque\Textures\Square\Edge]],
		PulseTexture = [[Interface\Cooldown\star4]],
		Color = {0, 0, 0, 0.8},
		Width = 30,
		Height = 30,
	},
	CooldownLoC = "Cooldown",
	ChargeCooldown = "Cooldown",
	-- [ SpellAlerts ]
	SpellAlert = {
		Width = 34,
		Height = 34,
		AltGlow = {
			Height = 40,
			Width = 40,
		},
		Classic = {
			Height = 30,
			Width = 30,
		},
		Modern = {
			Height = 29,
			Width = 29,
		},
		["Modern-Lite"] = {
			Height = 28.5,
			Width = 28.5,
		},
	},
	AssistedCombatHighlight = {
		Width = 40,
		Height = 40,
	},
}, true)
