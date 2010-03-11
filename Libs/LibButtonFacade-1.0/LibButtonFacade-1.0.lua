--[[
	Project.: LibButtonFacade
	File....: LibButtonFacade.lua
	Version.: @file-revision@
	Author..: StormFX, JJ Sheets
]]

-- [ LibStub ] --

local MAJOR, MINOR = "LibButtonFacade", "4"
local LBF = LibStub:NewLibrary(MAJOR, MINOR)
if not LBF then return end

-- [ Locals ] --

local assert, setmetatable, AddMessage = assert, setmetatable, DEFAULT_CHAT_FRAME.AddMessage

-- [ GUI Callbacks ] --

-- Table for the GUI callbacks.
local guicb = {}

-- Fires all registered GUI callbacks.
local function fireGuiCB(Addon,Group,Button)
	for i = 1, #guicb do local v = guicb[i]
		v.cb(v.arg,Addon,Group,Button)
	end
end

-- Registers a GUI callback.
function LBF:RegisterGuiCallback(callback,arg)
	guicb[#guicb+1] = {cb = callback, arg = arg}
end

-- [ Group Set Up ] --

-- Returns a group ID. IE: Addon, Addon_Group or Addon_Group_Button.
local function regID(Addon,Group,Button)
	local r = "ButtonFacade"
	if Addon then
		r = Addon
		if Group then
			r = r.."_"..Group
			if Button then
				r = r.."_"..Button
			end
		end
	end
	return r
end

local group_mt
local group = {}

-- Creates and returns a group.
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
		local a = group["ButtonFacade"] or newGroup()
		o.Parent = a
		a:AddSubGroup(Addon)
	end
	if Group then
		local a = group[Addon] or newGroup(Addon)
		o.Parent = a
		a:AddSubGroup(Group)
		if Button then
			local ag = group[Addon.."_"..Group] or newGroup(Addon,Group)
			o.Parent = ag
			ag:AddSubGroup(Button)
		end
	end
	return o
end

-- [ Skin Callbacks ] --

local skincb = {}

-- Fires all callbacks registered for the specified add-on.
local function fireSkinCB(Addon,SkinID,Gloss,Backdrop,Group,Button,Colors)
	Addon = Addon or "ButtonFacade"
	local args = skincb[Addon]
	if args then
		for arg, callback in pairs(args) do
			callback(arg and arg,SkinID,Gloss,Backdrop,Group,Button,Colors)
		end
	end
end

-- Registers a skin callback for the specified add-on.
function LBF:RegisterSkinCallback(Addon,callback,arg)
	local arg = callback and arg or false
	skincb[Addon] = skincb[Addon] or {}
	skincb[Addon][arg] = callback
end

-- [ Skin Lists ] --

local skins = {}
local skinlist = {}

-- Adds a skin to the skin tables.
function LBF:AddSkin(SkinID,data,overwrite)
	if skins[SkinID] and not overwrite then
		return
	end
	if data.Template then
		if skins[data.Template] then
			setmetatable(data,{__index=skins[data.Template]})
		else
			AddMessage("|cffccccffButtonFacade: |r|cffff8080ERROR!|r "..SkinID.." is attempting to use "..data.Template.." as a template, but "..data.Template.." doesn't exist!")
			return
		end
	end
	skins[SkinID] = data
	skinlist[SkinID] = SkinID
end

-- Returns the skin data table.
function LBF:GetSkins()
	return skins
end

-- Returns the skin list.
function LBF:ListSkins()
	return skinlist
end

-- [ Layer Settings ] --

--[[

	The following is a list of all available layers followed by the frame level they're assigned to, their draw layer where applicable
	and any notes. Keep in mind that the layers are listed in order from bottom to top.

	Name          Level          Layer          Notes
	----          -----          -----          -----
	Backdrop        1            BACKGROUND     Custom layer that puts a background image behind the button.
	Icon            1            BORDER         The default spell/skill icon.
	Pushed          4            ARTWORK        The texture displayed when a button is pushed.
	Flash           1            OVERLAY        The blinking texture that appears when an auto attack ability is active.
	Cooldown        2            n/a            The cool down spiral animation frame.
	Normal          4            BORDER         The "normal" or "border" texture that overlays the icon.
	Disabled        4            OVERLAY        The texture used when a button is disabled.
	Checked         4            OVERLAY        The texture used when a button is "checked" or active.
	Border          4            OVERLAY        The equipped color border showed when an item is on an action button.
	Highlight       4            HIGHLIGHT      The the texture shown when the mouse is over the button.
	Autocast        3            n/a            The "on" "sparkle" border animation that is shown on abilities that can be toggled.
	Autocastable    4            OVERLAY        The "off" texture that is shown on abilities that can be toggled.
	Gloss           6            OVERLAY        Custom layer that allows skin to put a gloss or shine on the buttons.
	Hotkey          6            OVERLAY        The hot key text.
	Count           6            OVERLAY        The item count text.
	Name            6            OVERLAY        The macro name text.

--]]

--[[

	List of standard, non-special-case layers that are provided by the default interface. These layers can have various
	attributes modifed, but most importantly their parent or frame level CAN be adjusted.

]]

local Layers = {
	"Icon",
	"Flash",
	"Cooldown",
	"Border",
	"AutoCast",
	"AutoCastable",
	"HotKey",
	"Count",
	"Name",
}

--[[

	List of layer types used to decide what to do with a particular layer. The type "Frame" used to be "Model" but were changed due to
	them no longer being models but animation frames instead. "Special" layers are layers that CAN NOT have their parent or frame level
	adjusted without causing issues.

]]

local LayerTypes = {
	Backdrop = "Texture",
	Icon = "Icon",
	Pushed = "Special",
	Flash = "Texture",
	Cooldown = "Frame",
	Normal = "Special",
	Disabled = "Special",
	Checked = "Special",
	Border = "Special",
	Highlight = "Special",
	AutoCast = "Frame",
	AutoCastable = "Texture",
	Gloss = "Texture",
	HotKey = "Text",
	Count = "Text",
	Name = "Text",
}

-- List of draw layers for textures and text.
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

-- List of frame levels for all layers.
local FrameLevels = {
	Backdrop = 1,
	Icon = 1,
	Pushed = 4,
	Flash = 1,
	Cooldown = 2,
	Normal = 4,
	Disabled = 4,
	Checked = 4,
	Border = 4,
	Highlight = 4,
	AutoCast = 5,
	AutoCastable = 6,
	Gloss = 6,
	HotKey = 6,
	Count = 6,
	Name = 6,
}

-- [ Texture Post-Hooks ] --

local loopcheck = {}

-- SetVertexColor post-hook.
local function HookSetVertexColor(region,r,g,b,a)
	if loopcheck[region] then loopcheck[region] = nil return end
	loopcheck[region] = true
	local R, G, B, A = region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A
	if R then
		region:SetVertexColor(R*r,G*g,B*b,A*(a or 1))
	end
end

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

-- [ Text Post-Hooks ] --

-- SetTextColor post-hook.
local function HookSetTextColor(region,r,g,b,a)
	if loopcheck[region] then loopcheck[region] = nil return end
	loopcheck[region] = true
	local R, G, B, A = region.__bf_R, region.__bf_G, region.__bf_B, region.__bf_A
	if R then
		region:SetTextColor(R*r,G*g,B*b,A*(a or 1))
	end
end

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

-- [ Primary Color-Setting Functions ] --

local hookedregion = {}

-- Sets the texture color.
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

-- Sets the text color.
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

-- Returns the layer's color table.
local function GetLayerColor(skinlayer,Color,layer,Alpha)
	if Color[layer] then
		return Color[layer][1] or 1, Color[layer][2] or 1, Color[layer][3] or 1, Alpha or Color[layer][4] or 1
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

-- [ Layer Skinning Function ] --

local defaultTexCoords = {0,1,0,1}

-- Skins a non-special-case layer.
local function SkinLayer(skin,button,btndata,layer,btnlayer,xscale,yscale,Color)
	local skinlayer = assert(skin[layer],"Missing layer '"..layer.."' in skin definition.")
	if not btnlayer then return end
	local layertype = LayerTypes[layer]
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
		local parent = button.__bf_framelevel[FrameLevels[layer]]
		btnlayer:SetParent(parent or button)
		btnlayer:SetTexture(skinlayer.Texture)
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
		btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
		btnlayer:SetDrawLayer(DrawLayers[layer])
		SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,layer))
	elseif layertype == "Icon" then
		local parent = button.__bf_framelevel[FrameLevels[layer]]
		btnlayer:SetParent(parent or button)
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
		btnlayer:SetDrawLayer(DrawLayers[layer])
	elseif layertype == "Text" then
		local parent = button.__bf_framelevel[FrameLevels[layer]]
		btnlayer:SetParent(parent or button)
		btnlayer:SetDrawLayer(DrawLayers[layer])
		SetTextColor(btnlayer,GetLayerColor(skinlayer,Color,layer))
	elseif layertype == "Frame" then
		btnlayer:SetFrameLevel(FrameLevels[layer])
	end
