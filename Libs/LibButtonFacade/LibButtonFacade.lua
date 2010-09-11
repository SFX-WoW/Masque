--[[
	Project.: LibButtonFacade
	File....: LibButtonFacade.lua
	Version.: @file-revision@
	Author..: StormFX, JJ Sheets
]]

-- [ Set Up ] --

local LBF
local assert = assert
do
	local major, minor = "LibButtonFacade", 30305
	local LS = assert(LibStub,major.." requires LibStub.")
	LBF = LS:NewLibrary(major,minor)
end
if not LBF then return end

-- [ Locals ] --

local error, pairs, print, setmetatable, type, unpack = error, pairs, print, setmetatable, type, unpack

-- [ Call Backs ] --

local FireGuiCB

do
	local callbacks = {}
	-- Fires all registered GUI call-backs.
	function FireGuiCB(Addon,Group,Button)
		for i = 1, #callbacks do
			local v = callbacks[i]
			v.cb(v.arg,Addon,Group,Button)
		end
	end
	-- Registers a GUI call-back.
	function LBF:RegisterGuiCallback(callback,arg)
		callbacks[#callbacks+1] = {cb = callback, arg = arg}
	end
end

local FireSkinCB

do
	local callbacks = {}
	-- Fires all call-backs registered for the specified add-on.
	function FireSkinCB(Addon,SkinID,Gloss,Backdrop,Group,Button,Colors)
		Addon = Addon or "ButtonFacade"
		local args = callbacks[Addon]
		if args then
			for arg, callback in pairs(args) do
				callback(arg and arg,SkinID,Gloss,Backdrop,Group,Button,Colors)
			end
		end
	end
	-- Registers a skin call-back for the specified add-on.
	function LBF:RegisterSkinCallback(Addon,callback,arg)
		local arg = callback and arg or false
		callbacks[Addon] = callbacks[Addon] or {}
		callbacks[Addon][arg] = callback
	end
end

-- [ Texture Coloring ] --

local SetTextureColor

do
	local loopcheck = {}
	local old_GetVertexColor
	-- GetVertexColor post-hook.
	local function HookGetVertexColor(region)
		local R, G, B, A = region.__LBF_R, region.__LBF_G, region.__LBF_B, region.__LBF_A
		local r, g, b, a = old_GetVertexColor(region)
		if R then
			r = r / R
			g = g / G
			b = b / B
			a = a / A
		end
		return r, g, b, a
	end
	-- SetVertexColor post-hook.
	local function HookSetVertexColor(region,r,g,b,a)
		if loopcheck[region] then loopcheck[region] = nil return end
		loopcheck[region] = true
		local R, G, B, A = region.__LBF_R, region.__LBF_G, region.__LBF_B, region.__LBF_A
		if R then
			region:SetVertexColor(R*r,G*g,B*b,A*(a or 1))
		end
	end
	-- Sets the texture color.
	function SetTextureColor(region,r,g,b,a)
		if not old_GetVertexColor then old_GetVertexColor = region.GetVertexColor end
		if region.GetVertexColor ~= HookGetVertexColor then
			hooksecurefunc(region,"SetVertexColor",HookSetVertexColor)
			region.GetVertexColor = HookGetVertexColor
		end
		region.__LBF_R, region.__LBF_G, region.__LBF_B, region.__LBF_A = r, g, b, a
		loopcheck[region] = true
		region:SetVertexColor(r,g,b,a)
	end
end

-- [ Layer Coloring ] --

-- Returns the layer's color table.
local function GetLayerColor(SkinLayer,Color,Layer,Alpha)
	local color = Color[Layer] or SkinLayer.Color
	if type(color) == "table" then
		return color[1] or 1, color[2] or 1, color[3] or 1, Alpha or color[4] or 1
	else
		return 1, 1, 1, Alpha or 1
	end
end

-- [ Default Settings ] --

-- Texture Coordinates
local TexCoords = {0,1,0,1}

-- Draw Layers
local DrawLayers = {
	Backdrop = "BACKGROUND",
	Icon = "BORDER",
	Pushed = "BACKGROUND",
	Flash = "OVERLAY",
	Normal = "BORDER",
	Disabled = "ARTWORK",
	Checked = "ARTWORK",
	Border = "OVERLAY",
	Highlight = "HIGHLIGHT",
	AutoCastable = "BORDER",
	Gloss = "OVERLAY",
	HotKey = "OVERLAY",
	Count = "OVERLAY",
	Name = "OVERLAY",
}

-- Non-special Case Layers
local LayerTypes = {
	Icon = "Icon",
	Flash = "Texture",
	Cooldown = "Frame",
	AutoCast = "Frame",
	AutoCastable = "Texture",
	HotKey = "Text",
	Count = "Text",
	Name = "Text",
}

-- Parent Levels - Represents the frame the layer is parented to (via Button.__LBF_Level)
local Levels = {
	Backdrop = 1,
	Icon = 1,
	Pushed = 3,
	Flash = 1,
	Cooldown = 2,
	Normal = 3,
	Disabled = 3,
	Checked = 3,
	Border = 3,
	Highlight = 3,
	AutoCast = 4,
	AutoCastable = 5,
	Gloss = 5,
	HotKey = 5,
	Count = 5,
	Name = 5,
}

-- Frame Offsets
local Offsets = {
	[1] = -2,
	[2] = -1,
	[4] = 1,
	[5] = 2,
}

-- Border Colors
local Borders = {
	Action = {0,1,0,0.35},
	None = {0.8,0,0,0.8},
	Magic = {0.2,0.6,1,0.8},
	Curse = {0.6,0,1,0.8},
	Poison = {0,0.6,0,0.8},
	Disease = {0.6,0.4,0,0.8},
	Enchant = {0.6,0.4,0.8,0.8},
	Special = {0,0,1,0.8},
}

-- [ Default Layers ] --

-- [ Normal ] --

local SkinNormalLayer

do
	local base = {}
	local hooked = {}
	-- Catch changes to the normal texture.
	local function Hook_SetNormalTexture(Button,Texture)
		local btnlayer = Button.__LBF_Normal
		local nrmlayer = Button:GetNormalTexture()
		if Button.__LBF_NoNormal then
				nrmlayer:SetTexture("")
				nrmlayer:Hide()
			return
		end
		if Texture == "Interface\\Buttons\\UI-Quickslot2" then
			if nrmlayer ~= btnlayer then
				nrmlayer:SetTexture("")
				nrmlayer:Hide()
			end
			btnlayer:SetTexture(Button.__LBF_SkinLayer.Texture or "")
			btnlayer.__LBF_UseEmpty = nil
		elseif Texture == "Interface\\Buttons\\UI-Quickslot" then
			if nrmlayer ~= btnlayer then
				nrmlayer:SetTexture("")
				nrmlayer:Hide()
			end
			btnlayer:SetTexture(Button.__LBF_SkinLayer.EmptyTexture or Button.__LBF_SkinLayer.Texture or "")
			btnlayer.__LBF_UseEmpty = true
		end
	end
	-- Skins the Normal layer.
	function SkinNormalLayer(Skin,Button,ButtonData,xScale,yScale,Color)
		local skinlayer = Skin.Normal
		local btnlayer
		if skinlayer.Static and ButtonData.Normal ~= false then
			btnlayer = ButtonData.Normal or Button:GetNormalTexture()
			if btnlayer then
				btnlayer:SetTexture("")
				btnlayer:Hide()
				Button.__LBF_NoNormal = true
			end
			btnlayer = base[Button] or Button:CreateTexture()
			base[Button] = btnlayer
		else
			btnlayer = ButtonData.Normal or Button:GetNormalTexture()
			if base[Button] then base[Button]:Hide() end
		end
		if not btnlayer then return end
		Button.__LBF_Normal = btnlayer
		if btnlayer:GetTexture() == "Interface\\Buttons\\UI-Quickslot" or btnlayer.__LBF_UseEmpty then
			btnlayer:SetTexture(skinlayer.EmptyTexture or skinlayer.Texture)
		else
			btnlayer:SetTexture(skinlayer.Texture)
		end
		if not hooked[Button] then
			hooksecurefunc(Button,"SetNormalTexture",Hook_SetNormalTexture)
			hooked[Button] = true
		end
		Button.__LBF_SkinLayer = skinlayer
		btnlayer.__LBF_SkinLayer = skinlayer
		btnlayer:Show()
		if skinlayer.Hide or ButtonData.Normal == false then
			btnlayer:SetTexture("")
			btnlayer:Hide()
			return
		end
		btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
		btnlayer:SetDrawLayer(DrawLayers.Normal)
		SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Normal"))
		btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xScale)
		btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yScale)
		btnlayer:ClearAllPoints()
		btnlayer:SetPoint("CENTER",Button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	end
	-- Gets the Normal texture.
	function LBF:GetNormalTexture(Button)
		return Button.__LBF_Normal or Button:GetNormalTexture()
	end
	-- Gets the Normal vertex color.
	function LBF:GetNormalVertexColor(Button)
		local t = Button.__LBF_Normal or Button:GetNormalTexture()
		if t then return t:GetVertexColor() end
	end
	-- Sets the Normal vertex color.
	function LBF:SetNormalVertexColor(Button,r,g,b,a)
		local t = Button.__LBF_Normal or Button:GetNormalTexture()
		if t then return t:SetVertexColor(r,g,b,a) end
	end
end

-- [ Highlight ] --

-- Skins the Highlight layer.
local function SkinHighlightLayer(Skin,Button,ButtonData,xScale,yScale,Color)
	local skinlayer = Skin.Highlight
	local btnlayer = ButtonData.Highlight or Button:GetHighlightTexture()
	if not btnlayer then return end
	if skinlayer.Hide or ButtonData.Highlight == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	btnlayer:SetDrawLayer(DrawLayers.Highlight)
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Highlight"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xScale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yScale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",Button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
end

-- [ Pushed ] --

-- Skins the Pushed layer.
local function SkinPushedLayer(Skin,Button,ButtonData,xScale,yScale,Color)
	local skinlayer = Skin.Pushed
	local btnlayer = ButtonData.Pushed or Button:GetPushedTexture()
	if not btnlayer then return end
	if skinlayer.Hide or ButtonData.Pushed == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetDrawLayer(DrawLayers.Pushed)
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Pushed"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xScale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yScale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",Button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
end

-- [ Disabled ] --

-- Skins the Disabled layer.
local function SkinDisabledLayer(Skin,Button,ButtonData,xScale,yScale,Color)
	local skinlayer = Skin.Disabled
	local btnlayer = ButtonData.Disabled or Button:GetDisabledTexture()
	if not btnlayer then return end
	if skinlayer.Hide or ButtonData.Disabled == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	btnlayer:SetDrawLayer(DrawLayers.Disabled)
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Disabled"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xScale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yScale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",Button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
end

-- [ Checked ] --

-- Skins the checked layer.
local function SkinCheckedLayer(Skin,Button,ButtonData,xScale,yScale,Color)
	local skinlayer = Skin.Checked
	local btnlayer = ButtonData.Checked or Button:GetCheckedTexture()
	if not btnlayer then return end
	if skinlayer.Hide or ButtonData.Checked == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Checked"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xScale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yScale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",Button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
end

-- [ Custom Layers ] --

-- [ Backdrop ] --

local RemoveBackdropLayer,SkinBackdropLayer

do
	local backdrop = {}
	local cache = {}
	-- Removes the backdrop layer.
	function RemoveBackdropLayer(Button)
		local layer = backdrop[Button]
		backdrop[Button] = nil
		if layer then
			layer:Hide()
			cache[#cache+1] = layer
		end
	end
	-- Skins the backdrop layer.
	function SkinBackdropLayer(Skin,Button,xScale,yScale,Color)
		local skinlayer = Skin.Backdrop
		local btnlayer
		local index = #cache
		if backdrop[Button] then
			btnlayer = backdrop[Button]
		elseif index > 0 then
			btnlayer = cache[index]
			cache[index] = nil
		else
			btnlayer = Button:CreateTexture(nil, "BACKGROUND")
		end
		backdrop[Button] = btnlayer
		local parent = Button.__LBF_Level[Levels.Backdrop]
		btnlayer:SetParent(parent or Button)
		btnlayer:Show()
		btnlayer:SetTexture(skinlayer.Texture)
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or TexCoords))
		btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
		btnlayer:SetDrawLayer(DrawLayers.Backdrop)
		SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Backdrop"))
		btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xScale)
		btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yScale)
		btnlayer:ClearAllPoints()
		btnlayer:SetPoint("CENTER",Button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	end
	-- Gets the backdrop layer.
	function LBF:GetBackdropLayer(Button)
		return backdrop[Button]
	end
end

-- [ Border ] --

local SkinBorderLayer,GetBorderColor

do
	local border = {}
	local hooked = {}
	-- Returns the border's color table.
	function GetBorderColor(Type,Colors,SkinLayer)
		if not Type or not Borders[Type] then
			Type = "Action"
		end
		local r, g, b, a = unpack(Borders[Type])
		if type(SkinLayer.Colors) == "table" then
			local c = SkinLayer.Colors[Type]
			if type(c) == "table" then
				r = c[1] or r
				g = c[2] or g
				b = c[3] or b
				a = c[4] or a
			end
		end
		if type(Colors.Borders) == "table" then
			local c = Colors.Borders[Type]
			if type(c) == "table" then
				r = c[1] or r
				g = c[2] or g
				b = c[3] or b
				a = c[4] or a
			end
		end
		return r, g, b, a
	end
	-- Hook to set the border's visibility.
	local function Hook_BorderUpdate(Button)
		local btnlayer = border[Button]
		if not btnlayer then return end
		local oldlayer = Button.__LBF_Border
		if Button.action and IsEquippedAction(Button.action) then
			btnlayer:Show()
		elseif oldlayer and oldlayer:IsShown() then
			btnlayer:Show()
		else
			btnlayer:Hide()
		end
	end
	-- Skins the custom border layer.
	function SkinBorderLayer(Skin,Button,ButtonData,xScale,yScale,Color)
		local name = Button:GetName()
		local oldlayer = ButtonData.Border or name and _G[name.."Border"]
		if not oldlayer then return end
		Button.__LBF_Border = oldlayer
		oldlayer:SetTexture("")
		local skinlayer = Skin.Border
		if skinlayer.Hide then return end
		local btnlayer = border[Button] or Button:CreateTexture(nil,"OVERLAY")
		border[Button] = btnlayer
		local parent = Button.__LBF_Level[Levels.Border]
		btnlayer:SetParent(parent or Button)
		if Button.action and IsEquippedAction(Button.action) then
			btnlayer:Show()
		elseif oldlayer:IsShown() then
			btnlayer:Show()
		else
			btnlayer:Hide()
		end
		btnlayer:SetTexture(skinlayer.Texture)
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or TexCoords))
		btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
		btnlayer:SetDrawLayer(DrawLayers.Gloss)
		SetTextureColor(btnlayer,GetBorderColor(Button.__LBF_Type,Color,skinlayer))
		btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xScale)
		btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yScale)
		btnlayer:ClearAllPoints()
		btnlayer:SetPoint("CENTER",Button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
		if not hooked[Button] then
			Button:HookScript("OnUpdate",Hook_BorderUpdate)
			hooked[Button] = true
		end
	end
	-- Get the border layer.
	function LBF:GetBorderLayer(Button)
		return border[Button]
	end
end

-- [ Gloss ] --

local RemoveGlossLayer,SkinGlossLayer

do
	local gloss = {}
	local cache = {}
	-- Removes the gloss layer.
	function RemoveGlossLayer(Button)
		local layer = gloss[Button]
		gloss[Button] = nil
		if layer then
			layer:Hide()
			cache[#cache+1] = layer
		end
	end
	-- Skins the gloss layer.
	function SkinGlossLayer(Skin,Button,xScale,yScale,Color,Alpha)
		local skinlayer = Skin.Gloss
		local btnlayer
		local index = #cache
		if gloss[Button] then
			btnlayer = gloss[Button]
		elseif index > 0 then
			btnlayer = cache[index]
			cache[index] = nil
			btnlayer:SetParent(Button)
		else
			btnlayer = Button:CreateTexture(nil,"OVERLAY")
		end
		gloss[Button] = btnlayer
		local parent = Button.__LBF_Level[Levels.Gloss]
		btnlayer:SetParent(parent or Button)
		btnlayer:Show()
		btnlayer:SetTexture(skinlayer.Texture)
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or TexCoords))
		btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
		btnlayer:SetDrawLayer(DrawLayers.Gloss)
		SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Gloss",Alpha))
		btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xScale)
		btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yScale)
		btnlayer:ClearAllPoints()
		btnlayer:SetPoint("CENTER",Button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	end
	-- Gets the gloss layer.
	function LBF:GetGlossLayer(Button)
		return gloss[Button]
	end
end

-- [ Non-Special-Case Layers ] --

local SkinLayer

do
	-- Skins a non-special-case layer.
	function SkinLayer(Skin,Button,Layer,btnlayer,xScale,yScale,Color)
	-- btnlayer = btnlayer
		local skinlayer = Skin[Layer]
		local type = LayerTypes[Layer]
		if skinlayer.Hide then
			if type == "Texture" then
				btnlayer:SetTexture("")
			end
			btnlayer:Hide()
			return
		end
		btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xScale)
		btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yScale)
		btnlayer:ClearAllPoints()
		btnlayer:SetPoint("CENTER",Button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
		local parent = Button.__LBF_Level[Levels[Layer]]
		if type == "Texture" then
			btnlayer:SetParent(parent or Button)
			btnlayer:SetTexture(skinlayer.Texture)
			btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or TexCoords))
			btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
			btnlayer:SetDrawLayer(DrawLayers[Layer])
			SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,Layer))
		elseif type == "Icon" then
			btnlayer:SetParent(parent or Button)
			btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or TexCoords))
			btnlayer:SetDrawLayer(DrawLayers[Layer])
		elseif type == "Text" then
			btnlayer:SetParent(parent or Button)
			btnlayer:SetDrawLayer(DrawLayers[Layer])
			btnlayer:SetTextColor(GetLayerColor(skinlayer,Color,Layer))
		elseif type == "Frame" then
			local level = Button:GetFrameLevel()
			btnlayer:SetFrameLevel(level + Offsets[Levels[Layer]])
		end
	end
