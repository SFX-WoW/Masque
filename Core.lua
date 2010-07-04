--[[
	Project.: ButtonFacade
	File....: Core.lua
	Version.: @file-revision@
	Author..: StormFX, JJ Sheets
]]

-- Get the private table.
local AddOn, ns = ...

-- [ Set Up ] --

local LBF = LibStub("LibButtonFacade", true)
if not LBF then return end
local BF = LibStub("AceAddon-3.0"):NewAddon(AddOn, "AceConsole-3.0")

-- [ Locals ] --

local pairs, gsub, format = pairs, gsub, format
local L = ns.L

-- [ Core Options ] --

BF.Options = {
	type = "group",
	name = AddOn,
	args = {
		General = {
			type = "group",
			name = AddOn,
			order = 1,
			args = {
				desc = {
					type = "description",
					name = L["BF_INFO"].."\n",
					order = 1,
				},
			},
		},
		Addons = {
			type = "group",
			name = L["Add-Ons"],
			order = 2,
			args = {
				desc = {
					type = "description",
					name = L["ADDON_INFO"].."\n",
					order = 1,
				},
			},
		},
	},
}

-- [ Core Methods ] --

-- Initialize function.
function BF:OnInitialize()
	-- Set up saved variables.
	local defaults = {
		profile = {
			SkinID = "Blizzard",
			Gloss = false,
			Backdrop = false,
			Colors = {},
		},
	}
	self.db = LibStub("AceDB-3.0"):New("ButtonFacadeDB", defaults, true)
	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")
	self.Options.args.Profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.Options.args.Profiles.order = 100
end

-- Enable function.
function BF:OnEnable()
	-- Set up the global skin.
	LBF:RegisterSkinCallback(AddOn, self.SkinCallback, self)
	LBF:Group():Skin(self.db.profile.SkinID, self.db.profile.Gloss, self.db.profile.Backdrop, self.db.profile.Colors)
	-- Register the GUI callback.
	LBF:RegisterGuiCallback(self.GuiUpdate, self)
	-- Set up options panels.
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(AddOn, self.Options)
	local ACD = LibStub("AceConfigDialog-3.0")
	self.OptionsPanel = ACD:AddToBlizOptions(AddOn, AddOn, nil, "General")
	self.OptionsPanel.Addons = ACD:AddToBlizOptions(AddOn, L["Add-Ons"], AddOn, "Addons")
	self.OptionsPanel.Profiles = ACD:AddToBlizOptions(AddOn, L["Profiles"], AddOn, "Profiles")
	-- Register the chat commands.
	self:RegisterChatCommand("bf", function() self:OpenOptions() end)
	self:RegisterChatCommand("buttonfacade", function() self:OpenOptions() end)
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

-- Opens the options window.
function BF:OpenOptions()
	InterfaceOptionsFrame_OpenToCategory(self.OptionsPanel.Profiles)
	InterfaceOptionsFrame_OpenToCategory(self.OptionsPanel)
end

