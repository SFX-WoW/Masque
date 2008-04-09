
local bf = LibStub("AceAddon-3.0"):GetAddon("ButtonFacade")

-- Localization for each module should be in its own separate locale object.
local AceLocale = LibStub("AceLocale-3.0")

local L = AceLocale:NewLocale( "ButtonFacade", "enUS", true )

if L then
	L["Hide Blizzard"] = true
	L["Enable Module"] = true
	L["Hide Blizzard Art Frames"] = true
end

-- Get the proper Locale for the client.
L = AceLocale:GetLocale("ButtonFacade")

local hidebliz = bf:NewModule("HideBlizzard")
local db

local ns_Defaults = {
	global = {
		hide_blizz = false,
	},
}

local module_Options = {
	bliz_art = {
		type = 'group',
		name = L["Hide Blizzard"],
		args = {
			enable_mod = {
				type = 'toggle',
				name = L["Enable Module"],
				get = function() return hidebliz:IsEnabled() end,
				set = function(info,s)
					if s then
						bf:EnableModule("HideBlizzard")
					else
						bf:DisableModule("HideBlizzard")
					end
				end,
				width = "full",
			},
			bliz_toggle = {
				type = 'toggle',
				name = L["Hide Blizzard Art Frames"],
				get = function() return db.profile.hide_bliz end,
				set = function(info,s) hidebliz:SetBlizVisibility(s) end,
				width = "full",
				disabled = function() return not hidebliz:IsEnabled() end,
			},
		},
	},
}

function hidebliz:OnInitialize()
	db = self:RegisterNamespace("HideBlizzard",ns_Defaults)
	self.db = db
	self:RegisterModuleOptions("HideBlizzard",module_Options)
	self:SetEnabledState(db.profile.enabled)
end

function hidebliz:OnEnable()
	if db.profile.hide_blizz then
		hidebliz:SetBlizVisibility(false)
	else
		hidebliz:SetBlizVisibility(true)
	end
	db.profile.enabled = true
end

function hidebliz:OnDisable()
	hidebliz:SetBlizVisibility(true)
	db.profile.enabled = nil
end

function hidebliz:SetBlizVisibility(set)
	db.profile.hide_bliz = set
	if set then
		MainMenuBar:Hide()
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			getglobal("PetActionButton"..i):Hide()
		end
		for i=1, 10, 1 do
			getglobal("ShapeshiftButton"..i):Hide()
		end
	else
		MainMenuBar:Show()
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			getglobal("PetActionButton"..i):Show()
		end
		for i=1, 10, 1 do
			getglobal("ShapeshiftButton"..i):Show()
		end
	end
end
