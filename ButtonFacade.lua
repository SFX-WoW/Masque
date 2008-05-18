
local bf = LibStub("AceAddon-3.0"):NewAddon("ButtonFacade", "AceConsole-3.0")

LibStub("AceAddon-3.0"):EmbedLibrary(bf, "LibFuBarPlugin-3.0", true)

local AceDB = LibStub("AceDB-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local db
local lbf = LibStub("LibButtonFacade")
local reg = LibStub("AceConfigRegistry-3.0")
local dialog = LibStub("AceConfigDialog-3.0")

local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale("ButtonFacade")

if bf.IsFuBarMinimapAttached then
	bf:SetFuBarOption("iconPath",[[Interface\Addons\ButtonFacade\icon]])
	bf:SetFuBarOption("defaultPosition","RIGHT")
	bf:SetFuBarOption("hideWithoutStandby",true)
end

local harbor = LibStub("AceAddon-3.0"):GetAddon("Harbor",true)
if harbor then
	function bf:GetCurrentSideDock()
		local harbordb = harbor:GetDockButtonDB("ButtonFacade")
		return harbordb.curdock
	end

	function bf:SetCurrentSideDock(dock)
		local harbordb = harbor:GetDockButtonDB("ButtonFacade")
		harbordb.curdock = dock
	end

	function bf:GetSideDockPriority()
		return 100
	end

	function bf:GetSideDockWidth()
		return 1
	end

	function bf:GetSideDockIcon()
		return [[Interface\AddOns\ButtonFacade\icon]]
	end

	function bf:OnSideDockClick()
		dialog:Open("ButtonFacade")
	end

	function bf:OnSideDockEnter()
		-- show Tooltip
	end

	function bf:OnSideDockLeave()
		-- hide tooltip
	end
end

function bf:OnInitialize()
	db = AceDB:New("ButtonFacadeDB")
	--db:RegisterDefaults({
		--profile = {}
	--})
	self.db = db
	self.options.args.profile = AceDBOptions:GetOptionsTable(db)
end

function bf:OnEnable()
	reg:RegisterOptionsTable("ButtonFacade", bf.options)
	self:RegisterChatCommand("bf", function() dialog:Open("ButtonFacade") end)
	lbf:ElementListCallback(self.ElementListUpdate,self)
	dialog:AddToBlizOptions("ButtonFacade","ButtonFacade")
	-- only do the following if the FuBar plugin library embedded correctly.
	if harbor then
		local harbordb = harbor:GetDockButtonDB("ButtonFacade")
		harbor:AddDockButton(self,harbordb.curdock)
	end
	if bf.IsFuBarMinimapAttached then
		if db.profile.FuBar_HideMinimapButton then
			self:Hide()
			return
		end
		if bf:IsFuBarMinimapAttached() == db.profile.FuBar_AttachMinimap then
			bf:ToggleFuBarMinimapAttached()
		end
	end
end

function bf:OnUpdateFuBarText()
	bf:SetFuBarText("BF")
end

function bf:OnUpdateFuBarTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine("|cffffff00"..L["ButtonFacade"].."|r")
	GameTooltip:AddLine(L["|cffffff00Right-click|r to open the Configuration GUI"])
end

-- We override the OpenMenu function to open the Ace3 Config screen instead.
function bf:OpenMenu()
	dialog:Open("ButtonFacade")
end

bf.options = {
	type = 'group',
	name = L["ButtonFacade"],
	
	args = {
		elements = {
			type = 'group',
			name = L["Elements"],
			args = {}
		},
		fubar = {
			type = "group",
			name = L["FuBar options"],
			desc = L["FuBar options"],
			disabled = function() return not bf.IsFuBarMinimapAttached end,
			hidden = function() return not bf.IsFuBarMinimapAttached end,
			order = 100,
			args = {
				attachMinimap = {
					type = "toggle",
					name = L["Attach to minimap"],
					desc = L["Attach to minimap"],
					get = function(info)
						return bf:IsFuBarMinimapAttached()
					end,
					set = function(info, v)
						bf:ToggleFuBarMinimapAttached()
						db.profile.FuBar_AttachMinimap = bf:IsFuBarMinimapAttached()
					end
				},
				hideIcon = {
					type = "toggle",
					name = L["Hide minimap/FuBar icon"],
					desc = L["Hide minimap/FuBar icon"],
					get = function(info) return db.profile.FuBar_HideMinimapButton end,
					set = function(info, v)
						db.profile.FuBar_HideMinimapButton = v
						if v then
							bf:Hide()
						else
							bf:Show()
						end
					end
				},
				showIcon = {
					type = "toggle",
					name = L["Show icon"],
					desc = L["Show icon"],
					get = function(info) return bf:IsFuBarIconShown() end,
					set = function(info, v) bf:ToggleFuBarIconShown() end
				},
				showText = {
					type = "toggle",
					name = L["Show text"],
					desc = L["Show text"],
					get = function(info) return bf:IsFuBarTextShown() end,
					set = function(info, v) bf:ToggleFuBarTextShown() end
				},
				position = {
					type = "select",
					name = L["Position"],
					desc = L["Position"],
					values = {LEFT = L["Left"], CENTER = L["Center"], RIGHT = L["Right"]},
					get = function() return bf:GetPanel() and bf:GetPanel():GetPluginSide(bf) end,
					set = function(info, val)
						if bf:GetPanel() then
							bf:GetPanel():SetPluginSide(bf, val)
						end
					end
				}
			}
		},
	}
}

bf:SetDefaultModulePrototype({
	RegisterNamespace = function(self,name,defaults)
		return db:RegisterNamespace(name,defaults)
	end,
	RegisterModuleOptions = function(self,name,options)
		bf.options.plugins = bf.options.plugins or {}
		bf.options.plugins[name] = options
	end,
})

do
	local function getSkin(info)
		return info.arg.SkinID
	end
	local function setSkin(info, value)
		local lbfGroup = info.arg
		lbfGroup:Skin(value, lbfGroup.Gloss, lbfGroup.Backdrop)
	end
	local function getGloss(info)
		return info.arg.Gloss or 0
	end
	local function setGloss(info, value)
		local lbfGroup = info.arg
		lbfGroup:Skin(lbfGroup.SkinID, value, lbfGroup.Backdrop)
	end
	local function getBackdrop(info)
		return info.arg.Backdrop
	end
	local function setBackdrop(info, value)
		local lbfGroup = info.arg
		lbfGroup:Skin(lbfGroup.SkinID, lbfGroup.Gloss, value)
	end
	local function getLayerColor(info)
		local lbfGroup, layer = info.arg[1], info.arg[2]
		return lbfGroup:GetLayerColor(layer)
	end
	local function setLayerColor(info, r,g,b,a)
		local lbfGroup, layer = info.arg[1], info.arg[2]
		lbfGroup:Skin(lbfGroup.SkinID, lbfGroup.Gloss, lbfGroup.Backdrop,layer,r,g,b,a)
	end
	local function resetColors(info)
		info.arg:ResetColors()
	end
	local args
	do
		local lbfGroup = lbf:Group() -- get the root group, since this is easier...
		bf.options.args.elements = {
			type = 'group',
			name = bf.name,
			args = {
				__bf_header = {
					name = L["Apply skin to all registered buttons."],
					type = 'description',
					order = 1,
				},
				__bf_skin = {
					name = L["Skin"],
					type = 'select',
					get = getSkin,
					set = setSkin,
					values = lbf.ListSkins,
					arg = lbfGroup,
					order = 2,
					style = "dropdown",
					width = "full",
				},
				__bf_gloss = {
					name = L["Gloss"],
					type = 'range',
					get = getGloss,
					set = setGloss,
					arg = lbfGroup,
					min = 0,
					max = 1,
					isPercent = true,
					step = 0.01,
					order = 3,
					width = "full",
				},
				__bf_backdrop = {
					type = 'toggle',
					name = L["Backdrop"],
					get = getBackdrop,
					set = setBackdrop,
					arg = lbfGroup,
					order = 4,
					width = "half",
				},
				__bf_ColorHeading = {
					type = 'header',
					name = L["Color Options"],
					order = 5,
				},
				__bf_ColorBackdrop = {
					type = 'color',
					name = L["Backdrop"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Backdrop"},
					order = 6,
				},
				__bf_ColorFlash = {
					type = 'color',
					name = L["Flash"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Flash"},
					order = 7,
				},
				__bf_ColorNormal = {
					type = 'color',
					name = L["Normal Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Normal"},
					order = 8,
				},
				__bf_ColorPushed = {
					type = 'color',
					name = L["Pushed Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Pushed"},
					order = 9,
				},
				__bf_ColorDisabled = {
					type = 'color',
					name = L["Disabled Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Disabled"},
					order = 10,
				},
				__bf_ColorChecked = {
					type = 'color',
					name = L["Checked"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Checked"},
					order = 11,
				},
				__bf_ColorBorder = {
					type = 'color',
					name = L["Equipped"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Border"},
					order = 12,
				},
				__bf_ColorHighlight = {
					type = 'color',
					name = L["Highlight"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Highlight"},
					order = 13,
				},
				__bf_ColorGloss = {
					type = 'color',
					name = L["Gloss"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {lbfGroup,"Gloss"},
					order = 14,
				},
				__bf_ResetColors = {
					type = 'execute',
					name = L["Reset Colors"],
					func = resetColors,
					arg = lbfGroup,
					order = 15,
				},
			},
		}
		args = bf.options.args.elements.args
	end
	local function CreateAddonOptions(addon)
		local lbfGroup = lbf:Group(addon)
		return {
			type = 'group',
			name = addon,
			args = {
				__bf_header = {
					name = L["Apply skin to all buttons registered with %s."]:format(addon),
					type = 'description',
					order = 1,
				},
				__bf_skin = {
					name = L["Skin"],
					type = 'select',
					get = getSkin,
					set = setSkin,
					values = lbf.ListSkins,
					arg = lbfGroup,
					order = 2,
					style = "dropdown",
					width = "full",
				},
				__bf_gloss = {
					name = L["Gloss"],
					type = 'range',
					get = getGloss,
					set = setGloss,
					arg = lbfGroup,
					min = 0,
					max = 1,
					isPercent = true,
					step = 0.01,
					order = 3,
					width = "full",
				},
				__bf_backdrop = {
					type = 'toggle',
					name = L["Backdrop"],
					get = getBackdrop,
					set = setBackdrop,
					arg = lbfGroup,
					order = 4,
					width = "half",
				},
				__bf_ColorHeading = {
					type = 'header',
					name = L["Color Options"],
					order = 5,
				},
				__bf_ColorBackdrop = {
					type = 'color',
					name = L["Backdrop"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Backdrop"},
					order = 6,
				},
				__bf_ColorFlash = {
					type = 'color',
					name = L["Flash"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Flash"},
					order = 7,
				},
				__bf_ColorNormal = {
					type = 'color',
					name = L["Normal Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Normal"},
					order = 8,
				},
				__bf_ColorPushed = {
					type = 'color',
					name = L["Pushed Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Pushed"},
					order = 9,
				},
				__bf_ColorDisabled = {
					type = 'color',
					name = L["Disabled Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Disabled"},
					order = 10,
				},
				__bf_ColorChecked = {
					type = 'color',
					name = L["Checked"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Checked"},
					order = 11,
				},
				__bf_ColorBorder = {
					type = 'color',
					name = L["Equipped"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Border"},
					order = 12,
				},
				__bf_ColorHighlight = {
					type = 'color',
					name = L["Highlight"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Highlight"},
					order = 13,
				},
				__bf_ColorGloss = {
					type = 'color',
					name = L["Gloss"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {lbfGroup,"Gloss"},
					order = 14,
				},
				__bf_ResetColors = {
					type = 'execute',
					name = L["Reset Colors"],
					func = resetColors,
					arg = lbfGroup,
					order = 15,
				},
			},
		}
	end
	local function CreateGroupOptions(addon, group)
		local lbfGroup = lbf:Group(addon, group)
		return {
			type = 'group',
			name = group,
			args = {
				__bf_header = {
					type = 'description',
					name = L["Apply skin to all buttons registered with %s/%s."]:format(addon, group),
					order = 1,
				},
				__bf_skin = {
					name = L["Skin"],
					type = 'select',
					get = getSkin,
					set = setSkin,
					values = lbf.ListSkins,
					arg = lbfGroup,
					order = 2,
					style = "dropdown",
					width = "full",
				},
				__bf_gloss = {
					name = L["Gloss"],
					type = 'range',
					get = getGloss,
					set = setGloss,
					arg = lbfGroup,
					min = 0,
					max = 1,
					isPercent = true,
					step = 0.01,
					order = 3,
					width = "full",
				},
				__bf_backdrop = {
					type = 'toggle',
					name = L["Backdrop"],
					get = getBackdrop,
					set = setBackdrop,
					arg = lbfGroup,
					order = 4,
					width = "half",
				},
				__bf_ColorHeading = {
					type = 'header',
					name = L["Color Options"],
					order = 5,
				},
				__bf_ColorBackdrop = {
					type = 'color',
					name = L["Backdrop"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Backdrop"},
					order = 6,
				},
				__bf_ColorFlash = {
					type = 'color',
					name = L["Flash"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Flash"},
					order = 7,
				},
				__bf_ColorNormal = {
					type = 'color',
					name = L["Normal Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Normal"},
					order = 8,
				},
				__bf_ColorPushed = {
					type = 'color',
					name = L["Pushed Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Pushed"},
					order = 9,
				},
				__bf_ColorDisabled = {
					type = 'color',
					name = L["Disabled Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Disabled"},
					order = 10,
				},
				__bf_ColorChecked = {
					type = 'color',
					name = L["Checked"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Checked"},
					order = 11,
				},
				__bf_ColorBorder = {
					type = 'color',
					name = L["Equipped"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Border"},
					order = 12,
				},
				__bf_ColorHighlight = {
					type = 'color',
					name = L["Highlight"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Highlight"},
					order = 13,
				},
				__bf_ColorGloss = {
					type = 'color',
					name = L["Gloss"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {lbfGroup,"Gloss"},
					order = 14,
				},
				__bf_ResetColors = {
					type = 'execute',
					name = L["Reset Colors"],
					func = resetColors,
					arg = lbfGroup,
					order = 15,
				},
			},
		}
	end
	local function CreateButtonOptions(addon, group, button)
		local lbfGroup = lbf:Group(addon, group, button)
		return {
			type = 'group',
			name = button,
			args = {
				__bf_header = {
					name = L["Apply skin to all buttons registered with %s/%s/%s."]:format(addon, group, button),
					type = 'description',
					order = 1,
				},
				__bf_skin = {
					name = L["Skin"],
					type = 'select',
					get = getSkin,
					set = setSkin,
					values = lbf.ListSkins,
					arg = lbfGroup,
					order = 2,
					style = "dropdown",
					width = "full",
				},
				__bf_gloss = {
					name = L["Gloss"],
					type = 'range',
					get = getGloss,
					set = setGloss,
					arg = lbfGroup,
					min = 0,
					max = 1,
					isPercent = true,
					step = 0.01,
					order = 3,
					width = "full",
				},
				__bf_backdrop = {
					type = 'toggle',
					name = L["Backdrop"],
					get = getBackdrop,
					set = setBackdrop,
					arg = lbfGroup,
					order = 4,
					width = "half",
				},
				__bf_ColorHeading = {
					type = 'header',
					name = L["Color Options"],
					order = 5,
				},
				__bf_ColorBackdrop = {
					type = 'color',
					name = L["Backdrop"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Backdrop"},
					order = 6,
				},
				__bf_ColorFlash = {
					type = 'color',
					name = L["Flash"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Flash"},
					order = 7,
				},
				__bf_ColorNormal = {
					type = 'color',
					name = L["Normal Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Normal"},
					order = 8,
				},
				__bf_ColorPushed = {
					type = 'color',
					name = L["Pushed Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Pushed"},
					order = 9,
				},
				__bf_ColorDisabled = {
					type = 'color',
					name = L["Disabled Border"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Disabled"},
					order = 10,
				},
				__bf_ColorChecked = {
					type = 'color',
					name = L["Checked"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Checked"},
					order = 11,
				},
				__bf_ColorBorder = {
					type = 'color',
					name = L["Equipped"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Border"},
					order = 12,
				},
				__bf_ColorHighlight = {
					type = 'color',
					name = L["Highlight"],
					get = getLayerColor,
					set = setLayerColor,
					hasAlpha = true,
					arg = {lbfGroup,"Highlight"},
					order = 13,
				},
				__bf_ColorGloss = {
					type = 'color',
					name = L["Gloss"],
					get = getLayerColor,
					set = setLayerColor,
					arg = {lbfGroup,"Gloss"},
					order = 14,
				},
				__bf_ResetColors = {
					type = 'execute',
					name = L["Reset Colors"],
					func = resetColors,
					arg = lbfGroup,
					order = 15,
				},
			},
		}
	end
	function bf:ElementListUpdate(addon, group)
		if not addon then
			for _, addon in pairs(lbf:ListAddons()) do
				local cAddon = addon:gsub("%s","_")
				args[cAddon] = args[cAddon] or CreateAddonOptions(addon)
				args[cAddon].hidden = false
			end
		elseif not group then
			local cAddon = addon:gsub("%s","_")
			for _, group in pairs(lbf:ListGroups(addon)) do
				local cGroup = group:gsub("%s","_")
				local addonArgs = args[cAddon].args
				addonArgs[cGroup] = addonArgs[cGroup] or CreateGroupOptions(addon, group)
			end
		else
			local cAddon = addon:gsub("%s","_")
			local cGroup = group:gsub("%s","_")
			for _, button in pairs(lbf:ListButtons(addon, group)) do
				local cButton = button:gsub("%s","_")
				local groupArgs = args[cAddon].args[cGroup].args
				groupArgs[cButton] = groupArgs[cButton] or CreateButtonOptions(addon, group, button)
			end
		end
	end
end
