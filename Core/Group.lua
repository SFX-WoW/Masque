--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Group.lua
	* Author.: StormFX, JJSheets

	Group Prototype

]]

-- GLOBALS:

local MASQUE, Core = ...

----------------------------------------
-- Lua
---

local error, pairs, type = error, pairs, type

----------------------------------------
-- Locals
---

-- @ Skins\Skins
local Skins = Core.Skins

-- @ Core\Utility: Size, Points, Color, Coords
local _, _, _GetColor = Core.Utility()

-- @ Core\Button
local SkinButton = Core.SkinButton

-- @ Core\Callback
local Callback = Core.Callback

----------------------------------------
-- Group Metatable
---

do
	-- Storage
	local Group = {}

	-- @ Core\Core
	local GetType = Core.GetType

	-- @ Skins\Regions
	local RegList = Core.RegList

	-- @ Core\Core
	local GetRegion = Core.GetRegion

	----------------------------------------
	-- :AddButton({Button}, {Regions} [, "Type" [, Strict]])
	---

	-- Adds or reassigns a button to the group.
	local function AddButton(self, Button, Regions, Type, Strict)
		local oType = Button.__MSQ_oType or GetType(Button, true)

		-- Validate the object type.
		if not oType then
			if Core.Debug then
				error("Bad argument to group method 'AddButton'. 'Button' must be a button object.", 2)
			end
			return

		-- Force 'Strict' if passing a frame.
		elseif oType == "Frame" then
			Strict = true
		end

		-- Button Type
		if not Type or not RegList[Type] then
			Type = Button.__MSQ_bType or GetType(Button)
		end

		Button.__MSQ_bType = Type

		-- Parent Group
		local Parent = Group[Button]

		if Parent then
			-- Already assigned to this group.
			if Parent == self then
				return

			-- Remove the button from its parent group.
			else
				Regions = Regions or Parent.Buttons[Button]
				Parent.Buttons[Button] = nil
			end
		end

		-- [Re]Assign the button to this group.
		Group[Button] = self

		-- Build the regions table.
		if type(Regions) ~= "table" then
			Regions = {}
		end

		-- Region List
		local Layers = RegList[Type]

		-- Iterate the layers.
		for Layer, Info in pairs(Layers) do
			local Region = Regions[Layer]

			-- Find missing regions.
			if not Strict and Region == nil then
				-- Check the old 'Shine' keys.
				if Layer == "AutoCastShine" then
					Region = Regions.Shine or Regions.AutoCast or GetRegion(Button, Info)

				-- Check the old 'FloatingBG' key.
				elseif Layer == "Backdrop" then
					Region = Regions.FloatingBG or GetRegion(Button, Info)

				-- Etc
				else
					Region = GetRegion(Button, Info)
				end

				-- Update the regions table.
				Regions[Layer] = Region
			end

			-- Update the region lists.
			if Region then
				-- Group
				self.Regions[Layer] = true

				-- Add-On
				if self.Group then
					local Addon = self.Parent
					Addon.Regions[Layer] = true
				end
			end
		end

		-- Store the Regions table.
		self.Buttons[Button] = Regions

		local db = self.db

		-- Skin the button.
		if not db.Disabled and not self.Queued then
			SkinButton(Button, Regions, db.SkinID, db.Backdrop, db.Shadow, db.Gloss, db.Colors)
		end
	end

	----------------------------------------
	-- :RemoveButton({Button})
	---

	-- Removes a button from the group and applies the default skin.
	local function RemoveButton(self, Button)
		if Button then
			local ButtonData = self.Buttons[Button]

			-- Apply the default skin.
			if ButtonData then
				SkinButton(Button, ButtonData, "Classic")
			end

			-- Remove the button.
			Group[Button] = nil
			self.Buttons[Button] = nil
		end
	end

	----------------------------------------
	-- :GetColor("Layer")
	---

	-- Returns a layer's current color.
	local function GetColor(self, Layer)
		if Layer then
			-- Get the skin.
			local Skin = Skins[self.db.SkinID] or Skins.Classic

			-- Return the current db or skin color.
			return _GetColor(self.db.Colors[Layer] or Skin[Layer].Color)
		end
	end

	----------------------------------------
	-- :GetLayer({Button}, "Layer")
	---

	-- Returns a button layer.
	local function GetLayer(self, Button, Layer)
		if Button and Layer then
			local Regions = self.Buttons[Button]

			-- Return the region.
			if Regions then
				return Regions[Layer]
			end
		end
	end

	----------------------------------------
	-- :ReSkin([Silent])
	---

	-- Reskins the group with its current settings.
	local function ReSkin(self, Silent)
		local db = self.db

		if not db.Disabled then
			-- Skin all buttons.
			for Button in pairs(self.Buttons) do
				SkinButton(Button, self.Buttons[Button], db.SkinID, db.Backdrop, db.Shadow, db.Gloss, db.Colors)
			end

			-- Fire the callback.
			if not Silent then
				-- Group Callback
				if self.Callback then
					Callback(self.ID, self.Group, db.SkinID, db.Backdrop, db.Shadow, db.Gloss, db.Colors)

				-- Add-on Callback
				elseif self.Addon then
					Callback(self.Addon, self.Group, db.SkinID, db.Backdrop, db.Shadow, db.Gloss, db.Colors)
				end
			end
		end
	end

	----------------------------------------
	-- :Delete()
	---

	-- Deletes the group and applies the default skin to its buttons.
	local function Delete(self)
		local Subs = self.SubList

		-- Delete any sub-groups.
		if Subs then
			for _, Sub in pairs(Subs) do
				Sub:Delete()
			end
		end

		local Buttons = self.Buttons

		-- Remove any buttons.
		for Button in pairs(Buttons) do
			-- Apply the default skin.
			SkinButton(Button, Buttons[Button], "Classic")

			-- Remove the button.
			Group[Button] = nil
			Buttons[Button] = nil
		end

		-- Update the parent's list.
		local Parent = self.Parent

		if Parent then
			Parent.SubList[self.ID] = nil
		end

		-- Update the options.
		Core:UpdateSkinOptions(self, true)

		-- Remove the group.
		Core.Groups[self.ID] = nil
	end

	----------------------------------------
	-- :SetName("Name")
	---

	-- :Renames the group.
	local function SetName(self, Name)
		if not self.StaticID then
			return

		-- @Name must be a string.
		elseif type(Name) ~= "string" then
			if Core.Debug then
				error("Bad argument to group method 'SetName'. 'Name' must be a string.", 2)
			end
			return
		end

		-- Update the name.
		self.Group = Name
		Core:UpdateSkinOptions(self)
	end

	----------------------------------------
	-- :SetCallback(func [, arg])
	---

	-- Registers a group-specific callback.
	local function SetCallback(self, func, arg)
		if self.ID == MASQUE then return end

		-- @func must be a function reference.
		if type(func) ~= "function" then
			if Core.Debug then
				error("Bad argument to Group method 'SetCallback'. 'func' must be a function.", 2)
			end
			return

		-- @arg must be a table or nil.
		elseif arg and type(arg) ~= "table" then
			if Core.Debug then
				error("Bad argument to Group method 'SetCallback'. 'arg' must be a table or nil.", 2)
			end
			return
		end

		-- Register the callback.
		Callback:Register(self.ID, func, arg or false)
		self.Callback = true
	end

	----------------------------------------
	-- :Reset()
	-- * This method is used internally.
	---

	-- Resets the group's skin settings.
	local function Reset(self)
		self.db.Backdrop = false
		self.db.Shadow = false
		self.db.Gloss = 0

		-- Unset all colors.
		for Layer in pairs(self.db.Colors) do
			self.db.Colors[Layer] = nil
		end

		-- Apply the changes.
		self:ReSkin()

		-- Update the sub-groups.
		local Subs = self.SubList

		if Subs then
			for _, Sub in pairs(Subs) do
				Sub:Reset()
			end
		end
	end

	----------------------------------------
	-- :Enable()
	-- * This method is used internally.
	---

	-- Enables the group.
	local function Enable(self)
		self.db.Disabled = false

		-- Reset the skin.
		self:ReSkin()

		-- Update the sub-groups.
		local Subs = self.SubList

		if Subs then
			for _, Sub in pairs(Subs) do
				Sub:Enable()
			end
		end
	end

	----------------------------------------
	-- :Disable([Silent])
	-- * This method is used internally.
	---

	-- Disables the group.
	local function Disable(self, Silent)
		self.db.Disabled = true

		-- Apply the default skin.
		for Button in pairs(self.Buttons) do
			SkinButton(Button, self.Buttons[Button], "Classic")
		end

		-- Fire the callback.
		if not Silent then
			local db = self.db

			-- Group Callback
			if self.Callback then
				Callback(self.ID, self.Group, db.SkinID, db.Backdrop, db.Shadow, db.Gloss, db.Colors, true)

			-- Add-on Callback
			elseif self.Addon then
				Callback(self.Addon, self.Group, db.SkinID, db.Backdrop, db.Shadow, db.Gloss, db.Colors, true)
			end
		end

		-- Update the sub-groups.
		local Subs = self.SubList

		if Subs then
			for _, Sub in pairs(Subs) do
				Sub:Disable(Silent)
			end
		end
	end

	----------------------------------------
	-- :SetColor("Layer", r, g, b [, a])
	-- * This method is used internally.
	---

	-- Sets the specified layer color.
	local function SetColor(self, Layer, r, g, b, a)
		if not Layer then return end

		-- Set the color.
		if r then
			self.db.Colors[Layer] = {r, g, b, a}

		-- Reset the color.
		else
			self.db.Colors[Layer] = nil
		end

		-- Apply the changes.
		self:ReSkin()

		-- Update the sub-groups.
		local Subs = self.SubList

		if Subs then
			for _, Sub in pairs(Subs) do
				Sub:SetColor(Layer, r, g, b, a)
			end
		end
	end

	----------------------------------------
	-- :SetOption("Option", Value)
	-- * This method is used internally.
	---

	-- Validates and sets a skin option.
	local function SetOption(self, Option, Value)
		if not Option then return end

		-- Skin
		if Option == "SkinID" then
			if Value and Skins[Value] then
				self.db.SkinID = Value
			end

		-- Backdrop
		elseif Option == "Backdrop" then
			self.db.Backdrop = (Value and true) or false

		-- Shadow
		elseif Option == "Shadow" then
			self.db.Shadow = (Value and true) or false

		-- Gloss
		elseif Option == "Gloss" then
			if type(Value) ~= "number" then
				Value = (Value and 1) or 0
			end
			self.db.Gloss = Value

		-- Etc
		else
			return
		end

		-- Apply the changes.
		self:ReSkin()

		-- Update the sub-groups.
		local Subs = self.SubList

		if Subs then
			for _, Sub in pairs(Subs) do
				Sub:SetOption(Option, Value)
			end
		end
	end

	----------------------------------------
	-- :GetOptions([Order])
	---

	-- Creates and returns an AceConfig-3.0 options table for the group.
	local function GetOptions(self, Order)
		return Core.GetOptions(self, Order)
	end

	----------------------------------------
	-- :Update([IsNew])
	-- * This method is intended for internal use only. Do not use it.
	---

	-- Updates the group on profile activity.
	local function Update(self, IsNew)
		local db = Core.db.profile.Groups[self.ID]

		-- Only update on profile change or group creation.
		if db == self.db then return end

		-- Update the DB the first time StaticID is used.
		if self.StaticID and not db.Upgraded then
			-- Get the old DB.
			local o_id = Core.GetID(self.Addon, self.Group)
			local o_db = Core.db.profile.Groups[o_id]

			-- Make sure it's not a new group.
			if not o_db.Inherit then
				Core.db.profile.Groups[self.ID] = o_db
				db = Core.db.profile.Groups[self.ID]
			end

			-- Remove the old pointer.
			Core.db.profile.Groups[o_id] = nil
			db.Upgraded = true
		end

		self.db = db

		-- Inheritance
		if self.Parent then
			local p_db = self.Parent.db

			-- Inherit the parent's settings on a new db.
			if db.Inherit then
				db.SkinID = p_db.SkinID
				db.Backdrop = p_db.Backdrop
				db.Shadow = p_db.Shadow
				db.Gloss = p_db.Gloss

				-- Remove any colors.
				for Layer in pairs(db.Colors) do
					db.Colors[Layer] = nil
				end

				-- Duplicate the parent's colors.
				for Layer in pairs(p_db.Colors) do
					local c = p_db.Colors[Layer]
					if type(c) == "table" then
						db.Colors[Layer] = {c[1], c[2], c[3], c[4]}
					end
				end

				db.Inherit = false
			end

			-- Update the disabled state.
			db.Disabled = p_db.Disabled
		end

		-- New Group
		if IsNew then
			-- Queue the group if PLAYER_LOGIN hasn't fired and the skin hasn't loaded.
			if Core.Queue and not self.Queued and not Skins[db.SkinID] then
				Core.Queue(self)
			end

			-- Update the options.
			Core:UpdateSkinOptions(self)

		-- Update the skin.
		else
			if db.Disabled then
				for Button in pairs(self.Buttons) do
					SkinButton(Button, self.Buttons[Button], "Classic")
				end
			else
				self:ReSkin()
			end

			-- Update the sub-groups.
			local Subs = self.SubList

			if Subs then
				for _, Sub in pairs(Subs) do
					Sub:Update()
				end
			end
		end
	end

	----------------------------------------
	-- Prototype
	---

	local Proto = {
		-- Button
		AddButton = AddButton,
		RemoveButton = RemoveButton,

		-- Region
		GetColor = GetColor,
		GetLayer = GetLayer,

		-- Group
		ReSkin = ReSkin,
		Delete = Delete,
		SetName = SetName,
		SetCallback = SetCallback,

		-- Options
		Reset = Reset,
		Enable = Enable,
		Disable = Disable,
		SetColor = SetColor,
		SetOption = SetOption,
		GetOptions = GetOptions,

		-- Profile
		Update = Update,
	}

	----------------------------------------
	-- Core
	---

	Core.Group_MT = {__index = Proto}
end
