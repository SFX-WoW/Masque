--[[
	Project.: Masque
	File....: Button/Options.lua
	Version.: @file-revision@
	Author..: StormFX, JJSheets
]]

local Masque, Core = ...

-- [ Locals ] --

local pairs = pairs
local L = Core.Locale

-- Skin Tables
local Skins = Core.Button:GetSkins()
local SkinList = Core.Button:ListSkins()

-- [ Button Options ] --

local CreateOptions

do

	-- [ Skin ] --

	-- Gets the skin.
	local function GetSkin(info)
		return info.arg.SkinID
	end

	-- Sets the skin.
	local function SetSkin(info, value)
		local Group = info.arg
		Group:__Skin(value, Group.Gloss, Group.Backdrop)
	end

	-- [ Gloss ] --

	-- Gets the gloss.
	local function GetGloss(info)
		return info.arg[1].Gloss or 0
	end

	-- Sets the gloss.
	local function SetGloss(info, value)
		local Group = info.arg[1]
		Group:__Skin(Group.SkinID, value, Group.Backdrop)
	end

	-- [ Backdrop ] --

	-- Gets the backdrop.
	local function GetBackdrop(info)
		return info.arg[1].Backdrop
	end

	-- Sets the backdrop.
	local function SetBackdrop(info, value)
		local Group = info.arg[1]
		Group:__Skin(Group.SkinID, Group.Gloss, (value and true) or false)
	end

	-- [ Colors ] --

	-- Gets a layer's color.
	local function GetLayerColor(info)
		local Group, Layer = info.arg[1], info.arg[2]
		return Group:GetLayerColor(Layer)
	end

	-- Sets a layer's color.
	local function SetLayerColor(info, r, g, b, a)
		local Group, Layer = info.arg[1], info.arg[2]
		Group:__SetLayerColor(Layer, r, g, b, a)
	end

	-- Resets all colors.
	local function ResetAllColors(info)
		info.arg:__ResetColors()
	end

	-- [ Layer States ] --

	-- Gets the state of the backdrop color.
	local function GetBackdropState(info)
		return (not info.arg[1].Backdrop) or info.arg[1].Disabled
	end

	-- Gets the hidden state of a layer.
	local function GetState(info)
		local Group, Layer = info.arg[1], info.arg[2]
		local Skin = Skins[Group.SkinID]
		return Skin[Layer].Hide or Group.Disabled
	end

	-- [ Group States ] --

	-- Gets the disabled state of a group.
	local function GetDisabled(info)
		return info.arg.Disabled
	end

	-- Sets the disabled state of a group.
	local function SetDisabled(info, value)
		local Group = info.arg
		if value then
			Group:__Disable()
		else
			Group:__Enable()
		end
	end

	-- Gets the disabled state of a group's parent.
	local function GetParentState(info)
		local Parent = info.arg.Parent
		return Parent and Parent.Disabled
	end

	-- Creates an options group for an add-on or add-on group.
	function CreateOptions(Addon, SubGroup)
		local Group = Core.Button:Group(Addon, SubGroup)
		local Name, Info, Desc
		if SubGroup then
			Name = SubGroup
			Info = (L["Adjust the skin of all buttons registered to %s: %s."]):format(Addon, SubGroup)
		elseif Addon then
			Name = Addon
			Info = (L["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."]):format(Addon)
		else
			Name = L["Global"]
			Info = L["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."]
		end
		return {
			type = "group",
			name = Name,
			args = {
				Info = {
					type = "description",
					name = Info.."\n",
					order = 0,
				},
				Disable = {
					type = "toggle",
					name = L["Disable"],
					desc = L["Disable the skinning of this group."],
					get = GetDisabled,
					set = SetDisabled,
					arg = Group,
					disabled = GetParentState,
					order = 1,
				},
				Skin = {
					type = "select",
					name = L["Skin"],
					desc = L["Set the skin for this group."],
					get = GetSkin,
					set = SetSkin,
					arg = Group,
					style = "dropdown",
					width = "full",
					values = SkinList,
					disabled = GetDisabled,
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
					inline = true,
					order = 4,
					args = {
						Color = {
							type = "color",
							name = L["Color"],
							desc = L["Set the color of the gloss texture."],
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {Group, "Gloss"},
							disabled = GetState,
							order = 1,
						},
						Opacity = {
							type = "range",
							name = L["Opacity"],
							desc = L["Set the intensity of the gloss color."],
							get = GetGloss,
							set = SetGloss,
							arg = {Group, "Gloss"},
							min = 0,
							max = 1,
							step = 0.05,
							isPercent = true,
							disabled = GetState,
							order = 2,
						},
					},
				},
				Backdrop = {
					type = "group",
					name = L["Backdrop Settings"],
					inline = true,
					order = 5,
					args = {
						Enable = {
							type = "toggle",
							name = L["Enable"],
							desc = L["Enable the backdrop texture."],
							get = GetBackdrop,
							set = SetBackdrop,
							arg = {Group, "Backdrop"},
							disabled = GetState,
							order = 1,
						},
						Color = {
							type = "color",
							name = L["Color"],
							desc = L["Set the color of the backdrop texture."],
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {Group, "Backdrop"},
							hasAlpha = true,
							disabled = GetBackdropState,
							order = 2,
						},
					},
				},
				Colors = {
					type = "group",
					name = L["Colors"],
					inline = true,
					order = 6,
					args = {
						Normal = {
							type = "color",
							name = L["Normal"],
							desc = L["Set the color of the normal texture."],
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {Group, "Normal"},
							hasAlpha = true,
							disabled = GetState,
							order = 1,
						},
						Highlight = {
							type = "color",
							name = L["Highlight"],
							desc = L["Set the color of the highlight texture."],
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {Group, "Highlight"},
							hasAlpha = true,
							disabled = GetState,
							order = 2,
						},
						Checked = {
							type = "color",
							name = L["Checked"],
							desc = L["Set the color of the checked texture."],
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {Group, "Checked"},
							hasAlpha = true,
							disabled = GetState,
							order = 3,
						},
						Flash = {
							type = "color",
							name = L["Flash"],
							desc = L["Set the color of the flash texture."],
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {Group, "Flash"},
							hasAlpha = true,
							disabled = GetState,
							order = 4,
						},
						Pushed = {
							type = "color",
							name = L["Pushed"],
							desc = L["Set the color of the pushed texture."],
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {Group, "Pushed"},
							hasAlpha = true,
							disabled = GetState,
							order = 5,
						},
						Disabled = {
							type = "color",
							name = L["Disabled"],
							desc = L["Set the color of the disabled texture."],
							get = GetLayerColor,
							set = SetLayerColor,
							arg = {Group, "Disabled"},
							hasAlpha = true,
							disabled = GetState,
							order = 6,
						},
					},
				},
				ResetAll = {
					type = "execute",
					name = L["Reset All Colors"],
					desc = L["Reset all colors to their defaults."],
					func = ResetAllColors,
					arg = Group,
					width = "full",
					disabled = GetDisabled,
					order = -1,
				},
			},
		}
	end