-- [ GUI Updater ] --
do
	-- Gets the skin.
	local function GetSkin(info)
		return info.arg.SkinID
	end
	-- Sets the skin.
	local function SetSkin(info, value)
		local LBFGroup = info.arg
		LBFGroup:Skin(value, LBFGroup.Gloss, LBFGroup.Backdrop)
	end
	-- Gets the gloss.
	local function GetGloss(info)
		return info.arg[1].Gloss or 0
	end
	-- Sets the gloss.
	local function SetGloss(info, value)
		local LBFGroup = info.arg[1]
		LBFGroup:Skin(LBFGroup.SkinID, value, LBFGroup.Backdrop)
	end
	-- Gets the backdrop.
	local function GetBackdrop(info)
		return info.arg[1].Backdrop
	end
	-- Sets the backdrop.
	local function SetBackdrop(info, value)
		local LBFGroup = info.arg[1]
		LBFGroup:Skin(LBFGroup.SkinID, LBFGroup.Gloss, value and true or false)
	end
	-- Gets a layer's color.
	local function GetLayerColor(info)
		local LBFGroup, layer = info.arg[1], info.arg[2]
		return LBFGroup:GetLayerColor(layer)
	end
	-- Sets a layer's color.
	local function SetLayerColor(info, r,g,b,a)
		local LBFGroup, layer = info.arg[1], info.arg[2]
		LBFGroup:Skin(LBFGroup.SkinID, LBFGroup.Gloss, LBFGroup.Backdrop, layer, r, g, b, a)
	end
	-- Resets all colors.
	local function ResetAllColors(info)
		info.arg:ResetColors()
	end
	-- Gets the hidden state of a layer.
	local function GetState(info)
		local LBFGroup, layer = info.arg[1], info.arg[2]
		local list = LBF:GetSkins()
		return list[LBFGroup.SkinID][layer].Hide
	end
	local function GetBackdropState(info)
		return not info.arg[1].Backdrop
	end
	local function CreateOptions(addon, group, button)
		local LBFGroup = LBF:Group(addon, group, button)
		local name, desc
		if button then
			name = button
			desc = L["Apply skin to all buttons registered with %s: %s/%s."]:format(addon, group, button)
		elseif group then
			name = group
			desc = L["Apply skin to all buttons registered with %s: %s."]:format(addon, group)
		elseif addon then
			name = addon
			desc = L["Apply skin to all buttons registered with %s."]:format(addon)
		else
			name = L["Global Settings"]
			desc = L["GLOBAL_INFO"]
		end
		return {
			type = "group",
			name = name,
			args = {
				Info = {
					type = "description",
					name = desc.."\n",
					order = 1,
				},
				Skin = {
					type = "select",
					name = L["Skin"],
					desc = L["Set the skin."],
					get = GetSkin,
					set = SetSkin,
					arg = LBFGroup,
					style = "dropdown",
					width = "full",
					values = LBF.ListSkins,
					order = 2,
				},
				Spacer = {
					type = "description",
					name = " ",
					order = 3,
				},
				Gloss = {
					type = "group",
					name = L["Gloss Settings"],
					order = 4,
					inline = true,
					args = {
						Color = {
							type = "color",
							name = L["Color"],
							desc = L["Set the %s color."]:format(L["Gloss"]),
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {LBFGroup, "Gloss"},
							disabled = GetState,
							order = 1,
						},
						Opacity = {
							type = "range",
							name = L["Opacity"],
							desc = L["Set the intensity of the gloss."],
							get = GetGloss,
							set = SetGloss,
							arg = {LBFGroup, "Gloss"},
							min = 0,
							max = 1,
							step = 0.01,
							isPercent = true,
							disabled = GetState,
							order = 2,
						},
					},
				},
				States = {
					type = "group",
					name = L["State Colors"],
					order = 5,
					inline = true,
					args = {
						Normal = {
							type = "color",
							name = L["Normal"],
							desc = L["Set the %s color."]:format(L["Normal"]),
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {LBFGroup, "Normal"},
							hasAlpha = true,
							disabled = GetState,
							order = 1,
						},
						Highlight = {
							type = "color",
							name = L["Highlight"],
							desc = L["Set the %s color."]:format(L["Highlight"]),
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {LBFGroup, "Highlight"},
							hasAlpha = true,
							disabled = GetState,
							order = 2,
						},
						Checked = {
							type = "color",
							name = L["Checked"],
							desc = L["Set the %s color."]:format(L["Checked"]),
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {LBFGroup, "Checked"},
							hasAlpha = true,
							disabled = GetState,
							order = 3,
						},
						Flash = {
							type = "color",
							name = L["Flash"],
							desc = L["Set the %s color."]:format(L["Flash"]),
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {LBFGroup, "Flash"},
							hasAlpha = true,
							disabled = GetState,
							order = 4,
						},
						Pushed = {
							type = "color",
							name = L["Pushed"],
							desc = L["Set the %s color."]:format(L["Pushed"]),
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {LBFGroup, "Pushed"},
							hasAlpha = true,
							disabled = GetState,
							order = 5,
						},
						Disabled = {
							type = "color",
							name = L["Disabled"],
							desc = L["Set the %s color."]:format(L["Disabled"]),
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {LBFGroup, "Disabled"},
							hasAlpha = true,
							disabled = GetState,
							order = 6,
						},
					},
				},
				Backdrop = {
					type = "group",
					name = L["Backdrop Settings"],
					order = 6,
					inline = true,
					args = {
						Color = {
							type = "color",
							name = L["Color"],
							desc = L["Set the %s color."]:format(L["Backdrop"]),
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {LBFGroup, "Backdrop"},
							hasAlpha = true,
							disabled = GetBackdropState,
							order = 1,
						},
						Enable = {
							type = "toggle",
							name = L["Enable"],
							desc = L["Enable the backdrop."],
							get = GetBackdrop,
							set = SetBackdrop,
							arg = {LBFGroup, "Backdrop"},
							--width = "half",
							disabled = GetState,
							order = 1,
						},
					},
				},
				ResetAll = {
					type = "execute",
					name = L["Reset All Colors"],
					desc = L["Reset all colors."],
					func = ResetAllColors,
					arg = LBFGroup,
					width = "full",
					order = 15,
				},
			},
		}
	end
	BF.Options.args.General.args.Global = CreateOptions()
	BF.Options.args.General.args.Global.inline = true
	local args = BF.Options.args.Addons.args
	function BF:GuiUpdate(addon, group)
		if not addon then
			for _, addon in pairs(LBF:ListAddons()) do
				local cAddon = addon:gsub("%s","_")
				args[cAddon] = args[cAddon] or CreateOptions(addon)
				args[cAddon].hidden = false
			end
		elseif not group then
			local cAddon = addon:gsub("%s","_")
			for _, group in pairs(LBF:ListGroups(addon)) do
				local cGroup = group:gsub("%s","_")
				local addonArgs = args[cAddon].args
				addonArgs[cGroup] = addonArgs[cGroup] or CreateOptions(addon, group)
			end
		else
			local cAddon = addon:gsub("%s","_")
			local cGroup = group:gsub("%s","_")
			for _, button in pairs(LBF:ListButtons(addon, group)) do
				local cButton = button:gsub("%s","_")
				local groupArgs = args[cAddon].args[cGroup].args
				groupArgs[cButton] = groupArgs[cButton] or CreateOptions(addon, group, button)
			end
		end
	end
end
