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
-- Skins
---

do
	-- Skin Data
	local Skins = {}

	-- Skin List
	local SkinList = {}

	-- Empty Table
	local __Empty = {}

	-- Hidden Table
	local Hidden = {
		Hide = true,
	}

	-- @ Skins\Regions
	local Layers = Core.RegDefs

	-- Adds data to the skin tables.
	local function AddSkin(SkinID, SkinData, Default)
		-- Validation
		for Layer, Info in pairs(Layers) do
			local Skin = SkinData[Layer]

			-- Set AutoCast/Shine to the proper key.
			if Layer == "AutoCastShine" then
				Skin = Skin or SkinData.Shine or SkinData.AutoCast

			-- Use Cooldown if ChargeCooldown is missing.
			elseif Layer == "ChargeCooldown" then
				Skin = Skin or SkinData.Cooldown
			end

			local CanHide = Info.CanHide

			-- Ensure each layer is set.
			if type(Skin) ~= "table" then
				Skin = (CanHide and Hidden) or __Empty

			-- Don't let skins hide layers they shouldn't.
			elseif not CanHide then
				Skin.Hide = nil

			-- Hide unused layers.
			elseif Info.Hide then
				Skin = Hidden
			end

			SkinData[Layer] = Skin
		end

		-- Save the ID
		SkinData.SkinID = SkinID

		-- Set the skin data.
		Skins[SkinID] = SkinData
		SkinList[SkinID] = SkinID

		-- Default Skin
		if Default then
			Core.DEFAULT_SKIN = SkinID
		end
	end

	----------------------------------------
	-- Core
	---

	Core.Skins = setmetatable(Skins, {
		__index = function(self, s)
			if s == "Blizzard" then
				return self.Classic
			end
		end
	})

	Core.SkinList = SkinList
	Core.AddSkin = AddSkin
	Core.__Empty = __Empty

	----------------------------------------
	-- API
	---

	local API = Core.API

	-- Wrapper for the AddSkin function.
	function API:AddSkin(SkinID, SkinData, Replace)
		local Debug = Core.Debug

		-- @SkinID must be a string.
		if type(SkinID) ~= "string" then
			if Debug then
				error("Bad argument to API method 'AddSkin'. 'SkinID' must be a string.", 2)
			end
			return
		end

		-- Duplicates
		if Skins[SkinID] and not Replace then
			return
		end

		-- @SkinData must be a table.
		if type(SkinData) ~= "table" then
			if Debug then
				error("Bad argument to API method 'AddSkin'. 'SkinData' must be a table.", 2)
			end
			return
		end

		-- Template
		local Template = SkinData.Template

		if Template then
			if type(Template) ~= "string" then
				if Debug then
					error(("Invalid template reference by skin '%s'. 'Template' must be a string."):format(SkinID), 2)
				end
				return
			end

			-- Make sure the template exists.
			local Parent = Skins[Template]
			if type(Parent) ~= "table"  then
				if Debug then
					error(("Invalid template reference by skin '%s'. Template '%s' does not exist or is not a table."):format(SkinID, Template), 2)
				end
				return
			end

			-- Group skins with their template.
			local Group = Parent.Group or Template
			Parent.Group = Group

			setmetatable(SkinData, {__index = Parent})
		end

		AddSkin(SkinID, SkinData)
	end

	-- Retrieves the default skin.
	function API:GetDefaultSkin()
		return Core.DEFAULT_SKIN
	end

	-- Retrieves the skin data for the specified skin.
	function API:GetSkin(SkinID)
		return SkinID and Skins[SkinID]
	end

	-- Retrieves the Skins table.
	function API:GetSkins()
		return Skins
	end
end
