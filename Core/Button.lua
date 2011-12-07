--[[
	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File.....: Core\Button.lua
	* Revision.: @file-revision@
	* Author...: StormFX, JJSheets

	Button Core
]]

local _, Core = ...
local hooksecurefunc, pairs, random, type, unpack = hooksecurefunc, pairs, random, type, unpack

local Skins, SkinList = Core:GetSkins()
local Levels = {
	Flash = {"ARTWORK", 0},
	Pushed = {"BACKGROUND", 0},
	Disabled = {"BORDER", 1},
	Checked = {"BORDER", 2},
	Border = {"ARTWORK", 0},
	AutoCastable = {"OVERLAY", 1},
	Highlight = {"HIGHLIGHT", 0},
}

-- Returns a set of color values.
local function GetColor(Color, Alpha)
	if type(Color) == "table" then
		return Color[1] or 1, Color[2] or 1, Color[3] or 1, Alpha or Color[4] or 1
	else
		return 1, 1, 1, Alpha or 1
	end
end
Core.GetColor = GetColor

-- Returns a set of texture coordinates.
local function GetTexCoords(Coords)
	if type(Coords) == "table" then
		return Coords[1] or 0, Coords[2] or 1, Coords[3] or 0, Coords[4] or 1
	else
		return 0, 1, 0, 1
	end
end

-- Returns the x and y scale of a button.
local function GetScale(Button)
	local x = (Button:GetWidth() or 36) / 36
	local y = (Button:GetHeight() or 36) / 36
	return x, y
end

-- Returns a random table key.
local function Random(v)
	if type(v) == "table" and #v > 1 then
		local i = random(1, #v)
		return v[i]
	end
end

local SkinBackdrop, RemoveBackdrop

do
	local Backdrop = {}
	local Cache = {}

	-- Removes the 'Backdrop' layer from a button.
	function RemoveBackdrop(Button)
		local Region = Button.__MSQ_Background or Backdrop[Button]
		if Region then
			Region:Hide()
			if Backdrop[Button] then
				Backdrop[Button] = nil
				Cache[#Cache + 1] = Region
			end
		end
	end

	-- Adds a 'Backdrop' layer to a button.
	function SkinBackdrop(Button, Skin, xScale, yScale, Color)
		local Region = Button.__MSQ_Background or Backdrop[Button]
		if not Region then
			local i = #Cache
			if i > 0 then
				Region = Cache[i]
				Cache[i] = nil
			else
				Region = Button:CreateTexture()
			end
		end
		if not Button.__MSQ_Background then
			Backdrop[Button] = Region
		end
		Region:SetParent(Button.__MSQ_Level[1] or Button)
		Region:SetTexture(Skin.Texture)
		Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
		Region:SetDrawLayer("BACKGROUND", 0)
		Region:SetBlendMode(Skin.BlendMode or "BLEND")
		Region:SetVertexColor(GetColor(Color or Skin.Color))
		Region:SetWidth((Skin.Width or 36) * xScale)
		Region:SetHeight((Skin.Height or 36) * yScale)
		Region:ClearAllPoints()
		Region:SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
		Region:Show()
	end

	-- API: Returns the 'Backdrop' layer of a button.
	function Core.API:GetBackdrop(Button)
		if Button then
			return Button.__MSQ_Background or Backdrop[Button]
		end
	end
end

-- Skins the 'Icon' layer of a button.
local function SkinIcon(Button, Region, Skin, xScale, yScale)
	Region:SetParent(Button.__MSQ_Level[1] or Button)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetDrawLayer("BORDER", 0)
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 36) * yScale)
	Region:ClearAllPoints()
	Region:SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
end

local SkinNormal

