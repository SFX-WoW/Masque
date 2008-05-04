
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

function bf:SkinSkin(s)
	for k,v in pairs(lbf:ListAddons()) do
		local group = lbf:Group(v)
		group:Skin(s,group.Gloss,group.Backdrop)
	end
end

function bf:SkinGloss(g)
	for k,v in pairs(lbf:ListAddons()) do
		local group = lbf:Group(v)
		group:Skin(group.SkinID,g,group.Backdrop)
	end
end

function bf:SkinBackdrop(b)
	for k,v in pairs(lbf:ListAddons()) do
		local group = lbf:Group(v)
		group:Skin(group.SkinID,group.Gloss,b)
	end
end

local global_gloss, global_back, lastSkin

bf.options = {
	type = 'group',
	name = L["ButtonFacade"],
	
	args = {
		elements = {
			type = 'group',
			name = L["Elements"],
			args = {
				__bf_header = {
					type = 'description',
					name = L["Apply skin to all registered buttons."],
					order = 1,
				},
				__bf_skin = {
					type = 'select',
					values = function() return lbf:ListSkins() end,
					name = L["Skin"],
					get = function() return lastSkin end,
					set = function(info,c) lastSkin = c bf:SkinSkin(c) end,
					style = "dropdown",
					order = 2,
					width = "full",
				},
				__bf_gloss = {
					type = 'range',
					name = L["Gloss"],
					min = 0,
					max = 1,
					isPercent = true,
					step = 0.01,
					get = function() return global_gloss or 0 end,
					set = function(info,c) bf:SkinGloss(c) global_gloss = c end,
					order = 3,
					width = "full",
				},
				__bf_backdrop = {
					type = 'toggle',
					name = L["Backdrop"],
					tristate = true,
					get = function() return global_back end,
					set = function(info,c) bf:SkinBackdrop(c) global_back = c and true or false end,
					order = 4,
					width = "half",
				},
			}
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

local elements_args = bf.options.args.elements.args

function bf:ElementListUpdate(Addon,Group)
	if not Addon then
		local list = lbf:ListAddons()
		local args = elements_args
		for k in pairs(args) do
			if (not list[k]) and (k:sub(1,5) ~= "__bf_") then args[k].hidden = true end
		end
		for k,v in pairs(list) do
			local cleanv = v:gsub("%s","_")
			if not elements_args[cleanv] then
				local g = lbf:Group(v)
				elements_args[cleanv] = {
					type = 'group',
					name = v,
					args = {
						__bf_header = {
							type = 'description',
							name = L["Apply skin to all buttons registered with %s."]:format(v),
							order = 1,
						},
						__bf_skin = {
							type = 'select',
							values = function() return lbf:ListSkins() end,
							name = L["Skin"],
							get = function() return g.SkinID end,
							set = function(info,c) g:Skin(c,g.Gloss,g.Backdrop) end,
							style = "dropdown",
							order = 2,
							width = "full",
						},
						__bf_gloss = {
							type = 'range',
							name = L["Gloss"],
							min = 0,
							max = 1,
							isPercent = true,
							step = 0.01,
							get = function() return g.Gloss or 0 end,
							set = function(info,c) g:Skin(g.SkinID,c,g.Backdrop) end,
							order = 3,
							width = "full",
						},
						__bf_backdrop = {
							type = 'toggle',
							name = L["Backdrop"],
							get = function() return g.Backdrop end,
							set = function(info,c) g:Skin(g.SkinID,g.Gloss,c) global_back = nil end,
							order = 4,
							width = "half",
						},
					},
				}
			else
				elements_args[cleanv].hidden = false
			end
		end
	elseif not Group then
		local list = lbf:ListGroups(Addon)
		local args = elements_args[Addon].args
		for k in pairs(args) do
			if (not list[k]) and (k:sub(1,5) ~= "__bf_") then args[k].hidden = true end
		end
		for k,v in pairs(list) do
			local cleanv = v:gsub("%s","_")
			if not args[cleanv] then
				local g = lbf:Group(Addon,v)
				args[cleanv] = {
					type = 'group',
					name = v,
					args = {
						__bf_header = {
							type = 'description',
							name = L["Apply skin to all buttons registered with %s/%s."]:format(Addon,v),
							order = 1,
						},
						__bf_skin = {
							type = 'select',
							values = function() return lbf:ListSkins() end,
							name = L["Skin"],
							get = function() return g.SkinID end,
							set = function(info,c) g:Skin(c,g.Gloss,g.Backdrop) end,
							style = "dropdown",
							order = 2,
							width = "full",
						},
						__bf_gloss = {
							type = 'range',
							name = L["Gloss"],
							min = 0,
							max = 1,
							isPercent = true,
							step = 0.01,
							get = function() return g.Gloss or 0 end,
							set = function(info,c) g:Skin(g.SkinID,c,g.Backdrop) end,
							order = 3,
							width = "full",
						},
						__bf_backdrop = {
							type = 'toggle',
							name = L["Backdrop"],
							get = function() return g.Backdrop end,
							set = function(info,c) g:Skin(g.SkinID,g.Gloss,c) global_back = nil end,
							order = 4,
							width = "half",
						},
					},
				}
			else
				args[cleanv].hidden = false
			end
		end
	else
		local list = lbf:ListButtons(Addon,Group)
		local args = elements_args[Addon].args[Group].args
		for k in pairs(args) do
			if (not list[k]) and (k:sub(1,5) ~= "__bf_") then args[k].hidden = true end
		end
		for k,v in pairs(list) do
			local cleanv = v:gsub("%s","_")
			if not args[cleanv] then
				local g = lbf:Group(Addon,Group,v)
				args[cleanv] = {
					type = 'group',
					name = v,
					args = {
						__bf_header = {
							type = 'description',
							name = L["Apply skin to all buttons registered with %s/%s/%s."]:format(Addon,Group,v),
							order = 1,
						},
						__bf_skin = {
							type = 'select',
							values = function() return lbf:ListSkins() end,
							name = L["Skin"],
							get = function() return g.SkinID end,
							set = function(info,c) g:Skin(c,g.Gloss,g.Backdrop) end,
							style = "dropdown",
							order = 2,
							width = "full",
						},
						__bf_gloss = {
							type = 'range',
							name = L["Gloss"],
							min = 0,
							max = 1,
							isPercent = true,
							step = 0.01,
							get = function() return g.Gloss or 0 end,
							set = function(info,c) g:Skin(g.SkinID,c,g.Backdrop) end,
							order = 3,
							width = "full",
						},
						__bf_backdrop = {
							type = 'toggle',
							name = L["Backdrop"],
							get = function() return g.Backdrop end,
							set = function(info,c) g:Skin(g.SkinID,g.Gloss,c) global_back = nil end,
							order = 4,
							width = "half",
						},
					},
				}
			else
				args[cleanv].hidden = false
			end
		end
	end
end