end

-- [ Special Case Layers ] --

-- [ Normal Layer ] --

local baselayer = {}
local normalhooked = {}

-- Catch changes to the normal texture.
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

-- Gets the normal texture.
function LBF:GetNormalTexture(button)
	return button.__bf_normaltexture or button:GetNormalTexture()
end

-- Sets the normal vertex color.
function LBF:SetNormalVertexColor(button,r,g,b,a)
	local t = button.__bf_normaltexture or button:GetNormalTexture()
	return t:SetVertexColor(r,g,b,a)
end

-- Gets the normal vertex color.
function LBF:GetNormalVertexColor(button)
	local t = button.__bf_normaltexture or button:GetNormalTexture()
	return t:GetVertexColor()
end

-- Skins the normal layer.
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
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	btnlayer:SetDrawLayer(DrawLayers.Normal)
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Normal"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
end

-- [ Highlight Layer ] --

-- Skins the highlight layer.
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
	btnlayer:SetDrawLayer(DrawLayers.Highlight)
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Highlight"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
end

-- [ Pushed Layer ] --

-- Skins the pushed layer.
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
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Pushed"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
end

-- [ Disabled Layer ] --

-- Skins the disabled layer.
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
	btnlayer:SetDrawLayer(DrawLayers.Disabled)
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

