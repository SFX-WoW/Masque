--[[
	Project.: LibButtonFacade
	File....: LibButtonFacade.lua
	Version.: @file-revision@
	Author..: StormFX, JJ Sheets
]]

-- [ LibStub ] --

local MAJOR, MINOR = "LibButtonFacade", 7
local LBF = LibStub:NewLibrary(MAJOR, MINOR)
if not LBF then return end

-- [ Locals ] --

local assert,pairs,setmetatable,type,unpack = assert,pairs,setmetatable,type,unpack

-- [ Call-Backs ] --

local FireGuiCB

do
	local callbacks = {}
	-- Fires all registered GUI call-backs.
	function FireGuiCB(Addon,Group,Button)
		for i = 1, #callbacks do local v = callbacks[i]
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

-- [ Colors ] --

local SetTextureColor

do
	local hooked = {}
	local loopcheck = {}
	local old_GetVertexColor
	-- GetVertexColor post-hook.
	local function HookGetVertexColor(region)
		local R, G, B, A = region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A
		local r,g,b,a = old_GetVertexColor(region)
		if R then
			r = r / R
			g = g / G
			b = b / B
			a = a / A
		end
		return r,g,b,a
	end
	-- SetVertexColor post-hook.
	local function HookSetVertexColor(region,r,g,b,a)
		if loopcheck[region] then loopcheck[region] = nil return end
		loopcheck[region] = true
		local R, G, B, A = region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A
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
			hooked[region] = true
		end
		region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A = r, g, b, a
		loopcheck[region] = true
		region:SetVertexColor(r,g,b,a)
	end
end

local SetTextColor

do
	local hooked = {}
	local loopcheck = {}
	local old_GetTextColor
	-- GetTextColor post-hook.
	local function HookGetTextColor(region,r,g,b,a)
		local R, G, B, A = region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A
		local r,g,b,a = old_GetTextColor(region)
		if R then
			r = r / R
			g = g / G
			b = b / B
			a = a / A
		end
		return r,g,b,a
	end
	-- SetTextColor post-hook.
	local function HookSetTextColor(region,r,g,b,a)
		if loopcheck[region] then loopcheck[region] = nil return end
		loopcheck[region] = true
		local R, G, B, A = region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A
		if R then
			region:SetTextColor(R*r,G*g,B*b,A*(a or 1))
		end
	end
	-- Sets the text color.
	function SetTextColor(region,r,g,b,a)
		if not old_GetTextColor then old_GetTextColor = region.GetTextColor end
		if not hooked[region] then
			hooksecurefunc(region,"SetTextColor",HookSetTextColor)
			region.GetTextColor = HookGetTextColor
			hooked[region] = true
		end
		region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A = r, g, b, a
		loopcheck[region] = true
		region:SetTextColor(r,g,b,a)
	end
end

-- Returns the layer's color table.
local function GetLayerColor(SkinLayer,Color,Layer,Alpha)
	if Color[Layer] then
		return Color[Layer][1] or 1, Color[Layer][2] or 1, Color[Layer][3] or 1, Alpha or Color[Layer][4] or 1
	end
	local skincolor = SkinLayer.Color
	if skincolor then
		return skincolor[1] or SkinLayer.Red or 1,
			skincolor[2] or SkinLayer.Green or 1,
			skincolor[3] or SkinLayer.Blue or 1,
			Alpha or skincolor[4] or SkinLayer.Alpha or 1
	end
	return SkinLayer.Red or 1,
		SkinLayer.Green or 1,
		SkinLayer.Blue or 1,
		Alpha or SkinLayer.Alpha or 1
end

-- [ Layers ] --

