--[[
	Project.: Masque
	File....: Button.lua
	Version.: @file-revision@
	Author..: StormFX, JJSheets
]]

-- [ Locals ] --

local Masque, Core = ...

if not Core.Loaded then return end

local error, pairs, setmetatable, type, unpack = error, pairs, setmetatable, type, unpack

-- Layer Types
local Layers = {
	Backdrop = "Custom",
	Icon = "Texture",
	Flash = "Texture",
	Cooldown = "Frame",
	Pushed = "Special",
	Normal = "Special",
	Disabled = "Special",
	Checked = "Special",
	Border = "Texture",
	Gloss = "Custom",
	AutoCastable = "Texture",
	Highlight = "Special",
	Name = "Text",
	Count = "Text",
	HotKey = "Text",
	Duration = "Text",
	AutoCast = "Frame",
}

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

-- [ Utility Functions ] --

-- Returns a random table key.
local function Random(v)
	if type(v) == "table" and #v > 1 then
		local i = random(1, #v)
		return v[i]
	end
end

-- Returns a set of color values.
local function GetColor(Color, Alpha)
	if type(Color) == "table" then
		return Color[1] or 1, Color[2] or 1, Color[3] or 1, Alpha or Color[4] or 1
	else
		return 1, 1, 1, Alpha or 1
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

-- [ Skins ] --

local Skins = {}
local SkinList = {}

do
	local Hidden = {Hide = true}

	-- Adds a skin to the skin tables.
	 function Core.Button:AddSkin(SkinID, SkinData, Replace)
		if type(SkinID) ~= "string" then
			if Core.db.profile.Debug then
				error("Bad argument to method 'AddSkin'. 'SkinID' must be a string.", 2)
			end
			return
		end
		if Skins[SkinID] and not Replace then return end
		if type(SkinData) ~= "table" then
			if Core.db.profile.Debug then
				error("Bad argument to method 'AddSkin'. 'SkinData' must be a table.", 2)
			end
			return
		end
		if SkinData.Template then
			if Skins[SkinData.Template] then
				setmetatable(SkinData, {__index=Skins[SkinData.Template]})
			else
				if Core.db.profile.Debug then
					error(("Invalid template reference by skin '%s'. Skin '%s' does not exist."):format(SkinID, SkinData.Template), 2)
				end
				return
			end
		end
		for Layer in pairs(Layers) do
			if type(SkinData[Layer]) ~= "table" then
				SkinData[Layer] = Hidden
			end
		end
		Skins[SkinID] = SkinData
		SkinList[SkinID] = SkinID
	end

	-- Returns the specified skin.
	function Core.Button:GetSkin(SkinID)
		return Skins[SkinID]
	end

	-- Returns the skin data table.
	function Core.Button:GetSkins()
		return Skins
	end

	-- Returns the skin list.
	function Core.Button:ListSkins()
		return SkinList
	end
end

-- [ Backdrop Texture ] --

local SkinBackdrop, RemoveBackdrop

do
	local Backdrop = {}
	local Cache = {}

	-- Removes the Backdrop layer.
	function RemoveBackdrop(Button)
		local Region = Backdrop[Button]
		Backdrop[Button] = nil
		if Region then
			Region:Hide()
			Cache[#Cache + 1] = Region
		end
	end

	-- Skins the Backdrop layer.
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
		Region:SetParent(Button._MSQ_Level[1] or Button)
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

	-- Gets the Backdrop layer.
	function Core.Button:GetBackdrop(Button)
		return Backdrop[Button]
	end
end

-- [ Icon Texture ] --

-- Skins the Icon layer
local function SkinIcon(Button, Region, Skin, xScale, yScale)
	Region:SetParent(Button._MSQ_Level[1] or Button)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetDrawLayer("BORDER", 0)
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 36) * yScale)
	Region:ClearAllPoints()
	Region:SetPoint("CENTER", Button, "CENTER", Skin.OffsetX or 0, Skin.OffsetY or 0)
end

-- [ Normal Texture ] --

local SkinNormal

