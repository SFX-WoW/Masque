--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Skins\Maul_Classic.lua
	* Author.: StormFX, Maul, Blizzard Entertainment

	"Classic Enhanced" Skin

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
local TEX_BAGSLOT = [[Interface\PaperDoll\UI-PaperDoll-Slot-Bag]]
local TEX_CHECKED = [[Interface\Buttons\CheckButtonHilight]]
local TEX_DEBUFF = [[Interface\Buttons\UI-Debuff-Overlays]]
local TEX_ENCHANT = [[Interface\Buttons\UI-TempEnchant-Border]]
local TEX_NORMAL = [[Interface\Buttons\UI-Quickslot2]]

----------------------------------------
-- Classic Enhanced
---

Core.AddSkin("Classic Enhanced", {
	-- API_VERSION = Template.API_VERSION,
	Shape = "Modern",
	Template = "Blizzard Classic",

	-- Info
	Authors = {"StormFX", "|cff999999Maul|r", "|cff999999Blizzard Entertainment|r"},
	Description = L["A modified version of the classic button style."],
	Discord = Core.Discord,
	-- Version = Template.Version,
	Websites = Core.Websites,

	-- Skin
	-- Mask = Template.Mask,
	Backdrop = {
		Texture = [[Interface\Buttons\UI-Quickslot]],
		Color = {1, 1, 1, 0.8},
		Width = 64,
		Height = 64,
		BagSlot = {
			Texture = TEX_BAGSLOT,
			Color = {1, 1, 1, 0.8},
		},
		Item = {
			Texture = TEX_BAGSLOT,
			Color = {1, 1, 1, 0.5},
		},
	},
	Icon = {
		TexCoords = {0.07, 0.93, 0.07, 0.93},
		Width = 32,
		Height = 32,
	},
	-- Shadow = Template.Shadow,
	Normal = {
		Texture = TEX_NORMAL,
		EmptyColor = {1, 1, 1, 0.5},
		Width = 60,
		Height = 60,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Pet = {
			Texture = TEX_NORMAL,
			Width = 58,
			Height = 58,
			OffsetX = 0.5,
			OffsetY = -0.5,
		},
	},
	-- Disabled = Template.Disabled,
	Pushed = {
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
		DrawLevel = 1,
	},
	Flash = {
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
		Color = {1, 1, 1, 0.75},
		Width = 34,
		Height = 34,
	},
	Checked = {
		Texture = TEX_CHECKED,
		Color = {1, 1, 1, 0.8},
		BlendMode = STR_ADD,
		Width = 33,
		Height = 33,
		Pet = {
			Texture = TEX_CHECKED,
			Color = {1, 1, 1, 0.8},
			BlendMode = STR_ADD,
			Width = 32,
			Height = 32,
		},
	},
	SlotHighlight = {
		Texture = TEX_CHECKED,
		Width = 33,
		Height = 33,
	},
	Border = {
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		BlendMode = STR_ADD,
		Width = 57,
		Height = 57,
		OffsetX = 0.5,
		OffsetY = 0.5,
		Debuff = {
			Texture = TEX_DEBUFF,
			TexCoords = {0.296875, 0.5703125, 0, 0.515625},
			Width = 40,
			Height = 38,
			OffsetY = 1,
		},
		Enchant = {
			Texture = TEX_ENCHANT,
			Width = 40,
			Height = 40,
		},
	},
	DebuffBorder = {
		Texture = TEX_DEBUFF,
		TexCoords = {0.296875, 0.5703125, 0, 0.515625},
		Width = 40,
		Height = 38,
		OffsetY = 1,
	},
	EnchantBorder = {
		Texture = TEX_ENCHANT,
		Width = 40,
		Height = 40,
	},
	-- IconBorder = Template.IconBorder,
	-- Gloss = Template.Gloss,
	-- NewAction = Template.NewAction,
	-- SpellHighlight = Template.SpellHighlight,
	-- IconOverlay = Template.IconOverlay,
	-- IconOverlay2 = Template.IconOverlay2,
	NewItem = {
		Atlas = "bags-newitem",
		BlendMode = STR_ADD,
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
		OffsetY = -1,
	},
	-- ContextOverlay = Template.ContextOverlay,
	-- SearchOverlay = Template.SearchOverlay,
	JunkIcon = {
		Atlas = "bags-junkcoin",
		UseAtlasSize = true,
		OffsetX = 1,
	},
	-- Duration = Template.Duration,
	-- Name = Template.Name,
	Highlight = {
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
		Width = 32,
		Height = 32,
	},
	-- [ TextOverlayContainer (Retail) ]
	-- Count = Template.Count,
	-- HotKey = Template.HotKey,
	-- [ AutoCastShine (Classic) ]
	AutoCastable = {
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
		Width = 66,
		Height = 66,
		OffsetX = 0.5,
		OffsetY = -0.5,
	},
	AutoCastShine = {
		Width = 32,
		Height = 32,
		OffsetX = 0.5,
		OffsetY = -0.5,
	},
	-- [ AutoCastOverlay (Retail) ]
	-- AutoCast_Frame = Template.AutoCast_Frame,
	-- AutoCast_Shine = Template.AutoCast_Shine,
	AutoCast_Mask = {
		Texture = [[Interface\AddOns\Masque\Textures\Modern\AutoCast-Mask]],
		Width = 28,
		Height = 28,
	},
	AutoCast_Corners = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Corners",
		Width = 36,
		Height = 36,
	},
	-- [ Cooldowns ]
	Cooldown = {
		Texture = [[Interface\AddOns\Masque\Textures\Modern\Mask]],
		EdgeTexture = [[Interface\AddOns\Masque\Textures\Modern\Edge]],
		PulseTexture = [[Interface\Cooldown\star4]],
		Color = {0, 0, 0, 0.8},
		Width = 32,
		Height = 32,
	},
	CooldownLoC = "Cooldown",
	ChargeCooldown = "Cooldown",
	-- [ SpellAlerts ]
	SpellAlert = {
		Height = 40,
		Width = 40,
		AltGlow = {
			Height = 46.5,
			Width = 46.5,
		},
		Classic = {
			Height = 32,
			Width = 32,
		},
		Modern = {
			Height = 32,
			Width = 32,
		},
		["Modern-Lite"] = {
			Height = 33,
			Width = 33,
		},
	},
	AssistedCombatHighlight = {
		Width = 46.5,
		Height = 46.5,
	},
}, true)