local DRAWLAYERS = {
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

-- [ Normal Layer ] --

local SkinNormalLayer

do
	local base = {}
	local hooked = {}
	-- Catch changes to the normal texture.
	local function Hook_SetNormalTexture(button,texture)
		local btnlayer = button.__bf_normaltexture
		local nrmlayer = button:GetNormalTexture()
		if button.__bf_nonormaltexture then
				nrmlayer:SetTexture("")
				nrmlayer:Hide()
			return
		end
		if texture == "Interface\\Buttons\\UI-Quickslot2" then
			if nrmlayer ~= btnlayer then
				nrmlayer:SetTexture("")
				nrmlayer:Hide()
			end
			btnlayer:SetTexture(button.__bf_skinlayer.Texture or "")
			btnlayer.__bf_useEmpty = nil
		elseif texture == "Interface\\Buttons\\UI-Quickslot" then
			if nrmlayer ~= btnlayer then
				nrmlayer:SetTexture("")
				nrmlayer:Hide()
			end
			btnlayer:SetTexture(button.__bf_skinlayer.EmptyTexture or button.__bf_skinlayer.Texture or "")
			btnlayer.__bf_useEmpty = true
		end
	end
	-- Skins the Normal layer.
	function SkinNormalLayer(skin,button,btndata,xscale,yscale,Color)
		local skinlayer = skin.Normal
		local btnlayer
		if skinlayer.Static and btndata.Normal ~= false then
			btnlayer = btndata.Normal or button:GetNormalTexture()
			if btnlayer then
				btnlayer:SetTexture("")
				btnlayer:Hide()
				button.__bf_nonormaltexture = true
			end
			btnlayer = base[button] or button:CreateTexture()
			base[button] = btnlayer
		else
			btnlayer = btndata.Normal or button:GetNormalTexture()
			if base[button] then base[button]:Hide() end
		end
		if not btnlayer then return end
		button.__bf_normaltexture = btnlayer
		if btnlayer:GetTexture() == "Interface\\Buttons\\UI-Quickslot" or btnlayer.__bf_useEmpty then
			btnlayer:SetTexture(skinlayer.EmptyTexture or skinlayer.Texture)
		else
			btnlayer:SetTexture(skinlayer.Texture)
		end
		if not hooked[button] then
			hooksecurefunc(button,"SetNormalTexture",Hook_SetNormalTexture)
			hooked[button] = true
		end
		button.__bf_skinlayer = skinlayer
		btnlayer.__bf_skinlayer = skinlayer
		btnlayer:Show()
		if skinlayer.Hide or btndata.Normal == false then
			btnlayer:SetTexture("")
			btnlayer:Hide()
			return
		end
		btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
		btnlayer:SetDrawLayer(DRAWLAYERS.Normal)
		SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Normal"))
		btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
		btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
		btnlayer:ClearAllPoints()
		btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	end
	-- Gets the Normal texture.
	function LBF:GetNormalTexture(button)
		return button.__bf_normaltexture or button:GetNormalTexture()
	end
	-- Gets the Normal vertex color.
	function LBF:GetNormalVertexColor(button)
		local t = button.__bf_normaltexture or button:GetNormalTexture()
		return t:GetVertexColor()
	end
	-- Sets the Normal vertex color.
	function LBF:SetNormalVertexColor(button,r,g,b,a)
		local t = button.__bf_normaltexture or button:GetNormalTexture()
		return t:SetVertexColor(r,g,b,a)
	end
end

-- [ Highlight Layer ] --

-- Skins the Highlight layer.
local function SkinHighlightLayer(skin,button,btndata,xscale,yscale,Color)
	local skinlayer = skin.Highlight
	local btnlayer = btndata.Highlight or button:GetHighlightTexture()
	if not btnlayer then return end
	if skinlayer.Hide or btndata.Highlight == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	btnlayer:SetDrawLayer(DRAWLAYERS.Highlight)
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Highlight"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
end

-- [ Pushed Layer ] --

-- Skins the Pushed layer.
local function SkinPushedLayer(skin,button,btndata,xscale,yscale,Color)
	local skinlayer = skin.Pushed
	local btnlayer = btndata.Pushed or button:GetPushedTexture()
	if not btnlayer then return end
	if skinlayer.Hide or btndata.Pushed == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetDrawLayer(DRAWLAYERS.Pushed)
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Pushed"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
end

-- [ Disabled Layer ] --

-- Skins the Disabled layer.
local function SkinDisabledLayer(skin,button,btndata,xscale,yscale,Color)
	local skinlayer = skin.Disabled
	local btnlayer = btndata.Disabled or button:GetDisabledTexture()
	if not btnlayer then return end
	if skinlayer.Hide or btndata.Disabled == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	btnlayer:SetDrawLayer(DRAWLAYERS.Disabled)
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Disabled"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
end

-- [ Checked Layer ] --

-- Skins the checked layer.
local function SkinCheckedLayer(skin,button,btndata,xscale,yscale,Color)
	local skinlayer = skin.Checked
	local btnlayer = btndata.Checked or button:GetCheckedTexture()
	if not btnlayer then return end
	if skinlayer.Hide or btndata.Checked == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Checked"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
end

-- [ Custom Layers ] --

local EMPTY = {}
local DEFAULT_COORDS = {0,1,0,1}
local LEVELS = {
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

-- [ Backdrop Layer ] --

local RemoveBackdropLayer,SkinBackdropLayer

do
	local backdrop = {}
	local cache = {}
	-- Removes the backdrop layer.
	function RemoveBackdropLayer(button)
		local layer = backdrop[button]
		backdrop[button] = nil
		if layer then
			layer:Hide()
			cache[#cache+1] = layer
		end
	end
	-- Skins the backdrop layer.
	function SkinBackdropLayer(skin,button,xscale,yscale,Color)
		local skinlayer = skin.Backdrop
		local btnlayer
		local index = #cache
		if backdrop[button] then
			btnlayer = backdrop[button]
		elseif index > 0 then
			btnlayer = cache[index]
			cache[index] = nil
			btnlayer:SetParent(button)
		else
			btnlayer = button:CreateTexture(nil, "OVERLAY")
		end
		backdrop[button] = btnlayer
		local parent = button.__bf_level[LEVELS.Backdrop]
		btnlayer:SetParent(parent or button)
		btnlayer:Show()
		btnlayer:SetTexture(skinlayer.Texture)
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or DEFAULT_COORDS))
		btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
		btnlayer:SetDrawLayer(DRAWLAYERS.Backdrop)
		SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Backdrop"))
		btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
		btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
		btnlayer:ClearAllPoints()
		btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	end
	-- Gets the backdrop layer.
	function LBF:GetBackdropLayer(button)
		return backdrop[button]
	end
end

-- [ Border Layer ] --

local SkinBorderLayer

do
	local border = {}
	-- Hook to set the border's visibility.
	local function Hook_ActionButton_Update(button)
		local btnlayer = border[button]
		if not btnlayer then return end
		if button.__bf_showborder then
			btnlayer:Show()
			return
		end
		if button.action and IsEquippedAction(button.action) then
			btnlayer:Show()
		else
			btnlayer:Hide()
		end
	end
	hooksecurefunc("ActionButton_Update",Hook_ActionButton_Update)
	-- Skins the custom border layer.
	function SkinBorderLayer(skin,button,xscale,yscale,Color)
		local oldlayer = _G[button:GetName().."Border"]
		if not oldlayer then return end
		oldlayer:SetTexture("")
		oldlayer:Hide()
		local skinlayer = skin.Border
		if skinlayer.Hide then return end
		local btnlayer = border[button] or button:CreateTexture(nil,"OVERLAY")
		border[button] = btnlayer
		local parent = button.__bf_level[LEVELS.Border]
		btnlayer:SetParent(parent or button)
		if button:GetObjectType() == "CheckButton" then
			if button.action and IsEquippedAction(button.action) then
				btnlayer:Show()
			else
				btnlayer:Hide()
			end
		else
			btnlayer:Show()
		end
		btnlayer:SetTexture(skinlayer.Texture)
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or DEFAULT_COORDS))
		btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
		btnlayer:SetDrawLayer(DRAWLAYERS.Gloss)
		SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Border"))
		btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
		btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
		btnlayer:ClearAllPoints()
		btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	end
	-- Get the border layer.
	function LBF:GetBorderLayer(button)
		return border[button]
	end
	-- Forces the border layer to be shown.
	function LBF:ShowBorder(button)
		if border[button] then
			button.__bf_showborder = true
		end
	end
	-- Disables the forced showing of the border layer.
	function LBF:HideBorder(button)
		if border[button] then
			button.__bf_showborder = false
		end
	end
	-- Gets the border vertex color.
	function LBF:GetBorderColor(button)
		local t = border[button]
		return t:GetVertexColor()
	end
	-- Set the border vertex color.
	function LBF:SetBorderColor(button,r,g,b,a)
		SetTextureColor(border[button],r,g,b,a)
	end
