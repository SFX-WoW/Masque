--[[
	Project.: Masque
	File....: Button/API.lua
	Version.: @file-revision@
	Author..: StormFX, JJSheets
]]

local Masque, Core = ...

-- [ Locals ] --

local error, pairs, setmetatable, type = error, pairs, setmetatable, type

-- [ Utility ] --

-- Returns a GroupID.
local function GroupID(Addon, Group)
	local id = Masque
	if type(Addon) == "string" then
		id = Addon
		if type(Group) == "string" then
			id = id.."_"..Group
		end
	end
	return id
end

-- [ Group API ] --

local Groups = {}
local GMT

-- Creates a group and loads its skin.
local function NewGroup(Addon, Group)
	local id = GroupID(Addon, Group)
	local o = {
		Addon = Addon,
		Group = Group,
		GroupID = id,
		Buttons = {},
		SubList = (not Group and {}) or nil,
		-- Load the skin.
		Disabled = Core.db.profile.Button[id].Disabled,
		SkinID = Core.db.profile.Button[id].SkinID,
		Gloss = Core.db.profile.Button[id].Gloss,
		Backdrop = Core.db.profile.Button[id].Backdrop,
		Colors = Core.db.profile.Button[id].Colors,
	}
	setmetatable(o, GMT)
	Groups[o.GroupID] = o
	if Addon then
		local Parent = Groups[Masque] or NewGroup()
		o.Parent = Parent
		Parent.SubList[Addon] = Addon
		Core.Button:UpdateOptions()
	end
	if Group then
		local Parent = Groups[Addon] or NewGroup(Addon)
		o.Parent = Parent
		Parent.SubList[id] = Group
		Core.Button:UpdateOptions(Addon)
	end
	return o
end

-- Returns a button group object.
function Core.Button:Group(Addon, Group)
	return Groups[GroupID(Addon, Group)] or NewGroup(Addon, Group)
end

-- Returns a list of registered add-ons.
function Core.Button:ListAddons()
	local Group = self:Group()
	return Group.SubList
end

-- Returns a list of button groups registered to an add-on.
function Core.Button:ListGroups(Addon)
	return Groups[Addon].SubList
end

-- [ Group Metatable ] --

