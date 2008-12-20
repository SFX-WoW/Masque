--[[ ButtonFacade ]]

-- Create the add-on.
local BF = LibStub("AceAddon-3.0"):NewAddon("ButtonFacade", "AceConsole-3.0")

--Locals
local db, pairs, gsub = nil, pairs, gsub

-- Set up libraries.
local LBF = LibStub("LibButtonFacade")
local L = LibStub("AceLocale-3.0"):GetLocale("ButtonFacade")
local LDB = LibStub("LibDataBroker-1.1", true)
local Icon = LibStub("LibDBIcon-1.0", true)

-- :OnInitialize(): Initialize the add-on.
function BF:OnInitialize()
	-- Check the DB and reset it if it's old.
	if (not ButtonFacadeDB) or (ButtonFacadeDB.version ~= 1) then
		ButtonFacadeDB = {}
		ButtonFacadeDB.version = 1
	end

	-- Set up defaults.
	local defaults = {
		profile = {
			mapicon = {
				hide = false,
				radius = 80,
				minimapPos = 220,
			},
		}
	}

	-- Set up the DB.
	self.db = LibStub("AceDB-3.0"):New("ButtonFacadeDB", defaults, "Default")
	self.db.RegisterCallback(self, "OnProfileChanged", "Reload")
	self.db.RegisterCallback(self, "OnProfileCopied", "Reload")
	self.db.RegisterCallback(self, "OnProfileReset", "Reload")
	db = self.db.profile
end

-- :OnEnable():
function BF:OnEnable()
	-- Update the elements.
	LBF:ElementListCallback(self.ElementListUpdate, self)

	-- Set up options.
	local ACR, ACD = LibStub("AceConfigRegistry-3.0"), LibStub("AceConfigDialog-3.0")
	self.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	ACR:RegisterOptionsTable("ButtonFacade", self.options)

	-- Set up options panels.
	self.OptionsPanel = ACD:AddToBlizOptions("ButtonFacade", L["ButtonFacade"], nil, "general")
	self.OptionsPanel.Skins = ACD:AddToBlizOptions("ButtonFacade", L["Skins"], "ButtonFacade", "skins")
	self.OptionsPanel.Plugins = ACD:AddToBlizOptions("ButtonFacade", L["Plugins"], "ButtonFacade", "plugins")
	self.OptionsPanel.Profiles = ACD:AddToBlizOptions("ButtonFacade", L["Profiles"], "ButtonFacade", "profiles")

	-- Register chat commands.
	self:RegisterChatCommand("bf", function() self:OpenOptions() end)
	self:RegisterChatCommand("buttonfacade", function() self:OpenOptions() end)

	-- Register with Broker.
	if LDB then
		-- LDB display object
		self.obj = LDB:NewDataObject(self.name, {
			type  = "launcher",
			label = L["ButtonFacade"],
			icon  = "Interface\\Addons\\ButtonFacade\\icon",
			OnClick = function(self, button)
				if button == "RightButton" then
					BF:OpenOptions()
				end
			end,
			OnTooltipShow = function(tip)
				if not tip or not tip.AddLine then return end
				tip:AddLine(L["ButtonFacade"])
				tip:AddLine(L["Right-Click to open the options window."], 1, 1, 1)
			end,
		})
		-- LDBIcon
		if Icon then
			Icon:Register(self.name, self.obj, db.mapicon)
		end
	end
end

-- :OpenOptions(): Opens the options window.
function BF:OpenOptions()
	InterfaceOptionsFrame_OpenToCategory(self.OptionsPanel.Profiles)
	InterfaceOptionsFrame_OpenToCategory(self.OptionsPanel)
end

-- :Reload(): Reloads settings on profile activity.
function BF:Reload()
	db = self.db.profile
	if Icon then
		Icon:Refresh(self.name, db.mapicon)
	end
end

