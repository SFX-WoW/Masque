--[[
	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: ButtonFacade\ButtonFacade.lua
	* Revision.: @file-revision@
	* Author...: StormFX

	ButtonFacade Support

	[ Notes ]

	This file will create a 'ButtonFacade' add-on  object to ensure compability for older add-ons and skins.
	The directory that this file is located in MUST be installed as a separate add-on in order for it to work correctly.
]]

local LibStub = assert(LibStub, "Masque requires LibStub.")
local MSQ = LibStub("Masque", true)

if not MSQ then return end

_G.ButtonFacade = LibStub("AceAddon-3.0"):NewAddon("ButtonFacade")
local LBF = LibStub:NewLibrary("LibButtonFacade", 40200)

function LBF:GetNormalVertexColor(Button)
	local Region = self:GetNormalTexture(Button)
	if Region then
		return Region:GetVertexColor()
	end
end

function LBF:SetNormalVertexColor(Button, r, g, b, a)
	local Region = self:GetNormalTexture(Button)
	if Region then
		Region:SetVertexColor(r, g, b, a)
	end
end

function LBF:GetNormalTexture(Button)
	return self:GetNormal(Button)
end

function LBF:GetGlossLayer(Button)
	return self:GetNormal(Button)
end

function LBF:GetBackdropLayer(Button)
	return self:GetNormal(Button)
end


local __MTT = {}
local __MTF = function() end

-- Bug fix for SBF.
function LBF:GetSkins()
	return __MTT
end

-- Deprecated
LBF.RegisterSkinCallback = __MTF
LBF.RegisterGuiCallback = __MTF
LBF.ListAddons = __MTF
LBF.ListGroups = __MTF
LBF.ListButtons = __MTF
LBF.GetSkin = __MTF
LBF.ListSkins = __MTF

setmetatable(LBF, {__index = MSQ})
