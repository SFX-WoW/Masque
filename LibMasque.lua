--[[
	Project.: Masque
	File....: LibMasque.lua
	Version.: @file-revision@
	Author..: StormFX
]]

local Masque, Core = ...

-- [ Locals ] --

local error, setmetatable, type = error, setmetatable, type

-- API Table
local API = {

	-- [ Button Module ] --

	Button = {
		AddSkin = Core.Button.AddSkin,
		GetBackdropLayer = Core.Button.GetBackdrop,
		GetNormalTexture = Core.Button.GetNormalTexture,
		GetGlossLayer = Core.Button.GetGloss,

		-- Custom 'Group' method so that we can validate the add-on name.
		Group = function(self, Addon, Group)
			if type(Addon) ~= "string" or Addon == Masque then
				if Core.db.profile.Debug then
					error("Bad argument to method 'Group'. 'Addon' must be a string.", 2)
				end
				return
			end
			return Core.Button:Group(Addon, Group)
		end,
	},
}

-- [ LBF Support ] --

local LBF = LibStub:NewLibrary("LibButtonFacade", 40100)

-- Temporary: Gets the Normal vertex color.
function LBF:GetNormalVertexColor(Button)
	local Region = self:GetNormalTexture(Button)
	if Region then
		return Region:GetVertexColor()
	end
end

-- Temporary: Sets the Normal vertex color.
function LBF:SetNormalVertexColor(Button, r, g, b, a)
	local Region = self:GetNormalTexture(Button)
	if Region then
		Region:SetVertexColor(r, g, b, a)
	end
end

-- Temporary: Bug fix for SBF.
function LBF:GetSkins()
	return Core.Button:GetSkins()
end

-- Empty Function
local __MTF = function() end

-- Deprecated methods.
LBF.RegisterSkinCallback = __MTF
LBF.RegisterGuiCallback = __MTF
LBF.ListAddons = __MTF
LBF.ListGroups = __MTF
LBF.ListButtons = __MTF
LBF.GetSkin = __MTF
LBF.ListSkins = __MTF

-- Add the API to LBF.
setmetatable(LBF, {__index = API.Button})

-- [ LibMasque ] --

LibMasque = {
	Version = 40100,
	GetModule = function(self, Module)
		if type(Module) ~= "string" then
			if Core.db.profile.Debug then
				error("Bad argument to method 'GetModule'. 'Module' must be a string.", 2)
			end
			return
		elseif not API[Module] then
			if Core.db.profile.Debug then
				error(("Invalid API reference. '%s' is not a supported module."):format(Module), 2)
			end
			return
		end
		return API[Module]
	end,
}
setmetatable(LibMasque, {__call = LibMasque.GetModule})