-- Set up the core options table.
do
	-- ToggleIcon(): Toggles the minimap icon.
	local function ToggleIcon()
		db.mapicon.hide = not db.mapicon.hide
		if Icon then
			if db.mapicon.hide then
				Icon:Hide("ButtonFacade")
			else
				Icon:Show("ButtonFacade")
			end
		end
	end

	-- Make sure we have LibDBIcon.
	if not Icon then
		L["Show the minimap icon."] = L["Show the minimap icon."].."\n|cff999999"..L["LibDBIcon-1.0 is not installed."].."|r"
	end

	-- Core Options
	BF.options = {
		type = "group",
		name = BF.name,
		args = {
			general = {
				type = "group",
				name = "General",
				order = 1,
				args = {
					desc = {
						type = "description",
						name = L["BF_INFO"].."\n",
						order = 1,
					},
					mapicon = {
						type = "toggle",
						name = L["Minimap Icon"],
						desc = L["Show the minimap icon."],
						get = function() return not db.mapicon.hide end,
						set = function() ToggleIcon() end,
						order = 3,
						disabled = function() 
							if not Icon then
								return true
							end
							return false
						end,
					},
				},
			},
			skins = {
				type = "group",
				name = "Skins",
				childGroups = "tab",
				order = 2,
				args = {
					global = {},
					addons = {
						type = "group",
						name = L["Addon Settings"],
						order = 2,
						args = {
							header = {
								type = "description",
								name = "|cffffcc00"..L["Addon Settings"].."|r\n",
								order = 1,
							},
							desc = {
								type = "description",
								name = L["ADDON_INFO"].."\n",
								order = 2,
							},
						},
					},
				},
			},
			plugins = {
				type = "group",
				name = "Plugins",
				order = 3,
				args = {
					desc = {
						type = "description",
						name = L["PLUGIN_INFO"].."\n",
					},
				},
			},
		}
	}
end

BF:SetDefaultModulePrototype({
	RegisterNamespace = function(self, name, defaults)
		return BF.db:RegisterNamespace(name, defaults)
	end,
	RegisterModuleOptions = function(self, name, options)
		BF.options.args.plugins.args = BF.options.args.plugins.args or {}
		BF.options.args.plugins.args[name] = options
	end,
})