end

-- [ Gloss Layer ] --

local RemoveGlossLayer,SkinGlossLayer

do
	local gloss = {}
	local cache = {}
	-- Removes the gloss layer.
	function RemoveGlossLayer(button)
		local layer = gloss[button]
		gloss[button] = nil
		if layer then
			layer:Hide()
			cache[#cache+1] = layer
		end
	end
	-- Skins the gloss layer.
	function SkinGlossLayer(skin,button,xscale,yscale,Alpha,Color)
		local skinlayer = skin.Gloss
		local btnlayer
		local index = #cache
		if gloss[button] then
			btnlayer = gloss[button]
		elseif index > 0 then
			btnlayer = cache[index]
			cache[index] = nil
			btnlayer:SetParent(button)
		else
			btnlayer = button:CreateTexture(nil, "OVERLAY")
		end
		gloss[button] = btnlayer
		local parent = button.__bf_level[LEVELS.Gloss]
		btnlayer:SetParent(parent or button)
		btnlayer:Show()
		btnlayer:SetTexture(skinlayer.Texture)
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or DEFAULT_COORDS))
		btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
		btnlayer:SetDrawLayer(DRAWLAYERS.Gloss)
		SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Gloss",Alpha))
		btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
		btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
		btnlayer:ClearAllPoints()
		btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	end
	-- Gets the gloss layer.
	function LBF:GetGlossLayer(button)
		return gloss[button]
	end
