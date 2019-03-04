--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Skins\Skins.lua
	* Author.: StormFX

	Skin API

]]

local _, Core = ...

----------------------------------------
-- Lua
---

local error, setmetatable, type = error, setmetatable, type

----------------------------------------
-- Locals
---

local C_API = Core.API

----------------------------------------
-- Skins
---

-- Skin Data
local Skins = {}
Core.Skins = setmetatable(Skins, {
	__index = function(self, s)
		if s == "Blizzard" then
			return self.Classic
		end
	end
})

-- Skin List
local SkinList = {}
Core.SkinList = SkinList

-- Layers
local Layers = {
	"Backdrop",
	"Icon",
	"Flash",
	"Pushed",
	"Normal",
	"Disabled",
	"Checked",
	"Border",
	"Gloss",
	"AutoCastable",
	"Highlight",
	"Name",
	"Count",
	"HotKey",
	"Duration",
	"Cooldown",
	"ChargeCooldown",
	"Shine",
}

-- Hidden Layer
local Hidden = {
	Hide = true,
}

-- Adds data to the skin tables, bypassing the skin validation.
function Core:AddSkin(SkinID, SkinData)
	for i = 1, #Layers do
		local Layer = Layers[i]
		if type(SkinData[Layer]) ~= "table" then
			if Layer == "Shine" and type(SkinData.AutoCast) == "table" then
				SkinData[Layer] = SkinData.AutoCast
			else
				SkinData[Layer] = Hidden
			end
		end
	end
	SkinData.SkinID = SkinID
	Skins[SkinID] = SkinData
	SkinList[SkinID] = SkinID
end

do
	----------------------------------------
	-- API
	---

	-- Wrapper method for the AddSkin function.
	function C_API:AddSkin(SkinID, SkinData, Replace)
		local Debug = Core.db.profile.Debug

		-- Validation
		if type(SkinID) ~= "string" then
			if Debug then
				error("Bad argument to API method 'AddSkin'. 'SkinID' must be a string.", 2)
			end
			return
		end

		if Skins[SkinID] and not Replace then
			return
		end
		if type(SkinData) ~= "table" then
			if Debug then
				error("Bad argument to API method 'AddSkin'. 'SkinData' must be a table.", 2)
			end
			return
		end

		-- Template Vaidation
		local Template = SkinData.Template
		if Template then
			if type(Template) ~= "string" then
				if Debug then
					error(("Invalid template reference by skin '%s'. 'Template' must be a string."):format(SkinID), 2)
				end
				return
			end
			local Parent = Skins[Template]
			if type(Parent) ~= "table"  then
				if Debug then
					error(("Invalid template reference by skin '%s'. Template '%s' does not exist or is not a table."):format(SkinID, Template), 2)
				end
				return
			end

			-- Automatically group templated skins with their parent.
			local Group = Parent.Group or Template
			Parent.Group = Group

			setmetatable(SkinData, {__index = Parent})
		end
		Core:AddSkin(SkinID, SkinData)
	end

	-- API method returning a specific skin.
	function C_API:GetSkin(SkinID)
		return SkinID and Skins[SkinID]
	end

	-- API method for returning the skins table.
	function C_API:GetSkins()
		return Skins
	end
end