do
	local function getSkin(info)
		return info.arg.SkinID
	end
	local function setSkin(info, value)
		local LBFGroup = info.arg
		LBFGroup:Skin(value, LBFGroup.Gloss, LBFGroup.Backdrop)
	end
	local function getGloss(info)
		return info.arg.Gloss or 0
	end
	local function setGloss(info, value)
		local LBFGroup = info.arg
		LBFGroup:Skin(LBFGroup.SkinID, value, LBFGroup.Backdrop)
	end
	local function getBackdrop(info)
		return info.arg.Backdrop
	end
	local function setBackdrop(info, value)
		local LBFGroup = info.arg
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
		local LBFGroup = LBF:Group() -- get the root group, since this is easier...
		BF.options.args.skins.args.global = {
			type = "group",
			name = "Global Settings",
			order = 1,
			args = {
				__bf_header = {
					type = "description",
					name = "|cffffcc00"..L["Global Settings"].."|r\n",
					order = 1,
				},
				__bf_desc = {
					type = "description",
					name = L["GLOBAL_INFO"].."\n",
					order = 1.5
				},
				__bf_skin = {
					type = "select",
					name = L["Skin"],
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
					get = getGloss,
					set = setGloss,
					arg = LBFGroup,
					min = 0,
					max = 1,
					step = 0.01,
					width = "full",
					isPercent = true,
					order = 3,
				},
				__bf_backdrop = {
					type = "toggle",
					name = L["Backdrop"],
					get = getBackdrop,
					set = setBackdrop,
					arg = LBFGroup,
					width = "half",
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
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Backdrop"},
					hasAlpha = true,
					order = 6,
				},
				__bf_ColorFlash = {
					type = "color",
					name = L["Flash"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Flash"},
					hasAlpha = true,
					order = 7,
				},
				__bf_ColorNormal = {
					type = "color",
					name = L["Normal Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Normal"},
					hasAlpha = true,
					order = 8,
				},
				__bf_ColorPushed = {
					type = "color",
					name = L["Pushed Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Pushed"},
					hasAlpha = true,
					order = 9,
				},
				__bf_ColorDisabled = {
					type = "color",
					name = L["Disabled Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Disabled"},
					hasAlpha = true,
					order = 10,
				},
				__bf_ColorChecked = {
					type = "color",
					name = L["Checked"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Checked"},
					hasAlpha = true,
					order = 11,
				},
				__bf_ColorBorder = {
					type = "color",
					name = L["Equipped"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Border"},
					hasAlpha = true,
					order = 12,
				},
				__bf_ColorHighlight = {
					type = "color",
					name = L["Highlight"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Highlight"},
					hasAlpha = true,
					order = 13,
				},
				__bf_ColorGloss = {
					type = "color",
					name = L["Gloss"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup,"Gloss"},
					order = 14,
				},
				__bf_ResetColors = {
					type = "execute",
					name = L["Reset Colors"],
					func = resetColors,
					arg = LBFGroup,
					order = 15,
				},
			},
		}
		args = BF.options.args.skins.args.addons.args
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
					get = getGloss,
					set = setGloss,
					arg = LBFGroup,
					min = 0,
					max = 1,
					step = 0.01,
					width = "full",
					isPercent = true,
					order = 3,
				},
				__bf_backdrop = {
					type = "toggle",
					name = L["Backdrop"],
					get = getBackdrop,
					set = setBackdrop,
					arg = LBFGroup,
					width = "half",
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
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Backdrop"},
					hasAlpha = true,
					order = 6,
				},
				__bf_ColorFlash = {
					type = "color",
					name = L["Flash"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Flash"},
					hasAlpha = true,
					order = 7,
				},
				__bf_ColorNormal = {
					type = "color",
					name = L["Normal Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Normal"},
					hasAlpha = true,
					order = 8,
				},
				__bf_ColorPushed = {
					type = "color",
					name = L["Pushed Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Pushed"},
					hasAlpha = true,
					order = 9,
				},
				__bf_ColorDisabled = {
					type = "color",
					name = L["Disabled Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Disabled"},
					hasAlpha = true,
					order = 10,
				},
				__bf_ColorChecked = {
					type = "color",
					name = L["Checked"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Checked"},
					hasAlpha = true,
					order = 11,
				},
				__bf_ColorBorder = {
					type = "color",
					name = L["Equipped"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Border"},
					hasAlpha = true,
					order = 12,
				},
				__bf_ColorHighlight = {
					type = "color",
					name = L["Highlight"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Highlight"},
					hasAlpha = true,
					order = 13,
				},
				__bf_ColorGloss = {
					type = "color",
					name = L["Gloss"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Gloss"},
					order = 14,
				},
				__bf_ResetColors = {
					type = "execute",
					name = L["Reset Colors"],
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
					get = getGloss,
					set = setGloss,
					arg = LBFGroup,
					min = 0,
					max = 1,
					step = 0.01,
					width = "full",
					isPercent = true,
					order = 3,
				},
				__bf_backdrop = {
					type = "toggle",
					name = L["Backdrop"],
					get = getBackdrop,
					set = setBackdrop,
					arg = LBFGroup,
					width = "half",
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
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {LBFGroup, "Backdrop"},
					order = 6,
				},
				__bf_ColorFlash = {
					type = "color",
					name = L["Flash"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Flash"},
					hasAlpha = true,
					order = 7,
				},
				__bf_ColorNormal = {
					type = "color",
					name = L["Normal Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Normal"},
					hasAlpha = true,
					order = 8,
				},
				__bf_ColorPushed = {
					type = "color",
					name = L["Pushed Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Pushed"},
					hasAlpha = true,
					order = 9,
				},
				__bf_ColorDisabled = {
					type = "color",
					name = L["Disabled Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Disabled"},
					hasAlpha = true,
					order = 10,
				},
				__bf_ColorChecked = {
					type = "color",
					name = L["Checked"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Checked"},
					hasAlpha = true,
					order = 11,
				},
				__bf_ColorBorder = {
					type = "color",
					name = L["Equipped"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Border"},
					hasAlpha = true,
					order = 12,
				},
				__bf_ColorHighlight = {
					type = "color",
					name = L["Highlight"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Highlight"},
					hasAlpha = true,
					order = 13,
				},
				__bf_ColorGloss = {
					type = "color",
					name = L["Gloss"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Gloss"},
					order = 14,
				},
				__bf_ResetColors = {
					type = "execute",
					name = L["Reset Colors"],
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
					get = getGloss,
					set = setGloss,
					arg = LBFGroup,
					min = 0,
					max = 1,
					step = 0.01,
					width = "full",
					isPercent = true,
					order = 3,
				},
				__bf_backdrop = {
					type = "toggle",
					name = L["Backdrop"],
					get = getBackdrop,
					set = setBackdrop,
					arg = LBFGroup,
					width = "half",
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
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Backdrop"},
					hasAlpha = true,
					order = 6,
				},
				__bf_ColorFlash = {
					type = "color",
					name = L["Flash"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Flash"},
					hasAlpha = true,
					order = 7,
				},
				__bf_ColorNormal = {
					type = "color",
					name = L["Normal Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Normal"},
					hasAlpha = true,
					order = 8,
				},
				__bf_ColorPushed = {
					type = "color",
					name = L["Pushed Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Pushed"},
					hasAlpha = true,
					order = 9,
				},
				__bf_ColorDisabled = {
					type = "color",
					name = L["Disabled Border"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Disabled"},
					hasAlpha = true,
					order = 10,
				},
				__bf_ColorChecked = {
					type = "color",
					name = L["Checked"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Checked"},
					hasAlpha = true,
					order = 11,
				},
				__bf_ColorBorder = {
					type = "color",
					name = L["Equipped"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Border"},
					hasAlpha = true,
					order = 12,
				},
				__bf_ColorHighlight = {
					type = "color",
					name = L["Highlight"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Highlight"},
					hasAlpha = true,
					order = 13,
				},
				__bf_ColorGloss = {
					type = "color",
					name = L["Gloss"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {LBFGroup, "Gloss"},
					order = 14,
				},
				__bf_ResetColors = {
					type = "execute",
					name = L["Reset Colors"],
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
