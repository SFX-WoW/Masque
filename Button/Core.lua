--[[
	Project.: Masque
	File....: Button/Core.lua
	Version.: @file-revision@
	Author..: StormFX, JJSheets
]]

local _, Core = ...

-- [ Locals ] --

local hooksecurefunc, pairs, type, unpack = hooksecurefunc, pairs, type, unpack

-- Draw Layers
local Levels = {
	Flash = {"ARTWORK", 0},
	Pushed = {"BACKGROUND", 0},
	Disabled = {"BORDER", 1},
	Checked = {"BORDER", 2},
	Border = {"ARTWORK", 0},
	AutoCastable = {"OVERLAY", 1},
	Highlight = {"HIGHLIGHT", 0},
}

-- [ Utility ] --

-- Returns a set of color values.
function Core.Button.GetColor(Color, Alpha)
	if type(Color) == "table" then
		return Color[1] or 1, Color[2] or 1, Color[3] or 1, Alpha or Color[4] or 1
	else
		return 1, 1, 1, Alpha or 1
	end
end
local GetColor = Core.Button.GetColor

-- Returns a random table key.
local function Random(v)
	if type(v) == "table" and #v > 1 then
		local i = random(1, #v)
		return v[i]
	end
end

-- Returns a set of texture coordinates.
local function GetTexCoords(Coords)
	if type(Coords) == "table" then
		return Coords[1] or 0, Coords[2] or 1, Coords[3] or 0, Coords[4] or 1
	else
		return 0, 1, 0, 1
	end
end

-- [ Backdrop ] --

local SkinBackdrop, RemoveBackdrop

do
	local Backdrop = {}
	local Cache = {}

	-- Removes the 'Backdrop' layer from a button.
	function RemoveBackdrop(Button)
		local Region = Backdrop[Button]
		Backdrop[Button] = nil
		if Region then
			Region:Hide()
			Cache[#Cache + 1] = Region
		end
	end

	-- Adds a 'Backdrop' layer to a button.
	function SkinBackdrop(Button, Skin, xScale, yScale, Color)
		local Region
		local i = #Cache
		if Backdrop[Button] then
			Region = Backdrop[Button]
		elseif i > 0 then
			Region = Cache[i]
			Cache[i] = nil
		else
			Region = Button:CreateTexture()
		end
		Backdrop[Button] = Region
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

	-- Returns the 'Backdrop' layer of a button.
	function Core.Button:GetBackdrop(Button)
		return Backdrop[Button]
	end
end

-- [ Icon ] --

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

-- [ Normal ] --

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
		if Texture == "Interface\\Buttons\\UI-Quickslot2" then
			Region:SetTexture(Button.__MSQ_RandomTexture or Skin.Texture)
			Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
			Region.__MSQ_Empty = nil
		elseif Texture == "Interface\\Buttons\\UI-Quickslot" then
			if Skin.EmptyTexture then
				Region:SetTexture(Skin.EmptyTexture)
				Region:SetTexCoord(GetTexCoords(Skin.EmptyCoords))
			else
				Region:SetTexture(Button.__MSQ_RandomTexture or Skin.Texture)
				Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
			end
			Region.__MSQ_Empty = true
		end
	end

	-- Skins the 'Normal' layer of a button.
	function SkinNormal(Button, Region, Skin, xScale, yScale, Color)
		Region = Region or Button:GetNormalTexture()
		local Texture = Region and Region:GetTexture()
		Region = Region or Normal
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
		if not Region then
			return
		end
		Button.__MSQ_NormalTexture = Region
		-- Random Texture
		if Skin.Random then
			Button.__MSQ_RandomTexture = Random(Skin.Textures)
		else
			Button.__MSQ_RandomTexture = nil
		end
		if (Texture == "Interface\\Buttons\\UI-Quickslot" or Region.__MSQ_Empty) and Skin.EmptyTexture then
			Region:SetTexture(Skin.EmptyTexture)
			Region:SetTexCoord(GetTexCoords(Skin.EmptyCoords))
		else
			Region:SetTexture(Button.__MSQ_RandomTexture or Skin.Texture)
			Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
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
		Region:SetVertexColor(GetColor(Color or Skin.Color))
		Region:SetWidth((Skin.Width or 36) * xScale)
		Region:SetHeight((Skin.Height or 36) * yScale)
		Region:ClearAllPoints()
		Region:SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
	end

	-- Returns the 'Normal' texture of a button.
	function Core.Button:GetNormalTexture(Button)
		return Button.__MSQ_NormalTexture or Button:GetNormalTexture()
	end
end

-- [ Gloss ] --

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

	-- Returns the 'Gloss' layer of a button.
	function Core.Button:GetGloss(Button)
		return Gloss[Button]
	end
end

-- [ Texture ] --

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

-- [ Name ] --

-- Skins the 'Name' text od a button.
local function SkinName(Button, Region, Skin, xScale, yScale, Color, Version)
	local font, _, flags = Region:GetFont()
	Region:SetFont(font, Skin.FontSize or 11, flags)
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

-- [ Count ] --

-- Skins the 'Count' text of a button.
local function SkinCount(Button, Region, Skin, xScale, yScale, Color, Version)
	local font, _, flags = Region:GetFont()
	Region:SetFont(font, Skin.FontSize or 15, flags)
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

-- [ HotKey ] --

-- Skins the 'HotKey' text of a button.
local function SkinHotKey(Button, Region, Skin, xScale, yScale, Version)
	local font, _, flags = Region:GetFont()
	Region:SetFont(font, Skin.FontSize or 13, flags)
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

-- [ Duration ] --

-- Skins the 'Duration' text of a button.
local function SkinDuration(Button, Region, Skin, xScale, yScale, Color, Version)
	local font, _, flags = Region:GetFont()
	Region:SetFont(font, Skin.FontSize or 11, flags)
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

-- [ Frame ] --

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

-- [ Button ] --

do
	local Hooked = {}

	-- Skin Tables
	local Skins = Core.Button:GetSkins()
	local SkinList = Core.Button:ListSkins()

	-- Empty Table
	local __MTT = {}

	-- Hook to automatically adjust the button's additional frames' levels.
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
	function Core.Button.Skin(Button, ButtonData, SkinID, Gloss, Backdrop, Colors)
		if not Button then
			return
		end
		Button.__MSQ_Level = Button.__MSQ_Level or {}
		if not Button.__MSQ_Level[1] then -- Frame Level 1
			local frame = CreateFrame("Frame", nil, Button)
			Button.__MSQ_Level[1] = frame
		end
		Button.__MSQ_Level[3] = Button -- Frame Level 3
		if type(Colors) ~= "table" then
			Colors = __MTT
		end
		if type(Gloss) ~= "number" then
			Gloss = (Gloss and 1) or 0
		end
		local xScale = (Button:GetWidth() or 36) / 36
		local yScale = (Button:GetHeight() or 36) / 36
		local Skin = (SkinID and Skins[SkinID]) or Skins["Blizzard"]
		local Version = Skin.Masque_Version or Skin.LBF_Version
		-- Skin Shape
		Button.__MSQ_Shape = Skin.Shape
		-- Backdrop
		if Backdrop and not Skin.Backdrop.Hide then
			SkinBackdrop(Button, Skin.Backdrop, xScale, yScale, Colors.Backdrop)
		else
			RemoveBackdrop(Button)
		end
		-- Icon
		if ButtonData.Icon then
			SkinIcon(Button, ButtonData.Icon, Skin.Icon, xScale, yScale)
		end
		-- Normal
		if ButtonData.Normal ~= false then
			SkinNormal(Button, ButtonData.Normal, Skin.Normal, xScale, yScale, Colors.Normal)
		end
		-- Textures
		for Layer in pairs(Levels) do
			if ButtonData[Layer] then
				SkinTexture(Button, ButtonData[Layer], Layer, Skin[Layer], xScale, yScale, Colors[Layer])
			end
		end
		-- Gloss
		if Gloss > 0 and not Skin.Gloss.Hide then
			SkinGloss(Button, Skin.Gloss, xScale, yScale, Colors.Gloss, Gloss)
		else
			RemoveGloss(Button)
		end
		-- Name
		if ButtonData.Name then
			SkinName(Button, ButtonData.Name, Skin.Name, xScale, yScale, Colors.Name, Version)
		end
		-- Count
		if ButtonData.Count then
			SkinCount(Button, ButtonData.Count, Skin.Count, xScale, yScale, Colors.Count, Version)
		end
		-- HotKey
		if ButtonData.HotKey then
			SkinHotKey(Button, ButtonData.HotKey, Skin.HotKey, xScale, yScale, Version)
		end
		-- Duration
		if ButtonData.Duration then
			SkinDuration(Button, ButtonData.Duration, Skin.Duration, xScale, yScale, Colors.Duration, Version)
		end
		-- Cooldown
		if ButtonData.Cooldown then
			Button.__MSQ_Level[2] = ButtonData.Cooldown -- Frame Level 2
			SkinFrame(Button, ButtonData.Cooldown, Skin.Cooldown, xScale, yScale)
		end
		-- AutoCast
		if ButtonData.AutoCast then
			Button.__MSQ_Level[4] = ButtonData.AutoCast -- Frame Level 4
			SkinFrame(Button, ButtonData.AutoCast, Skin.AutoCast, xScale, yScale)
		end
		if not Hooked[Button] then
			hooksecurefunc(Button, "SetFrameLevel", Hook_SetFrameLevel)
			Hooked[Button] = true
		end
		-- Reorder the frames.
		local level = Button:GetFrameLevel()
		if level < 4 then
			level = 4
		end
		Button:SetFrameLevel(level)
	end
end