do
	local Base = {}
	local Hooked = {}

	-- Hook to catch changes to a button's 'Normal' texture. 
	local function Hook_SetNormalTexture(Button, Texture)
		local Region = Button.__MSQ_NormalTexture
		local Normal = Button:GetNormalTexture()
		local Skin = Button.__MSQ_NormalSkin
		if Normal ~= Region then
			Normal:SetTexture("")
			Normal:Hide()
		end
		if Texture == "Interface\\Buttons\\UI-Quickslot" and Skin.EmptyTexture then
			Region:SetTexture(Skin.EmptyTexture)
			Region:SetTexCoord(GetTexCoords(Skin.EmptyCoords or Skin.TexCoords))
			if Skin.EmptyColor then
				Region:SetVertexColor(GetColor(Skin.EmptyColor))
			end
			Region.__MSQ_Empty = true
		elseif Texture == "Interface\\Buttons\\UI-Quickslot2" then
			Region:SetTexture(Button.__MSQ_RandomTexture or Skin.Texture)
			Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
			Region:SetVertexColor(GetColor(Button.__MSQ_NormalColor))
			Region.__MSQ_Empty = nil
		end
	end

	-- Skins the 'Normal' layer of a button.
	function SkinNormal(Button, Region, Skin, xScale, yScale, Color)
		Region = Region or Button:GetNormalTexture()
		local Texture = Region and Region:GetTexture()
		-- Explicitly call 'Static = false' to enable the default states.
		if Skin.Static == false then
			if Base[Button] then
				Base[Button]:Hide()
			end
		else
			if Region then
				Region:SetTexture("")
				Region:Hide()
			end
			Region = Base[Button] or Button:CreateTexture()
			Base[Button] = Region
		end
		if not Region then return end
		Button.__MSQ_NormalTexture = Region
		-- Random Texture
		if Skin.Random then
			Button.__MSQ_RandomTexture = Random(Skin.Textures)
		else
			Button.__MSQ_RandomTexture = nil
		end
		Button.__MSQ_NormalColor = Color or Skin.Color
		if (Texture == "Interface\\Buttons\\UI-Quickslot" or Region.__MSQ_Empty) and Skin.EmptyTexture then
			Region:SetTexture(Skin.EmptyTexture)
			Region:SetTexCoord(GetTexCoords(Skin.EmptyCoords))
			if Skin.EmptyColor then
				Region:SetVertexColor(GetColor(Skin.EmptyColor))
			end
		else
			Region:SetTexture(Button.__MSQ_RandomTexture or Skin.Texture)
			Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
			Region:SetVertexColor(GetColor(Button.__MSQ_NormalColor))
		end
		if not Hooked[Button] then
			hooksecurefunc(Button, "SetNormalTexture", Hook_SetNormalTexture)
			Hooked[Button] = true
		end
		Button.__MSQ_NormalSkin = Skin
		Region:Show()
		if Skin.Hide then
			Region:SetTexture("")
			Region:Hide()
			return
		end
		Region:SetDrawLayer("BORDER", 0)
		Region:SetBlendMode(Skin.BlendMode or "BLEND")
		Region:SetWidth((Skin.Width or 36) * xScale)
		Region:SetHeight((Skin.Height or 36) * yScale)
		Region:ClearAllPoints()
		Region:SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
	end

	-- API: Returns the 'Normal' layer of a button.
	function Core.API:GetNormal(Button)
		return Button.__MSQ_NormalTexture or (Button.GetNormalTexture and Button:GetNormalTexture())
	end
end

local SkinGloss, RemoveGloss