end

-- [ Non-Special-Case Layers ] --
local SkinLayer
local OFFSETS = {
	[1] = -2,
	[2] = -1,
	[4] = 1,
	[5] = 2,
}

do
	local types = {
		Icon = "Icon",
		Flash = "Texture",
		Cooldown = "Frame",
		AutoCast = "Frame",
		AutoCastable = "Texture",
		Gloss = "Texture",
		HotKey = "Text",
		Count = "Text",
		Name = "Text",
	}
	-- Skins a non-special-case layer.
	function SkinLayer(skin,button,layer,btnlayer,xscale,yscale,Color)
		local skinlayer = assert(skin[layer],"Missing layer '"..layer.."' in skin definition.")
		if not btnlayer then return end
		local layertype = types[layer]
		if skinlayer.Hide then
			if layertype == "Texture" then
				btnlayer:SetTexture("")
			end
			btnlayer:Hide()
			return
		end
		btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
		btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
		btnlayer:ClearAllPoints()
		btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
		if layertype == "Texture" then
			local parent = button.__bf_level[LEVELS[layer]]
			btnlayer:SetParent(parent or button)
			btnlayer:SetTexture(skinlayer.Texture)
			btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or DEFAULT_COORDS))
			btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
			btnlayer:SetDrawLayer(DRAWLAYERS[layer])
			SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,layer))
		elseif layertype == "Icon" then
			local parent = button.__bf_level[LEVELS[layer]]
			btnlayer:SetParent(parent or button)
			btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or DEFAULT_COORDS))
			btnlayer:SetDrawLayer(DRAWLAYERS[layer])
		elseif layertype == "Text" then
			local parent = button.__bf_level[LEVELS[layer]]
			btnlayer:SetParent(parent or button)
			btnlayer:SetDrawLayer(DRAWLAYERS[layer])
			SetTextColor(btnlayer,GetLayerColor(skinlayer,Color,layer))
		elseif layertype == "Frame" then
		local level = button:GetFrameLevel()
		btnlayer:SetFrameLevel(level + OFFSETS[LEVELS[layer]])
		end
	end
end

-- [ Skins ] --

local SKINS = {}

do
	local skinlist = {}
	-- Adds a skin to the skin tables.
	function LBF:AddSkin(SkinID,data,overwrite)
		if SKINS[SkinID] and not overwrite then
			return
		end
		if data.Template then
			if SKINS[data.Template] then
				setmetatable(data,{__index=SKINS[data.Template]})
			else
				DEFAULT_CHAT_FRAME:AddMessage("|cffccccffButtonFacade: |r|cffff8080ERROR!|r "..SkinID.." is attempting to use "..data.Template.." as a template, but "..data.Template.." doesn't exist!")
				return
			end
		end
		SKINS[SkinID] = data
		skinlist[SkinID] = SkinID
	end
	-- Returns the specified skin.
	function LBF:GetSkin(SkinID)
		return SKINS[SkinID]
	end
	-- Returns the skin data table.
	function LBF:GetSkins()
		return SKINS
	end
	-- Returns the skin list.
	function LBF:ListSkins()
		return skinlist
	end
end

local ApplySkin

