--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Options.lua
	* Author.: StormFX

	'Skin Settings' Group/Panel

]]

-- GLOBALS: LibStub

local MASQUE, Core = ...

----------------------------------------
-- Lua
---

local pairs = pairs

----------------------------------------
-- Locals
---

local L = Core.Locale
local GetOptions

----------------------------------------
-- Utility
---

do
	local Skins, SkinList = Core.Skins, Core.SkinList

	-- Gets an option's value.
	local function GetOption(info)
		local Option = info[#info]
		if Option == "SkinID" then
			return SkinList[info.arg.db.SkinID] or "Classic"
		else
			return info.arg.db[Option]
		end
	end

	-- Sets an option's value.
	local function SetOption(info, value)
		info.arg:SetOption(info[#info], value)
	end

	-- Gets a layer color.
	local function GetColor(info)
		local Layer = info[#info]
		if Layer == "Color" then
			Layer = info[#info-1]
		end
		return info.arg:GetColor(Layer)
	end

	-- Sets a layer color.
	local function SetColor(info, r, g, b, a)
		local Layer = info[#info]
		if Layer == "Color" then
			Layer = info[#info-1]
		end
		info.arg:SetColor(Layer, r, g, b, a)
	end

	-- Resets the skin.
	local function Reset(info)
		info.arg:Reset()
	end

	-- Gets the disabled state of a group.
	local function GetGroupState(info)
		return info.arg.db.Disabled
	end

	-- Sets the disabled state of a group.
	local function SetGroupState(info, value)
		if value then
			info.arg:Disable()
		else
			info.arg:Enable()
		end
	end

	-- Gets the disabled state of a group's parent.
	local function GetParentState(info)
		local Parent = info.arg.Parent
		return Parent and Parent.db.Disabled
	end

	-- Gets the state of a layer.
	local function GetState(info)
		local db, Layer = info.arg.db, info[#info]
		local Skin = Skins[db.SkinID] or "Classic"
		if Layer == "Color" then
			Layer = info[#info-1]
		end
		if Layer == "Border" then
			return (not info.arg.IsActionBar) or Skin[Layer].Hide or db.Disabled
		else
			return Skin[Layer].Hide or db.Disabled
		end
	end

	-- Gets the state of the backdrop color.
	local function GetBackdropState(info)
		local db = info.arg.db
		return (not db.Backdrop) or db.Disabled
	end

	----------------------------------------
	-- Options Builder
	---

	-- Creates a skin options group for an add-on or add-on group.
	function GetOptions(obj, Order)
		local Addon, Group = obj.Addon, obj.Group
		local Name, Title, Info

		if Group then
			local Text = Addon..": "..Group
			Name = Group
			Title = "|cffffcc00"..Text.."|r\n"
			Info = L["This section will allow you to adjust the skin settings of all buttons registered to %s."]
			Info = Info:format(Text)
		elseif Addon then
			Name = Addon
			Title = "|cffffcc00"..Addon.."|r\n"
			Info = L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."]
			Info = Info:format(Addon)
		else
			Name = L["Global"]
			Title = "|cffffcc00"..L["Global Settings"].."|r\n"
			Info = L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."]
		end

		return {
			type = "group",
			name = Name,
			order = Order,
			args = {
				Title = {
					type = "description",
					name = Title,
					fontSize = "medium",
					order = 0,
				},
				Info = {
					type = "description",
					name = Info.."\n",
					fontSize = "medium",
					order = 1,
				},
				Disable = {
					type = "toggle",
					name = L["Disable"],
					desc = L["Disable the skinning of this group."],
					get = GetGroupState,
					set = SetGroupState,
					arg = obj,
					disabled = GetParentState,
					order = 2,
				},
				SkinID = {
					type = "select",
					name = L["Skin"],
					desc = L["Set the skin for this group."],
					get = GetOption,
					set = SetOption,
					arg = obj,
					style = "dropdown",
					width = "full",
					values = SkinList,
					disabled = GetGroupState,
					order = 3,
				},
				Spacer = {
					type = "description",
					name = " ",
					order = 4,
				},
				Gloss = {
					type = "group",
					name = L["Gloss Settings"],
					inline = true,
					disabled = GetState,
					order = 5,
					args = { 
						Color = {
							type = "color",
							name = L["Color"],
							desc = L["Set the color of the Gloss texture."],
							get = GetColor,
							set = SetColor,
							arg = obj,
							order = 1,
						},
						Gloss = {
							type = "range",
							name = L["Opacity"],
							desc = L["Set the intensity of the Gloss color."],
							get = GetOption,
							set = SetOption,
							arg = obj,
							min = 0,
							max = 1,
							step = 0.05,
							isPercent = true,
							order = 2,
						},
					},
				},
				Backdrop = {
					type = "group",
					name = L["Backdrop Settings"],
					inline = true,
					order = 6,
					args = {
						Backdrop = {
							type = "toggle",
							name = L["Enable"],
							desc = L["Enable the Backdrop texture."],
							get = GetOption,
							set = SetOption,
							arg = obj,
							disabled = GetState,
							order = 1,
						},
						Color = {
							type = "color",
							name = L["Color"],
							desc = L["Set the color of the Backdrop texture."],
							get = GetColor,
							set = SetColor,
							arg = obj,
							disabled = GetBackdropState,
							hasAlpha = true,
							order = 2,
						},
					},
				},
				Colors = {
					type = "group",
					name = L["Colors"],
					get = GetColor,
					set = SetColor,
					inline = true,
					disabled = GetState,
					order = 7,
					args = {
						Normal = {
							type = "color",
							name = L["Normal"],
							desc = L["Set the color of the Normal texture."],
							arg = obj,
							hasAlpha = true,
							order = 1,
						},
						Highlight = {
							type = "color",
							name = L["Highlight"],
							desc = L["Set the color of the Highlight texture."],
							arg = obj,
							hasAlpha = true,
							order = 2,
						},
						Checked = {
							type = "color",
							name = L["Checked"],
							desc = L["Set the color of the Checked texture."],
							arg = obj,
							hasAlpha = true,
							order = 3,
						},
						Border = {
							type = "color",
							name = L["Equipped"],
							desc = L["Set the color of the Equipped item texture."],
							arg = obj,
							hasAlpha = true,
							order = 4,
						},
						Flash = {
							type = "color",
							name = L["Flash"],
							desc = L["Set the color of the Flash texture."],
							arg = obj,
							hasAlpha = true,
							order = 5,
						},
						Pushed = {
							type = "color",
							name = L["Pushed"],
							desc = L["Set the color of the Pushed texture."],
							arg = obj,
							hasAlpha = true,
							order = 6,
						},
						Disabled = {
							type = "color",
							name = L["Disabled"],
							desc = L["Set the color of the Disabled texture."],
							arg = obj,
							hasAlpha = true,
							order = 7,
						},
						Cooldown = {
							type = "color",
							name = L["Cooldown"],
							desc = L["Set the color of the Cooldown animation."],
							arg = obj,
							hasAlpha = true,
							order = 8,
						},
					},
				},
				Reset = {
					type = "execute",
					name = L["Reset Skin"],
					desc = L["Reset all skin options to the defaults."],
					func = Reset,
					arg = obj,
					width = "full",
					disabled = GetGroupState,
					order = -1,
				},
			},
		}
	end

	Core.GetOptions = GetOptions
end

----------------------------------------
-- Setup
---

do
	local Setup = Core.Setup

	-- Creates the 'Skin Settings' options group and panel.
	function Setup.Skins(self)
		-- Root Options Group
		local Options = {
			type = "group",
			name = L["Skin Settings"],
			order = 1,
			args = {
				Title = {
					type = "description",
					name = "|cffffcc00"..MASQUE.." - "..L["Skin Settings"].."|r\n",
					order = 0,
					fontSize = "medium",
					hidden = Core.GetStandAlone,
				},
				Info = {
					type = "description",
					name = L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."].."\n",
					fontSize = "medium",
					order = 1,
				},
			},
		}

		local args = Options.args

		-- Global
		local Global = Core.GetGroup(MASQUE)
		args.Global = GetOptions(Global, 2)

		-- Add-Ons
		local Addons = Global.SubList
		for aID, aObj in pairs(Addons) do
		args[aID] = GetOptions(aObj)
			local aargs = args[aID].args

			-- Groups
			local Groups = aObj.SubList
			for gID, gObj in pairs(Groups) do
			aargs[gID] = GetOptions(gObj)
			end
		end

		-- Core Options Group/Panel
		self.Options.args.Skins = Options
		self.SkinOptionsPanel = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(MASQUE, L["Skin Settings"], MASQUE, "Skins")

		-- GC
		Setup.Skins = nil
	end
end

----------------------------------------
-- Core
---

do
	local LIB_ACR = LibStub("AceConfigRegistry-3.0")

	-- Updates the skin options for the group based on the value passed.
	function Core.UpdateSkinOptions(obj, Value)
		if not Core.OptionsLoaded then return end

		local ID, Addon, Group = obj.ID, obj.Addon, Obj.Group
		local args = self.Options.args.Skins.args

		if Group then
			args = args[Addon].args
		end

		-- Create
		if not Value and not args[ID] then
			args[ID] = GetOptions(obj)
		-- Rename
		elseif type(Value) == "string" and Group then
			args[ID].name = Value
		-- Delete
		elseif Value == true then
			args[ID] = nil
		else
			return
		end

		LIB_ACR:NotifyChange(MASQUE)
	end
end
