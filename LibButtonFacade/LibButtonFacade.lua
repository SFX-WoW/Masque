--[[
Name: LibButtonFacade
Revision: $Revision: 1 $
Author: JJSheets (sheets.jeff@gmail.com)
Documentation: http://
SVN: http://
Description: Button Skinning Tool.
Dependencies: LibStub
License: LGPL v2.1
]]

local MAJOR, MINOR = "LibButtonFacade", "1"
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

local table_sort = table.sort

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
	local r = ""
	if Addon then
		r = r.."|"..Addon
		if Group then
			r = r.."|"..Group
			if Button then
				r = r.."|"..Button
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
		Buttons = {},
		SubList = not Button and {} or nil,
	}
	setmetatable(o,group_mt)
	group[o.RegID] = o
	if Addon then
		local a = group[""] or newGroup()
		o.Parent = a
		a:AddSubGroup(Addon)
	end
	if Group then
		local a = group["|"..Addon] or newGroup(Addon)
		o.Parent = a
		a:AddSubGroup(Group)
		if Button then
			local ag = group["|"..Addon.."|"..Group] or newGroup(Addon,Group)
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
local callbackArgs = {}

local function fireSkinCB(SkinID,Gloss,Backdrop,Addon,Group,Button)
	if callbacks[Addon] then
		callbacks[Addon](callbackArgs[Addon],SkinID,Gloss,Backdrop,Group,Button)
	end
end

function lib:RegisterSkinCallback(AddonID,callback,arg)
	callbacks[AddonID] = callback
	callbackArgs[AddonID] = callback and arg or nil
end

local skins = {}
local skinlist = {}
function lib:AddSkin(SkinID,data,overwrite)
	if overwrite == nil then overwrite = true end
	if not overwrite and skins[SkinID] then
		return
	end
	skins[SkinID] = data
	skinlist[SkinID] = SkinID
	--table_sort(skinlist)
end

function lib:ListSkins()
	return skinlist
end

local texturelayer = {
	Backdrop = "BACKGROUND",
	Icon = "BACKGROUND",
	Flash = "ARTWORK",
	Normal = "ARTWORK", -- NormalTexture, CheckedTexture, HighlightTexture, PushedTexture, and Disabled Texture all use the Border level.
	AutoCastable = "ARTWORK",
	Border = "OVERLAY",
	Gloss = "OVERLAY",
	HotKey = "OVERLAY",
	Count = "OVERLAY",
	Name = "OVERLAY",
}

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
local layerTypes = {
	Backdrop = "Texture",
	Icon = "Icon",
	Flash = "Texture",
	Cooldown = "Model",
	AutoCast = "Model",
	AutoCastable = "Texture",
	Normal = "Special",
	Pushed = "Special",
	Disabled = "Special",
	Highlight = "Special",
	Checked = "Special",
	Gloss = "Texture",
	HotKey = "Text",
	Count = "Text",
	Name = "Text",
}

local defaultTexCoords = {0,1,0,1}

local function SkinLayer(skin,button,btndata,layer,btnlayer)
	local skinlayer = assert(skin[layer],"Missing layer in skin definition: "..layer)
	if not btnlayer then return end
	if skinlayer.Hide then
		btnlayer:Hide()
		return
	end
	btnlayer:SetWidth(skinlayer.Width * (skinlayer.Scale or 1))
	btnlayer:SetHeight(skinlayer.Height * (skinlayer.Scale or 1))
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	local layerType = layerTypes[layer]
	if layerType == "Texture" then
		btnlayer:SetTexture(skinlayer.Texture)
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
		btnlayer:SetDrawLayer(texturelayer[layer])
		btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
		btnlayer:SetVertexColor(skinlayer.Red or 1,skinlayer.Green or 1,skinlayer.Blue or 1,skinlayer.Alpha or 1)
	elseif layerType == "Icon" then
		btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
		btnlayer:SetDrawLayer(texturelayer[layer])
	elseif layerType == "Text" then
		btnlayer:SetDrawLayer(texturelayer[layer])
		btnlayer:SetVertexColor(skinlayer.Red or 1,skinlayer.Green or 1,skinlayer.Blue or 1,skinlayer.Alpha or 1)
	end
end

local normalhooked = {}
local function Catch_SetNormalTexture(button,texture)
	local btnlayer = button:GetNormalTexture()
	if texture == "Interface\\Buttons\\UI-Quickslot2" then
		btnlayer:SetTexture(button.__bf_skinlayer.Texture or "")
		btnlayer.__bf_useEmpty = nil
	elseif texture == "Interface\\Buttons\\UI-Quickslot" then
		btnlayer:SetTexture(button.__bf_skinlayer.EmptyTexture or "")
		btnlayer.__bf_useEmpty = true
	end
end