do
	local Base = {}
	local Hooked = {}

	-- Hook to catch changes to the Normal texture.
	local function Hook_SetNormalTexture(Button, Texture)
		local Region = Button._MSQ_NormalTexture
		local Normal = Button:GetNormalTexture()
		if Button._MSQ_Static then
				Normal:SetTexture("")
				Normal:Hide()
			return
		end
		local Skin = Button._MSQ_NormalSkin
		if Texture == "Interface\\Buttons\\UI-Quickslot2" then
			if Normal ~= Region then
				Normal:SetTexture("")
				Normal:Hide()
			end
			Region:SetTexture(Button._MSQ_Random or Skin.Texture)
			Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
			Region._MSQ_Empty = nil
		elseif Texture == "Interface\\Buttons\\UI-Quickslot" then
			if Normal ~= Region then
				Normal:SetTexture("")
				Normal:Hide()
			end
			if Skin.EmptyTexture then
				Region:SetTexture(Skin.EmptyTexture)
				Region:SetTexCoord(GetTexCoords(Skin.EmptyCoords))
			else
				Region:SetTexture(Button._MSQ_Random or Skin.Texture)
				Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
			end
			Region._MSQ_Empty = true
		end
	end

	-- Skins the Normal layer.
	function SkinNormal(Button, Region, Skin, xScale, yScale, Color)
		Region = Region or Button:GetNormalTexture()
		if Skin.Static then
			if Region then
				Region:SetTexture("")
				Region:Hide()
				Button._MSQ_Static = true
			end
			Region = Base[Button] or Button:CreateTexture()
			Base[Button] = Region
		else
			if Base[Button] then Base[Button]:Hide() end
		end
		if not Region then return end
		Button._MSQ_NormalTexture = Region
		if Skin.Random then -- Random texture
			Button._MSQ_Random = Random(Skin.Textures)
		end
		if (Region:GetTexture() == "Interface\\Buttons\\UI-Quickslot" or Region._MSQ_Empty) and Skin.EmptyTexture then
			Region:SetTexture(Skin.EmptyTexture)
			Region:SetTexCoord(GetTexCoords(Skin.EmptyCoords))
		else
			Region:SetTexture(Button._MSQ_Random or Skin.Texture)
			Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
		end
		if not Hooked[Button] then
			hooksecurefunc(Button, "SetNormalTexture", Hook_SetNormalTexture)
			Hooked[Button] = true
		end
		Button._MSQ_NormalSkin = Skin
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

	-- Gets the Normal texture.
	function Core.Button:GetNormalTexture(Button)
		return Button._MSQ_NormalTexture or Button:GetNormalTexture()
	end
end

-- [ Gloss Texture ] --

local SkinGloss, RemoveGloss

do
	local Gloss = {}
	local Cache = {}

	-- Removes the Gloss layer.
	function RemoveGloss(Button)
		local Region = Gloss[Button]
		Gloss[Button] = nil
		if Region then
			Region:Hide()
			Cache[#Cache+1] = Region
		end
	end

	-- Skins the Gloss layer.
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

	-- Gets the Gloss layer.
	function Core.Button:GetGloss(Button)
		return Gloss[Button]
	end
end

-- [ Other Textures ] --

-- Skins a texture layer.
local function SkinTexture(Button, Region, Layer, Skin, xScale, yScale, Color)
	if Skin.Hide then
		Region:SetTexture("")
		Region:Hide()
		return
	end
	local texture = Skin.Texture or Region:GetTexture()
	Region:SetTexture(texture)
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

-- [ Name Text ] --

-- Skins the Name text.
local function SkinName(Button, Region, Skin, xScale, yScale, Color)
	local font, _, flags = Region:GetFont()
	if not Region._MSQ_Font then
		Region._MSQ_Font = font
	end
	Region:SetFont(Skin.Font or Region._MSQ_Font, Skin.FontSize or 11, flags)
	Region:SetJustifyH(Skin.JustifyH or "CENTER")
	Region:SetJustifyV(Skin.JustifyV or "MIDDLE")
	Region:SetDrawLayer("OVERLAY")
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 10) * yScale)
	Region:ClearAllPoints()
	Region:SetPoint("BOTTOM", Button, "BOTTOM", Skin.OffsetX or 0, Skin.OffsetY or 0)
	Region:SetVertexColor(GetColor(Color or Skin.Color))
end

-- [ Count Text ] --

-- Skins the Count text.
local function SkinCount(Button, Region, Skin, xScale, yScale, Color)
	local font, _, flags = Region:GetFont()
	if not Region._MSQ_Font then
		Region._MSQ_Font = font
	end
	Region:SetFont(Skin.Font or Region._MSQ_Font, Skin.FontSize or 15, flags)
	Region:SetJustifyH(Skin.JustifyH or "RIGHT")
	Region:SetJustifyV(Skin.JustifyV or "MIDDLE")
	Region:SetDrawLayer("OVERLAY")
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 10) * yScale)
	Region:ClearAllPoints()
	Region:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", Skin.OffsetX or 0, Skin.OffsetY or 0)
	Region:SetVertexColor(GetColor(Color or Skin.Color))