end

-- [ Skins ] --

local Skins = {}
local SkinList = {}

do
	-- Adds a skin to the skin tables.
	function LBF:AddSkin(SkinID,SkinData,Replace)
		if type(SkinID) ~= "string" or type(SkinData) ~= "table" then return end
		if Skins[SkinID] and not Replace then
			return
		end
		if SkinData.Template then
			if Skins[SkinData.Template] then
				setmetatable(SkinData,{__index=Skins[SkinData.Template]})
			else
				print("|cff8000LBF Warning:|r Invalid template reference by skin '"..SkinID.."'.")
				return
			end
		end
		Skins[SkinID] = SkinData
		SkinList[SkinID] = SkinID
	end
	-- Returns the specified skin.
	function LBF:GetSkin(SkinID)
		return Skins[SkinID]
	end
	-- Returns the skin data table.
	function LBF:GetSkins()
		return Skins
	end
	-- Returns the skin list.
	function LBF:ListSkins()
		return SkinList
	end
end

local ApplySkin

do
	local hooked = {}
	local empty = {}
	-- Hook to automatically adjust the button's additional frames.
	local function Hook_SetFrameLevel(Button,Level)
		local base = Level or Button:GetFrameLevel()
		for k,v in pairs(Offsets) do
			local frame = Button.__LBF_Level[k]
			if frame then
				frame:SetFrameLevel(base + v)
			end
		end
	end
	-- Applies a skin to a button.
	function ApplySkin(SkinID,Gloss,Backdrop,Color,Button,ButtonData)
		if not Button then return end
		local name = Button:GetName()
		Button.__LBF_Level = Button.__LBF_Level or {}
		-- Level 1: Frame to parent the background texture and icon to.
		if not Button.__LBF_Level[1] then
			local frame1 = CreateFrame("Frame",nil,Button)
			Button.__LBF_Level[1] = frame1
		end
		-- Level 2: Cooldown. This places it above the icon but under the "normal" texture.
		ButtonData.Cooldown = ButtonData.Cooldown or name and _G[name.."Cooldown"]
		if ButtonData.Cooldown then
			Button.__LBF_Level[2] = ButtonData.Cooldown
		end
		-- Level 3: The Button frame.
		Button.__LBF_Level[3] = Button
		-- Level 4: The AutoCast frame.
		ButtonData.AutoCast = ButtonData.AutoCast or name and _G[name.."Shine"]
		if ButtonData.AutoCast then
			Button.__LBF_Level[4] = ButtonData.AutoCast
		end
		-- Level 5: Frame to parent the text layers and AutoCastable/Gloss textures to.
		if not Button.__LBF_Level[5] then
			local frame5 = CreateFrame("Frame",nil,Button)
			Button.__LBF_Level[5] = frame5
		end
		if not hooked[Button] then
			hooksecurefunc(Button,"SetFrameLevel",Hook_SetFrameLevel)
			hooked[Button] = true
		end
		local level = Button:GetFrameLevel()
		if level < 4 then
			level = 4
		end
		Button:SetFrameLevel(level)
		if type(Gloss) ~= "number" then
			Gloss = Gloss and 1 or 0
		end
		Color = Color or empty
		local xScale = (Button:GetWidth() or 36) / 36
		local yScale = (Button:GetHeight() or 36) / 36
		local skin = Skins[SkinID or "Blizzard"] or Skins["Blizzard"]
		for layer in pairs(LayerTypes) do
			if ButtonData[layer] == nil then
				ButtonData[layer] = name and _G[name..layer]
			end
			local btnlayer = ButtonData[layer]
			if btnlayer then
				SkinLayer(skin,Button,layer,btnlayer,xScale,yScale,Color)
			end
		end
		SkinNormalLayer(skin,Button,ButtonData,xScale,yScale,Color)
		SkinHighlightLayer(skin,Button,ButtonData,xScale,yScale,Color)
		SkinPushedLayer(skin,Button,ButtonData,xScale,yScale,Color)
		SkinDisabledLayer(skin,Button,ButtonData,xScale,yScale,Color)
		SkinBorderLayer(skin,Button,ButtonData,xScale,yScale,Color)
		if Button:GetObjectType() == "CheckButton" then
			SkinCheckedLayer(skin,Button,ButtonData,xScale,yScale,Color)
		end
		if Backdrop and not skin.Backdrop.Hide then
			SkinBackdropLayer(skin,Button,xScale,yScale,Color)
		else
			RemoveBackdropLayer(Button)
		end
		if Gloss > 0 and not skin.Gloss.Hide then
			SkinGlossLayer(skin,Button,xScale,yScale,Color,Gloss)
		else
			RemoveGlossLayer(Button)
		end
	end
