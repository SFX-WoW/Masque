--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the project page for Dominos.

	* File...: Skins\Addons\Dominos.lua
	* Author.: Tuller

	'Dominos' Skin

	* This skin is intended for internal use only.

]]

local _, Core = ...

----------------------------------------
-- Internal
---

-- @ Skins\Skins
local LoadSkin = Core.LoadSkin

----------------------------------------
-- Dominos
---

function LoadSkin.Dominos(self)
	self.AddSkin("Dominos", {
		-- Info
		Description = "The default skin for Dominos.",
		Author = "Tuller",

		-- Skin
		Template = "Default",
		Icon = {
			TexCoords = {0.06, 0.94, 0.06, 0.94},
			DrawLayer = "BACKGROUND",
			DrawLevel = 0,
			Width = 36,
			Height = 36,
			Point = "CENTER",
			OffsetX = 0,
			OffsetY = 0,
		},
		Normal = {
			Texture = [[Interface\Buttons\UI-Quickslot2]],
			-- TexCoords = {0, 1, 0, 1},
			Color = {1, 1, 1, 0.5},
			-- EmptyTexture = [[Interface\Buttons\UI-Quickslot2]],
			-- EmptyCoords = {0, 1, 0, 1},
			-- EmptyColor = {1, 1, 1, 0.5},
			BlendMode = "BLEND",
			DrawLayer = "ARTWORK",
			DrawLevel = 0,
			Width = 66,
			Height = 66,
			Point = "CENTER",
			OffsetX = 0,
			OffsetY = 0,
			UseStates = true,
			Pet = {
				Texture = [[Interface\Buttons\UI-Quickslot2]],
				-- TexCoords = {0, 1, 0, 1},
				Color = {1, 1, 1, 0.5},
				-- EmptyTexture = [[Interface\Buttons\UI-Quickslot2]],
				-- EmptyCoords = {0, 1, 0, 1},
				-- EmptyColor = {1, 1, 1, 0.5},
				BlendMode = "BLEND",
				DrawLayer = "ARTWORK",
				DrawLevel = 0,
				Width = 66,
				Height = 66,
				Point = "CENTER",
				OffsetX = 0,
				OffsetY = 0,
				UseStates = true,
			},
			Item = {
				Texture = "Interface\\Buttons\\UI-Quickslot2",
				-- TexCoords = {0, 1, 0, 1},
				Color = {1, 1, 1, 1},
				-- EmptyTexture = [[Interface\Buttons\UI-Quickslot2]],
				-- EmptyCoords = {0, 1, 0, 1},
				-- EmptyColor = {1, 1, 1, 0.5},
				BlendMode = "BLEND",
				DrawLayer = "ARTWORK",
				DrawLevel = 0,
				Width = 62,
				Height = 62,
				Point = "CENTER",
				OffsetX = 0,
				OffsetY = -1,
				UseStates = true,
			},
		},
	}, true)
	LoadSkin.Dominos = nil
end
