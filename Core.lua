--[[
	Project.: ButtonFacade
	File....: Core.lua
	Version.: @file-revision@
	Author..: StormFX, JJ Sheets
]]

-- Get the private table.
local AddOn, ns = ...

-- [ Set Up ] --

local LBF = LibStub("LibButtonFacade")
if not LBF then return end
local BF = LibStub("AceAddon-3.0"):NewAddon(AddOn, "AceConsole-3.0")

-- [ Locals ] --

local L = ns.L
local pairs, gsub, format = pairs, gsub, format

-- [ Core Methods ] --

-- Initialize the add-on.
function BF:OnInitialize()
	local defaults = {
		profile = {
			SkinID = "Blizzard",
			Gloss = false,
			Backdrop = false,
			Colors = {},
		},
	}
	self.db = LibStub("AceDB-3.0"):New("ButtonFacadeDB", nil, true)
	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")
	self.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.options.args.profiles.order = 100
end

-- Enable function.
function BF:OnEnable()
	-- Set up the global skin
	LBF:RegisterSkinCallback(AddOn, self.SkinCallback, self)
	LBF:Group():Skin(self.db.profile.SkinID, self.db.profile.Gloss, self.db.profile.Backdrop, self.db.profile.Colors)

	-- Update the elements.
	LBF:RegisterGuiCallback(self.ElementListUpdate, self)

	-- Set up options.
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(AddOn, self.options)
	local ACD = LibStub("AceConfigDialog-3.0")
	self.OptionsPanel = ACD:AddToBlizOptions(self.name, self.name, nil, "global")
	self.OptionsPanel.Addons = ACD:AddToBlizOptions(self.name, L["Addons"], self.name, "addons")
	self.OptionsPanel.Profiles = ACD:AddToBlizOptions(self.name, L["Profiles"], self.name, "profiles")
	self:RegisterChatCommand("bf", function() self:OpenOptions() end)
	self:RegisterChatCommand("buttonfacade", function() self:OpenOptions() end)
end

-- Opens the options window.
function BF:OpenOptions()
	InterfaceOptionsFrame_OpenToCategory(self.OptionsPanel.Profiles)
	InterfaceOptionsFrame_OpenToCategory(self.OptionsPanel)
end

-- Reloads settings on profile activity.
function BF:Refresh()
	LBF:Group():SetSkin(self.db.profile.SkinID, self.db.profile.Gloss, self.db.profile.Backdrop, self.db.profile.Colors)
end

-- Callback function to store settings.
function BF:SkinCallback(SkinID, Gloss, Backdrop, Group, Button, Colors)
	if not Group then
		self.db.profile.SkinID = SkinID
		self.db.profile.Gloss = Gloss
		self.db.profile.Backdrop = Backdrop
		self.db.profile.Colors = Colors
	end
end

-- [ Core GUI Options ] --

BF.options = {
	type = "group",
	name = AddOn,
	args = {
		global = {},
		addons = {
			type = "group",
			name = L["Addons"],
			order = 2,
			args = {
				desc = {
					type = "description",
					name = L["ADDON_INFO"].."\n",
					order = 1
				},
			},
		},
	},
}

