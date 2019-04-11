--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Core\Regions\IconBorder.lua
	* Author.: StormFX

	Texture Regions

	* See Skins\Regions.lua for region defaults.

]]

-- GLOBALS:

local _, Core = ...

----------------------------------------
-- API
---

local hooksecurefunc = hooksecurefunc

----------------------------------------
-- Locals
---

-- @ Core\Utility
local GetSize, SetPoints = Core.GetSize, Core.SetPoints
local GetTexCoords = Core.GetTexCoords

-- @ Core\Core
local SkinRegion = Core.SkinRegion

----------------------------------------
-- Hook
---

-- Hook to counter texture changes.
local function Hook_SetTexture(Region, Texture)
	if Region.__ExitHook or Region.__MSQ_UnHook then
		return
	end

	Region.__ExitHook = true

	local Skin = Region.__MSQ_Skin
	local SkinTexture = Skin.Texture

	if Texture == [[Interface\Artifacts\RelicIconFrame]] then
		SkinTexture = Skin.RelicTexture or SkinTexture or Texture
		Region.__MSQ_Texture = Texture

	else
		SkinTexture = SkinTexture or [[Interface\Common\WhiteIconFrame]]
		Region.__MSQ_Texture = [[Interface\Common\WhiteIconFrame]]
	end

	Region:SetTexture(SkinTexture)
	Region.__ExitHook = nil
end

----------------------------------------
-- Region
---

-- Skins the 'IconBorder' region of a button.
function SkinRegion.IconBorder(Region, Button, Skin, xScale, yScale)
	local UnHook = Button.__MSQ_UnHook
	Region.__MSQ_UnHook = UnHook

	local Texture = Region.__MSQ_Texture or Region:GetTexture()
	Region.__MSQ_Texture = Texture

	local SkinTexture = Skin.Texture

	if Texture == [[Interface\Artifacts\RelicIconFrame]] then
		SkinTexture = Skin.RelicTexture or SkinTexture or Texture
	else
		SkinTexture = SkinTexture or [[Interface\Common\WhiteIconFrame]]
	end

	Region.__MSQ_Skin = Skin

	if not Region.__MSQ_Hooked then
		hooksecurefunc(Region, "SetTexture", Hook_SetTexture)
		Region.__MSQ_Hooked = true
	end

	Hook_SetTexture(Region, SkinTexture)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))

	Region:SetBlendMode(Skin.BlendMode or "BLEND")

	Region:SetDrawLayer(Skin.DrawLayer or "OVERLAY", Skin.DrawLevel or 0)

	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

	SetPoints(Region, Button, Skin, nil, Skin.SetAllPoints)
end
