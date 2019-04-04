--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Group.lua
	* Author.: StormFX, JJSheets

	Group API

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

-- @ Skins\Regions
local RegList = Core.RegList

-- @ Core\Utility
local _GetColor = Core.GetColor

-- @ Core\Core
local GetType, GetRegion = Core.GetType, Core.GetRegion

-- @ Core\Button
local SkinButton = Core.SkinButton

-- @ Core\Callback
local Callback = Core.Callback

local Group = {}

----------------------------------------
-- Private Functions
---

-- Fires the callback for the add-on or group.
local function FireCB(self)
	local db = self.db

	if self.Callback then
		Callback(self.ID, self.Group, db.SkinID, db.Backdrop, db.Shadow, db.Gloss, db.Colors, db.Disabled)

	elseif self.Addon then
		Callback(self.Addon, self.Group, db.SkinID, db.Backdrop, db.Shadow, db.Gloss, db.Colors, db.Disabled)
	end
end

----------------------------------------
-- AddButton
---

-- Adds or reassigns a button to the group.
local function AddButton(self, Button, Regions, Type, Strict)
	local oType = Button.__MSQ_oType or GetType(Button, true)

	if not oType then
		if Core.Debug then
			error("Bad argument to group method 'AddButton'. 'Button' must be a button object.", 2)
		end
		return

	elseif oType == "Frame" then
		Strict = true
	end

	if not Type or not RegList[Type] then
		Type = Button.__MSQ_bType or GetType(Button)
	end

	Button.__MSQ_bType = Type

	local Parent = Group[Button]

	if Parent then
		if Parent == self then
			return
		else
			Regions = Regions or Parent.Buttons[Button]
			Parent.Buttons[Button] = nil
		end
	end

	Group[Button] = self

	if type(Regions) ~= "table" then
		Regions = {}
	end

	local Layers = RegList[Type]

	for Layer, Info in pairs(Layers) do
		local Region = Regions[Layer]

		if not Strict and Region == nil then
			if Layer == "AutoCastShine" then
				Region = Regions.Shine or Regions.AutoCast or GetRegion(Button, Info)

			elseif Layer == "Backdrop" then
				Region = Regions.FloatingBG or GetRegion(Button, Info)

			else
				Region = GetRegion(Button, Info)
			end

			Regions[Layer] = Region
		end
	end

	self.Buttons[Button] = Regions

	local db = self.db

	if not db.Disabled and not self.Queued then
		SkinButton(Button, Regions, db.SkinID, db.Backdrop, db.Shadow, db.Gloss, db.Colors)
	end
end

----------------------------------------
-- RemoveButton
---

-- Removes a button from the group and applies the default skin.
local function RemoveButton(self, Button)
	if Button then
		local Regions = self.Buttons[Button]

		if Regions then
			SkinButton(Button, Regions, "Classic")
		end

		Group[Button] = nil
		self.Buttons[Button] = nil
	end
end

----------------------------------------
-- GetColor
---

-- Returns a layer's current color.
local function GetColor(self, Layer)
	if Layer then
		local Skin = Skins[self.db.SkinID] or Skins.Classic
		return _GetColor(self.db.Colors[Layer] or Skin[Layer].Color)
	end
end

----------------------------------------
-- GetLayer
---

-- Returns a button layer.
local function GetLayer(self, Button, Layer)
	if Button and Layer then
		local Regions = self.Buttons[Button]

		if Regions then
			return Regions[Layer]
		end
	end
end

----------------------------------------
-- ReSkin
---

-- Reskins the group with its current settings.
local function ReSkin(self, Silent)
	local db = self.db

	if not db.Disabled then
		for Button in pairs(self.Buttons) do
			SkinButton(Button, self.Buttons[Button], db.SkinID, db.Backdrop, db.Shadow, db.Gloss, db.Colors)
		end

		if not Silent then
			FireCB(self)
		end
	end
end

----------------------------------------
-- Delete
---

-- Deletes the group and applies the default skin to its buttons.
local function Delete(self)
	local Subs = self.SubList

	if Subs then
		for _, Sub in pairs(Subs) do
			Sub:Delete()
		end
	end

	local Buttons = self.Buttons

	for Button in pairs(Buttons) do
		SkinButton(Button, Buttons[Button], "Classic")

		Group[Button] = nil
		Buttons[Button] = nil
	end

	local Parent = self.Parent

	if Parent then
		Parent.SubList[self.ID] = nil
	end

	Core:UpdateSkinOptions(self, true)
	Core.Groups[self.ID] = nil
end

----------------------------------------
-- SetName
---

-- Renames the group.
local function SetName(self, Name)
	if not self.StaticID then
		return

	elseif type(Name) ~= "string" then
		if Core.Debug then
			error("Bad argument to group method 'SetName'. 'Name' must be a string.", 2)
		end
		return
	end

	self.Group = Name
	Core:UpdateSkinOptions(self)
end

----------------------------------------
-- SetCallback
---