-- [ Border Layer ] --

local border = {}
local borderhooked = {}

-- Sets the border's visibility.
local function SetBorderState(button)
	local btnlayer = border[button]
	if button:GetObjectType() == "CheckButton" then
		btnlayer:Hide()
		if button.action and IsEquippedAction(button.action) then
			btnlayer:Show()
		end
	else
		btnlayer:Show()
		if button.filter and button.filter == "HELPFUL" then
			btnlayer:Hide()
		end
	end
end

-- Hook to update the border texture.
local function Hook_BorderUpdate(button)
	if button.__bf_noborder then return end
	SetBorderState(button)
end

-- Gets the custom border layer.
function LBF:GetBorderLayer(button)
	return border[button]
end

-- Set the normal vertex color.
function LBF:SetBorderColor(button,r,g,b,a)
	SetTextureColor(border[button],r,g,b,a)
end

-- Gets the normal vertex color.
function LBF:GetBorderColor(button)
	local t = border[button]
	return t:GetVertexColor()
end

-- Skins the custom border layer.
local function SkinBorderLayer(skin,button,btndata,xscale,yscale,Color)
	local oldlayer = _G[button:GetName().."Border"]
	if oldlayer then
		oldlayer:SetTexture("")
		oldlayer:Hide()
	end
	local skinlayer = skin.Border
	local btnlayer = border[button] or button:CreateTexture(nil,"OVERLAY")
	if skinlayer.Hide then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		button.__bf_noborder = true
		return
	end
	border[button] = btnlayer
	local parent = button.__bf_framelevel[FrameLevels.Border]
	btnlayer:SetParent(parent or button)
	if not borderhooked[button] then
		button:HookScript("OnUpdate",Hook_BorderUpdate)
		borderhooked[button] = true
	end
	btnlayer:Show()
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	btnlayer:SetDrawLayer(DrawLayers.Gloss)
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Border"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	SetBorderState(button)
end

-- [ Gloss Layer ] --

local gloss = {}
local freegloss = {}