local function SkinNormalLayer(skin,button,btndata)
	local skinlayer = skin.Normal
	local btnlayer = btndata.Normal or button:GetNormalTexture()
	if not btnlayer then return end
	if skinlayer.Hide or btndata.Normal == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	if btnlayer:GetTexture() == "Interface\\Buttons\\UI-Quickslot" or btnlayer.__bf_useEmpty then
		btnlayer:SetTexture(skinlayer.EmptyTexture)
	else
		btnlayer:SetTexture(skinlayer.Texture)
	end
	-- the following catches when Blizzard changes the texture to the Empty texture.
	if not normalhooked[button] then
		hooksecurefunc(button,"SetNormalTexture",Catch_SetNormalTexture)
	end
	button.__bf_skinlayer = skinlayer
	btnlayer:Show()
	btnlayer:SetDrawLayer("BORDER")
	btnlayer:SetWidth(skinlayer.Width * (skinlayer.Scale or 1))
	btnlayer:SetHeight(skinlayer.Height * (skinlayer.Scale or 1))
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
end

local function SkinHighlightLayer(skin,button,btndata)
	local skinlayer = skin.Highlight
	local btnlayer = btndata.Highlight or button:GetHighlightTexture()
	if not btnlayer then return end
	if skinlayer.Hide or btndata.Highlight == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetWidth(skinlayer.Width * (skinlayer.Scale or 1))
	btnlayer:SetHeight(skinlayer.Height * (skinlayer.Scale or 1))
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	btnlayer:SetVertexColor(skinlayer.Red or 1,skinlayer.Green or 1,skinlayer.Blue or 1,skinlayer.Alpha or 1)
end

local function SkinPushedLayer(skin,button,btndata)
	local skinlayer = skin.Pushed
	local btnlayer = btndata.Pushed or button:GetPushedTexture()
	if not btnlayer then return end
	if skinlayer.Hide or btndata.Pushed == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetDrawLayer("BORDER")
	btnlayer:SetWidth(skinlayer.Width * (skinlayer.Scale or 1))
	btnlayer:SetHeight(skinlayer.Height * (skinlayer.Scale or 1))
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
end

local function SkinDisabledLayer(skin,button,btndata)
	local skinlayer = skin.Disabled
	local btnlayer = btndata.Disabled or button:GetDisabledTexture()
	if not btnlayer then return end
	if skinlayer.Hide or btndata.Disabled == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetDrawLayer("BORDER")
	btnlayer:SetWidth(skinlayer.Width * (skinlayer.Scale or 1))
	btnlayer:SetHeight(skinlayer.Height * (skinlayer.Scale or 1))
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
end

local function SkinCheckedLayer(skin,button,btndata)
	local skinlayer = skin.Checked
	local btnlayer = btndata.Checked or button:GetCheckedTexture()
	if not btnlayer then return end
	if skinlayer.Hide or btndata.Checked == false then
		btnlayer:SetTexture("")
		btnlayer:Hide()
		return
	end
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetWidth(skinlayer.Width * (skinlayer.Scale or 1))
	btnlayer:SetHeight(skinlayer.Height * (skinlayer.Scale or 1))
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	btnlayer:SetVertexColor(skinlayer.Red or 1,skinlayer.Green or 1,skinlayer.Blue or 1,skinlayer.Alpha or 1)
end