end

-- [ Groups ] --

-- Returns a group ID. IE: Addon, Addon_Group or Addon_Group_Button.
local function RegID(Addon,Group,Button)
	local id = "ButtonFacade"
	if Addon then
		id = Addon
		if Group then
			id = id.."_"..Group
			if Button then
				id = id.."_"..Button
			end
		end
	end
	return id
end

local Groups = {}
local GroupMT

-- Creates and returns a group.
local function NewGroup(Addon,Group,Button)
	if not Group then Button = nil end
	local o = {
		Addon = Addon,
		Group = Group,
		Button = Button,
		RegID = RegID(Addon,Group,Button),
		SkinID = "Blizzard",
		Gloss = false,
		Backdrop = false,
		Colors = {},
		Buttons = {},
		SubList = not Button and {} or nil,
	}
	setmetatable(o,GroupMT)
	Groups[o.RegID] = o
	if Addon then
		local a = Groups["ButtonFacade"] or NewGroup()
		o.Parent = a
		a:AddSubGroup(Addon)
	end
	if Group then
		local a = Groups[Addon] or NewGroup(Addon)
		o.Parent = a
		a:AddSubGroup(Group)
		if Button then
			local ag = Groups[Addon.."_"..Group] or NewGroup(Addon,Group)
			o.Parent = ag
			ag:AddSubGroup(Button)
		end
	end
	return o
