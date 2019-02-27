--[[

	Copyright (c) StormFX 2018-2019. All rights reserved.
	See https://github.com/StormFX/AceGUI-3.0_SFX-Widgets for more information.

]]

-- GLOBALS: GameFontHighlight, GameTooltip
local AceGUI = LibStub and LibStub("AceGUI-3.0")

local Type, Version = "SFX-Info-URL", 1
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

----------------------------------------
-- Locals
---

-- Lua Functions
local max = math.max

-- Locales
local L = {
	["Copy"] = "Copy",
	["Select"] = "Select",
	["CTRL+C"] = "CTRL+C",
	["Escape"] = "Escape",
	["Press %s to copy."] = "Press %s to copy.",
	["Press %s to cancel."] = "Press %s to cancel.",
	["Click to select this text."] = "Click to select this text."
}

--local Locale = GetLocale()
--if Locale == "deDE" then
--elseif Locale == "esMX" or Locale == "esES" then
--elseif Locale == "frFR" then
--elseif Locale == "itIT" then
--elseif Locale == "koKR" then
--elseif Locale == "ptBR" then
--elseif Locale == "ruRU" then
--elseif Locale == "zhCN" then
--elseif Locale == "zhTW" then
--end

-- String Edits
local KEY_COPY = "|cffffcc00"..L["CTRL+C"].."|r"
local KEY_EXIT = "|cffffcc00"..L["Escape"].."|r"
local TXT_COPY = (L["Press %s to copy."]):format(KEY_COPY)
local TXT_EXIT = (L["Press %s to cancel."]):format(KEY_EXIT)