local function RemoveGlossLayer(button)
	local layer = gloss[button]
	gloss[button] = nil
	if layer then
		layer:Hide()
		layer:ClearAllPoints()
		freegloss[#freegloss+1] = layer
	end
end

local function SkinGlossLayer(skin,button,btndata)
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
	btnlayer:Show()
	btnlayer:SetWidth(skinlayer.Width * (skinlayer.Scale or 1))
	btnlayer:SetHeight(skinlayer.Height * (skinlayer.Scale or 1))
	btnlayer:ClearAllPoints()
	btnlayer:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	btnlayer:SetVertexColor(skinlayer.Red or 1,skinlayer.Green or 1,skinlayer.Blue or 1,skinlayer.Alpha or 1)
	btnlayer:SetDrawLayer("OVERLAY")
end

local function RemoveBackdropLayer(button)
	local layer = backdrop[button]
	backdrop[button] = nil
	if layer then
		layer.frame:Hide()
		layer.frame:ClearAllPoints()
		freebackdrop[#freebackdrop+1] = layer
	end
end

local function SkinBackdropLayer(skin,button,btndata)
	local skinlayer = skin.Backdrop
	local btnlayer
	local freebackdropn = #freebackdrop
	if backdrop[button] then
		btnlayer = backdrop[button]
	elseif freebackdropn > 0 then
		btnlayer = freebackdrop[freebackdropn]
		freebackdrop[freebackdropn] = nil
		btnlayer.frame:SetParent(button)
	else
		local frame = CreateFrame("Frame",nil,button)
		btnlayer = frame:CreateTexture(nil,"BACKGROUND")
		btnlayer.frame = frame
		btnlayer:ClearAllPoints()
		btnlayer:SetAllPoints(button)
	end
	backdrop[button] = btnlayer
	--btnlayer.frame:SetFrameStrata("PARENT")
	btnlayer.frame:SetFrameLevel(0)
	btnlayer.frame:Show()
	btnlayer:Show()
	btnlayer.frame:SetWidth(skinlayer.Width * (skinlayer.Scale or 1))
	btnlayer.frame:SetHeight(skinlayer.Height * (skinlayer.Scale or 1))
	btnlayer.frame:ClearAllPoints()
	btnlayer.frame:SetPoint("CENTER",button,"CENTER",skinlayer.OffsetX or 0,skinlayer.OffsetY or 0)
	btnlayer:SetTexture(skinlayer.Texture)
	btnlayer:SetTexCoord(unpack(skinlayer.TexCoords or defaultTexCoords))
	btnlayer:SetBlendMode(skinlayer.BlendMode or "BLEND")
	btnlayer:SetVertexColor(skinlayer.Red or 1,skinlayer.Green or 1,skinlayer.Blue or 1,skinlayer.Alpha or 1)
	btnlayer:SetDrawLayer("BACKGROUND")
end

local function ApplySkin(SkinID,Gloss,Backdrop,button,btndata)
	if not button then return end
	local skin = skins[SkinID or "Blizzard"] or skins["Blizzard"]
	-- Cycle through the normal layers and skin as needed.
	for i = 1, #layers do local layer = layers[i]
		if btndata[layer] == nil then
			btndata[layer] = _G[button:GetName()..layer]
		end
		btnlayer = btndata[layer]
		if btnlayer then
			SkinLayer(skin,button,btndata,layer,btnlayer)
		end
	end
	if Gloss and not skin.Gloss.Hide then
		SkinGlossLayer(skin,button,btndata)
	elseif gloss[button] then
		RemoveGlossLayer(button)
	end
	if Backdrop and not skin.Backdrop.Hide then
		SkinBackdropLayer(skin,button,btndata)
	elseif backdrop[button] then
		RemoveBackdropLayer(button)
	end
	SkinNormalLayer(skin,button,btndata) -- Uses the Border Layer info.
	SkinHighlightLayer(skin,button,btndata)
	SkinPushedLayer(skin,button,btndata)
	SkinDisabledLayer(skin,button,btndata)
	if button:GetFrameType() == "CheckButton" then
		SkinCheckedLayer(skin,button,btndata)
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
	return group[""].SubList
end

function lib:ListGroups(Addon)
	return group["|"..Addon].SubList
end

function lib:ListButtons(Addon,Group)
	return group["|"..Addon.."|"..Group].SubList
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
			self.Buttons[btn] = true
			data[btn] = btndata
			ApplySkin(self.SkinID,self.Gloss,self.Backdrop,btn,btndata)
		end,
		RemoveButton = function(self,btn,noReskin)
			reverse[btn] = nil
			self.Buttons[btn] = nil
			if not noReskin then -- damn that sounds redneck...
				ApplySkin("Blizzard",false,false,btn,data[btn])
				data[btn] = nil
			end
		end,
		Skin = function(self,SkinID,Gloss,Backdrop)
			for k in pairs(self.Buttons) do
				ApplySkin(SkinID,Gloss,Backdrop,k,data[k])
			end
			self.SkinID = SkinID
			self.Gloss = Gloss
			self.Backdrop = Backdrop
			fireSkinCB(SkinID,Gloss,Backdrop,self.Addon,self.Group,self.Button)
			local sl = self.SubList
			if sl then
				for k in pairs(sl) do
					group[k]:Skin(SkinID,Gloss,Backdrop)
				end
			end
		end,
		AddSubGroup = function(self,SubGroup)
			local r = self.RegID.."|"..SubGroup
			self.SubList[r] = SubGroup
			--group[r].Parent = self
			fireRegCB(self.Addon,self.Group,self.Button)
		end,
		RemoveSubGroup = function(self,SubGroup)
			local r = SubGroup.RegID
			self.SubList[r] = nil
			--group[r].Parent = nil
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
		Delete = function(self)
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
				self.Buttons[k] = nil
				ApplySkin("Blizzard",false,false,k,data[k])
			end
			-- finally, remove ourselves from our parent group.
			Parent:RemoveSubGroup(self)
		end,
	}
}

lib:AddSkin("Blizzard",{
	Backdrop = {
		Hide = true
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
		EmptyTexture = [[Interface\Buttons\UI=Quickslot]],
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

lib:AddSkin("Zoomed",{
	Backdrop = {
		Hide = true,
	},
	Icon = {
		Width = 36,
		Height = 36,
		TexCoords = {0.07,0.93,0.07,0.93},
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
		Hide = true,
	},
	Pushed = {
		Hide = true,
	},
	Disabled = {
		Hide = true,
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

lib:AddSkin("DreamLayout",{
	Backdrop = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Tooltips\UI-Tooltip-Background]],
		Red = 0,
		Green = 0,
		Blue = 0,
		Alpha = 0.6,
	},
	Icon = {
		Width = 30,
		Height = 30,
		TexCoords = {0.07,0.93,0.07,0.93},
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
		Hide = true,
	},
	Pushed = {
		Hide = true,
	},
	Disabled = {
		Hide = true,
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
