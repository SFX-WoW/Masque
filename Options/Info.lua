--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Options\Info.lua
	* Author.: StormFX

	'Installed Skins' Group/Panel

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Lua
---

local pairs, tostring = pairs, tostring

----------------------------------------
-- Locals
---

local L = Core.Locale
local GetInfoGroup

----------------------------------------
-- Utility
---

do
	-- Versions
	local API_VERSION = Core.API_VERSION
	local OLD_VERSION = Core.OLD_VERSION

	-- Formatted Status Text
	local UNKNOWN = "|cff777777"..L["Unknown"].."|r"
	local UPDATED = "|cff00ff00"..L["Compatible"].."|r"
	local COMPATIBLE = "|cffffff00"..L["Compatible"].."|r"
	local INCOMPATIBLE = "|cffff0000"..L["Incompatible"].."|r"

	-- Returns the Status text for a skin based on its Masque_Version setting.
	local function GetStatus(Version)
		if not Version then
			return UNKNOWN
		elseif Version < OLD_VERSION then
			return INCOMPATIBLE
		elseif Version < API_VERSION then
			return COMPATIBLE
		else
			return UPDATED
		end
	end

	----------------------------------------
	-- Options Builder
	---

	-- Creates a Skin Info options group.
	function GetInfoGroup(Skin, Group)
		local Title = (Group and Skin.Title) or Skin.SkinID
		local Order = (Group and Skin.Order) or nil
		local Description = Skin.Description or L["No description available."]
		local Version = (Skin.Version and tostring(Skin.Version)) or UNKNOWN
		local Authors = Skin.Authors or Skin.Author or UNKNOWN
		local Websites = Skin.Websites or Skin.Website
		local Status = GetStatus(Skin.Masque_Version)

		-- Options Group
		local Info = {
			type = "group",
			name = Title,
			order = Order,
			args = {
				Label = {
					type = "description",
					name = "|cffffcc00"..L["Description"].."|r\n",
					order = 1,
					fontSize = "medium",
				},
				Text = {
					type = "description",
					name = Description.."\n",
					order = 2,
					fontSize = "medium",
				},
				Info = {
					type = "group",
					name = "",
					order = 3,
					inline = true,
					args = {
						Version = {
							type = "input",
							name = L["Version"],
							arg = Version.."\n",
							order = 1,
							disabled = true,
							dialogControl = "SFX-InfoRow",
						},
					},
				},
			},
		}

		local args = Info.args.Info.args
		Order = 3

		-- Populate the Author field(s).
		if type(Authors) == "table" then
			local Count = #Authors
			if Count > 0 then
				for i = 1, Count do
					local Key = "Author"..i
					local Name = (i == 1 and L["Authors"]) or ""
					args[Key] = {
						type = "input",
						name = Name,
						arg  = Authors[i],
						order = Order,
						disabled = true,
						dialogControl = "SFX-InfoRow",
					}
					Order = Order + 1
				end
				args["SPC"..Order] = {
					type = "description",
					name = " ",
					order = Order,
				}
				Order = Order + 1
			end
		elseif type(Authors) == "string" then
			args.Author = {
				type = "input",
				name = L["Author"],
				arg  = Authors,
				order = Order,
				disabled = true,
				dialogControl = "SFX-InfoRow",
			}
			Order = Order + 1
			args["SPC"..Order] = {
				type = "description",
				name = " ",
				order = Order,
			}
			Order = Order + 1
		end

		-- Populate the Website field(s).
		if type(Websites) == "table" then
			local Count = #Websites
			if Count > 0 then
				for i = 1, Count do
					local Key = "Website"..i
					local Name = (i == 1) and L["Websites"] or ""
					args[Key] = {
						type = "input",
						name = Name,
						arg  = Websites[i],
						order = Order,
						dialogControl = "SFX-InfoRow",
					}
					Order = Order + 1
				end
				args["SPC"..Order] = {
					type = "description",
					name = " ",
					order = Order,
				}
				Order = Order + 1
			end
		elseif type(Websites) == "string" then
			args.Website = {
				type = "input",
				name = L["Website"],
				arg  = Websites,
				order = Order,
				dialogControl = "SFX-InfoRow",
			}
			Order = Order + 1
			args["SPC"..Order] = {
				type = "description",
				name = " ",
				order = Order,
			}
			Order = Order + 1
		end

		-- Status
		args.Status = {
			type = "input",
			name = L["Status"],
			arg = Status,
			order = Order,
			disabled = true,
			dialogControl = "SFX-InfoRow",
		}

		return Info
	end
end

----------------------------------------
-- Setup
---

do
	local Setup = Core.Setup

	-- Creates/Removes the 'Installed Skins' options group and panel.
	function Setup.Info(self)
		if self.db.profile.SkinInfo then
			local TOOLTIP = "|cffffffff"..L["Click for details."].."|r"

			-- Root Options Group
			local Options = {
				type = "group",
				name = L["Installed Skins"],
				desc = TOOLTIP,
				get = Core.GetArg,
				set = Core.NoOp,
				order = 4,
				args = {
					Label = {
						type = "description",
						name = "Skins page description",
						fontSize = "medium",
						order = 0,
					},
				},
			}

			local Skins = Core.Skins
			local args = Options.args

			-- Create the options groups.
			for SkinID, Skin in pairs(Skins) do
				local Group = Skin.Group
				if Group then
					if not args[Group] then
						args[Group] = {
							type = "group",
							name = Group,
							desc = TOOLTIP,
							args = {},
							childGroups = "select",
						}
					end
					args[Group].args[SkinID] = GetInfoGroup(Skin, Group)
				else
					args[SkinID] = GetInfoGroup(Skin)
					args[SkinID].desc = TOOLTIP
				end
			end

			-- Core Options Group
			self.Options.args.Core.args.SkinInfo = Options
		else
			self.Options.args.Core.args.SkinInfo = nil
		end
		LibStub("AceConfigRegistry-3.0"):NotifyChange(MASQUE)
	end
end
