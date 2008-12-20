local bf = LibStub("AceAddon-3.0"):GetAddon("ButtonFacade")
local lbf = LibStub("LibButtonFacade")
local AceLocale = LibStub("AceLocale-3.0")

-- Localization for each module should be in its own separate locale object.
local L = AceLocale:NewLocale("ButtonFacade", "enUS", true)
if L then
	L["Button Test"] = true
	L["Enable Module"] = true
	L["Drag"] = true
	L["Displays a set of buttons that can be used to verify the functionality of a skin.  In order from left to right, the buttons inherit from the following templates: ActionBarButtonTemplate, BonusActionButtonTemplate, ShapeshiftButtonTemplate, ItemButtonTemplate, PetActionButtonTemplate."] = true
end

local L = AceLocale:NewLocale("ButtonFacade", "esES")
if L then
	L["Button Test"] = "Probar Botón"
	L["Enable Module"] = "Activar Módulo"
	L["Drag"] = "Arrastar"
	L["Displays a set of buttons that can be used to verify the functionality of a skin.  In order from left to right, the buttons inherit from the following templates: ActionBarButtonTemplate, BonusActionButtonTemplate, ShapeshiftButtonTemplate, ItemButtonTemplate, PetActionButtonTemplate."] = "Muestra una serie de botones que pueden ser utilizados para verificar la funcionalidad de una piel. En orden de izquierda a derecha, los botones heredan las siguientes plantillas: ActionBarButtonTemplate, BonusActionButtonTemplate, ShapeshiftButtonTemplate, ItemButtonTemplate, PetActionButtonTemplate."
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
	type = "group",
	name = L["Button Test"],
	args = {
		header = {
			type = "description",
			name = "|cffffcc00"..L["Button Test"].."|r\n",
			order = 1,
		},
		info = {
			type = "description",
			name = L["Displays a set of buttons that can be used to verify the functionality of a skin.  In order from left to right, the buttons inherit from the following templates: ActionBarButtonTemplate, BonusActionButtonTemplate, ShapeshiftButtonTemplate, ItemButtonTemplate, PetActionButtonTemplate."].."\n",
			order = 2,
		},
		enable_mod = {
			type = "toggle",
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
			order = 3,
		},
		drag = {
			type = "toggle",
			name = L["Drag"],
			get = function() return db.profile.Unlocked end,
			set = function(info,s)
				db.profile.Unlocked = s
				btntest:SetDrag()
			end,
			width = "full",
			order = 4,
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
local dragbar

function btntest:SkinCallback(SkinID,Gloss,Backdrop,Group,Button)
	db.profile.Skin = SkinID
	db.profile.Gloss = Gloss
	db.profile.Backdrop = Backdrop
end

local function startDrag()
	buttons[1]:StartMoving()
end

local function stopDrag()
	local frame = buttons[1]
	local p ,rel ,rp ,X ,Y = frame:GetPoint()
	frame:StopMovingOrSizing()
	db.profile.x = X
	db.profile.y = Y
end

function btntest:SetDrag()
	if db.profile.Unlocked then
		if not dragbar then
			dragbar = CreateFrame("Frame","BF_ButtonTestDragbar",UIParent)
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
			dragbar:SetPoint("TOPLEFT",buttons[1],"TOPLEFT")
			dragbar:SetPoint("BOTTOMRIGHT",buttons[5],"BOTTOMRIGHT")
		end
		buttons[1]:SetMovable(true)
		dragbar:SetFrameLevel(100)
		dragbar:Show()
		dragbar:SetScript("OnDragStart",startDrag)
		dragbar:SetScript("OnDragStop",stopDrag)
	elseif dragbar then
		buttons[1]:SetMovable(false)
		dragbar:Hide()
		dragbar:SetScript("OnDragStart",nil)
		dragbar:SetScript("OnDragStop",nil)
	end
end

function btntest:OnEnable()
	lbf:RegisterSkinCallback(btntest.SkinCallback,btntest)
	local group = lbf:Group("ButtonTest")
	group:Skin(db.profile.Skin or "Blizzard", db.profile.Gloss, db.profile.Backdrop)
	if #buttons == 0 then
		local btn
		btn = CreateFrame("CheckButton","BF_ButtonTest1",UIParent,"ActionBarButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",UIParent,"TOPLEFT",db.profile.x or 100,db.profile.y or -200)
		BF_ButtonTest1HotKey:SetText("H")
		BF_ButtonTest1Count:SetText("C")
		BF_ButtonTest1Name:SetText("Name")
		buttons[1] = btn
		btn = CreateFrame("CheckButton","BF_ButtonTest2",UIParent,"BonusActionButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",buttons[1],"TOPRIGHT",4,0)
		BF_ButtonTest2HotKey:SetText("H")
		BF_ButtonTest2Count:SetText("C")
		BF_ButtonTest2Name:SetText("Name")
		buttons[2] = btn
		btn = CreateFrame("CheckButton","BF_ButtonTest3",UIParent,"ShapeshiftButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",buttons[2],"TOPRIGHT",4,0)
		BF_ButtonTest3HotKey:SetText("H")
		BF_ButtonTest3Count:SetText("C")
		BF_ButtonTest3Name:SetText("Name")
		buttons[3] = btn
		btn = CreateFrame("CheckButton","BF_ButtonTest4",UIParent,"ItemButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",buttons[3],"TOPRIGHT",4,0)
		BF_ButtonTest4Count:SetText("C")
		buttons[4] = btn
		btn = CreateFrame("CheckButton","BF_ButtonTest5",UIParent,"PetActionButtonTemplate")
		btn:SetID(1)
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",buttons[4],"TOPRIGHT",4,0)
		BF_ButtonTest5HotKey:SetText("H")
		BF_ButtonTest5Count:SetText("C")
		BF_ButtonTest5Name:SetText("Name")
		buttons[5] = btn
		btn = CreateFrame("CheckButton","BF_ButtonTest6",UIParent,"ActionButtonTemplate, SecureActionButtonTemplate")
		btn:ClearAllPoints()
		btn:SetPoint("TOPLEFT",buttons[5],"TOPRIGHT",4,0)
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
	buttons[1]:SetPoint("TOPLEFT",UIParent,"TOPLEFT",db.profile.x or 100,db.profile.y or -200)
	self:SetDrag()
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
	buttons[1]:SetPoint("TOPLEFT",UIParent,"BOTTOMRIGHT",100,-200)
	group:Delete()
	db.profile.enabled = nil
end
