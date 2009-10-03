--[[
	Project.: LibButtonFacade
	File....: LibButtonFacade.lua
	Version.: @file-revision@
	Author..: JJ Sheets, StormFX
]]

local MAJOR, MINOR = "LibButtonFacade", "3"
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

local regcb = {}

local function fireRegCB(Addon,Group,Button)
	for i = 1, #regcb do local v = regcb[i]
		v.cb(v.arg,Addon,Group,Button)
	end
end

function lib:ElementListCallback(callback,arg)
	regcb[#regcb+1] = {cb = callback, arg = arg}
end

local function regID(Addon,Group,Button)
-- Edit: 5/21
-- 	local r = ""
	local r = "ButtonFacade"
	if Addon then
-- Edit: 5/21
-- 		r = r.."|"..Addon
		r = Addon
		if Group then
-- Edit: 5/21
-- 			r = r.."|"..Group
			r = r.."_"..Group
			if Button then
-- Edit: 5/21
-- 				r = r.."|"..Button
				r = r.."_"..Button
			end
		end
	end
	return r
end

local group_mt

local group = {}

local function newGroup(Addon,Group,Button)
	if not Group then Button = nil end
	local o = {
		Addon = Addon,
		Group = Group,
		Button = Button,
		RegID = regID(Addon,Group,Button),
		SkinID = "Blizzard",
		Gloss = false,
		Backdrop = false,
		Colors = {},
		Buttons = {},
		SubList = not Button and {} or nil,
	}
	setmetatable(o,group_mt)
	group[o.RegID] = o
	if Addon then
-- Edit: 5/21
-- 		local a = group[""] or newGroup()
		local a = group["ButtonFacade"] or newGroup()
		o.Parent = a
		a:AddSubGroup(Addon)
	end
	if Group then
-- Edit: 5/21
-- 		local a = group["|"..Addon] or newGroup(Addon)
		local a = group[Addon] or newGroup(Addon)
		o.Parent = a
		a:AddSubGroup(Group)
		if Button then
-- Edit: 5/21
-- 			local ag = group["|"..Addon.."|"..Group] or newGroup(Addon,Group)
			local ag = group[Addon.."_"..Group] or newGroup(Addon,Group)
			o.Parent = ag
			ag:AddSubGroup(Button)
		end
	end
	return o
end

local gloss = {}
local backdrop = {}
local freegloss = {}
local freebackdrop = {}

local callbacks = {}

local function fireSkinCB(SkinID,Gloss,Backdrop,Addon,Group,Button,Colors)
-- Edit: 5/21
	Addon = Addon or "ButtonFacade"
	local args = callbacks[Addon]
	if args then
		for arg, callback in pairs(args) do
			callback(arg and arg,SkinID,Gloss,Backdrop,Group,Button,Colors)
		end
	end
end

function lib:RegisterSkinCallback(AddonID,callback,arg)
	local arg = callback and arg or false
	callbacks[AddonID] = callbacks[AddonID] or {}
	callbacks[AddonID][arg] = callback
end

local skins = {}
local skinlist = {}
function lib:AddSkin(SkinID,data,overwrite)
	if overwrite == nil then overwrite = true end
	if not overwrite and skins[SkinID] then
		return
	end
	if data.Template then
		if skins[data.Template] then
			setmetatable(data,{__index=skins[data.Template]})
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffccccffButtonFacade: |r|cffff8080ERROR!|r "..SkinID.." is attempting to use "..data.Template.." as a template, but "..data.Template.." doesn't exist!")
			return
		end
	end
	skins[SkinID] = data
	skinlist[SkinID] = SkinID
end

function lib:GetSkins()
	return skins
end

function lib:ListSkins()
	return skinlist
end

-- The list of non-special case Layers.
local layers = {
	"Icon",
	"Flash",
	"Cooldown",
	"AutoCast",
	"AutoCastable",
	"Border",
	"HotKey",
	"Count",
	"Name",
}
local layerTypes = {        -- Draw Layer and frame level.
	Backdrop = "Texture",			-- BACKGROUND 1
	Icon = "Icon",						-- BORDER     1
	Flash = "Texture",				-- OVERLAY    1
	Cooldown = "Model",				--            2
	AutoCast = "Model",				--            3
	Normal = "Special",				-- BORDER     4
	Pushed = "Special",				-- ARTWORK    4
	AutoCastable = "Texture",	-- OVERLAY    4
	Border = "Texture",				-- OVERLAY    4
	Disabled = "Special",			-- OVERLAY    4
	Checked = "Special",			-- OVERLAY    4
	Highlight = "Special",		-- HIGHLIGHT  4
	Gloss = "Texture",				-- OVERLAY    6
	HotKey = "Text",					-- OVERLAY    6
	Count = "Text",						-- OVERLAY    6
	Name = "Text",						-- OVERLAY    6
}
local DrawLayers = {
	Backdrop = "BACKGROUND",
	Icon = "BORDER",
	Border = "OVERLAY",
	Flash = "OVERLAY",
	AutoCastable = "OVERLAY",
	Normal = "BORDER",
	Pushed = "ARTWORK",
	Disabled = "OVERLAY",
	Checked = "OVERLAY",
	Highlight = "HIGHLIGHT",
	Gloss = "OVERLAY",
	HotKey = "OVERLAY",
	Count = "OVERLAY",
	Name = "OVERLAY",
}
local FrameLevels = {
	Backdrop = 1,
	Icon = 1,
	Border = 4,
	Flash = 1,
	Cooldown = 2,
	AutoCast = 3,
	AutoCastable = 4,
	Normal = 4,
	Pushed = 4,
	Disabled = 4,
	Checked = 4,
	Highlight = 4,
	Gloss = 6,
	HotKey = 6,
	Count = 6,
	Name = 6,
}

local defaultTexCoords = {0,1,0,1}

local loopcheck = {}
local function HookSetVertexColor(region,r,g,b,a)
	if loopcheck[region] then loopcheck[region] = nil return end
	loopcheck[region] = true
	local R, G, B, A = region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A
	if R then
		region:SetVertexColor(R*r,G*g,B*b,A*(a or 1))
	end
end

local old_GetVertexColor
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

local function HookSetTextColor(region,r,g,b,a)
	if loopcheck[region] then loopcheck[region] = nil return end
	loopcheck[region] = true
	local R, G, B, A = region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A
	if R then
		region:SetTextColor(R*r,G*g,B*b,A*(a or 1))
	end
end

local old_GetTextColor
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

local hookedregion = {}
local function SetTextureColor(region,r,g,b,a)
	if not old_GetVertexColor then old_GetVertexColor = region.GetVertexColor end
	if region.GetVertexColor ~= HookGetVertexColor then
		hooksecurefunc(region,"SetVertexColor",HookSetVertexColor)
		region.GetVertexColor = HookGetVertexColor
		hookedregion[region] = true
	end
	region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A = r, g, b, a
	loopcheck[region] = true
	region:SetVertexColor(r,g,b,a)
end

local function SetTextColor(region,r,g,b,a)
	if not old_GetTextColor then old_GetTextColor = region.GetTextColor end
	if not hookedregion[region] then
		hooksecurefunc(region,"SetTextColor",HookSetTextColor)
		region.GetTextColor = HookGetTextColor
		hookedregion[region] = true
	end
	region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A = r, g, b, a
	loopcheck[region] = true
	region:SetTextColor(r,g,b,a)
end

local function GetLayerColor(skinlayer,Color,layer,Alpha)
	if Color[layer] then
		return Color[layer][1], Color[layer][2], Color[layer][3], Alpha or Color[layer][4]
	end
	local skincolor = skinlayer.Color
	if skincolor then
		return skincolor[1] or skinlayer.Red or 1,
			skincolor[2] or skinlayer.Green or 1,
			skincolor[3] or skinlayer.Blue or 1,
			Alpha or skincolor[4] or skinlayer.Alpha or 1
	end
	return skinlayer.Red or 1,
		skinlayer.Green or 1,
		skinlayer.Blue or 1,
		Alpha or skinlayer.Alpha or 1
end

local function SkinLayer(skin,button,btndata,layer,btnlayer,xscale,yscale,Color)
	local skinlayer = assert(skin[layer],"Missing layer in skin definition: "..layer)
	if not btnlayer then return end
	local layerType = layerTypes[layer]
	if skinlayer.Hide then
		if layerType == "Texture" then
			btnlayer:SetTexture("")
		end
		btnlayer:Hide()
		return
	end
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	if layerType == "Texture" then
		local parent = button.__bf_framelevel[FrameLevels[layer]]
		btnlayer:SetParent(parent or button)
		btnlayer:SetTexture(skinlayer.Texture)
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
		btnlayer:SetDrawLayer(DrawLayers[layer])
		btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
		SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,layer))
	elseif layerType == "Icon" then
		local parent = button.__bf_framelevel[FrameLevels[layer]]
		btnlayer:SetParent(parent or button)
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
		btnlayer:SetDrawLayer(DrawLayers[layer])
	elseif layerType == "Text" then
		local parent = button.__bf_framelevel[FrameLevels[layer]]
		btnlayer:SetParent(parent or button)
		btnlayer:SetDrawLayer(DrawLayers[layer])
		SetTextColor(btnlayer,GetLayerColor(skinlayer,Color,layer))
	elseif layerType == "Model" then
		local FrameLevel = skinlayer.AboveNormal and 5 or FrameLevels[layer]
		btnlayer:SetFrameLevel(FrameLevel)
		if skinlayer.ModelX or skinlayer.ModelY then
			btnlayer:SetPosition(skinlayer.ModelX or 0, skinlayer.ModelY or 0,0)
		end
		-- HotFix-3.0.2: Disable ModelScale to fix AutoCast (It's not a model anymore).
		-- if skinlayer.ModelScale then
			-- btnlayer:SetModelScale(skinlayer.ModelScale)
		-- end
	end
end

local baselayer = {}
local normalhooked = {}
local function Catch_SetNormalTexture(button,texture)
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

function lib:GetNormalTexture(button)
	return button.__bf_normaltexture or button:GetNormalTexture()
end

function lib:SetNormalVertexColor(button,r,g,b,a)
	local t = button.__bf_normaltexture or button:GetNormalTexture()
	return t:SetVertexColor(r,g,b,a)
end

function lib:GetNormalVertexColor(button)
	local t = button.__bf_normaltexture or button:GetNormalTexture()
	return t:GetVertexColor()
end

local function SkinNormalLayer(skin,button,btndata,xscale,yscale,Color)
	local skinlayer = skin.Normal
	local btnlayer
	if skinlayer.Static and btndata.Normal ~= false then
		btnlayer = btndata.Normal or button:GetNormalTexture()
		if btnlayer then
			btnlayer:SetTexture("")
			btnlayer:Hide()
			button.__bf_nonormaltexture = true
		end
		btnlayer = baselayer[button] or button:CreateTexture()
		baselayer[button] = btnlayer
	else
		btnlayer = btndata.Normal or button:GetNormalTexture()
		if baselayer[button] then baselayer[button]:Hide() end
	end
	if not btnlayer then return end
	button.__bf_normaltexture = btnlayer
	if btnlayer:GetTexture() == "Interface\\Buttons\\UI-Quickslot" or btnlayer.__bf_useEmpty then
		btnlayer:SetTexture(skinlayer.EmptyTexture or skinlayer.Texture)
	else
		btnlayer:SetTexture(skinlayer.Texture)
	end
	-- the following catches when Blizzard changes the texture to the Empty texture.
	if not normalhooked[button] then
		hooksecurefunc(button,"SetNormalTexture",Catch_SetNormalTexture)
    normalhooked[button] = true
	end
	button.__bf_skinlayer = skinlayer
	btnlayer.__bf_skinlayer = skinlayer
	btnlayer:Show()
	if skinlayer.Hide or btndata.Normal == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetDrawLayer(DrawLayers.Normal)
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Normal"))
end

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
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Highlight"))
	btnlayer:SetDrawLayer(DrawLayers.Highlight)
end

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
	btnlayer:SetDrawLayer(DrawLayers.Pushed)
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Pushed"))
end

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
	btnlayer:SetDrawLayer(DrawLayers.Disabled)
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Disabled"))
end

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
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Checked"))
end

local function RemoveGlossLayer(button)
	local layer = gloss[button]
	gloss[button] = nil
	if layer then
		layer:Hide()
		freegloss[#freegloss+1] = layer
	end
end

function lib:GetGlossLayer(button)
	return gloss[button]
end

local function SkinGlossLayer(skin,button,btndata,xscale,yscale,GlossAlpha,Color)
	local skinlayer = skin.Gloss
	local btnlayer
	local freeglossn = #freegloss
	if gloss[button] then
		btnlayer = gloss[button]
	elseif freeglossn > 0 then
		btnlayer = freegloss[freeglossn]
		freegloss[freeglossn] = nil
		btnlayer:SetParent(button)
	else
		btnlayer = button:CreateTexture(nil, "OVERLAY")
	end
	gloss[button] = btnlayer
	local parent = button.__bf_framelevel[FrameLevels.Gloss]
	btnlayer:SetParent(parent or button)
	btnlayer:Show()
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Gloss",GlossAlpha))
	btnlayer:SetDrawLayer(DrawLayers.Gloss)
end

local function RemoveBackdropLayer(button)
	local layer = backdrop[button]
	backdrop[button] = nil
	if layer then
		layer:Hide()
		freebackdrop[#freebackdrop+1] = layer
	end
end

function lib:GetBackdropLayer(button)
	return backdrop[button]
end

local function SkinBackdropLayer(skin,button,btndata,xscale,yscale,Color)
	local skinlayer = skin.Backdrop
	local btnlayer
	local freebackdropn = #freebackdrop
	if backdrop[button] then
		btnlayer = backdrop[button]
	elseif freebackdropn > 0 then
		btnlayer = freebackdrop[freebackdropn]
		freebackdrop[freebackdropn] = nil
		btnlayer:SetParent(button)
	else
		btnlayer = button.__bf_framelevel[1]:CreateTexture(nil,"BACKGROUND")
	end
	backdrop[button] = btnlayer
	local parent = button.__bf_framelevel[FrameLevels.Backdrop]
	btnlayer:SetParent(parent or button)
	btnlayer:Show()
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Backdrop"))
	btnlayer:SetDrawLayer(DrawLayers.Backdrop)
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
end

local emptyColor = {} -- this should be left empty.
local function ApplySkin(SkinID,Gloss,Backdrop,Color,button,btndata)
	if not button then return end
	if type(Gloss) ~= "number" then
		Gloss = Gloss and 1 or 0
	end
	Color = Color or emptyColor
	button:SetFrameLevel(4)
	button.__bf_framelevel = button.__bf_framelevel or {}
	button.__bf_framelevel[4] = button
	btndata.Cooldown = btndata.Cooldown or _G[button:GetName().."Cooldown"]
	-- HotFix-3.0.2: "AutoCast" is now "Shine".
	btndata.AutoCast = btndata.AutoCast or _G[button:GetName().."Shine"]
	if btndata.Cooldown then
		button.__bf_framelevel[2] = btndata.Cooldown
	end
	if btndata.AutoCast then
		button.__bf_framelevel[3] = btndata.AutoCast
	elseif not button.__bf_framelevel[3] then
		local frame3 = CreateFrame("Frame",nil,button)
		frame3:SetAllPoints(button)
		button.__bf_framelevel[3] = frame3
	end
	if not button.__bf_framelevel[1] then
		local frame1 = CreateFrame("Frame",nil,button)
		button.__bf_framelevel[1] = frame1
		frame1:SetFrameLevel(1)
	end
	if not button.__bf_framelevel[5] then
		local frame5 = CreateFrame("Frame",nil,button)
		button.__bf_framelevel[5] = frame5
		frame5:SetFrameLevel(5)
	end
	local xscale = (button:GetWidth() or 36) / 36
	local yscale = (button:GetHeight() or 36) / 36
	local skin = skins[SkinID or "Blizzard"] or skins["Blizzard"]
	-- Cycle through the normal layers and skin as needed.
	for i = 1, #layers do local layer = layers[i]
		if btndata[layer] == nil then
			btndata[layer] = _G[button:GetName()..layer]
		end
		local btnlayer = btndata[layer]
		if btnlayer then
			SkinLayer(skin,button,btndata,layer,btnlayer,xscale,yscale,Color)
		end
	end
	if Gloss > 0 and not skin.Gloss.Hide then
		SkinGlossLayer(skin,button,btndata,xscale,yscale,Gloss,Color)
	elseif gloss[button] then
		RemoveGlossLayer(button)
	end
	if Backdrop and not skin.Backdrop.Hide then
		SkinBackdropLayer(skin,button,btndata,xscale,yscale,Color)
	elseif backdrop[button] then
		RemoveBackdropLayer(button)
	end
	SkinNormalLayer(skin,button,btndata,xscale,yscale,Color)
	SkinHighlightLayer(skin,button,btndata,xscale,yscale,Color)
	SkinPushedLayer(skin,button,btndata,xscale,yscale,Color)
	SkinDisabledLayer(skin,button,btndata,xscale,yscale,Color)
	if button:GetFrameType() == "CheckButton" then
		SkinCheckedLayer(skin,button,btndata,xscale,yscale,Color)
	end
end

--[[ The format of btndata is as follows:

{
	-- any of the following can be omitted or set to nil to have LBF find it from the name of Button.
	-- set any of the following to false to force LBF to not skin that layer.
	Icon = <defaults to _G[Button:GetName().."Icon"]>,
	Cooldown = <defaults to _G[Button:GetName().."Cooldown"]>,
	AutoCast = <defaults to _G[Button:GetName().."Autocast"]>,
	AutoCastable = <defaults to _G[Button:GetName().."AutoCastable"]>,
	HotKey = <defaults to _G[Button:GetName().."HotKey"]>,
	Count = <defaults to _G[Button:GetName().."Count"]>,
	Name = <defaults to _G[Button:GetName().."Name"]>,
}	

--]]

-- the following will create the group if it doesn't exist.
function lib:Group(Addon,Group,Button)
	local g = group[regID(Addon,Group,Button)] or newGroup(Addon,Group,Button)
	return g
end

function lib:DeleteGroup(Addon,Group,Button)
	local g = group[regID(Addon,Group,Button)]
	if g then
		g:Delete()
	end
end

function lib:ListAddons()
	lib:Group()
-- Edit: 5/21
-- 	return group[""].SubList
	return group["ButtonFacade"].SubList
end

function lib:ListGroups(Addon)
-- Edit: 5/21
-- 	return group["|"..Addon].SubList
	return group[Addon].SubList
end

function lib:ListButtons(Addon,Group)
-- Edit: 5/21
-- 	return group["|"..Addon.."|"..Group].SubList
	return group[Addon.."_"..Group].SubList
end

local reverse = {}
local data = {}

group_mt = {
	__index = {
		AddButton = function(self,btn,btndata)
			btndata = btndata or {}
			-- return if we're adding a button we already have.
			if reverse[btn] == self.RegID then return end
			-- remove a button from its current group if necessary
			if reverse[btn] then reverse[btn]:RemoveButton(btn,true) end
			-- store the new group of the button.
			reverse[btn] = self
			-- add the button to our list.
			self.Buttons[btn] = btndata
			ApplySkin(self.SkinID,self.Gloss,self.Backdrop,self.Colors,btn,btndata)
		end,
		RemoveButton = function(self,btn,noReskin)
			local btndata = self.Buttons[btn]
			reverse[btn] = nil
			if btndata and not noReskin then
				ApplySkin("Blizzard",false,false,emptyColor,btn,btndata)
			end
			self.Buttons[btn] = nil
		end,
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
			fireSkinCB(self.SkinID,self.Gloss,self.Backdrop,self.Addon,self.Group,self.Button,self.Colors)
			local sl = self.SubList
			if sl then
				for k in pairs(sl) do
					group[k]:Skin(SkinID,Gloss,Backdrop,ColorLayer,r,g,b,a)
				end
			end
		end,
		SkinGroup = function(self,SkinID,Gloss,Backdrop,ColorLayer,r,g,b,a) -- Added to just change the root group's skin
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
			fireSkinCB(self.SkinID,self.Gloss,self.Backdrop,self.Addon,self.Group,self.Button,self.Colors)
		end,
		SetLayerColor = function(self,Layer,r,g,b,a)
			self.Colors = self.Colors or {}
			if r then
				self.Colors[Layer] = {r,g,b,a}
			else
				self.Colors[Layer] = nil
			end
		end,
		GetLayerColor = function(self,Layer)
			local skin = skins[self.SkinID or "Blizzard"] or skins["Blizzard"]
			return GetLayerColor(skin[Layer],self.Colors,Layer)
		end,
		ResetColors = function(self,noReskin)
			local c = self.Colors
			for k in pairs(c) do c[k] = nil end
			local sl = self.SubList
			if sl then
				for k in pairs(sl) do
					group[k]:ResetColors(true)
				end
			end
			if not noReskin then
				self:Skin()
			end
		end,
		AddSubGroup = function(self,SubGroup)
			local r = self.RegID.."_"..SubGroup
			if self.RegID == "ButtonFacade" then -- Edit: 5/21
				self.SubList[SubGroup] = SubGroup
			else
				self.SubList[r] = SubGroup
			end
			-- group[r].Parent = self
			fireRegCB(self.Addon,self.Group,self.Button)
		end,
		RemoveSubGroup = function(self,SubGroup)
			local r = SubGroup.RegID
			self.SubList[r] = nil
			-- group[r].Parent = nil
			fireRegCB(self.Addon,self.Group,self.Button)
		end,
		--[[ Note, instead of the following, just access the data directly, using group_obj.SkinID, etc.
		GetSkin = function(self)
			return self.SkinID
		end,
		GetGloss = function(self)
			return self.Gloss
		end,
		GetBackdrop = function(self)
			return self.Backdrop
		end,
		
		Also, use group_obj.SubList as the list in a select/choice control.
		--]]
		Delete = function(self,noReskin)
			-- first, Delete all subgroups.
			local sl = self.SubList
			if sl then
				for k in pairs(sl) do
					group[k]:Delete()
				end
			end
			-- next, Remove all Buttons
			for k in pairs(self.Buttons) do
				reverse[k] = nil
				if not noReskin then
					ApplySkin("Blizzard",false,false,nil,k,self.Buttons[k])
				end
				self.Buttons[k] = nil
			end
			-- finally, remove ourselves from our parent group.
			self.Parent:RemoveSubGroup(self)
			group[self.RegID] = nil
		end,
	}
}

lib:AddSkin("Blizzard",{
	Backdrop = {
		Width = 34,
		Height = 35,
		Texture = [[Interface\Buttons\UI-EmptySlot]],
		OffsetY = -0.5,
		TexCoords = {0.2,0.8,0.2,0.8},
		Red = 1,
		Green = 1,
		Blue = 1,
		Alpha = 1,
	},
	Icon = {
		Width = 36,
		Height = 36,
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
	AutoCast = {
		Width = 36,
		Height = 36,
	},
	AutoCastable = {
		Width = 58,
		Height = 58,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Normal = {
		Width = 66,
		Height = 66,
		Texture = [[Interface\Buttons\UI-Quickslot2]],
		EmptyTexture = [[Interface\Buttons\UI-Quickslot]],
		OffsetY = -1,
	},
	Pushed = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
	},
	Disabled = {
		Width = 66,
		Height = 66,
		Texture = [[Interface\Buttons\UI-Quickslot2]],
		OffsetY = -1,
	},
	Highlight = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
		BlendMode = "ADD",
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
