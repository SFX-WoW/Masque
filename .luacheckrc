----------------------------------------
-- Setup
---

std = 'lua51'

----------------------------------------
-- Path Exclusions
---

exclude_files = {
	".luacheckrc",
	".docs",
	"Libs",
	"Options/Widgets/",
}

----------------------------------------
-- Ignored Warnings
---

ignore = {
	"11./SLASH_.*", -- Undefined Global (Slash Handler)
	"212", -- Unused Argument
	"631", -- Line Length
}

----------------------------------------
-- Globals
---

globals = {
	-- WoW API
	"SlashCmdList",
}

----------------------------------------
-- Read-Only Globals
---

read_globals = {
	-- WoW Lua
	"assert",
	"hooksecurefunc",
	"print",
	"random",

	-- WoW API
	"CreateFrame",
	"GetAddOnMetadata",
	"GetBuildInfo",
	"GetLocale",
	"InCombatLockdown",
	"InterfaceOptionsFrame",
	"InterfaceOptionsFrame_OpenToCategory",
	"InterfaceOptionsFrame_Show",
	"ReloadUI",

	-- Libraries
	"LibStub",
}