do
	-- Reverse Look-up
	local Group = {}

	-- Skin Tables
	local Skins = Core.Button:GetSkins()
	local SkinList = Core.Button:ListSkins()

	-- Button Layers
	local Layers = Core.Button:GetLayers()

	-- Skinning Functions
	local GetColor = Core.Button.GetColor
	local SkinButton = Core.Button.Skin

	-- Empty Function
	local __MTF = function() end

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

	-- Temporary fix for Bartender4 since it edits the group's skin directly.
	local function Refresh(self)
		self.SkinID = Core.db.profile.Button[self.GroupID].SkinID
		self.Gloss = Core.db.profile.Button[self.GroupID].Gloss
		self.Backdrop = Core.db.profile.Button[self.GroupID].Backdrop
		self.Colors = Core.db.profile.Button[self.GroupID].Colors
		self.BT4Fix = true
	end

	GMT = {
		__index = {

			-- [ Public Methods ] --

			-- These methods are available for the 'Group' API and function as they previously did.

			-- Adds or reassigns a button to the group.
			AddButton = function(self, Button, ButtonData)
				if type(Button) ~= "table" then
					if Core.db.profile.Debug then
						error("Bad argument to method 'AddButton'. 'Button' must be a button object.", 2)
					end
					return
				end
				if Group[Button] == self then
					return
				end
				if Group[Button] then
					Group[Button]:RemoveButton(Button, true)
				end
				Group[Button] = self
				ButtonData = ButtonData or {}
				for Layer, Type in pairs(Layers) do
					if ButtonData[Layer] == nil and Type ~= "Custom" then
						ButtonData[Layer] = GetRegion(Button, Layer, Type)
					end
				end
				self.Buttons[Button] = ButtonData
				-- BT4 Fix
				if self.Addon == "Bartender4" and not self.BT4Fix then
					Refresh(self)
				end
				if not self.Disabled then
					SkinButton(Button, ButtonData, self.SkinID, self.Gloss, self.Backdrop, self.Colors)
				end
			end,

			-- Removes a button from the group and optionally applies the default skin.
			RemoveButton = function(self, Button, noReset)
				if type(Button) ~= "table" then
					if Core.db.profile.Debug then error("Bad argument to method 'RemoveButton'. 'Button' must be a button object.", 2) end
					return
				end
				local ButtonData = self.Buttons[Button]
				Group[Button] = nil
				if ButtonData and not noReset then
					SkinButton(Button, ButtonData, "Blizzard", false, false)
				end
				self.Buttons[Button] = nil
			end,

			-- Deletes the current group.
			Delete = function(self, noReset)
				local Subs = self.SubList
				if Subs then
					for Sub in pairs(Subs) do
						Groups[Sub]:Delete()
					end
				end
				for Button in pairs(self.Buttons) do
					Group[Button] = nil
					if not noReset then
						SkinButton(Button, self.Buttons[Button], "Blizzard", false, false)
					end
					self.Buttons[Button] = nil
				end
				if self.Parent then
					self.Parent.SubList[self.GroupID] = nil
				end
				Core.Button:UpdateOptions(self.Addon)
				Groups[self.GroupID] = nil
			end,

			-- Reskins the group with its current settings.
			ReSkin = function(self)
				self:__Skin(self.SkinID, self.Gloss, self.Backdrop, self.Colors, true)
			end,

			-- Gets a layer's color.
			GetLayer = function(self, Button, Layer)
				local ButtonData = self.Buttons[Button]
				if ButtonData then
					return ButtonData[Layer]
				end
			end,

			-- Gets a layer's color.
			GetLayerColor = function(self, Layer)
				local Skin = Skins[self.SkinID or "Blizzard"] or Skins["Blizzard"]
				return GetColor(self.Colors[Layer] or Skin[Layer].Color)
			end,

			-- [ Private Methods ] --

			-- These methods are for internal use only and may be modified or removed without notice.

			-- Disables the group.
			__Disable = function(self)
				self.Disabled = true
				Core.db.profile.Button[self.GroupID].Disabled = true
				for Button in pairs(self.Buttons) do
					SkinButton(Button, self.Buttons[Button], "Blizzard", false, false)
				end
				local Subs = self.SubList
				if Subs then
					for Sub in pairs(Subs) do
						Groups[Sub]:__Disable()
					end
				end
			end,

			-- Enables the group.
			__Enable = function(self)
				self.Disabled = false
				Core.db.profile.Button[self.GroupID].Disabled = false
				self:ReSkin()
				local Subs = self.SubList
				if Subs then
					for Sub in pairs(Subs) do
						Groups[Sub]:__Enable()
					end
				end
			end,

			-- Updates the groups's skin with the new data then applies and saves it.
			__Skin = function(self, SkinID, Gloss, Backdrop, Colors, noSubs)
				self.SkinID = (SkinID and SkinList[SkinID]) or self.SkinID
				if type(Gloss) ~= "number" then
					Gloss = (Gloss and 1) or 0
				end
				self.Gloss = Gloss
				self.Backdrop = (Backdrop and true) or false
				if type(Colors) == "table" then
					self.Colors = Colors
				end
				if not self.Disabled then
					for Button in pairs(self.Buttons) do
						SkinButton(Button, self.Buttons[Button], self.SkinID, self.Gloss, self.Backdrop, self.Colors)
					end
				end
				local Subs = self.SubList
				if Subs and not noSubs then
					for Sub in pairs(Subs) do
						Groups[Sub]:__Skin(SkinID, Gloss, Backdrop, Colors)
					end
				end
				-- Save the skin.
				Core.db.profile.Button[self.GroupID].SkinID = self.SkinID
				Core.db.profile.Button[self.GroupID].Gloss = self.Gloss
				Core.db.profile.Button[self.GroupID].Backdrop = self.Backdrop
				Core.db.profile.Button[self.GroupID].Colors = self.Colors
			end,

			-- Sets a layer's color and optionally reskins the group.
			__SetLayerColor = function(self, Layer, r, g, b, a, noReset)
				if r then
					self.Colors[Layer] = {r, g, b, a}
				else
					self.Colors[Layer] = nil
				end
				if not noReset then
					self:__Skin(self.SkinID, self.Gloss, self.Backdrop, self.Colors)
				end
			end,

			-- Resets the group's layer colors.
			__ResetColors = function(self, noReset)
				for Layer in pairs(self.Colors) do
					self.Colors[Layer] = nil
				end
				local Subs = self.SubList
				if Subs then
					for Sub in pairs(Subs) do
						Groups[Sub]:__ResetColors(true)
					end
				end
				if not noReset then self:__Skin() end
			end,

			-- [ Temporary Methods ] --

			-- These methods are deprecated and will be removed.

			-- Imports settings from an add-on still using the LBF API.
			Skin = function(self, SkinID, Gloss, Backdrop, Colors, noSubs)
				if Core.db.profile.Button[self.GroupID].Import then
					self:__Skin(SkinID, Gloss, Backdrop, Colors, noSubs)
					Core.db.profile.Button[self.GroupID].Import = false
				end
			end,

			-- Deperecated
			AddSubGroup = __MTF,
			RemoveSubGroup = __MTF,
			SetSkin = __MTF,
		}
	}
end