do
	----------------------------------------
	-- EditBox
	----------------------------------------

	local EditBox

	-- :OnEnter Handler
	local function EditBox_OnEnter(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
		GameTooltip:SetText(L["Copy"])
		GameTooltip:AddLine(TXT_COPY, 1, 1, 1)
		GameTooltip:AddLine(TXT_EXIT, 1, 1, 1)
		GameTooltip:Show()
	end

	-- :OnLeave Handler
	local function EditBox_OnLeave(self)
		GameTooltip:Hide()
	end

	-- :OnEditFocusGained Handler
	local function EditBox_OnFocusGained(self)
		self:HighlightText()
		self:SetCursorPosition(0)
	end

	-- :OnEditFocusLost Handler
	local function EditBox_OnFocusLost(self)
		if self.obj then
			self.obj.Info:Show()
			self.obj = nil
		end
		self:Hide()
	end

	-- :OnTextChanged Handler
	local function EditBox_OnTextChanged(self)
		local Text = (self:GetParent()).Value or ""
		self:SetText(Text)
		EditBox_OnFocusGained(self)
	end

	----------------------------------------
	-- Button
	---

	-- :OnClick Handler
	local function Button_OnClick(self)
		EditBox:ClearFocus() -- Explicit Call

		local obj = self.obj
	
		local Text = self.Value or obj:GetText() or ""
		EditBox:SetText(Text)

		EditBox:SetParent(self)
		EditBox:ClearAllPoints()
		EditBox:SetPoint("TOPLEFT", obj.Info, -2, 2)
		EditBox:SetPoint("BOTTOMRIGHT", obj.Info, 0, -2)

		-- Check for a new line character.
		-- Tip: Don't use them.
		local Height = obj.Info:GetHeight()
		local Multi = (Height > 14) and true or false
		EditBox:SetMultiLine(Multi) 

		EditBox:Show()
		EditBox:SetFocus()
		EditBox.obj = obj

		obj.Info:Hide()
	end

	-- :OnEnter Handler
	local function Button_OnEnter(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
		GameTooltip:SetText(L["Select"])
		GameTooltip:AddLine(L["Click to select this text."], 1, 1, 1)
		GameTooltip:Show()
	end

	-- :OnLeave Handler
	local function Button_OnLeave(self)
		GameTooltip:Hide()
	end

	----------------------------------------
	-- Widget
	---

	-- Unused Buttons
	local Buttons = {}

	-- :OnAcquire Handler
	local function Widget_OnAcquire(self)
		-- Default to disabled.
		self:SetDisabled(true)

		self:SetLabel()
		self:SetColon()
		self:SetText()

		self:SetFullWidth(true)
	end

	-- :OnRelease Handler
	local function Widget_OnRelease(self)
		self:SetDisabled(true)
		self.frame:ClearAllPoints()
	end

	-- :SetDisabled Handler
	-- * Determines whether the text in the 'Info' field can be copied.
	local function Widget_SetDisabled(self, Disabled)
		self.disabled = Disabled
		if Disabled then
			-- Cache the Button.
			local Button = self.Button
			if Button then
				Buttons[#Buttons+1] = Button
				Button.obj = nil
				Button.Value = nil
				Button:SetParent(nil)
				Button:Hide()
				self.Button = nil
			end
			self.Info:SetTextColor(1, 1, 1)
		else
			-- Set up the EditBox.
			if not EditBox then
				EditBox = CreateFrame("EditBox", "AceGUI-3.0_SFX-InfoRow_EditBox", self.frame)
				EditBox:SetAutoFocus(true)

				EditBox:SetFontObject(GameFontHighlight)
				EditBox:SetJustifyH("LEFT")
				EditBox:SetJustifyV("TOP")
				EditBox:SetHeight(14)

				EditBox:SetBackdrop({
					bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
					edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
					tile = true, edgeSize = 0.8, tileSize = 5,
				})
				EditBox:SetBackdropColor(0, 0, 0, 0.5)
				EditBox:SetBackdropBorderColor(1, 1, 1, 0.2)
				EditBox:SetTextInsets(2, 1, 1, 1)

				EditBox:SetScript("OnEnter", EditBox_OnEnter)
				EditBox:SetScript("OnLeave", EditBox_OnLeave)
				EditBox:SetScript("OnTextChanged", EditBox_OnTextChanged)
				EditBox:SetScript("OnEnterPressed", EditBox.ClearFocus)
				EditBox:SetScript("OnEscapePressed", EditBox.ClearFocus)
				EditBox:SetScript("OnEditFocusLost", EditBox_OnFocusLost)
				EditBox:SetScript("OnEditFocusGained", EditBox_OnFocusGained)
				EditBox:Hide()
			end

			-- Set up a Button.
			local Button = self.Button
			if not Button then
				local i = #Buttons
				if i > 0 then
					Button = Buttons[i]
					Buttons[i] = nil
					Button:SetParent(self.frame)
				else
					Button = CreateFrame('Button', nil, self.frame)
					Button:SetScript("OnClick", Button_OnClick)
					Button:SetScript("OnEnter", Button_OnEnter)
					Button:SetScript("OnLeave", Button_OnLeave)
				end
			end

			Button.obj = self
			Button.Value = self:GetText()

			Button:ClearAllPoints()
			Button:SetAllPoints(self.Info)
			Button:Show()
	
			self.Button = Button
			self.Info:SetTextColor(0, 0.6, 1)
		end
	end

	-- :SetColon
	-- Sets the column separator.
	local function Widget_SetColon(self, Text)
		self.Colon:SetText(Text or ":")
	end

	-- :SetLabel
	-- Sets the text of the Label field.
	local function Widget_SetLabel(self, Text)
		Text = Text or ""
		self.Label:SetText(Text)
		if Text == "" then
			self:SetColon(Text)
		end
	end

	-- :GetText
	-- Returns the text of the Info field.
	local function Widget_GetText(self)
		return self.Info:GetText() or ""
	end

	-- :SetText
	-- Sets the text of the Info field.
	local function Widget_SetText(self, Text)
		Text = Text or ""
		self.Info:SetText(Text)

		local Height = max(self.Label:GetHeight(), self.Info:GetHeight())
		self:SetHeight(Height)
	end

	-- :SetWidth
	-- * Uses :SetFullWidth(true).
	local function Widget_SetWidth(self, Width)
		--self.frame:SetWidth(Width)
	end

	----------------------------------------
	-- Constructor
	---

	local function Constructor()
		local Widget = {}

		-- Container Frame
		local frame = CreateFrame("Frame", nil, UIParent)

		Widget.frame = frame
		frame.obj = Widget

		-- Label: Left Text
		local Label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		Label:SetWidth(75)
		Label:SetPoint("TOPLEFT", frame, "TOPLEFT")
		Label:SetPoint("BOTTOM", frame, "BOTTOM")
		Label:SetJustifyH("RIGHT")
		Label:SetJustifyV("TOP")

		Widget.Label = Label
		Label.obj = Widget

		-- Colon: Column Separator
		local Colon = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		Colon:SetWidth(8)
		Colon:SetPoint("TOPLEFT", Label, "TOPRIGHT")
		Colon:SetPoint("BOTTOM", frame, "BOTTOM")
		Colon:SetJustifyH("LEFT")
		Colon:SetJustifyV("TOP")

		Widget.Colon = Colon
		Colon.obj = Widget

		-- Info: Right Text
		local Info = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		Info:SetPoint("TOPLEFT", Colon, "TOPRIGHT")
		Info:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
		Info:SetJustifyH("LEFT")
		Info:SetJustifyV("TOP")

		Widget.Info = Info
		Info.obj = Widget

		-- Widget
		Widget.type  = Type
		Widget.num   = AceGUI:GetNextWidgetNum(Type)

		Widget.OnAcquire = Widget_OnAcquire
		Widget.OnRelease = Widget_OnRelease
		Widget.SetDisabled = Widget_SetDisabled

		Widget.SetColon = Widget_SetColon
		Widget.SetLabel = Widget_SetLabel
		Widget.GetText = Widget_GetText
		Widget.SetText = Widget_SetText
		Widget.SetWidth = Widget_SetWidth

		return AceGUI:RegisterAsWidget(Widget)
	end
	AceGUI:RegisterWidgetType(Type, Constructor, Version)
end