end

-- [ HotKey Text ] --

-- Skins the HotKey text.
local function SkinHotKey(Button, Region, Skin, xScale, yScale)
	local font, _, flags = Region:GetFont()
	if not Region._MSQ_Font then
		Region._MSQ_Font = font
	end
	Region:SetFont(Skin.Font or Region._MSQ_Font, Skin.FontSize or 13, flags)
	Region:SetJustifyH(Skin.JustifyH or "RIGHT")
	Region:SetJustifyV(Skin.JustifyV or "MIDDLE")
	Region:SetDrawLayer("OVERLAY")
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 10) * yScale)
	Region:ClearAllPoints()
	if not Region._MSQ_SetPoint then
		Region._MSQ_SetPoint = Region.SetPoint
		Region.SetPoint = function() end
	end
	Region:_MSQ_SetPoint("TOPLEFT", Button, "TOPLEFT", Skin.OffsetX or 0, Skin.OffsetY or 0)
end

-- [ Duration Text ] --

-- Skins the Duration text.
local function SkinDuration(Button, Region, Skin, xScale, yScale, Color)
	local font, _, flags = Region:GetFont()
	if not Region._MSQ_Font then
		Region._MSQ_Font = font
	end
	Region:SetFont(Skin.Font or Region._MSQ_Font, Skin.FontSize or 11, flags)
	Region:SetJustifyH(Skin.JustifyH or "CENTER")
	Region:SetJustifyV(Skin.JustifyV or "MIDDLE")
	Region:SetDrawLayer("OVERLAY")
	Region:SetWidth((Skin.Width or 36) * xScale)
	Region:SetHeight((Skin.Height or 10) * yScale)
	Region:ClearAllPoints()
	Region:SetPoint("TOP", Button, "BOTTOM", Skin.OffsetX or 0, Skin.OffsetY or 0)
	Region:SetVertexColor(GetColor(Color or Skin.Color))
end

-- [ Animation Frames ] --

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

-- [ Skinning Function ] --

local SkinButton

do
	local Hooked = {}
	local Empty = {}

	-- Hook to automatically adjust the button's additional frames.
	local function Hook_SetFrameLevel(Button, Level)
		local base = Level or Button:GetFrameLevel()
		if base < 3 then base = 3 end
		if Button._MSQ_Level[1] then Button._MSQ_Level[1]:SetFrameLevel(base - 2) end
		if Button._MSQ_Level[2] then Button._MSQ_Level[2]:SetFrameLevel(base - 1) end
		if Button._MSQ_Level[4] then Button._MSQ_Level[4]:SetFrameLevel(base + 1) end
	end

	-- Applies a skin to a button and its associated layers.
	function SkinButton(Button, ButtonData, SkinID, Gloss, Backdrop, Colors)
		if not Button then return end
		Button._MSQ_Level = Button._MSQ_Level or {}
		if not Button._MSQ_Level[1] then -- Frame Level 1
			local frame = CreateFrame("Frame", nil, Button)
			Button._MSQ_Level[1] = frame
		end
		Button._MSQ_Level[3] = Button -- Frame Level 3
		if type(Colors) ~= "table" then
			Colors = Empty
		end
		if type(Gloss) ~= "number" then
			Gloss = (Gloss and 1) or 0
		end
		local xScale = (Button:GetWidth() or 36) / 36
		local yScale = (Button:GetHeight() or 36) / 36
		local Skin = (SkinID and Skins[SkinID]) or Skins["Blizzard"]
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
		if ButtonData.Normal then
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
			SkinName(Button, ButtonData.Name, Skin.Name, xScale, yScale, Colors.Name)
		end
		-- Count
		if ButtonData.Count then
			SkinCount(Button, ButtonData.Count, Skin.Count, xScale, yScale, Colors.Count)
		end
		-- HotKey
		if ButtonData.HotKey then
			SkinHotKey(Button, ButtonData.HotKey, Skin.HotKey, xScale, yScale)
		end
		-- Duration
		if ButtonData.Duration then
			SkinDuration(Button, ButtonData.Duration, Skin.Duration, xScale, yScale, Colors.Duration)
		end
		-- Cooldown
		if ButtonData.Cooldown then
			Button._MSQ_Level[2] = ButtonData.Cooldown -- Frame Level 2
			SkinFrame(Button, ButtonData.Cooldown, Skin.Cooldown, xScale, yScale)
		end
		-- AutoCast
		if ButtonData.AutoCast then
			Button._MSQ_Level[4] = ButtonData.AutoCast -- Frame Level 4
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

