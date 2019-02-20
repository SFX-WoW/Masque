--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Options\About.lua
	* Author.: StormFX

	'About Masque' Group/Panel

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- Lua
---

local tostring = tostring

----------------------------------------
-- Setup
---

do
	local Setup = Core.Setup

	-- Creates the 'About Masque' options group and panel.
	function Setup.About(self)
		local L = self.Locale

		local Desc = L["Masque is a skinning engine for button-based add-ons."].." "..
			L["You must have an add-on that supports Masque installed to use it."].."\n\n"..
			L["For more information, please visit one of the sites listed below."].."\n"

		-- Root Options Group
		local Options = {
			type = "group",
			name = L["About Masque"],
			order = 3,
			args = {
				Label = {
					type = "description",
					name = "|cffffcc00"..L["About Masque"].."|r\n",
					fontSize = "medium",
					order = 1,
				},
				Text = {
					type = "description",
					name = Desc,
					fontSize = "medium",
					order = 2,
				},
				Info = {
					type = "group",
					name = "",
					order = 3,
					inline = true,
					get  = Core.GetArg,
					set  = Core.NoOp,
					args = {
						Version = {
							type = "input",
							name = L["Version"],
							arg  = tostring(Core.Version),
							order = 1,
							disabled = true,
							dialogControl = "SFX-Info",
						},
						API = {
							type = "input",
							name = L["API"],
							arg  = tostring(Core.API_VERSION),
							order = 2,
							disabled = true,
							dialogControl = "SFX-Info",
						},
						SPC0 = {
							type = "description",
							name = " ",
							order = 3,
						},
					},
				},
			},
		}

		local args = Options.args.Info.args

		local Authors = self.Authors
		local Websites = self.Websites

		local Order = 4
		local Count

		-- Populate the Author fields.
		Count = #Authors
		if Count > 0 then
			for i = 1, Count do
				local Name = (i == 1 and L["Authors"]) or ""
				local Key = "Author"..i
				args[Key] = {
					type = "input",
					name = Name,
					arg  = Authors[i],
					order = Order,
					disabled = true,
					dialogControl = "SFX-Info",
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

		-- Populate the Website fields.
		Count = #Websites
		if Count > 0 then
			for i = 1, Count do
				local Name = (i == 1 and L["Websites"]) or ""
				local Key = "Website"..i
				args[Key] = {
					type = "input",
					name = Name,
					arg  = Websites[i],
					order = Order,
					dialogControl = "SFX-Info-URL",
				}
				Order = Order + 1
			end
			args["SPC"..Order] = {
				type = "description",
				name = " ",
				order = Order,
			}
		end

		-- Core Options Group
		self.Options.args.Core.args.About = Options

		-- GC
		Setup.About = nil
	end
end