end

local args

-- [ Core Methods ] --

-- Updates the appropriate button options table.
function Core.Button:UpdateOptions(Addon, Group)
	if not Core.OptionsLoaded then
		return
	end
	if not Addon then
		for _, Addon in pairs(self:ListAddons()) do
			local a = Addon:gsub("%s", "_")
			args[a] = args[a] or CreateOptions(Addon)
		end
	elseif not Group then
		local a = Addon:gsub("%s", "_")
		for _, Group in pairs(self:ListGroups(Addon)) do
			local g = Group:gsub("%s", "_")
			local aargs = args[a].args
			aargs[g] = aargs[g] or CreateOptions(Addon, Group)
		end
	end
end

-- Loads the buttons options.
function Core.Button:LoadOptions()
	-- Button General
	Core.Options.args.Buttons = {
		type = "group",
		name = L["Buttons"],
		order = 1,
		args = {
			Info = {
				type = "description",
				name = L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."].."\n",
				order = 1,
			},
		},
	}

	args = Core.Options.args.Buttons.args

	-- Global
	Core.Options.args.Buttons.args.Global = CreateOptions()
	Core.Options.args.Buttons.args.Global.order = 0

	-- Update
	self:UpdateOptions()
	for _, Addon in pairs(self:ListAddons()) do
		self:UpdateOptions(Addon)
	end

	-- Buttons Panel
	Core.OptionsPanel.Buttons = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(Masque, L["Buttons"], Masque, "Buttons")
end

-- Reloads the button settings on profile activity.
function Core.Button:Reload()
	-- Global Skin
	local CG = self:Group()
	CG.Disabled = Core.db.profile.Button.Masque.Disabled
	CG:__Skin(Core.db.profile.Button.Masque.SkinID, Core.db.profile.Button.Masque.Gloss, Core.db.profile.Button.Masque.Backdrop, Core.db.profile.Button.Masque.Colors, true)

	-- Add-on Skins
	for _, Addon in pairs(self:ListAddons()) do
		local AG = self:Group(Addon)
		local id = AG.GroupID
		AG.Disabled = Core.db.profile.Button[id].Disabled
		AG:__Skin(Core.db.profile.Button[id].SkinID, Core.db.profile.Button[id].Gloss, Core.db.profile.Button[id].Backdrop, Core.db.profile.Button[id].Colors, true)

		-- Group Skins
		for _, Group in pairs(self:ListGroups(Addon)) do
			local SG = self:Group(Addon, Group)
			local sid = SG.GroupID
			SG.Disabled = Core.db.profile.Button[sid].Disabled
			SG:__Skin(Core.db.profile.Button[sid].SkinID, Core.db.profile.Button[sid].Gloss, Core.db.profile.Button[sid].Backdrop, Core.db.profile.Button[sid].Colors)
		end
	end
end
