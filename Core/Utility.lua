--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Utility.lua
	* Author.: StormFX

	Utility Functions

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local _G, type = _G, type

----------------------------------------
-- Miscellaneous
---

-- An empty function.
local function NoOp() end
Core.NoOp = NoOp

----------------------------------------
-- Color
---

-- Returns a set of color values.
function Core.GetColor(Color, Alpha)
	if type(Color) == "table" then
		return Color[1] or 1, Color[2] or 1, Color[3] or 1, Alpha or Color[4] or 1
	else
		return 1, 1, 1, Alpha or 1
	end
end

----------------------------------------
-- Points
---

-- Clears and sets the point(s) for a region.
function Core.ClearSetPoint(Region, Point, Anchor, RelPoint, OffsetX, OffsetY, SetAllPoints)
	Anchor = Anchor or Region:GetParent()

	Region:ClearAllPoints()

	if SetAllPoints then
		Region:SetAllPoints(Anchor)
	else
		Region:SetPoint(Point or "CENTER", Anchor, RelPoint or "CENTER", OffsetX or 0, OffsetY or 0)
	end
end

-- Clears and sets the point(s) for a region using skin data.
function Core.SetSkinPoint(Region, Button, Skin, Default, SetAllPoints)
	local Anchor = Button
	local Skin_Anchor = Skin and Skin.Anchor

	if Skin_Anchor then
		local _mcfg = Button._MSQ_CFG
		local Regions = _mcfg and _mcfg.Regions

		if type(Regions) == "table" then
			Anchor = Regions[Skin_Anchor] or Button
		end
	end

	Region:ClearAllPoints()

	if SetAllPoints then
		Region:SetAllPoints(Anchor)
		return
	end

	local Point, RelPoint = "CENTER", "CENTER"
	local OffsetX, OffsetY = 0, 0

	local SkinData = Skin or Default

	if SkinData then
		if SkinData.Point then
			Point = SkinData.Point
			RelPoint = SkinData.RelPoint or Point
		end

		OffsetX = SkinData.OffsetX or OffsetX
		OffsetY = SkinData.OffsetY or OffsetY
	end

	Region:SetPoint(Point, Anchor, RelPoint, OffsetX, OffsetY)
end

----------------------------------------
-- Texture Coordinates
---

-- Returns a set of texture coordinates.
function Core.GetTexCoords(Coords)
	if type(Coords) == "table" then
		return Coords[1] or 0, Coords[2] or 1, Coords[3] or 0, Coords[4] or 1
	else
		return 0, 1, 0, 1
	end
end

----------------------------------------
-- Group Queue
---

-- Self-destructing table to skin groups created prior to the PLAYER_LOGIN event.
Core.Queue = {
	Cache = {},

	-- Adds a group to the queue.
	Add = function(self, Group)
		self.Cache[#self.Cache + 1] = Group
		Group.Queued = true
	end,

	-- Re-Skins all queued groups.
	ReSkin = function(self)
		for i = 1, #self.Cache do
			local Group = self.Cache[i]

			Group:ReSkin(true)
			Group.Queued = nil
		end

		-- GC
		self.Cache = nil
		Core.Queue = nil
	end,
}

setmetatable(Core.Queue, {__call = Core.Queue.Add})

----------------------------------------
-- Region Finder
---

-- Returns a region for a button that uses a template.
function Core.GetRegion(Button, Info)
	local Key = Info.Key

	-- Key Reference
	if Key then
		local Parent = (Info.Parent and Button[Info.Parent]) or Button

		if type(Parent) == "table" then
			local Region = Parent[Key]

			if type(Region) == "table" then
				local rType = Region.GetObjectType and Region:GetObjectType()

				if rType == Info.Type then
					return Region
				end
			end
		end
	end

	-- Function Reference
	local Func = Info.Func

	if Func then
		local Method = Button[Func]

		if type(Method) == "function" then
			return Method(Button)
		end
	end

	-- Global Reference
	local Name = Info.Name

	if Name then
		local bName = Button.GetName and Button:GetName()

		if bName then
			return _G[bName..Name]
		end
	end
end

----------------------------------------
-- API - Deprecated
---

Core.API.Register = NoOp
