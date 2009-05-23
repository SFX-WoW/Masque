--[[
	Project.: ButtonFacade
	File....: Modules/ButtonTest.lua
	Version.: @file-revision@
	Author..: JJ Sheets, StormFX
]]

-- Dependencies
local BF = LibStub("AceAddon-3.0"):GetAddon("ButtonFacade")
local LBF = LibStub("LibButtonFacade")
if not LBF then return end

-- [ Localization ] --

-- Hard-code enUS/enGB.
local L = {
	["Button Test"] = "Button Test",
	["BTEST_Desc"] = "Displays a set of buttons that can be used to verify the functionality of a skin.",
	["Enable Module"] = "Enable Module",
	["Enable this module."]	= "Enable this module.",
	["Enable Drag"] = "Enable Drag",
	["Enable dragging of the buttons."] = "Enable dragging of the buttons.",
	["Button Information"] = "Button Information",
	["BTEST_Info1"] = "In order from left to right, the buttons inherit from the following templates:",
	["BTEST_Info2"] = "* ActionBarButtonTemplate\n* BonusActionButtonTemplate\n* ShapeshiftButtonTemplate\n* ItemButtonTemplate\n* PetActionButtonTemplate\n* SecureActionButtonTemplate",
}
-- Automatically inject all other locales. Please use the localization application on WoWAce.com to update these.
-- http://www.wowace.com/projects/buttonfacade/localization/namespaces/buttontest/
do
	local LOC = GetLocale()
	if LOC == "deDE" then
--@localization(locale="deDE", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="ButtonTest")@
	elseif LOC == "esES" or LOC == "esMX" then
-- Use esES until we have a solid esMX localization.
--@localization(locale="esES", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="ButtonTest")@
	elseif LOC == "frFR" then
--@localization(locale="frFR", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="ButtonTest")@
	elseif LOC == "koKR" then
--@localization(locale="koKR", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="ButtonTest")@
	elseif LOC == "ruRU" then
--@localization(locale="ruRU", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="ButtonTest")@
	elseif LOC == "zhCN" then
--@localization(locale="zhCN", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="ButtonTest")@
	elseif LOC == "zhTW" then
--@localization(locale="zhTW", format="lua_additive_table", table-name="L", handle-unlocalized="comment", namespace="ButtonTest")@
	end
end

-- [ Set Up ] --

-- Create the module.
local mod = BF:NewModule("ButtonTest")

-- Locals
local db
local buttons = {}
local dragbar

-- Options
local options = {
	type = "group",
	name = L["Button Test"],
	args = {
		title = {
			type = "description",
			name = "|cffffcc00"..L["Button Test"].."|r\n",
			order = 1,
		},
		desc = {
			type = "description",
			name = L["BTEST_Desc"].."\n",
			order = 2,
		},
		enable = {
			type = "toggle",
			name = L["Enable Module"],
			desc = L["Enable this module."],
			get = function() return mod:IsEnabled() end,
			set = function(info, s)
				if s then
					BF:EnableModule("ButtonTest")
				else
					BF:DisableModule("ButtonTest")
				end
			end,
			order = 3,
		},
		drag = {
			type = "toggle",
			name = L["Enable Drag"],
			desc = L["Enable dragging of the buttons."],
			get = function() return db.drag end,
			set = function(info, s)
				db.drag = s
				mod:SetDrag()
			end,
			order = 4,
			disabled = function() return not db.enabled end
		},
		info = {
			type = "description",
			name = "\n|cffffcc00"..L["Button Information"].."|r\n",
			order = 5,
		},
		info1 = {
			type = "description",
			name = L["BTEST_Info1"].."\n",
			order = 6,
		},
		info2 = {
			type = "description",
			name = "|cffffcc00"..L["BTEST_Info2"].."|r",
			order = 7,
		},
	},
}
-- [ Local Functions ] --

-- startDrag(): Enables dragging of the buttons.
local function startDrag()
	buttons[1]:StartMoving()
end

-- stopDrag(): Disables dragging of the buttons.
local function stopDrag()
	local frame = buttons[1]
	local p ,rel ,rp ,X ,Y = frame:GetPoint()
	frame:StopMovingOrSizing()
	db.x = X
	db.y = Y
end

-- [ Core Methods ] --

-- :OnInitialize(): Initialize the module.
function mod:OnInitialize()
	-- Set up defaults.
	local defaults = {
		profile = {
			enabled = false,
			drag = false,
			skin = {
				ID = "Blizzard",
				Gloss = false,
				Backdrop = false,
				Colors = {},
			},
		},
	}

	-- Set up the DB.
	self.db = self:RegisterNamespace("ButtonTest", defaults)
	db = self.db.profile
	self:SetEnabledState(db.enabled)

	-- Hook into the root events.
	BF.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	BF.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	BF.db.RegisterCallback(self, "OnProfileReset", "Refresh")

	-- Set up options.
	self:RegisterModuleOptions("ButtonTest", options)
end