-- Registers a group-specific callback.
local function SetCallback(self, func, arg)
	if self.ID == MASQUE then return end

	if type(func) ~= "function" then
		if Core.Debug then
			error("Bad argument to Group method 'SetCallback'. 'func' must be a function.", 2)
		end
		return

	elseif arg and type(arg) ~= "table" then
		if Core.Debug then
			error("Bad argument to Group method 'SetCallback'. 'arg' must be a table or nil.", 2)
		end
		return
	end

	Callback:Register(self.ID, func, arg or false)
	self.Callback = true
end

----------------------------------------
-- GetOptions
---

-- Creates and returns an AceConfig-3.0 options table for the group.
local function GetOptions(self, Order)
	return Core.GetOptions(self, Order)
end

----------------------------------------
-- Enable
-- * This methods is intended for internal use only.
---

-- Enables the group.
local function Enable(self)
	self.db.Disabled = false
	self:ReSkin()

	local Subs = self.SubList

	if Subs then
		for _, Sub in pairs(Subs) do
			Sub:Enable()
		end
	end
end

----------------------------------------
-- Disable
-- * This methods is intended for internal use only.
---

-- Disables the group.
local function Disable(self, Silent)
	self.db.Disabled = true

	for Button in pairs(self.Buttons) do
		SkinButton(Button, self.Buttons[Button], "Classic")
	end

	if not Silent then
		FireCB(self)
	end

	local Subs = self.SubList

	if Subs then
		for _, Sub in pairs(Subs) do
			Sub:Disable(Silent)
		end
	end
end

----------------------------------------
-- SetColor
-- * This methods is intended for internal use only.
---

-- Sets the specified layer color.
local function SetColor(self, Layer, r, g, b, a)
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
end

----------------------------------------
-- __Set
-- * This methods is intended for internal use only.
---

-- Validates and sets a skin option.
local function __Set(self, Option, Value)
	if not Option then return end

	local db = self.db

	if Option == "SkinID" then
		if Value and Skins[Value] then
			db.SkinID = Value
		end

	elseif db[Option] ~= nil then
		Value = (Value and true) or false
		db[Option] = Value

	else
		return
	end

	self:ReSkin()

	local Subs = self.SubList

	if Subs then
		for _, Sub in pairs(Subs) do
			Sub:__Set(Option, Value)
		end
	end
end

----------------------------------------
-- __Reset
-- * This methods is intended for internal use only.
---

-- Resets the group's skin settings.
local function __Reset(self)
	self.db.Backdrop = false
	self.db.Shadow = false
	self.db.Gloss = false

	for Layer in pairs(self.db.Colors) do
		self.db.Colors[Layer] = nil
	end

	self:ReSkin()

	local Subs = self.SubList

	if Subs then
		for _, Sub in pairs(Subs) do
			Sub:__Reset()
		end
	end
end

----------------------------------------
-- __Update
-- * This methods is intended for internal use only.
---

-- Updates the group on creation or profile activity.
local function __Update(self, IsNew)
	local db = Core.db.profile.Groups[self.ID]

	if db == self.db then return end

	-- Update the DB the first time a StaticID is used.
	if self.StaticID and not db.Upgraded then
		local o_id = Core.GetID(self.Addon, self.Group)
		local o_db = Core.db.profile.Groups[o_id]

		if not o_db.Inherit then
			Core.db.profile.Groups[self.ID] = o_db
			db = Core.db.profile.Groups[self.ID]
		end

		Core.db.profile.Groups[o_id] = nil
		db.Upgraded = true
	end

	self.db = db

	-- Inheritance
	if self.Parent then
		local p_db = self.Parent.db

		if db.Inherit then
			db.SkinID = p_db.SkinID
			db.Backdrop = p_db.Backdrop
			db.Shadow = p_db.Shadow
			db.Gloss = p_db.Gloss

			for Layer in pairs(db.Colors) do
				db.Colors[Layer] = nil
			end

			for Layer in pairs(p_db.Colors) do
				local c = p_db.Colors[Layer]

				if type(c) == "table" then
					db.Colors[Layer] = {c[1], c[2], c[3], c[4]}
				end
			end

			db.Inherit = false
		end

		if p_db.Disabled then
			db.Disabled = true
		end
	end

	if IsNew then
		-- Queue the group if PLAYER_LOGIN hasn't fired and the skin hasn't loaded.
		if Core.Queue and not self.Queued and not Skins[db.SkinID] then
			Core.Queue(self)
		end

		Core:UpdateSkinOptions(self)

	else
		if db.Disabled then
			for Button in pairs(self.Buttons) do
				SkinButton(Button, self.Buttons[Button], "Classic")
			end
		else
			self:ReSkin()
		end

		local Subs = self.SubList

		if Subs then
			for _, Sub in pairs(Subs) do
				Sub:__Update()
			end
		end
	end
end

----------------------------------------
-- Group Metatable
---

Core.Group_MT = {__index = {
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
	GetOptions = GetOptions,

	-- Internal
	Enable = Enable,
	Disable = Disable,
	SetColor = SetColor,

	__Set = __Set,
	__Reset = __Reset,
	__Update = __Update,
}}