-- Removes the gloss layer.
local function RemoveGlossLayer(button)
	local layer = gloss[button]
	gloss[button] = nil
	if layer then
		layer:Hide()
		freegloss[#freegloss+1] = layer
	end
end

-- Gets the gloss layer.
function LBF:GetGlossLayer(button)
	return gloss[button]
end

-- Skins the gloss layer.
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
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	btnlayer:SetDrawLayer(DrawLayers.Gloss)
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Gloss",GlossAlpha))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
end

-- [ Backdrop Layer ] --

local backdrop = {}
local freebackdrop = {}

-- Removes the backdrop layer.
local function RemoveBackdropLayer(button)
	local layer = backdrop[button]
	backdrop[button] = nil
	if layer then
		layer:Hide()
		freebackdrop[#freebackdrop+1] = layer
	end
end

-- Gets the backdrop layer.
function LBF:GetBackdropLayer(button)
	return backdrop[button]
end

-- Skins the backdrop layer.
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
	btnlayer:SetDrawLayer(DrawLayers.Backdrop)
	SetTextureColor(btnlayer,GetLayerColor(skinlayer,Color,"Backdrop"))
	btnlayer:SetWidth((skinlayer.Width or 36) * (skinlayer.Scale or 1) * xscale)
	btnlayer:SetHeight((skinlayer.Height or 36) * (skinlayer.Scale or 1) * yscale)
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
end

-- [ Final Skinning Function ] --

local emptyColor = {}

-- Applies a skin to a button.
local function ApplySkin(SkinID,Gloss,Backdrop,Color,button,btndata)
	if not button then return end
	if type(Gloss) ~= "number" then
		Gloss = Gloss and 1 or 0
	end
	Color = Color or emptyColor
	-- Set the frame level.
	button:SetFrameLevel(4)
	button.__bf_framelevel = button.__bf_framelevel or {}
	-- Assign the button's frame to this level so we can parent textures to it.
	button.__bf_framelevel[4] = button
	btndata.Cooldown = btndata.Cooldown or _G[button:GetName().."Cooldown"]
	btndata.AutoCast = btndata.AutoCast or _G[button:GetName().."Shine"]
	if not button.__bf_framelevel[1] then
		-- Create a new frame to parent textures to for level 1 (background), with its parent being the button.
		local frame1 = CreateFrame("Frame",nil,button)
		button.__bf_framelevel[1] = frame1
		frame1:SetFrameLevel(1)
	end
	if btndata.Cooldown then
		-- Adjust the level of the cooldown frame.
		button.__bf_framelevel[2] = btndata.Cooldown
	end
	if btndata.AutoCast then
		-- Adjust the level of the cooldown frames.
		button.__bf_framelevel[5] = btndata.AutoCast
	elseif not button.__bf_framelevel[5] then
		local frame5 = CreateFrame("Frame",nil,button)
		frame5:SetAllPoints(button)
		button.__bf_framelevel[5] = frame5
	end
	if not button.__bf_framelevel[6] then
		-- Create a new frame to parent the top-most textures and text to.
		local frame6 = CreateFrame("Frame",nil,button)
		button.__bf_framelevel[6] = frame6
		frame6:SetFrameLevel(6)
	end
	local xscale = (button:GetWidth() or 36) / 36
	local yscale = (button:GetHeight() or 36) / 36
	local skin = skins[SkinID or "Blizzard"] or skins["Blizzard"]
	-- Cycle through the normal layers and skin as needed.
	for i = 1, #Layers do local layer = Layers[i]
		if btndata[layer] == nil then
			btndata[layer] = _G[button:GetName()..layer]
		end
		local btnlayer = btndata[layer]
		if btnlayer then
			SkinLayer(skin,button,btndata,layer,btnlayer,xscale,yscale,Color)
		end
	end
	-- Skin the gloss layer.
	if Gloss > 0 and not skin.Gloss.Hide then
		SkinGlossLayer(skin,button,btndata,xscale,yscale,Gloss,Color)
	elseif gloss[button] then
		RemoveGlossLayer(button)
	end
	-- Skin the backdrop layer.
	if Backdrop and not skin.Backdrop.Hide then
		SkinBackdropLayer(skin,button,btndata,xscale,yscale,Color)
	elseif backdrop[button] then
		RemoveBackdropLayer(button)
	end
	-- Skin the "special" layers.
	SkinNormalLayer(skin,button,btndata,xscale,yscale,Color)
	SkinBorderLayer(skin,button,btndata,xscale,yscale,Color)
	SkinHighlightLayer(skin,button,btndata,xscale,yscale,Color)
	SkinPushedLayer(skin,button,btndata,xscale,yscale,Color)
	SkinDisabledLayer(skin,button,btndata,xscale,yscale,Color)
	if button:GetObjectType() == "CheckButton" then
		SkinCheckedLayer(skin,button,btndata,xscale,yscale,Color)
	end
end

--[[

	"btndata" is the layer attribute table for a button. In most cases, the data is provided by the skin. The layers listed below are the exception.
	They can be set to nil to have LBF find it from the name of the button or to false to force them to not be skinned.

	Icon: Defaults to _G[Button:GetName().."Icon"]
	Cooldown: Defaults to _G[Button:GetName().."Cooldown"]
	AutoCast: Ddefaults to _G[Button:GetName().."Autocast"]
	AutoCastable: Defaults to _G[Button:GetName().."AutoCastable"]
	HotKey: Ddefaults to _G[Button:GetName().."HotKey"]
	Count: Ddefaults to _G[Button:GetName().."Count"]
	Name: Defaults to _G[Button:GetName().."Name"]

]]

-- [ Group Methods ] --

-- Returns a group.
function LBF:Group(Addon,Group,Button)
	local g = group[regID(Addon,Group,Button)] or newGroup(Addon,Group,Button)
	return g
end

-- Removes a group.
function LBF:DeleteGroup(Addon,Group,Button)
	local g = group[regID(Addon,Group,Button)]
	if g then
		g:Delete()
	end
end

-- Returns a list of add-ons.
function LBF:ListAddons()
	LBF:Group()
	return group["ButtonFacade"].SubList
end

-- Returns a list of groups registered to an add-on.
function LBF:ListGroups(Addon)
	return group[Addon].SubList
end

-- Returns a list of buttons registered to a group.
function LBF:ListButtons(Addon,Group)
	return group[Addon.."_"..Group].SubList
end

-- [ Group Metatable ] --

-- Reverse look-up table.
local reverse = {}

group_mt = {
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
				ApplySkin("Blizzard",false,false,emptyColor,btn,btndata)
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
			fireSkinCB(self.Addon,self.SkinID,self.Gloss,self.Backdrop,self.Group,self.Button,self.Colors)
			local sl = self.SubList
			if sl then
				for k in pairs(sl) do
					group[k]:Skin(SkinID,Gloss,Backdrop,ColorLayer,r,g,b,a)
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
			fireSkinCB(self.Addon,self.SkinID,self.Gloss,self.Backdrop,self.Group,self.Button,self.Colors)
		end,
		-- Sets a layer's color but doesn't apply it.
		SetLayerColor = function(self,Layer,r,g,b,a,apply)
			self.Colors = self.Colors or {}
			if r then
				self.Colors[Layer] = {r,g,b,a}
			else
				self.Colors[Layer] = nil
			end
		end,
		-- Returns a layer's color.
		GetLayerColor = function(self,Layer)
			local skin = skins[self.SkinID or "Blizzard"] or skins["Blizzard"]
			return GetLayerColor(skin[Layer],self.Colors,Layer)
		end,
		-- Resets a layer's colors.
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
		-- Adds a sub-group to a group.
		AddSubGroup = function(self,SubGroup)
			local r = self.RegID.."_"..SubGroup
			if self.RegID == "ButtonFacade" then
				self.SubList[SubGroup] = SubGroup
			else
				self.SubList[r] = SubGroup
			end
			fireGuiCB(self.Addon,self.Group,self.Button)
		end,
		-- Removes a sub-group from a group.
		RemoveSubGroup = function(self,SubGroup)
			local r = SubGroup.RegID
			self.SubList[r] = nil
			fireGuiCB(self.Addon,self.Group,self.Button)
		end,
		-- Deletes the self group.
		Delete = function(self,noReskin)
			local sl = self.SubList
			if sl then
				for k in pairs(sl) do
					group[k]:Delete()
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
			group[self.RegID] = nil
		end,
	}
}

-- [ Default Skin ] --

LBF:AddSkin("Blizzard",{
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
