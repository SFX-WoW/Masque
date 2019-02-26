--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Groups.lua
	* Author.: StormFX, JJSheets

	Group API

]]

-- GLOBALS:

local MASQUE, Core = ...

----------------------------------------
-- Lua
---

local error, pairs, setmetatable, type = error, pairs, setmetatable, type

----------------------------------------
-- Locals
---

local C_API = Core.API
local Skins = Core.Skins
local GetColor, SkinButton = Core.GetColor, Core.SkinButton

----------------------------------------
-- Callback
---

local Callback

do
	local Cache = {}

	Callback = {

		-- Notifies an add-on of skin changes.
		Fire = function(self, Addon, Group, SkinID, Gloss, Backdrop, Colors, Disabled)
			local args = Cache[Addon]
			if args then
				for arg, func in pairs(args) do
					if arg then
						func(arg, Group, Skin, SkinID, Backdrop, Colors, Disabled)
					else
						func(Group, Skin, SkinID, Backdrop, Colors, Disabled)
					end
				end
			end
		end,

		-- Registers an add-on to be notified of skin changes.
		Register = function(self, Addon, func, arg)
			Cache[Addon] = Cache[Addon] or {}
			Cache[Addon][arg] = func
		end,
	}

	setmetatable(Callback, {__call = Callback.Fire})

	----------------------------------------
	-- API
	---

	-- Wrapper for the 'Register' method.
	function C_API:Register(Addon, func, arg)
		-- Validation
		if type(Addon) ~= "string" then
			if Core.db.profile.Debug then
				error("Bad argument to API method 'Register'. 'Addon' must be a string.", 2)
			end
			return
		elseif type(func) ~= "function" then
			if Core.db.profile.Debug then
				error("Bad argument to API method 'Register'. 'func' must be a function.", 2)
			end
			return
		elseif arg and type(arg) ~= "table" then
			if Core.db.profile.Debug then
				error("Bad argument to API method 'Register'. 'arg' must be a table or nil.", 2)
			end
			return
		end

		Callback:Register(Addon, func, arg or false)
	end
end

----------------------------------------
-- Queue
---