-- [ Button Groups ] --

local Groups = {}
local GMT

-- Returns a group's ID.
local function GetID(Addon, Group)
	local id = Masque
	if Addon then
		id = Addon
		if Group then
			id = id.."_"..Group
		end
	end
	return id
end

-- Creates, skins and returns a group.
local function NewGroup(Addon, Group)
	local id = GetID(Addon, Group)
	local o = {
		Addon = Addon,
		Group = Group,
		GroupID = id,
		Buttons = {},
		SubList = (not Group and {}) or nil,
		-- Load the skin.
		Disabled = Core.db.profile.Buttons[id].Disabled,
		SkinID = Core.db.profile.Buttons[id].SkinID,
		Gloss = Core.db.profile.Buttons[id].Gloss,
		Backdrop = Core.db.profile.Buttons[id].Backdrop,
		Colors = Core.db.profile.Buttons[id].Colors,
	}
	setmetatable(o, GMT)
	Groups[o.GroupID] = o
	if Addon then
		local Parent = Groups[Masque] or NewGroup()
		o.Parent = Parent
		Parent:AddSubGroup(Addon)
	end
	if Group then
		local Parent = Groups[Addon] or NewGroup(Addon)
		o.Parent = Parent
		Parent:AddSubGroup(Group)
	end
	return o
end

-- Returns a group.
function Core.Button:Group(Addon, SubGroup)
	local Group = Groups[GetID(Addon, SubGroup)] or NewGroup(Addon, SubGroup)
	return Group
end

-- Returns a list of add-ons.
function Core.Button:ListAddons()
	local Group = self:Group()
	return Group.SubList
end

-- Returns a list of groups registered to an add-on.
function Core.Button:ListGroups(Addon)
	return Groups[Addon].SubList
end

-- [ Group Metatable ] --