do
	local function getState(info)
		local LBFGroup, layer = info.arg[1], info.arg[2]
		local list = LBF:GetSkins()
		return list[LBFGroup.SkinID][layer].Hide
	end
	local function getSkin(info)
		return info.arg.SkinID
	end
	local function setSkin(info, value)
		local LBFGroup = info.arg
		LBFGroup:Skin(value, LBFGroup.Gloss, LBFGroup.Backdrop)
	end
	local function getGloss(info)
		return info.arg[1].Gloss or 0
	end
	local function setGloss(info, value)
		local LBFGroup = info.arg[1]
		LBFGroup:Skin(LBFGroup.SkinID, value, LBFGroup.Backdrop)
	end
	local function getBackdrop(info)
		return info.arg[1].Backdrop
	end
	local function setBackdrop(info, value)
		local LBFGroup = info.arg[1]
		LBFGroup:Skin(LBFGroup.SkinID, LBFGroup.Gloss, value and true or false)
	end
	local function getLayerColor(info)
		local LBFGroup, layer = info.arg[1], info.arg[2]
		return LBFGroup:GetLayerColor(layer)
	end
	local function setLayerColor(info, r,g,b,a)
		local LBFGroup, layer = info.arg[1], info.arg[2]
		LBFGroup:Skin(LBFGroup.SkinID, LBFGroup.Gloss, LBFGroup.Backdrop, layer, r, g, b, a)
	end
	local function resetColors(info)
		info.arg:ResetColors()
	end
	local args
	do
		local LBFGroup = LBF:Group()
		BF.options.args.global = {
			type = "group",
			name = L["Global Settings"],
			order = 1,
			args = {
				__bf_header = {
					type = "description",
					name = L["GLOBAL_INFO"].."\n",
					order = 1,
				},
				__bf_skin = {
					type = "select",
					name = L["Skin"],
					desc = L["Set the skin."],
					get = getSkin,
					set = setSkin,
					arg = LBFGroup,
					style = "dropdown",
					width = "full",
					values = LBF.ListSkins,
					order = 2,
				},
				__bf_gloss = {
					type = "range",
					name = L["Gloss"],
					desc = L["Set the intensity of the gloss."],
					get = getGloss,
					set = setGloss,
					arg = {LBFGroup, "Gloss"},
					min = 0,
					max = 1,
					step = 0.01,
					width = "full",
					isPercent = true,
					disabled = getState,
					order = 3,
				},
				__bf_backdrop = {
					type = "toggle",
					name = L["Backdrop"],
					desc = L["Toggle the backdrop."],
					get = getBackdrop,
					set = setBackdrop,
					arg = {LBFGroup, "Backdrop"},
					width = "half",
					disabled = getState,
					order = 4,
				},
				__bf_ColorHeading = {
					type = "header",
					name = L["Color Options"],
					order = 5,
				},
				__bf_ColorBackdrop = {
					type = "color",
					name = L["Backdrop"],
					desc = L["Set the %s color."]:format(L["Backdrop"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Backdrop"},
					hasAlpha = true,
					disabled = getState,
					order = 6,
				},
				__bf_ColorFlash = {
					type = "color",
					name = L["Flash"],
					desc = L["Set the %s color."]:format(L["Flash"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Flash"},
					hasAlpha = true,
					disabled = getState,
					order = 7,
				},
				__bf_ColorNormal = {
					type = "color",
					name = L["Normal"],
					desc = L["Set the %s color."]:format(L["Normal"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Normal"},
					hasAlpha = true,
					disabled = getState,
					order = 8,
				},
				__bf_ColorPushed = {
					type = "color",
					name = L["Pushed"],
					desc = L["Set the %s color."]:format(L["Pushed"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Pushed"},
					hasAlpha = true,
					disabled = getState,
					order = 9,
				},
				__bf_ColorDisabled = {
					type = "color",
					name = L["Disabled"],
					desc = L["Set the %s color."]:format(L["Disabled"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Disabled"},
					hasAlpha = true,
					disabled = getState,
					order = 10,
				},
				__bf_ColorChecked = {
					type = "color",
					name = L["Checked"],
					desc = L["Set the %s color."]:format(L["Checked"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Checked"},
					hasAlpha = true,
					disabled = getState,
					order = 11,
				},
				__bf_ColorBorder = {
					type = "color",
					name = L["Equipped"],
					desc = L["Set the %s color."]:format(L["Equipped"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Border"},
					hasAlpha = true,
					disabled = getState,
					order = 12,
				},
				__bf_ColorHighlight = {
					type = "color",
					name = L["Highlight"],
					desc = L["Set the %s color."]:format(L["Highlight"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Highlight"},
					hasAlpha = true,
					disabled = getState,
					order = 13,
				},
				__bf_ColorGloss = {
					type = "color",
					name = L["Gloss"],
					desc = L["Set the %s color."]:format(L["Flash"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup,"Gloss"},
					disabled = getState,
					order = 14,
				},
				__bf_ResetColors = {
					type = "execute",
					name = L["Reset Colors"],
					desc = L["Reset all colors."],
					func = resetColors,
					arg = LBFGroup,
					order = 15,
				},
			},
		}
		args = BF.options.args.addons.args
	end
	local function CreateAddonOptions(addon)
		local LBFGroup = LBF:Group(addon)
		return {
			type = "group",
			name = addon,
			args = {
				__bf_header = {
					type = "description",
					name = L["Apply skin to all buttons registered with %s."]:format(addon),
					order = 1,
				},
				__bf_skin = {
					type = "select",
					name = L["Skin"],
					desc = L["Set the skin."],
					get = getSkin,
					set = setSkin,
					arg = LBFGroup,
					style = "dropdown",
					width = "full",
					values = LBF.ListSkins,
					order = 2,
				},
				__bf_gloss = {
					type = "range",
					name = L["Gloss"],
					desc = L["Set the intensity of the gloss."],
					get = getGloss,
					set = setGloss,
					arg = {LBFGroup, "Gloss"},
					min = 0,
					max = 1,
					step = 0.01,
					width = "full",
					isPercent = true,
					disabled = getState,
					order = 3,
				},
				__bf_backdrop = {
					type = "toggle",
					name = L["Backdrop"],
					desc = L["Toggle the backdrop."],
					get = getBackdrop,
					set = setBackdrop,
					arg = {LBFGroup, "Backdrop"},
					width = "half",
					disabled = getState,
					order = 4,
				},
				__bf_ColorHeading = {
					type = "header",
					name = L["Color Options"],
					order = 5,
				},
				__bf_ColorBackdrop = {
					type = "color",
					name = L["Backdrop"],
					desc = L["Set the %s color."]:format(L["Backdrop"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Backdrop"},
					hasAlpha = true,
					disabled = getState,
					order = 6,
				},
				__bf_ColorFlash = {
					type = "color",
					name = L["Flash"],
					desc = L["Set the %s color."]:format(L["Flash"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Flash"},
					hasAlpha = true,
					disabled = getState,
					order = 7,
				},
				__bf_ColorNormal = {
					type = "color",
					name = L["Normal"],
					desc = L["Set the %s color."]:format(L["Normal"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Normal"},
					hasAlpha = true,
					disabled = getState,
					order = 8,
				},
				__bf_ColorPushed = {
					type = "color",
					name = L["Pushed"],
					desc = L["Set the %s color."]:format(L["Pushed"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Pushed"},
					hasAlpha = true,
					disabled = getState,
					order = 9,
				},
				__bf_ColorDisabled = {
					type = "color",
					name = L["Disabled"],
					desc = L["Set the %s color."]:format(L["Disabled"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Disabled"},
					hasAlpha = true,
					disabled = getState,
					order = 10,
				},
				__bf_ColorChecked = {
					type = "color",
					name = L["Checked"],
					desc = L["Set the %s color."]:format(L["Checked"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Checked"},
					hasAlpha = true,
					disabled = getState,
					order = 11,
				},
				__bf_ColorBorder = {
					type = "color",
					name = L["Equipped"],
					desc = L["Set the %s color."]:format(L["Equipped"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Border"},
					hasAlpha = true,
					disabled = getState,
					order = 12,
				},
				__bf_ColorHighlight = {
					type = "color",
					name = L["Highlight"],
					desc = L["Set the %s color."]:format(L["Highlight"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Highlight"},
					hasAlpha = true,
					disabled = getState,
					order = 13,
				},
				__bf_ColorGloss = {
					type = "color",
					name = L["Gloss"],
					desc = L["Set the %s color."]:format(L["Flash"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Gloss"},
					disabled = getState,
					order = 14,
				},
				__bf_ResetColors = {
					type = "execute",
					name = L["Reset Colors"],
					desc = L["Reset all colors."],
					func = resetColors,
					arg = LBFGroup,
					order = 15,
				},
			},
		}
	end
	local function CreateGroupOptions(addon, group)
		local LBFGroup = LBF:Group(addon, group)
		return {
			type = "group",
			name = group,
			args = {
				__bf_header = {
					type = "description",
					name = L["Apply skin to all buttons registered with %s: %s."]:format(addon, group),
					order = 1,
				},
				__bf_skin = {
					type = "select",
					name = L["Skin"],
					desc = L["Set the skin."],
					get = getSkin,
					set = setSkin,
					arg = LBFGroup,
					style = "dropdown",
					width = "full",
					values = LBF.ListSkins,
					order = 2,
				},
				__bf_gloss = {
					type = "range",
					name = L["Gloss"],
					desc = L["Set the intensity of the gloss."],
					get = getGloss,
					set = setGloss,
					arg = {LBFGroup, "Gloss"},
					min = 0,
					max = 1,
					step = 0.01,
					width = "full",
					isPercent = true,
					disabled = getState,
					order = 3,
				},
				__bf_backdrop = {
					type = "toggle",
					name = L["Backdrop"],
					desc = L["Toggle the backdrop."],
					get = getBackdrop,
					set = setBackdrop,
					arg = {LBFGroup, "Backdrop"},
					width = "half",
					disabled = getState,
					order = 4,
				},
				__bf_ColorHeading = {
					type = "header",
					name = L["Color Options"],
					order = 5,
				},
				__bf_ColorBackdrop = {
					type = "color",
					name = L["Backdrop"],
					desc = L["Set the %s color."]:format(L["Backdrop"]),
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {LBFGroup, "Backdrop"},
					disabled = getState,
					order = 6,
				},
				__bf_ColorFlash = {
					type = "color",
					name = L["Flash"],
					desc = L["Set the %s color."]:format(L["Flash"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Flash"},
					hasAlpha = true,
					disabled = getState,
					order = 7,
				},
				__bf_ColorNormal = {
					type = "color",
					name = L["Normal"],
					desc = L["Set the %s color."]:format(L["Normal"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Normal"},
					hasAlpha = true,
					disabled = getState,
					order = 8,
				},
				__bf_ColorPushed = {
					type = "color",
					name = L["Pushed"],
					desc = L["Set the %s color."]:format(L["Pushed"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Pushed"},
					hasAlpha = true,
					disabled = getState,
					order = 9,
				},
				__bf_ColorDisabled = {
					type = "color",
					name = L["Disabled"],
					desc = L["Set the %s color."]:format(L["Disabled"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Disabled"},
					hasAlpha = true,
					disabled = getState,
					order = 10,
				},
				__bf_ColorChecked = {
					type = "color",
					name = L["Checked"],
					desc = L["Set the %s color."]:format(L["Checked"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Checked"},
					hasAlpha = true,
					disabled = getState,
					order = 11,
				},
				__bf_ColorBorder = {
					type = "color",
					name = L["Equipped"],
					desc = L["Set the %s color."]:format(L["Equipped"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Border"},
					hasAlpha = true,
					disabled = getState,
					order = 12,
				},
				__bf_ColorHighlight = {
					type = "color",
					name = L["Highlight"],
					desc = L["Set the %s color."]:format(L["Highlight"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Highlight"},
					hasAlpha = true,
					disabled = getState,
					order = 13,
				},
				__bf_ColorGloss = {
					type = "color",
					name = L["Gloss"],
					desc = L["Set the %s color."]:format(L["Flash"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Gloss"},
					disabled = getState,
					order = 14,
				},
				__bf_ResetColors = {
					type = "execute",
					name = L["Reset Colors"],
					desc = L["Reset all colors."],
					func = resetColors,
					arg = LBFGroup,
					order = 15,
				},
			},
		}
	end
	local function CreateButtonOptions(addon, group, button)
		local LBFGroup = LBF:Group(addon, group, button)
		return {
			type = "group",
			name = button,
			args = {
				__bf_header = {
					type = "description",
					name = L["Apply skin to all buttons registered with %s: %s/%s."]:format(addon, group, button),
					order = 1,
				},
				__bf_skin = {
					type = "select",
					name = L["Skin"],
					desc = L["Set the skin."],
					get = getSkin,
					set = setSkin,
					arg = LBFGroup,
					style = "dropdown",
					width = "full",
					values = LBF.ListSkins,
					order = 2,
				},
				__bf_gloss = {
					type = "range",
					name = L["Gloss"],
					desc = L["Set the intensity of the gloss."],
					get = getGloss,
					set = setGloss,
					arg = {LBFGroup, "Gloss"},
					min = 0,
					max = 1,
					step = 0.01,
					width = "full",
					isPercent = true,
					disabled = getState,
					order = 3,
				},
				__bf_backdrop = {
					type = "toggle",
					name = L["Backdrop"],
					desc = L["Toggle the backdrop."],
					get = getBackdrop,
					set = setBackdrop,
					arg = {LBFGroup, "Backdrop"},
					width = "half",
					disabled = getState,
					order = 4,
				},
				__bf_ColorHeading = {
					type = "header",
					name = L["Color Options"],
					order = 5,
				},
				__bf_ColorBackdrop = {
					type = "color",
					name = L["Backdrop"],
					desc = L["Set the %s color."]:format(L["Backdrop"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Backdrop"},
					hasAlpha = true,
					disabled = getState,
					order = 6,
				},
				__bf_ColorFlash = {
					type = "color",
					name = L["Flash"],
					desc = L["Set the %s color."]:format(L["Flash"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Flash"},
					hasAlpha = true,
					disabled = getState,
					order = 7,
				},
				__bf_ColorNormal = {
					type = "color",
					name = L["Normal"],
					desc = L["Set the %s color."]:format(L["Normal"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Normal"},
					hasAlpha = true,
					disabled = getState,
					order = 8,
				},
				__bf_ColorPushed = {
					type = "color",
					name = L["Pushed"],
					desc = L["Set the %s color."]:format(L["Pushed"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Pushed"},
					hasAlpha = true,
					disabled = getState,
					order = 9,
				},
				__bf_ColorDisabled = {
					type = "color",
					name = L["Disabled"],
					desc = L["Set the %s color."]:format(L["Disabled"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Disabled"},
					hasAlpha = true,
					disabled = getState,
					order = 10,
				},
				__bf_ColorChecked = {
					type = "color",
					name = L["Checked"],
					desc = L["Set the %s color."]:format(L["Checked"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Checked"},
					hasAlpha = true,
					disabled = getState,
					order = 11,
				},
				__bf_ColorBorder = {
					type = "color",
					name = L["Equipped"],
					desc = L["Set the %s color."]:format(L["Equipped"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Border"},
					hasAlpha = true,
					disabled = getState,
					order = 12,
				},
				__bf_ColorHighlight = {
					type = "color",
					name = L["Highlight"],
					desc = L["Set the %s color."]:format(L["Highlight"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Highlight"},
					hasAlpha = true,
					disabled = getState,
					order = 13,
				},
				__bf_ColorGloss = {
					type = "color",
					name = L["Gloss"],
					desc = L["Set the %s color."]:format(L["Flash"]),
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Gloss"},
					disabled = getState,
					order = 14,
				},
				__bf_ResetColors = {
					type = "execute",
					name = L["Reset Colors"],
					desc = L["Reset all colors."],
					func = resetColors,
					arg = LBFGroup,
					order = 15,
				},
			},
		}
	end
	function BF:ElementListUpdate(addon, group)
		if not addon then
			for _, addon in pairs(LBF:ListAddons()) do
				local cAddon = addon:gsub("%s","_")
				args[cAddon] = args[cAddon] or CreateAddonOptions(addon)
				args[cAddon].hidden = false
			end
		elseif not group then
			local cAddon = addon:gsub("%s","_")
			for _, group in pairs(LBF:ListGroups(addon)) do
				local cGroup = group:gsub("%s","_")
				local addonArgs = args[cAddon].args
				addonArgs[cGroup] = addonArgs[cGroup] or CreateGroupOptions(addon, group)
			end
		else
			local cAddon = addon:gsub("%s","_")
			local cGroup = group:gsub("%s","_")
			for _, button in pairs(LBF:ListButtons(addon, group)) do
				local cButton = button:gsub("%s","_")
				local groupArgs = args[cAddon].args[cGroup].args
				groupArgs[cButton] = groupArgs[cButton] or CreateButtonOptions(addon, group, button)
			end
		end
	end
end
