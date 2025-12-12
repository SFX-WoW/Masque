--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Skins\Modern_Enhanced.lua
	* Author.: StormFX, Blizzard Entertainment

	"Modern Enhanced" Skin

]]

local _, Core = ...

----------------------------------------
-- Internal
---

-- @ Locales\enUS
local L = Core.Locale

-- @ Skins\Skins
local Hidden = Core._Hidden

----------------------------------------
-- Modern Enhanced
---

Core.AddSkin("Modern Enhanced", {
	-- API_VERSION = Template.API_VERSION,
	Shape = "Modern",
	Template = "Blizzard Modern",

	-- Info
	Authors = {"StormFX", "|cff0099ffBlizzard Entertainment|r"},
	Description = L["An enhanced version of the modern button style."],
	Discord = Core.Discord,
	-- Version = Template.Version,
	Websites = Core.Websites,

	-- Skin
	-- Mask = Template.Mask,
	-- Backdrop = Template.Backdrop,
	-- Icon = Template.Icon,
	-- Shadow = Template.Shadow,
	-- Normal = Template.Normal,
	-- Disabled = Template.Disabled,
	-- Pushed = Template.Pushed,
	-- Flash = Template.Flash,
	-- Checked = Template.Checked,
	-- SlotHighlight = Template.SlotHighlight,
	-- Border = Template.Border,
	-- DebuffBorder = Template.DebuffBorder,
	-- EnchantBorder = Template.EnchantBorder,
	-- IconBorder = Template.IconBorder,
	Gloss = {
		Texture = [[Interface\AddOns\Masque\Textures\Modern\Gloss]],
		Color = {1, 1, 1, 0.8},
		Width = 52,
		Height = 52,
		Backpack = Hidden,
		BagSlot = Hidden,
		Item = Hidden,
	},
	-- NewAction = Template.NewAction,
	-- SpellHighlight = Template.SpellHighlight,
	-- IconOverlay = Template.IconOverlay,
	-- IconOverlay2 = Template.IconOverlay2,
	-- NewItem = Template.NewItem,
	-- QuestBorder = Template.QuestBorder,
	-- UpgradeIcon = Template.UpgradeIcon,
	-- ContextOverlay = Template.ContextOverlay,
	-- SearchOverlay = Template.SearchOverlay,
	-- JunkIcon = Template.JunkIcon,
	-- Duration = Template.Duration,
	-- Name = Template.Name,
	-- Highlight = Template.Highlight,
	-- [ TextOverlayContainer ]
	-- Count = Template.Count,
	-- HotKey = Template.HotKey,
	-- [ AutoCastShine (Classic) ]
	-- AutoCastable = Template.AutoCastable,
	-- AutoCastShine = Template.AutoCastShine,
	-- [ AutoCastOverlay (Retail) ]
	-- AutoCast_Frame = Template.AutoCast_Frame,
	-- AutoCast_Mask = Template.AutoCast_Mask,
	-- AutoCast_Shine = Template.AutoCast_Shine,
	-- AutoCast_Corners = Template.AutoCast_Corners,
	-- [ Cooldowns ]
	-- Cooldown = Template.Cooldown,
	-- ChargeCooldown = Template.ChargeCooldown,
	-- [ SpellAlerts ]
	-- SpellAlert = Template.SpellAlert,
	-- AssistedCombatHighlight = Template.AssistedCombatHighlight,
}, true)