do
	local Gloss = {}
	local Cache = {}

	-- Removes the 'Gloss' layer from a button.
	function RemoveGloss(Button)
		local Region = Gloss[Button]
		Gloss[Button] = nil
		if Region then
			Region:Hide()
			Cache[#Cache+1] = Region
		end
	end

	-- Adds a 'Gloss' layer to a button.
	function SkinGloss(Button, Skin, xScale, yScale, Color, Alpha)
		local Region
		local i = #Cache
		if Gloss[Button] then
			Region = Gloss[Button]
		elseif i > 0 then
			Region = Cache[i]
			Cache[i] = nil
		else
			Region = Button:CreateTexture()
		end
		Gloss[Button] = Region
		Region:SetParent(Button)
		Region:SetTexture(Skin.Texture)
		Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
		Region:SetDrawLayer("OVERLAY", 0)
		Region:SetVertexColor(GetColor(Color or Skin.Color, Alpha))
		Region:SetBlendMode(Skin.BlendMode or "BLEND")
		Region:SetWidth((Skin.Width or 36) * xScale)
		Region:SetHeight((Skin.Height or 36) * yScale)
		Region:ClearAllPoints()
		Region:SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
		Region:Show()
	end

	-- API: Returns the 'Gloss' layer of a button.
	function Core.API:GetGloss(Button)
		if Button then
			return Gloss[Button]
		end
	end
end

-- Skins a texture layer.
local function SkinTexture(Button, Region, Layer, Skin, xScale, yScale, Color)
	if Skin.Hide then
		Region:SetTexture("")
		Region:Hide()
		return
	end
	local Texture = Skin.Texture or Region:GetTexture()
	Region:SetTexture(Texture)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetDrawLayer(unpack(Levels[Layer]))
	Region:SetBlendMode(Skin.BlendMode or "BLEND")
	if Layer ~= "Border" then
		Region:SetVertexColor(GetColor(Color or Skin.Color))
	end
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 36) * yScale)
	Region:ClearAllPoints()
	Region:SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
end

-- Skins the 'Name' text of a button.
local function SkinName(Button, Region, Skin, xScale, yScale, Color, Fonts, Version)
	local font, size, flags = Region:GetFont()
	if font then
		if not Region.__MSQ_Font then
			Region.__MSQ_Font = font
		end
		size = 10
		if Fonts then
			font = Skin.Font or Region.__MSQ_Font
			size = Skin.FontSize or size
		else
			font = Region.__MSQ_Font
		end
		Region:SetFont(font, size, flags)
	end
	Region:SetJustifyH(Skin.JustifyH or "CENTER")
	Region:SetJustifyV(Skin.JustifyV or "MIDDLE")
	Region:SetDrawLayer("OVERLAY")
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 10) * yScale)
	Region:ClearAllPoints()
	if Version then
		Region:SetPoint("BOTTOM", Button, "BOTTOM", Skin.OffsetX or 0, Skin.OffsetY or 0)
	else
		Region:SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
	end
	Region:SetVertexColor(GetColor(Color or Skin.Color))
end

-- Skins the 'Count' text of a button.
local function SkinCount(Button, Region, Skin, xScale, yScale, Color, Fonts, Version)
	local font, size, flags = Region:GetFont()
	if font then
		if not Region.__MSQ_Font then
			Region.__MSQ_Font = font
		end
		size = 13
		if Fonts then
			font = Skin.Font or Region.__MSQ_Font
			size = Skin.FontSize or size
		else
			font = Region.__MSQ_Font
		end
		Region:SetFont(font, size, flags)
	end
	Region:SetJustifyH(Skin.JustifyH or "RIGHT")
	Region:SetJustifyV(Skin.JustifyV or "MIDDLE")
	Region:SetDrawLayer("OVERLAY")
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 10) * yScale)
	Region:ClearAllPoints()
	if Version then
		Region:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", Skin.OffsetX or 0, Skin.OffsetY or 0)
	else
		Region:SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
	end
	Region:SetVertexColor(GetColor(Color or Skin.Color))
end

-- Skins the 'HotKey' text of a button.
local function SkinHotKey(Button, Region, Skin, xScale, yScale, Fonts, Version)
	local font, size, flags = Region:GetFont()
	if font then
		if not Region.__MSQ_Font then
			Region.__MSQ_Font = font
		end
		size = 12
		if Fonts then
			font = Skin.Font or Region.__MSQ_Font
			size = Skin.FontSize or size
		else
			font = Region.__MSQ_Font
		end
		Region:SetFont(font, size, flags)
	end
	Region:SetJustifyH(Skin.JustifyH or "RIGHT")
	Region:SetJustifyV(Skin.JustifyV or "MIDDLE")
	Region:SetDrawLayer("OVERLAY")
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 10) * yScale)
	Region:ClearAllPoints()
	if not Region.__MSQ_SetPoint then
		Region.__MSQ_SetPoint = Region.SetPoint
		Region.SetPoint = function() end
	end
	if Version then
		Region:__MSQ_SetPoint("TOPLEFT", Button, "TOPLEFT", Skin.OffsetX or 0, Skin.OffsetY or 0)
	else
		Region:__MSQ_SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
	end
