--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the project page for Bartender4.

	* File...: Skins\Addons\Bartender4.lua
	* Author.: Nevcairel

	'Bartender4' Skin

	* This skin is intended for internal use only.

]]

local _, Core = ...

----------------------------------------
-- Internal
---

-- @ Skins\Skins
local LoadSkin = Core.LoadSkin

----------------------------------------
-- Bartender
---

function LoadSkin.Bartender4(self)
	self.AddSkin("Bartender4", {
		-- Info
		Description = "The default skin for Bartender4.",
		Author = "Nevcairel",

		-- Skin
		Template = "Default",
		Normal = {
			Texture = [[Interface\Buttons\UI-Quickslot2]],
			TexCoords = {0, 0, 0, 0},
			Color = {1, 1, 1, 1},
			EmptyTexture = [[Interface\Buttons\UI-Quickslot]],
			EmptyCoords = {-0.15, 1.15, -0.15, 1.17},
			-- EmptyColor = {1, 1, 1, 1},
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
				Color = {1, 1, 1, 1},
				TexCoords = {0, 0, 0, 0},
				EmptyTexture = [[Interface\Buttons\UI-Quickslot]],
				EmptyCoords = {-0.1, 1.1, -0.1, 1.12},
				-- EmptyColor = {1, 1, 1, 1},
				BlendMode = "BLEND",
				DrawLayer = "ARTWORK",
				DrawLevel = 0,
				Width = 64,
				Height = 64,
				Point = "CENTER",
				OffsetX = 0,
				OffsetY = -1,
				UseStates = true,
			},
			Item = {
				Texture = "Interface\\Buttons\\UI-Quickslot2",
				-- TexCoords = {0, 1, 0, 1},
				Color = {1, 1, 1, 1},
				-- EmptyTexture = "Interface\\Buttons\\UI-Quickslot2",
				-- TexCoords = {0, 1, 0, 1},
				-- EmptyColor = {1, 1, 1, 1},
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
		HotKey = {
			JustifyH = "RIGHT",
			JustifyV = "MIDDLE",
			DrawLayer = "ARTWORK",
			Width = 36,
			Height = 10,
			Point = "TOPRIGHT",
			OffsetX = -2,
			OffsetY = -2,
			Pet = {
				JustifyH = "RIGHT",
				JustifyV = "MIDDLE",
				DrawLayer = "ARTWORK",
				Width = 36,
				Height = 10,
				Point = "TOPRIGHT",
				OffsetX = 4,
				OffsetY = -4,
			},
		},
	}, true)
	LoadSkin.Bartender4 = nil
end
