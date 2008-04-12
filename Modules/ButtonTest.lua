
local bf = LibStub("AceAddon-3.0"):GetAddon("ButtonFacade")
local lbf = LibStub("LibButtonFacade")

-- Localization for each module should be in its own separate locale object.
local AceLocale = LibStub("AceLocale-3.0")

local L = AceLocale:NewLocale( "ButtonFacade", "enUS", true )

if L then
	L["Button Test"] = true
	L["Enable Module"] = true
	L["Displays a set of buttons that can be used to verify the functionality of a skin.  In order from left to right, the buttons inherit from the following templates: ActionBarButtonTemplate, BonusActionButtonTemplate, ShapeshiftButtonTemplate, ItemButtonTemplate, PetActionButtonTemplate."] = true
end

-- Get the proper Locale for the client.
L = AceLocale:GetLocale("ButtonFacade")

local btntest = bf:NewModule("ButtonTest")
local db

local ns_Defaults = {
	global = {
	},
}

local module_Options = {
	bliz_art = {
		type = 'group',
		name = L["Button Test"],
		args = {
			enable_mod = {
				type = 'toggle',
				name = L["Enable Module"],
				get = function() return btntest:IsEnabled() end,
				set = function(info,s)
					if s then
						bf:EnableModule("ButtonTest")
					else
						bf:DisableModule("ButtonTest")
					end
				end,
				width = "full",
			},
			info = {
				type = 'description',
				name = L["Displays a set of buttons that can be used to verify the functionality of a skin.  In order from left to right, the buttons inherit from the following templates: ActionBarButtonTemplate, BonusActionButtonTemplate, ShapeshiftButtonTemplate, ItemButtonTemplate, PetActionButtonTemplate."]
			},
		},
	},
}

function btntest:OnInitialize()
	db = self:RegisterNamespace("ButtonTest",ns_Defaults)
	self.db = db
	self:RegisterModuleOptions("ButtonTest",module_Options)
	self:SetEnabledState(db.profile.enabled)
end

local buttons = {}

function btntest:OnEnable()
	local group = lbf:Group("ButtonTest")
	if #buttons == 0 then
		local btn
		btn = CreateFrame("CheckButton","BF_ButtonTest1",UIParent,"ActionBarButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",UIParent,"TOPLEFT",100,-200)
		buttons[1] = btn
		btn = CreateFrame("CheckButton","BF_ButtonTest2",UIParent,"BonusActionButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",buttons[1],"TOPRIGHT",4,0)
		buttons[2] = btn
		btn = CreateFrame("CheckButton","BF_ButtonTest3",UIParent,"ShapeshiftButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",buttons[2],"TOPRIGHT",4,0)
		buttons[3] = btn
		btn = CreateFrame("CheckButton","BF_ButtonTest4",UIParent,"ItemButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",buttons[3],"TOPRIGHT",4,0)
		buttons[4] = btn
		btn = CreateFrame("CheckButton","BF_ButtonTest5",UIParent,"PetActionButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",buttons[4],"TOPRIGHT",4,0)
		buttons[5] = btn
	end
	for i = 1, #buttons do
		group:AddButton(buttons[i])
		buttons[i]:Show()
	end
	db.profile.enabled = true
end

function btntest:OnDisable()
	local group = lbf:Group("ButtonTest")
	-- hide all buttons, after removing the group from lbf
	for i = 1, #buttons do
		group:RemoveButton(buttons[i])
		buttons[i]:Hide()
	end
	buttons[1]:ClearAllPoints()
	buttons[1]:SetPoint("TOPLEFT",UIParent,"BOTTOMRIGHT",100)
	group:Delete()
	db.profile.enabled = nil
end