do
	-- Self-destructing table to skin groups created prior to PLAYER_LOGIN.
	Core.Queue = {
		-- Storage
		Cache = {},

		-- Adds a group to the queue.
		Add = function(self, obj)
			self.Cache[#self.Cache+1] = obj
			obj.Queued = true
		end,

		-- Re-Skins all queued groups.
		ReSkin = function(self)
			for i = 1, #self.Cache do
				local obj = self.Cache[i]
				obj:ReSkin(true)
				obj.Queued = nil
			end

			-- GC
			self.Cache = nil
			Core.Queue = nil
		end,
	}

	setmetatable(Core.Queue, {__call = Core.Queue.Add})
end

----------------------------------------
-- Groups
---

local Groups = {}
local GMT

-- Returns a group's ID.
local function GetID(Addon, Group)
	local ID = MASQUE
	if type(Addon) == "string" then
		ID = Addon
		if type(Group) == "string" then
			ID = ID.."_"..Group
		end
	end
	return ID
end

-- Creates a new group.
local function NewGroup(Addon, Group, IsActionBar)
	local ID = GetID(Addon, Group)
	local obj = {
		Addon = Addon,
		Group = Group,
		ID = ID,
		Buttons = {},
		SubList = (not Group and {}) or nil,
		IsActionBar = IsActionBar,
	}

	setmetatable(obj, GMT)
	Groups[ID] = obj

	local Parent
	if Group then
		Parent = Groups[Addon] or NewGroup(Addon)
		Core:UpdateOptions(Addon)
	elseif Addon then
		Parent = Groups[MASQUE] or NewGroup()
		Core:UpdateOptions()
	end

	if Parent then
		Parent.SubList[ID] = obj
		obj.Parent = Parent
	end

	obj:Update(true)
	return obj
end

-- Returns a button group.
function Core:Group(Addon, Group, IsActionBar)
	return Groups[GetID(Addon, Group)] or NewGroup(Addon, Group, IsActionBar)
end

-- Returns a list of registered add-ons.
function Core:ListAddons()
	local Group = self:Group()
	return Group.SubList
end

-- Returns a list of button groups registered to an add-on.
function Core:ListGroups(Addon)
	return Groups[Addon].SubList
end

-- API: Validates and returns a button group.
function Core.API:Group(Addon, Group, IsActionBar)
	if type(Addon) ~= "string" or Addon == MASQUE then
		if Core.db.profile.Debug then
			error("Bad argument to method API 'Group'. 'Addon' must be a string.", 2)
		end
		return
	end
	return Core:Group(Addon, Group, IsActionBar)
end

---------------------------------------------
-- Group Metatable
---

do
	local Group = {}
	local Layers = {
		FloatingBG = "Texture",
		Icon = "Texture",
		Cooldown = "Frame",
		Flash = "Texture",
		Pushed = "Special",
		Disabled = "Special",
		Checked = "Special",
		Border = "Texture",
		AutoCastable = "Texture",
		Highlight = "Special",
		Name = "Text",
		Count = "Text",
		HotKey = "Text",
		Duration = "Text",
		Shine = "Frame",
	}

	-- Gets a button region.
	local function GetRegion(Button, Layer, Type)
		local Region
		if Type == "Special" then
			local f = Button["Get"..Layer.."Texture"]
			Region = (f and f(Button)) or false
		else
			local n = Button:GetName()
			Region = (n and _G[n..Layer]) or false
		end
		return Region
	end

	GMT = {
		__index = {

			-- Adds or reassigns a button to the group.
			AddButton = function(self, Button, ButtonData)
				if type(Button) ~= "table" then
					if Core.db.profile.Debug then
						error("Bad argument to group method 'AddButton'. 'Button' must be a button object.", 2)
					end
					return
				end
				local Parent = Group[Button]
				if Parent then
					if Parent == self then
						return
					else
						ButtonData = ButtonData or Parent.Buttons[Button]
						Parent.Buttons[Button] = nil
					end
				end
				Group[Button] = self
				if type(ButtonData) ~= "table" then
					ButtonData = {}
				end
				for Layer, Type in pairs(Layers) do
					if ButtonData[Layer] == nil then
						if Layer == "Shine" then
							ButtonData[Layer] = ButtonData.AutoCast or GetRegion(Button, Layer, Type)
						else
							ButtonData[Layer] = GetRegion(Button, Layer, Type)
						end
					end
				end
				self.Buttons[Button] = ButtonData

				local db = self.db
				if not db.Disabled and not self.Queued then
					SkinButton(Button, ButtonData, db.SkinID, db.Gloss, db.Backdrop, db.Colors, self.IsActionBar)
				end
			end,

			-- Removes a button from the group and applies the default skin.
			RemoveButton = function(self, Button)
				if Button then
					local ButtonData = self.Buttons[Button]
					Group[Button] = nil
					if ButtonData then
						SkinButton(Button, ButtonData, "Classic")
					end
					self.Buttons[Button] = nil
				end
			end,

			-- Deletes the group and applies the default skin to its buttons.
			Delete = function(self)
				local Subs = self.SubList
				if Subs then
					for _, Sub in pairs(Subs) do
						Sub:Delete()
					end
				end

				local Buttons = self.Buttons
				for Button in pairs(Buttons) do
					Group[Button] = nil
					SkinButton(Button, Buttons[Button], "Classic")
					Buttons[Button] = nil
				end

				local Parent = self.Parent
				if Parent then
					Parent.SubList[self.ID] = nil
				end
				Core:UpdateOptions(self.Addon, self.Group, true)
				Groups[self.ID] = nil
			end,

			-- Reskins the group with its current settings.
			ReSkin = function(self, Silent)
				if not self.db.Disabled then
					local db = self.db
					for Button in pairs(self.Buttons) do
						SkinButton(Button, self.Buttons[Button], db.SkinID, db.Gloss, db.Backdrop, db.Colors, self.IsActionBar)
					end
					if self.Addon and not Silent then
						Callback(self.Addon, self.Group, db.SkinID, db.Gloss, db.Backdrop, db.Colors)
					end
				end
			end,

			-- Returns a button layer.
			GetLayer = function(self, Button, Layer)
				if Button and Layer then
					local ButtonData = self.Buttons[Button]
					if ButtonData then
						return ButtonData[Layer]
					end
				end
			end,

			-- Returns a layer color.
			GetColor = function(self, Layer)
				local Skin = Skins[self.db.SkinID] or Skins["Classic"]
				return GetColor(self.db.Colors[Layer] or Skin[Layer].Color)
			end,

			----------------------------------------
			-- Internal Methods
			---

			-- Disables the group.
			Disable = function(self)
				self.db.Disabled = true
				for Button in pairs(self.Buttons) do
					SkinButton(Button, self.Buttons[Button], "Classic")
				end
				local db = self.db
				Callback(self.Addon, self.Group, db.SkinID, db.Gloss, db.Backdrop, db.Colors, true)
				local Subs = self.SubList
				if Subs then
					for _, Sub in pairs(Subs) do
						Sub:Disable()
					end
				end
			end,

			-- Enables the group.
			Enable = function(self)
				self.db.Disabled = false
				self:ReSkin()

				local Subs = self.SubList
				if Subs then
					for _, Sub in pairs(Subs) do
						Sub:Enable()
					end
				end
			end,

			-- Validates and sets a skin option.
			SetOption = function(self, Option, Value)
				if Option == "SkinID" then
					if Value and Skins[Value] then
						self.db.SkinID = Value
					end
				elseif Option == "Gloss" then
					if type(Value) ~= "number" then
						Value = (Value and 1) or 0
					end
					self.db.Gloss = Value
				elseif Option == "Backdrop" then
					self.db.Backdrop = (Value and true) or false
				else
					return
				end
				self:ReSkin()
				local Subs = self.SubList
				if Subs then
					for _, Sub in pairs(Subs) do
						Sub:SetOption(Option, Value)
					end
				end
			end,

			-- Sets the specified layer color.
			SetColor = function(self, Layer, r, g, b, a)
				if not Layer then return end
				if r then
					self.db.Colors[Layer] = {r, g, b, a}
				else
					self.db.Colors[Layer] = nil
				end
				self:ReSkin()
				local Subs = self.SubList
				if Subs then
					for _, Sub in pairs(Subs) do
						Sub:SetColor(Layer, r, g, b, a)
					end
				end
			end,

			-- Resets the group's skin back to its defaults.
			Reset = function(self)
				self.db.Gloss = 0
				self.db.Backdrop = false
				for Layer in pairs(self.db.Colors) do
					self.db.Colors[Layer] = nil
				end
				self:ReSkin()
				local Subs = self.SubList
				if Subs then
					for _, Sub in pairs(Subs) do
						Sub:Reset()
					end
				end
			end,

			-- Updates the group on profile activity.
			Update = function(self, IsNew)
				local db = Core.db.profile.Groups[self.ID]

				-- Only update on profile change or group creation.
				if db == self.db then return end
				self.db = db

				-- Inheritance
				if self.Parent then
					local p_db = self.Parent.db

					-- Inherit the parent's settings on a new db.
					if db.Inherit then
						db.SkinID = p_db.SkinID
						db.Gloss = p_db.Gloss
						db.Backdrop = p_db.Backdrop

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
					if p_db.Disabled then
						db.Disabled = true
					end
				end

				-- New Group
				if IsNew then
					-- Queue the group if PLAYER_LOGIN hasn't fired and the skin hasn't loaded.
					if Core.Queue and not self.Queued and not Skins[db.SkinID] then
						Core.Queue(self)
					end

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
			end,

			-- Returns an Ace3 options table for the group.
			GetOptions = function(self)
				return Core:GetOptions(self.Addon, self.Group)
			end,
		}
	}
end