do
	local hooked = {}
	local layers = {
		"Icon",
		"Flash",
		"Cooldown",
		"AutoCast",
		"AutoCastable",
		"HotKey",
		"Count",
		"Name",
	}
	-- Hook to automatically adjust the button's additional frames.
	local function Hook_SetFrameLevel(button,level)
		local base = level or button:GetFrameLevel()
		for k,v in pairs(OFFSETS) do
			local frame = button.__bf_level[k]
			if frame then
				frame:SetFrameLevel(base + v)
			end
		end
	end
	-- Applies a skin to a button.
	function ApplySkin(SkinID,Gloss,Backdrop,Color,button,btndata)
		if not button then return end
		button.__bf_level = button.__bf_level or {}
		if not button.__bf_level[1] then
			local frame1 = CreateFrame("Frame",nil,button)
			button.__bf_level[1] = frame1
		end
		btndata.Cooldown = btndata.Cooldown or _G[button:GetName().."Cooldown"]
		if btndata.Cooldown then
			button.__bf_level[2] = btndata.Cooldown
		end
		button.__bf_level[3] = button
		btndata.AutoCast = btndata.AutoCast or _G[button:GetName().."Shine"]
		if btndata.AutoCast then
			button.__bf_level[4] = btndata.AutoCast
		elseif not button.__bf_level[4] then
			local frame4 = CreateFrame("Frame",nil,button)
			frame4:SetAllPoints(button)
			button.__bf_level[4] = frame4
		end
		if not button.__bf_level[5] then
			local frame5 = CreateFrame("Frame",nil,button)
			button.__bf_level[5] = frame5
		end
		if not hooked[button] then
			hooksecurefunc(button,"SetFrameLevel",Hook_SetFrameLevel)
			hooked[button] = true
		end
		local level = button:GetFrameLevel()
		if level < 4 then
			level = 4
		end
		button:SetFrameLevel(level)
		if type(Gloss) ~= "number" then
			Gloss = Gloss and 1 or 0
		end
		Color = Color or EMPTY
		local xscale = (button:GetWidth() or 36) / 36
		local yscale = (button:GetHeight() or 36) / 36
		local skin = SKINS[SkinID or "Blizzard"] or SKINS["Blizzard"]
		for i = 1, #layers do
			local layer = layers[i]
			if btndata[layer] == nil then
				btndata[layer] = _G[button:GetName()..layer]
			end
			local btnlayer = btndata[layer]
			if btnlayer then
				SkinLayer(skin,button,layer,btnlayer,xscale,yscale,Color)
			end
		end
		SkinNormalLayer(skin,button,btndata,xscale,yscale,Color)
		SkinHighlightLayer(skin,button,btndata,xscale,yscale,Color)
		SkinPushedLayer(skin,button,btndata,xscale,yscale,Color)
		SkinDisabledLayer(skin,button,btndata,xscale,yscale,Color)
		SkinBorderLayer(skin,button,xscale,yscale,Color)
		if button:GetObjectType() == "CheckButton" then
			SkinCheckedLayer(skin,button,btndata,xscale,yscale,Color)
		end
		if Backdrop and not skin.Backdrop.Hide then
			SkinBackdropLayer(skin,button,xscale,yscale,Color)
		else
			RemoveBackdropLayer(button)
		end
		if Gloss > 0 and not skin.Gloss.Hide then
			SkinGlossLayer(skin,button,xscale,yscale,Gloss,Color)
		else
			RemoveGlossLayer(button)
		end
	end
end

-- [ Groups ] --

local GROUPS = {}
local GROUP_MT

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
	setmetatable(o,GROUP_MT)
	GROUPS[o.RegID] = o
	if Addon then
		local a = GROUPS["ButtonFacade"] or NewGroup()
		o.Parent = a
		a:AddSubGroup(Addon)
	end
	if Group then
		local a = GROUPS[Addon] or NewGroup(Addon)
		o.Parent = a
		a:AddSubGroup(Group)
		if Button then
			local ag = GROUPS[Addon.."_"..Group] or NewGroup(Addon,Group)
			o.Parent = ag
			ag:AddSubGroup(Button)
		end
	end
	return o
end

-- Returns a group.
function LBF:Group(Addon,Group,Button)
	local g = GROUPS[RegID(Addon,Group,Button)] or NewGroup(Addon,Group,Button)
	return g
end

-- Removes a group.
function LBF:DeleteGroup(Addon,Group,Button)
	local g = GROUPS[RegID(Addon,Group,Button)]
	if g then
		g:Delete()
	end
end

-- Returns a list of add-ons.
function LBF:ListAddons()
	LBF:Group()
	return GROUPS["ButtonFacade"].SubList
end

-- Returns a list of groups registered to an add-on.
function LBF:ListGroups(Addon)
	return GROUPS[Addon].SubList
end

-- Returns a list of buttons registered to a group.
function LBF:ListButtons(Addon,Group)
	return GROUPS[Addon.."_"..Group].SubList
end