do
	local Group = {} -- Reverse lookup.

	-- Gets a region.
	local function GetRegion(Button, Layer, Type)
		local Region
		if Type == "Special" then
			local f = Button["Get"..Layer.."Texture"]
			Region = (f and f(Button)) or false
			return Region
		else
			local n = Button:GetName()
			Region = (n and _G[n..Layer]) or false
			return Region
		end
	end

	-- Group Metatable
	GMT = {
		__index = {

			-- Adds a button to the group.
			AddButton = function(self, Button, ButtonData)
				if Group[Button] == self then return end
				if Group[Button] then
					Group[Button]:RemoveButton(Button, true)
				end
				Group[Button] = self
				ButtonData = ButtonData or {}
				for Layer, Type in pairs(Layers) do
					if ButtonData[Layer] == nil and Type ~= "Custom" then
						ButtonData[Layer] = GetRegion(Button, Layer, Type)
					end
				end
				self.Buttons[Button] = ButtonData
				if not self.Disabled then
					SkinButton(Button, ButtonData, self.SkinID, self.Gloss, self.Backdrop, self.Colors)
				end
			end,

			-- Removes a button from the group and optionally resets the skin.
			RemoveButton = function(self, Button, noReset)
				local ButtonData = self.Buttons[Button]
				Group[Button] = nil
				if ButtonData and not noReset then
					SkinButton(Button, ButtonData, "Blizzard", false, false)
				end
				self.Buttons[Button] = nil
			end,

			-- Updates the groups's skin with the new data and then applies it.
			Skin = function(self, SkinID, Gloss, Backdrop, Colors, noSubs)
				self.SkinID = (SkinID and SkinList[SkinID]) or self.SkinID
				if type(Gloss) ~= "number" then
					Gloss = (Gloss and 1) or 0
				end
				self.Gloss = Gloss
				self.Backdrop = (Backdrop and true) or false
				if type(Colors) == "table" then
					self.Colors = Colors
				end
				if not self.Disabled then
					for Button in pairs(self.Buttons) do
						SkinButton(Button, self.Buttons[Button], self.SkinID, self.Gloss, self.Backdrop, self.Colors)
					end
				end
				local Subs = self.SubList
				if Subs and not noSubs then
					for Sub in pairs(Subs) do
						Groups[Sub]:Skin(SkinID, Gloss, Backdrop, Colors)
					end
				end
				self:SaveDB()
			end,

			-- Reskins the group.
			ReSkin = function(self)
				self:Skin(self.SkinID, self.Gloss, self.Backdrop, self.Colors, true)
			end,

			-- Deletes the current group.
			Delete = function(self, noReset)
				local Subs = self.SubList
				if Subs then
					for Sub in pairs(Subs) do
						Groups[Sub]:Delete()
					end
				end
				for Button in pairs(self.Buttons) do
					Group[Button] = nil
					if not noReset then
						SkinButton(Button, self.Buttons[Button], "Blizzard", false, false)
					end
					self.Buttons[Button] = nil
				end
				self.Parent:RemoveSubGroup(self)
				Groups[self.GroupID] = nil
			end,

			-- [ Internal Methods ] --

			-- Adds a sub-group to a group.
			AddSubGroup = function(self, SubGroup)
				if self.GroupID == Masque then
					self.SubList[SubGroup] = SubGroup
				else
					self.SubList[self.GroupID.."_"..SubGroup] = SubGroup
				end
				Core.Button:UpdateOptions(self.Addon)
			end,

			-- Removes a sub-group from a group.
			RemoveSubGroup = function(self, SubGroup)
				local id = SubGroup.GroupID
				self.SubList[id] = nil
				Core.Button:UpdateOptions(self.Addon)
			end,

			-- Saves the current profile.
			SaveDB = function(self)
				Core.db.profile.Buttons[self.GroupID].SkinID = self.SkinID
				Core.db.profile.Buttons[self.GroupID].Gloss = self.Gloss
				Core.db.profile.Buttons[self.GroupID].Backdrop = self.Backdrop
				Core.db.profile.Buttons[self.GroupID].Colors = self.Colors
			end,

			-- GUI Methods --

			-- Disables the group.
			Disable = function(self)
				self.Disabled = true
				Core.db.profile.Buttons[self.GroupID].Disabled = true
				for Button in pairs(self.Buttons) do
					SkinButton(Button, self.Buttons[Button], "Blizzard", false, false)
				end
				local Subs = self.SubList
				if Subs then
					for Sub in pairs(Subs) do
						Groups[Sub]:Disable()
					end
				end
			end,

			-- Enables the group.
			Enable = function(self)
				self.Disabled = false
				Core.db.profile.Buttons[self.GroupID].Disabled = false
				self:ReSkin()
				local Subs = self.SubList
				if Subs then
					for Sub in pairs(Subs) do
						Groups[Sub]:Enable()
					end
				end
			end,

			-- Gets a layer's color.
			GetLayerColor = function(self, Layer)
				local Skin = Skins[self.SkinID or "Blizzard"] or Skins["Blizzard"]
				return GetColor(self.Colors[Layer] or Skin[Layer].Color)
			end,

			-- Sets a layer's color and optionally reskins the group.
			SetLayerColor = function(self, Layer, r, g, b, a)
				if r then
					self.Colors[Layer] = {r, g, b, a}
				else
					self.Colors[Layer] = nil
				end
				if not noReset then
					self:Skin(self.SkinID, self.Gloss, self.Backdrop, self.Colors)
				end
			end,

			-- Resets a layer's colors.
			ResetColors = function(self, noReset)
				local c = self.Colors
				for Sub in pairs(c) do c[Sub] = nil end
				local Subs = self.SubList
				if Subs then
					for Sub in pairs(Subs) do
						Groups[Sub]:ResetColors(true)
					end
				end
				if not noReset then self:Skin() end
			end,
		}
	}
end

-- [ Reload ] --

-- Reloads the button settings on profile activity.
function Core.Button:Reload()
	-- Global Skin
	local CG = self:Group()
	CG.Disabled = Core.db.profile.Buttons.Masque.Disabled
	CG:Skin(Core.db.profile.Buttons.Masque.SkinID, Core.db.profile.Buttons.Masque.Gloss, Core.db.profile.Buttons.Masque.Backdrop, Core.db.profile.Buttons.Masque.Colors, true)

	-- Add-on Skins
	for _, Addon in pairs(self:ListAddons()) do
		local AG = self:Group(Addon)
		local id = AG.GroupID
		AG.Disabled = Core.db.profile.Buttons[id].Disabled
		AG:Skin(Core.db.profile.Buttons[id].SkinID, Core.db.profile.Buttons[id].Gloss, Core.db.profile.Buttons[id].Backdrop, Core.db.profile.Buttons[id].Colors, true)

		-- Group Skins
		for _, Group in pairs(self:ListGroups(Addon)) do
			local SG = self:Group(Addon, Group)
			local sid = SG.GroupID
			SG.Disabled = Core.db.profile.Buttons[sid].Disabled
			SG:Skin(Core.db.profile.Buttons[sid].SkinID, Core.db.profile.Buttons[sid].Gloss, Core.db.profile.Buttons[sid].Backdrop, Core.db.profile.Buttons[sid].Colors)
		end
	end
end
