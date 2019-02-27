--[[

	Copyright (c) StormFX 2018-2019. All rights reserved.
	See https://github.com/StormFX/AceGUI-3.0_SFX-Widgets for more information.

]]

-- GLOBALS: GameFontHighlight

local AceGUI = LibStub and LibStub("AceGUI-3.0")

local Type, Version = "SFX-Info", 1
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

----------------------------------------
-- Locals
---

-- Lua Functions
local max = math.max

do
	----------------------------------------
	-- Frame
	---

	-- :OnEnter Handler
	local function Frame_OnEnter(self)
		self.obj:Fire("OnEnter")
	end

	-- :OnLeave Handler
	local function Frame_OnLeave(self)
		self.obj:Fire("OnLeave")
	end

	----------------------------------------
	-- Widget
	---

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
	-- Toggles showing of the tooltip.
	local function Widget_SetDisabled(self, Disabled)
		self.disabled = Disabled
		local frame = self.frame

		if Disabled then
			frame:SetScript("OnEnter", nil)
			frame:SetScript("OnLeave", nil)
		else
			frame:SetScript("OnEnter", Frame_OnEnter)
			frame:SetScript("OnLeave", Frame_OnLeave)
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