end

-- Returns a group.
function LBF:Group(Addon,Group,Button)
	local group = Groups[RegID(Addon,Group,Button)] or NewGroup(Addon,Group,Button)
	return group
end

-- Returns a list of add-ons.
function LBF:ListAddons()
	local group = self:Group()
	return group.SubList
end

-- Returns a list of groups registered to an add-on.
function LBF:ListGroups(Addon)
	return Groups[Addon].SubList
end

-- Returns a list of buttons registered to a group.
function LBF:ListButtons(Addon,Group)
	return Groups[Addon.."_"..Group].SubList
end

do
	local reverse = {}
	-- Group Metatable
	GroupMT = {
		__index = {
			-- Adds a button to a group. If the button already exists in this group, the method returns. If it exists in another group, it gets reassigned to this group.
			AddButton = function(self,Button,ButtonData,Type)
				if type(Button) ~= "table" then
					error("Bad argument to LBF Group method 'AddButton'. 'Button' must be a table.",2)
				end
				if reverse[Button] == self then return end
				if reverse[Button] then
					reverse[Button]:RemoveButton(Button,true)
				end
				reverse[Button] = self
				ButtonData = ButtonData or {}
				self.Buttons[Button] = ButtonData
				if not Type or not Borders[Type] then Type = "Action" end
				Button.__LBF_Type = Type
				ApplySkin(self.SkinID,self.Gloss,self.Backdrop,self.Colors,Button,ButtonData)
			end,
			-- Removes and optionally reskins a button.
			RemoveButton = function(self,Button,noReskin)
				local btndata = self.Buttons[Button]
				reverse[Button] = nil
				if btndata and not noReskin then
					ApplySkin("Blizzard",false,false,nil,Button,btndata)
				end
				self.Buttons[Button] = nil
			end,
			-- Deletes the current group.
			Delete = function(self,noReskin)
				local sl = self.SubList
				if sl then
					for k in pairs(sl) do
						Groups[k]:Delete()
					end
				end
				for k in pairs(self.Buttons) do
					reverse[k] = nil
					if not noReskin then
						ApplySkin("Blizzard",false,false,nil,k,self.Buttons[k])
					end
					self.Buttons[k] = nil
				end
				self.Parent:RemoveSubGroup(self)
				Groups[self.RegID] = nil
			end,
			-- Updates the groups's skin with the new data and then applies it.
			Skin = function(self,SkinID,Gloss,Backdrop,Colors)
				self.SkinID = SkinID and SkinList[SkinID] or self.SkinID
				if type(Gloss) ~= "number" then
					Gloss = Gloss and 1 or 0
				end
				self.Gloss = Gloss
				self.Backdrop = Backdrop and true or false
				if type(Colors) == "table" then
					self.Colors = Colors
				end
				for k in pairs(self.Buttons) do
					ApplySkin(self.SkinID,self.Gloss,self.Backdrop,self.Colors,k,self.Buttons[k])
				end
				FireSkinCB(self.Addon,self.SkinID,self.Gloss,self.Backdrop,self.Group,self.Button,self.Colors)
				local sl = self.SubList
				if sl then
					for k in pairs(sl) do
						Groups[k]:Skin(SkinID,Gloss,Backdrop,Colors)
					end
				end
			end,
			-- Reskins the group.
			ReSkin = function(self)
				self:Skin(self.SkinID,self.Gloss,self.Backdrop,self.Colors)
			end,
			-- Adds a sub-group to a group.
			AddSubGroup = function(self,SubGroup)
				if self.RegID == "ButtonFacade" then
					self.SubList[SubGroup] = SubGroup
				else
					self.SubList[self.RegID.."_"..SubGroup] = SubGroup
				end
				FireGuiCB(self.Addon,self.Group,self.Button)
			end,
			-- Removes a sub-group from a group.
			RemoveSubGroup = function(self,SubGroup)
				local r = SubGroup.RegID
				self.SubList[r] = nil
				FireGuiCB(self.Addon,self.Group,self.Button)
			end,
			-- Updates the group's skin data without applying the new skin.
			SetSkin = function(self,SkinID,Gloss,Backdrop,Colors)
				self.SkinID = SkinID and SkinList[SkinID] or self.SkinID
				if type(Gloss) ~= "number" then
					Gloss = Gloss and 1 or 0
				end
				self.Gloss = Gloss
				self.Backdrop = Backdrop and true or false
				if type(Colors) == "table" then
					self.Colors = Colors
				end
				FireSkinCB(self.Addon,self.SkinID,self.Gloss,self.Backdrop,self.Group,self.Button,self.Colors)
			end,
			-- Returns a layer's color.
			GetLayerColor = function(self,Layer)
				local skin = Skins[self.SkinID or "Blizzard"] or Skins["Blizzard"]
				return GetLayerColor(skin[Layer],self.Colors,Layer)
			end,
			-- Sets a layer's color and optionally reskins the group.
			SetLayerColor = function(self,Layer,r,g,b,a,noReskin)
				self.Colors = self.Colors or {}
				if r then
					self.Colors[Layer] = {r,g,b,a}
				else
					self.Colors[Layer] = nil
				end
				if not noReskin then self:ReSkin() end
			end,
			-- Returns a border type's color.
			GetBorderColor = function(self,Type)
				local skin = Skins[self.SkinID or "Blizzard"] or Skins["Blizzard"]
				return GetBorderColor(Type,self.Colors,skin.Border)
			end,
			-- Sets a border type's color and optionally reskins the group.
			SetBorderColor = function(self,Type,r,g,b,a,noReskin)
				self.Colors = self.Colors or {}
				self.Colors.Borders = self.Colors.Borders or {}
				if r then
					self.Colors.Borders[Type] = {r,g,b,a}
				else
					self.Colors.Borders[Type] = nil
				end
				if not noReskin then self:ReSkin() end
			end,
			-- Resets a layer's colors.
			ResetColors = function(self,noReskin)
				local c = self.Colors
				for k in pairs(c) do c[k] = nil end
				local sl = self.SubList
				if sl then
					for k in pairs(sl) do
						Groups[k]:ResetColors(true)
					end
				end
				if not noReskin then self:Skin() end
			end,
		}
	}
