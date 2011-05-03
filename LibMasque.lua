--[[
	Project.: Masque
	File....: LibMasque.lua
	Version.: @file-revision@
	Author..: StormFX
]]

-- [ Locals ] --

local _, Core = ...
if not Core.Loaded then return end
local error, setmetatable, type = error, setmetatable, type

-- API Table
local API = {}

-- [ LibMasque ] --

LibMasque = {
	Version = 40100,
	GetModule = function(self, Module)
		if type(Module) ~= "string" then
			if Core.db.profile.Debug then error("Bad argument to method 'GetModule'. 'Module' must be a string.", 2) end
			return
		elseif not API[Module] then
			if Core.db.profile.Debug then error(("Invalid API reference. '%s' is not a supported module."):format(Module), 2) end
			return
		end
		return API[Module]
	end,
}
setmetatable(LibMasque, {__call = LibMasque.GetModule})

-- [ Button Module ] --

do
	-- Button Groups (Public)
	local Groups = {}
	local GMT

	-- Creates a set of groups.
	local function NewGroup(Addon, Group)
		local CG = Core.Button:Group(Addon, Group)
		local o = {
			Addon = Addon,
			Group = Group,
			GroupID = CG.GroupID,
		}
		setmetatable(o, GMT)
		Groups[o.GroupID] = o
		return o
	end

	-- Button API
	API.Button = {
		AddSkin = Core.Button.AddSkin,
		GetNormalTexture = Core.Button.GetNormalTexture,
	}
	function API.Button:Group(Addon, Group)
		if type(Addon) ~= "string" or Addon == "Masque" then
			if Core.db.profile.Debug then error("Bad argument to method 'Group'. 'Addon' must be a string.", 2) end
			return
		end
		if type(Group) == "string" then
			if not Groups[Addon] then NewGroup(Addon) end
			local id = Addon.."_"..Group
			return Groups[id] or NewGroup(Addon, Group)
		else
			return Groups[Addon] or NewGroup(Addon)
		end
	end

	-- Empty function.
	local Empty = function() end

	-- Button Group Metatable (Public)
	GMT = {
		__index = {

			-- Adds a button to a button group.
			AddButton = function(self, Button, ButtonData)
				if type(Button) ~= "table" then
					if Core.db.profile.Debug then error("Bad argument to method 'AddButton'. 'Button' must be a button object.", 2) end
					return
				end
				local Group = Core.Button:Group(self.Addon, self.Group)
				Group:AddButton(Button, ButtonData)
			end,

			-- Removes a button from a button group.
			RemoveButton = function(self, Button, noReset)
				if type(Button) ~= "table" then
					if Core.db.profile.Debug then error("Bad argument to method 'RemoveButton'. 'Button' must be a button object.", 2) end
					return
				end
				local Group = Core.Button:Group(self.Addon, self.Group)
				Group:RemoveButton(Button, noReset)
			end,

			-- Deletes a button group.
			Delete = function(self, noReset)
				local Group = Core.Button:Group(self.Addon, self.Group)
				Group:Delete(noReset)
				Groups[self.GroupID] = nil
			end,

			-- Reskins a button group.
			ReSkin = function(self)
				local Group = Core.Button:Group(self.Addon, self.Group)
				Group:ReSkin()
			end,

			-- Deprecated group methods.
			Skin = Empty,
			SetSkin = Empty,
			AddSubGroup = Empty,
			RemoveSubGroup = Empty,
			GetLayerColor = Empty,
			SetLayerColor = Empty,
			ResetColors = Empty,
		},
	}

	-- LBF Support
	local LBF = LibStub:NewLibrary("LibButtonFacade", 40000)

	-- Deprecated methods.
	LBF.RegisterSkinCallback = Empty
	LBF.RegisterGuiCallback = Empty

	-- Methods that shouldn't be used by authors but just in case.
	LBF.ListAddons = Empty
	LBF.ListGroups = Empty
	LBF.ListButtons = Empty
	LBF.GetSkin = Empty
	LBF.GetSkins = Empty
	LBF.ListSkins = Empty
	LBF.GetBackdropLayer = Empty
	LBF.GetGlossLayer = Empty

	-- Add the API to LBF.
	setmetatable(LBF, {__index = API.Button})

	-- Gets the Normal vertex color.
	function LBF:GetNormalVertexColor(Button)
		local Region = self:GetNormalTexture(Button)
		if Region then return Region:GetVertexColor() end
	end

	-- Sets the Normal vertex color.
	function LBF:SetNormalVertexColor(Button, r, g, b, a)
		local Region = self:GetNormalTexture(Button)
		if Region then Region:SetVertexColor(r, g, b, a) end
	end
end