-- :OnEnable(): Enable function.
function mod:OnEnable()
	LBF:RegisterSkinCallback("ButtonTest", self.SkinCallback, self)
	local group = LBF:Group("ButtonTest")
	group:Skin(db.skin.ID or "Blizzard", db.skin.Gloss, db.skin.Backdrop, db.skin.Backdrop)
	if #buttons == 0 then
		local btn
		btn = CreateFrame("CheckButton", "BF_ButtonTest1", UIParent, "ActionBarButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT", UIParent, "TOPLEFT", db.x or 100, db.y or -200)
		BF_ButtonTest1HotKey:SetText("H")
		BF_ButtonTest1Count:SetText("C")
		BF_ButtonTest1Name:SetText("Name")
		buttons[1] = btn
		btn = CreateFrame("CheckButton", "BF_ButtonTest2", UIParent, "BonusActionButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT", buttons[1], "TOPRIGHT", 4, 0)
		BF_ButtonTest2HotKey:SetText("H")
		BF_ButtonTest2Count:SetText("C")
		BF_ButtonTest2Name:SetText("Name")
		buttons[2] = btn
		btn = CreateFrame("CheckButton", "BF_ButtonTest3", UIParent, "ShapeshiftButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT", buttons[2], "TOPRIGHT", 4, 0)
		BF_ButtonTest3HotKey:SetText("H")
		BF_ButtonTest3Count:SetText("C")
		BF_ButtonTest3Name:SetText("Name")
		buttons[3] = btn
		btn = CreateFrame("CheckButton", "BF_ButtonTest4", UIParent, "ItemButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT", buttons[3], "TOPRIGHT", 4, 0)
		BF_ButtonTest4Count:SetText("C")
		buttons[4] = btn
		btn = CreateFrame("CheckButton", "BF_ButtonTest5", UIParent, "PetActionButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",buttons[4], "TOPRIGHT", 4, 0)
		BF_ButtonTest5HotKey:SetText("H")
		BF_ButtonTest5Count:SetText("C")
		BF_ButtonTest5Name:SetText("Name")
		buttons[5] = btn
		btn = CreateFrame("CheckButton", "BF_ButtonTest6", UIParent, "ActionButtonTemplate, SecureActionButtonTemplate")
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT", buttons[5], "TOPRIGHT", 4, 0)
		BF_ButtonTest6HotKey:SetText("H")
		BF_ButtonTest6Count:SetText("C")
		BF_ButtonTest6Name:SetText("Name")
		local spellFirstAidIcon
		_, _, spellFirstAidIcon = GetSpellInfo(27028)
		BF_ButtonTest6Icon:SetTexture(spellFirstAidIcon)
		buttons[6] = btn
	end
	for i = 1, #buttons do
		group:AddButton(buttons[i])
		buttons[i]:Show()
	end
	buttons[1]:ClearAllPoints()
	buttons[1]:SetPoint("TOPLEFT", UIParent, "TOPLEFT", db.x or 100, db.y or -200)
	self:SetDrag()
	db.enabled = true
end

-- :OnEnable(): Disable function.
function mod:OnDisable()
	local group = LBF:Group("ButtonTest")
	for i = 1, #buttons do
		group:RemoveButton(buttons[i])
		buttons[i]:Hide()
	end
	buttons[1]:ClearAllPoints()
	buttons[1]:SetPoint("TOPLEFT", UIParent, "BOTTOMRIGHT", 100, -200)
	group:Delete()
	BF:RemoveModuleOptions("ButtonTest")
	db.enabled = false
end

-- :Refresh(): Refreshes the module's state.
function mod:Refresh()
	db = self.db.profile
	if db.enabled then
		self:Disable()
		self:Enable()
	else
		self:Disable()
	end
end

-- setDrag(): Sets the drag state.
function mod:SetDrag()
	if db.drag then
		if not dragbar then
			dragbar = CreateFrame("Frame", "BF_ButtonTestDragbar", UIParent)
			dragbar:EnableMouse(true)
			dragbar:RegisterForDrag("LeftButton")
			dragbar:SetBackdrop({
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				tile = true,
				tileSize = 16,
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				edgeSize = 16,
				insets = {left = 0, right = 0, top = 0, bottom = 0}
			})
			dragbar:SetBackdropColor(0, 0.5, 0, 0.9)
			dragbar:SetBackdropBorderColor(0, 0, 0, 0)
			dragbar:ClearAllPoints()
			dragbar:SetPoint("TOPLEFT", buttons[1], "TOPLEFT")
			dragbar:SetPoint("BOTTOMRIGHT", buttons[5], "BOTTOMRIGHT")
		end
		buttons[1]:SetMovable(true)
		dragbar:SetFrameLevel(100)
		dragbar:Show()
		dragbar:SetScript("OnDragStart", startDrag)
		dragbar:SetScript("OnDragStop", stopDrag)
	elseif dragbar then
		buttons[1]:SetMovable(false)
		dragbar:Hide()
		dragbar:SetScript("OnDragStart", nil)
		dragbar:SetScript("OnDragStop", nil)
	end
end

-- :SkinCallBack(): Callback function to store settings.
function mod:SkinCallback(SkinID, Gloss, Backdrop, Group, Button, Colors)
	if Group == "ButtonTest" then
		db.skin.ID = SkinID
		db.skin.Gloss = Gloss
		db.skin.Backdrop = Backdrop
		db.skin.Colors = Colors
	end
end