do
	local reverse = {}
	-- Group Metatable
	GROUP_MT = {
		__index = {
			-- Adds a button to the group. If the button already exists, it gets reassigned to this group.
			AddButton = function(self,btn,btndata)
				btndata = btndata or {}
				if reverse[btn] == self.RegID then return end
				if reverse[btn] then reverse[btn]:RemoveButton(btn,true) end
				reverse[btn] = self
				self.Buttons[btn] = btndata
				ApplySkin(self.SkinID,self.Gloss,self.Backdrop,self.Colors,btn,btndata)
			end,
			-- Removes and optionally reskins a button.
			RemoveButton = function(self,btn,noReskin)
				local btndata = self.Buttons[btn]
				reverse[btn] = nil
				if btndata and not noReskin then
					ApplySkin("Blizzard",false,false,EMPTY,btn,btndata)
				end
				self.Buttons[btn] = nil
			end,
			-- Updates the groups's skin with the new data and then applies then new skin.
			Skin = function(self,SkinID,Gloss,Backdrop,ColorLayer,r,g,b,a)
				if type(Gloss) ~= "number" then
					Gloss = Gloss and 1 or 0
				end
				if type(ColorLayer) == "table" then
					self.Colors = ColorLayer
				elseif ColorLayer then
					self:SetLayerColor(ColorLayer,r,g,b,a)
				end
				self.SkinID = SkinID or self.SkinID
				self.Gloss = Gloss or self.Gloss
				if type(Backdrop) == "boolean" then
					self.Backdrop = Backdrop
				end
				for k in pairs(self.Buttons) do
					ApplySkin(self.SkinID,self.Gloss,self.Backdrop,self.Colors,k,self.Buttons[k])
				end
				FireSkinCB(self.Addon,self.SkinID,self.Gloss,self.Backdrop,self.Group,self.Button,self.Colors)
				local sl = self.SubList
				if sl then
					for k in pairs(sl) do
						GROUPS[k]:Skin(SkinID,Gloss,Backdrop,ColorLayer,r,g,b,a)
					end
				end
			end,
			-- Updates the group's skin data without applying the new skin.
			SetSkin = function(self,SkinID,Gloss,Backdrop,ColorLayer,r,g,b,a)
				if type(Gloss) ~= "number" then
					Gloss = Gloss and 1 or 0
				end
				if type(ColorLayer) == "table" then
					self.Colors = ColorLayer
				elseif ColorLayer then
					self:SetLayerColor(ColorLayer,r,g,b,a)
				end
				self.SkinID = SkinID or self.SkinID
				self.Gloss = Gloss or self.Gloss
				if type(Backdrop) == "boolean" then
					self.Backdrop = Backdrop
				end
				FireSkinCB(self.Addon,self.SkinID,self.Gloss,self.Backdrop,self.Group,self.Button,self.Colors)
			end,
			-- Sets a layer's color but doesn't apply it.
			SetLayerColor = function(self,Layer,r,g,b,a)
				self.Colors = self.Colors or {}
				if r then
					self.Colors[Layer] = {r,g,b,a}
				else
					self.Colors[Layer] = nil
				end
			end,
			-- Returns a layer's color.
			GetLayerColor = function(self,Layer)
				local skin = SKINS[self.SkinID or "Blizzard"] or SKINS["Blizzard"]
				return GetLayerColor(skin[Layer],self.Colors,Layer)
			end,
			-- Resets a layer's colors.
			ResetColors = function(self,noReskin)
				local c = self.Colors
				for k in pairs(c) do c[k] = nil end
				local sl = self.SubList
				if sl then
					for k in pairs(sl) do
						GROUPS[k]:ResetColors(true)
					end
				end
				if not noReskin then
					self:Skin()
				end
			end,
			-- Adds a sub-group to a group.
			AddSubGroup = function(self,SubGroup)
				local r = self.RegID.."_"..SubGroup
				if self.RegID == "ButtonFacade" then
					self.SubList[SubGroup] = SubGroup
				else
					self.SubList[r] = SubGroup
				end
				FireGuiCB(self.Addon,self.Group,self.Button)
			end,
			-- Removes a sub-group from a group.
			RemoveSubGroup = function(self,SubGroup)
				local r = SubGroup.RegID
				self.SubList[r] = nil
				FireGuiCB(self.Addon,self.Group,self.Button)
			end,
			-- Deletes the self group.
			Delete = function(self,noReskin)
				local sl = self.SubList
				if sl then
					for k in pairs(sl) do
						GROUPS[k]:Delete()
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
				GROUPS[self.RegID] = nil
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
		Color = {0, 1, 0, 0.35},
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