end

-- [ Default Skin ] --

LBF:AddSkin("Blizzard",{
	Backdrop = {
		Width = 34,
		Height = 35,
		Texture = [[Interface\Buttons\UI-EmptySlot]],
		OffsetY = -0.5,
		TexCoords = {0.2,0.8,0.2,0.8},
	},
	Icon = {
		Width = 36,
		Height = 36,
	},
	Pushed = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
	},
	Flash = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
	},
	Cooldown = {
		Width = 36,
		Height = 36,
	},
	Normal = {
		Width = 66,
		Height = 66,
		Texture = [[Interface\Buttons\UI-Quickslot2]],
		EmptyTexture = [[Interface\Buttons\UI-Quickslot]],
		OffsetY = -1,
	},
	Disabled = {
		Width = 66,
		Height = 66,
		Texture = [[Interface\Buttons\UI-Quickslot2]],
		OffsetY = -1,
	},
	Checked = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		BlendMode = "ADD",
	},
	Border = {
		Width = 62,
		Height = 62,
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		BlendMode = "ADD",
	},
	Highlight = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
		BlendMode = "ADD",
	},
	AutoCast = {
		Width = 36,
		Height = 36,
	},
	AutoCastable = {
		Width = 58,
		Height = 58,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Gloss = {
		Hide = true
	},
	HotKey = {
		Width = 36,
		Height = 10,
		OffsetX = -2,
		OffsetY = 11,
	},
	Count = {
		Width = 36,
		Height = 10,
		OffsetX = -2,
		OffsetY = -11,
	},
	Name = {
		Width = 36,
		Height = 10,
		OffsetY = -11,
	},
})
