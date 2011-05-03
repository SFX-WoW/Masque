--[[
	Project.: Masque
	File....: Options.lua
	Version.: @file-revision@
	Author..: StormFX, JJSheets
]]

-- [ Locals ] --

local Masque, Core = ...
if not Core.Loaded then return end
local L, pairs = Core.Locale, pairs

-- [ Core Methods ] --

-- Loads the options table when called.
function Core:LoadOptions()
	-- General Options
	self.Options.args.General.args.Info = {
		type = "description",
		name = L["Masque is a modular add-on skinning engine."].."\n",
		order = 1,
	}
	self.Options.args.General.args.Preload = {
		type = "toggle",
		name = L["Preload Options"],
		desc = L["Causes Masque to preload its options instead of having them loaded on demand."],
		get = function() return Core.db.profile.Preload end,
		set = function(i, v)
			Core.db.profile.Preload = v
		end,
		order = 2,
	}
	self.Options.args.General.args.Debug = {
		type = "toggle",
		name = L["Debug Mode"],
		desc = L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."],
		get = function() return Core.db.profile.Debug end,
		set = function() Core:Debug() end,
		order = 3,
	}

	-- Button Options
	Core.Options.args.Buttons.args.Global = Core.Button:CreateOptions()
	Core.Options.args.Buttons.args.Global.order = 0
	self.Button:UpdateOptions()
	for _, Addon in pairs(self.Button:ListAddons()) do
		self.Button:UpdateOptions(Addon)
	end

	-- Profile Options
	self.Options.args.Profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.Options.args.Profiles.order = -1

	-- DualSpec
	local LDS = LibStub('LibDualSpec-1.0', true)
	if LDS then
		LDS:EnhanceDatabase(self.db, Masque)
		LDS:EnhanceOptions(self.Options.args.Profiles, self.db)
	end

	-- Options Panels
	local ACD = LibStub("AceConfigDialog-3.0")
	self.OptionsPanel.Buttons = ACD:AddToBlizOptions(Masque, L["Buttons"], Masque, "Buttons")
	self.OptionsPanel.Profiles = ACD:AddToBlizOptions(Masque, L["Profiles"], Masque, "Profiles")

	self.OptionsLoaded = true
end

-- [ Button Options ] --

do
	-- Gets the skin.
	local function GetSkin(info)
		return info.arg.SkinID
	end

	-- Sets the skin.
	local function SetSkin(info, value)
		local Group = info.arg
		Group:Skin(value, Group.Gloss, Group.Backdrop)
	end

	-- Gets the gloss.
	local function GetGloss(info)
		return info.arg[1].Gloss or 0
	end

	-- Sets the gloss.
	local function SetGloss(info, value) -- redo
		local Group = info.arg[1]
		Group:Skin(Group.SkinID, value, Group.Backdrop)
	end

	-- Gets the backdrop.
	local function GetBackdrop(info)
		return info.arg[1].Backdrop
	end

	-- Sets the backdrop.
	local function SetBackdrop(info, value)
		local Group = info.arg[1]
		Group:Skin(Group.SkinID, Group.Gloss, (value and true) or false)
	end

	-- Gets the state of the backdrop color.
	local function GetBDState(info)
		return (not info.arg[1].Backdrop) or info.arg[1].Disabled
	end

	-- Gets a layer's color.
	local function GetLayerColor(info)
		local Group, Layer = info.arg[1], info.arg[2]
		return Group:GetLayerColor(Layer)
	end

	-- Sets a layer's color.
	local function SetLayerColor(info, r, g, b, a)
		local Group, Layer = info.arg[1], info.arg[2]
		Group:SetLayerColor(Layer, r, g, b, a)
	end

	-- Resets all colors.
	local function ResetAllColors(info)
		info.arg:ResetColors()
	end

	-- Gets the hidden state of a layer.
	local function GetState(info)
		local Group, Layer = info.arg[1], info.arg[2]
		local Skin = Core.Button:GetSkin(Group.SkinID)
		return Skin[Layer].Hide or Group.Disabled
	end

	-- Gets the disabled state of a group.
	local function GetDisabled(info)
		return info.arg.Disabled
	end

	-- Sets the disabled state of a group.
	local function SetDisabled(info, value)
		local Group = info.arg
		if value then
			Group:Disable()
		else
			Group:Enable()
		end
	end

	-- Gets the disabled state of a group and its parent.
	local function GetParentState(info)
		local Parent = info.arg.Parent
		return Parent and Parent.Disabled
	end

	-- Creates an options group for an add-on or add-on group.
	function Core.Button:CreateOptions(Addon, SubGroup)
		local Group = self:Group(Addon, SubGroup)
 		local Name, Info
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
					values = Core.Button.ListSkins,
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
							disabled = GetBDState,
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

	local Args = Core.Options.args.Buttons.args

	-- Updates the button options table.
	function Core.Button:UpdateOptions(Addon, Group)
		if not Addon then
			for _, Addon in pairs(Core.Button:ListAddons()) do
				local a = Addon:gsub("%s", "_")
				Args[a] = Args[a] or Core.Button:CreateOptions(Addon)
				--print("Creating options for", Addon)
			end
		elseif not Group then
			local a = Addon:gsub("%s", "_")
			for _, Group in pairs(Core.Button:ListGroups(Addon)) do
				local g = Group:gsub("%s", "_")
				local AddonArgs = Args[a].args
				AddonArgs[g] = AddonArgs[g] or Core.Button:CreateOptions(Addon, Group)
			end
		end
	end
end
