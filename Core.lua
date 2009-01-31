-- ButtonFacade/Core

-- Create the add-on.
ButtonFacade = LibStub("AceAddon-3.0"):NewAddon("ButtonFacade", "AceConsole-3.0")
local BF = ButtonFacade

--Locals
local mdb, db
local pairs, gsub = pairs, gsub

-- Set up libraries.
local LBF = LibStub("LibButtonFacade")
local L = LibStub("AceLocale-3.0"):GetLocale("ButtonFacade")
local ACD = LibStub("AceConfigDialog-3.0")
local LDB = LibStub("LibDataBroker-1.1", true)
local Icon = LibStub("LibDBIcon-1.0", true)

-- :OnInitialize(): Initialize the add-on.
function BF:OnInitialize()
	-- Check the DB and reset it if it's old.
	if (not ButtonFacadeDB) or (ButtonFacadeDB.version ~= 3) then
		ButtonFacadeDB = {}
		ButtonFacadeDB.version = 3
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
	mdb = LibStub("AceDB-3.0"):New("ButtonFacadeDB", nil, "Default") -- Set aside for module creation.
	self.db = mdb
	self.db:RegisterDefaults(defaults)
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
	local ACR = LibStub("AceConfigRegistry-3.0")
	self.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.options.args.profiles.order = 4
	ACR:RegisterOptionsTable("ButtonFacade", self.options)

	-- Set up options panels.
	self.OptionsPanel = ACD:AddToBlizOptions(self.name, L["ButtonFacade"], nil, "global")
	self.OptionsPanel.Addons = ACD:AddToBlizOptions(self.name, L["Addons"], self.name, "addons")
	self.OptionsPanel.Options = ACD:AddToBlizOptions(self.name, L["Options"], self.name, "general")
	self.OptionsPanel.Plugins = ACD:AddToBlizOptions(self.name, L["Plugins"], self.name, "plugins")
	self.OptionsPanel.Profiles = ACD:AddToBlizOptions(self.name, L["Profiles"], self.name, "profiles")
	self.OptionsPanel.About = ACD:AddToBlizOptions(self.name, L["About"], self.name, "about")

	-- Register chat commands.
	self:RegisterChatCommand("bf", function() self:OpenOptions() end)
	self:RegisterChatCommand("bfo", function() self:OpenOptions(true) end)
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
function BF:OpenOptions(bfo)
	if bfo then
		InterfaceOptionsFrame:Hide()
		ACD:Open(BF.name)
	else
		InterfaceOptionsFrame_OpenToCategory(self.OptionsPanel.Profiles)
		InterfaceOptionsFrame_OpenToCategory(self.OptionsPanel)
	end
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
				Icon:Hide(BF.name)
			else
				Icon:Show(BF.name)
			end
		end
	end

	-- Core Options
	BF.options = {
		type = "group",
		name = BF.name,
		args = {
			global = {}, -- Default options panel.
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
			general = {
				type = "group",
				name = L["Options"],
				order = 3,
				args = {
					desc = {
						type = "description",
						name = L["OPTION_INFO"].."\n",
						order = 1
					},
					mapicon = {
						type = "toggle",
						name = L["Minimap Icon"],
						desc = L["Show the minimap icon."],
						get = function() return not db.mapicon.hide end,
						set = function() ToggleIcon() end,
						order = 2,
						disabled = function()
							if not Icon then
								return true
							else
								return false
							end
						end,
					},
					optissue = {
						type = "description",
						name = "\n"..L["OPTWIN_ISSUE"].."\n",
						order = 1000,
					},
					optbutton = {
						type = "execute",
						name = L["Standalone Options"],
						desc = L["Open a standalone options window."],
						order = 1001,
						disabled = function()
							if ACD.OpenFrames[BF.name] then
								return true
							else
								return false
							end
						end,
						func = function() BF:OpenOptions(true) end,
					},
				},
			},
			plugins = {
				type = "group",
				name = L["Plugins"],
				order = 3,
				args = {
					desc = {
						type = "description",
						name = L["PLUGIN_INFO"].."\n",
					},
				},
			},
			about = {
				type = "group",
				name = L["About"],
				order = 5,
				args = {
					desc_text = {
						type = "description",
						name = L["BF_INFO"].."\n",
						order = 1,
					},
					vers_head = {
						type = "description",
						name = "|cffffcc00"..L["Version"].."|r",
						order = 2,
					},
					vers_text = {
						type = "description",
						name = GetAddOnMetadata(BF.name, "Version").."\n",
						order = 3,
					},
					auth_head = {
						type = "description",
						name = "|cffffcc00"..L["Authors"].."|r",
						order = 4,
					},
					auth_text = {
						type = "description",
						name = "|cff999999JJ Sheets|r\nStormFX\n",
						order = 5,
					},
					url_head = {
						type = "description",
						name = "|cffffcc00"..L["Web Site"].."|r",
						order = 6,
					},
					url_text = {
						type = "description",
						name = GetAddOnMetadata(BF.name, "X-WebSite").."\n",
						order = 7,
					},
					fb_head = {
						type = "description",
						name = "|cffffcc00"..L["Feedback"].."|r",
						order = 8,
					},
					fb_text = {
						type = "description",
						name = L["FB_TEXT"].."\n",
						order = 9,
					},
					trans_head = {
						type = "description",
						name = "|cffffcc00"..L["Translations"].."|r",
						order = 10,
					},
					trans_text = {
						type = "description",
						name = L["TRANS_TEXT"].."\n",
						order = 11,
					},
				},
			},
		}
	}
end

BF:SetDefaultModulePrototype({
	RegisterNamespace = function(self, name, defaults)
		return mdb:RegisterNamespace(name, defaults)
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
		BF.options.args.global = {
			type = "group",
			name = "Global",
			order = 1,
			args = {
				__bf_header = {
					type = "description",
					name = L["GLOBAL_INFO"].."\n",
					order = 1
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
