----------------------------------------
-- Setup
---

std = 'lua51'

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
	"print",

	-- WoW API
	"GetAddOnMetadata",
	"InterfaceOptionsFrame",
	"InterfaceOptionsFrame_OpenToCategory",
	"InterfaceOptionsFrame_Show",
	"ReloadUI",

	-- Libraries
	"LibStub",
}