end

-- Skins the 'Duration' text of a button.
local function SkinDuration(Button, Region, Skin, xScale, yScale, Color, Fonts, Version)
	local font, size, flags = Region:GetFont()
	if font then
		if not Region.__MSQ_Font then
			Region.__MSQ_Font = font
		end
		size = 10
		if Fonts then
			font = Skin.Font or Region.__MSQ_Font
			size = Skin.FontSize or size
		else
			font = Region.__MSQ_Font
		end
		Region:SetFont(font, size, flags)
	end
	Region:SetJustifyH(Skin.JustifyH or "CENTER")
	Region:SetJustifyV(Skin.JustifyV or "MIDDLE")
	Region:SetDrawLayer("OVERLAY")
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 10) * yScale)
	Region:ClearAllPoints()
	if Version then
		Region:SetPoint("TOP", Button, "BOTTOM", Skin.OffsetX or 0, Skin.OffsetY or 0)
	else
		Region:SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
	end
	Region:SetVertexColor(GetColor(Color or Skin.Color))
end

-- Skins an animation frame.
local function SkinFrame(Button, Region, Skin, xScale, yScale)
	if Skin.Hide then
		Region:Hide()
		return
	end
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 36) * yScale)
	Region:ClearAllPoints()
	Region:SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
end

local UpdateSpellAlert

do
	local Alerts = {
		Square = {
			Glow = "Interface\\SpellActivationOverlay\\IconAlert",
			Ants = "Interface\\SpellActivationOverlay\\IconAlertAnts",
		},
		Circle = {
			Glow = "Interface\\AddOns\\Masque\\Textures\\IconAlert-Circle",
			Ants = "Interface\\AddOns\\Masque\\Textures\\IconAlertAnts-Circle",
		},
	}

	-- Hook to update the spell alert animation.
	function UpdateSpellAlert(Button)
		local Overlay = Button.overlay
		if not Overlay or not Overlay.spark then return end
		if Overlay.__MSQ_Shape ~= Button.__MSQ_Shape then
			local Shape = Button.__MSQ_Shape
			local Glow, Ants
			if Shape and Alerts[Shape] then
				Glow = Alerts[Shape].Glow or Alerts.Square.Glow
				Ants = Alerts[Shape].Ants or Alerts.Square.Ants
			else
				Glow = Alerts.Square.Glow
				Ants = Alerts.Square.Ants
			end
			Overlay.innerGlow:SetTexture(Glow)
			Overlay.innerGlowOver:SetTexture(Glow)
			Overlay.outerGlow:SetTexture(Glow)
			Overlay.outerGlowOver:SetTexture(Glow)
			Overlay.spark:SetTexture(Glow)
			Overlay.ants:SetTexture(Ants)
			Overlay.__MSQ_Shape = Button.__MSQ_Shape
		end
	end
	hooksecurefunc("ActionButton_ShowOverlayGlow", UpdateSpellAlert)

	-- Adds a spell alert to the cache.
	function Core.API:AddSpellAlert(Shape, Glow, Ants)
		if type(Shape) == "string" then
			local  Overlay = Alerts[Shape] or {}
			if type(Glow) == "string" then
				Overlay.Glow = Glow
			end
			if type(Ants) == "string" then
				Overlay.Ants = Ants
			end
			Alerts[Shape] = Overlay
		else
			if Core.db.profile.Debug then
				error("Bad argument to method 'AddSpellAlert'. 'Shape' must be a string.", 2)
			end
			return
		end
	end
end

do
	local Hooked = {}
	local __MTT = {}

	-- Hook to automatically adjust the button's additional frame levels.
	local function Hook_SetFrameLevel(Button, Level)
		local base = Level or Button:GetFrameLevel()
		if base < 3 then base = 3 end
		if Button.__MSQ_Level[1] then
			Button.__MSQ_Level[1]:SetFrameLevel(base - 2)
		end
		if Button.__MSQ_Level[2] then
			Button.__MSQ_Level[2]:SetFrameLevel(base - 1)
		end
		if Button.__MSQ_Level[4] then
			Button.__MSQ_Level[4]:SetFrameLevel(base + 1)
		end
	end

	-- Applies a skin to a button and its associated layers.
	function Core.SkinButton(Button, ButtonData, SkinID, Gloss, Backdrop, Colors, Fonts)
		if not Button then return end
		Button.__MSQ_Level = Button.__MSQ_Level or {}
		if not Button.__MSQ_Level[1] then
			local frame = CreateFrame("Frame", nil, Button)
			Button.__MSQ_Level[1] = frame
		end
		Button.__MSQ_Level[3] = Button
		if type(Colors) ~= "table" then
			Colors = __MTT
		end
		if type(Gloss) ~= "number" then
			Gloss = (Gloss and 1) or 0
		end
		local xScale, yScale = GetScale(Button)
		local Skin = (SkinID and Skins[SkinID]) or Skins["Blizzard"]
		local Version = Skin.Masque_Version or Skin.LBF_Version
		Button.__MSQ_Background = ButtonData.FloatingBG
		if Backdrop and not Skin.Backdrop.Hide then
			SkinBackdrop(Button, Skin.Backdrop, xScale, yScale, Colors.Backdrop)
		else
			RemoveBackdrop(Button)
		end
		if ButtonData.Icon then
			SkinIcon(Button, ButtonData.Icon, Skin.Icon, xScale, yScale)
		end
		if ButtonData.Normal ~= false then
			SkinNormal(Button, ButtonData.Normal, Skin.Normal, xScale, yScale, Colors.Normal)
		end
		for Layer in pairs(Levels) do
			if ButtonData[Layer] then
				SkinTexture(Button, ButtonData[Layer], Layer, Skin[Layer], xScale, yScale, Colors[Layer])
			end
		end
		if Gloss > 0 and not Skin.Gloss.Hide then
			SkinGloss(Button, Skin.Gloss, xScale, yScale, Colors.Gloss, Gloss)
		else
			RemoveGloss(Button)
		end
		if ButtonData.Name then
			SkinName(Button, ButtonData.Name, Skin.Name, xScale, yScale, Colors.Name, Fonts, Version)
		end
		if ButtonData.Count then
			SkinCount(Button, ButtonData.Count, Skin.Count, xScale, yScale, Colors.Count, Fonts, Version)
		end
		if ButtonData.HotKey then
			SkinHotKey(Button, ButtonData.HotKey, Skin.HotKey, xScale, yScale, Fonts, Version)
		end
		if ButtonData.Duration then
			SkinDuration(Button, ButtonData.Duration, Skin.Duration, xScale, yScale, Colors.Duration, Fonts, Version)
		end
		if ButtonData.Cooldown then
			Button.__MSQ_Level[2] = ButtonData.Cooldown
			SkinFrame(Button, ButtonData.Cooldown, Skin.Cooldown, xScale, yScale)
		end
		if ButtonData.AutoCast then
			Button.__MSQ_Level[4] = ButtonData.AutoCast
			SkinFrame(Button, ButtonData.AutoCast, Skin.AutoCast, xScale, yScale)
		end
		Button.__MSQ_Shape = Skin.Shape
		-- Button must be a 'CheckButton' to use the Spell Alert feature.
		if Button:GetObjectType() == "CheckButton" then
			UpdateSpellAlert(Button)
		end
		if not Hooked[Button] then
			hooksecurefunc(Button, "SetFrameLevel", Hook_SetFrameLevel)
			Hooked[Button] = true
		end
		local level = Button:GetFrameLevel()
		if level < 4 then
			level = 4
		end
		Button:SetFrameLevel(level)
	end
end
