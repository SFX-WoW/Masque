--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\koKR.lua

	koKR Locale

	[ Notes ]

	To help with translations, use the localization system on WoWAce (https://www.wowace.com/projects/masque/localization)
	or contribute directly on GitHub (https://github.com/SFX-WoW/Masque).

]]

if GetLocale() ~= "koKR" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

-- L["About Masque"] = "About Masque"
-- L["API"] = "API"
-- L["For more information, please visit one of the sites listed below."] = "For more information, please visit one of the sites listed below."
-- L["Masque is a skinning engine for button-based add-ons."] = "Masque is a skinning engine for button-based add-ons."
-- L["Select to view."] = "Select to view."
-- L["You must have an add-on that supports Masque installed to use it."] = "You must have an add-on that supports Masque installed to use it."

----------------------------------------
-- Classic Skin
---

-- L["An improved version of the game's default button style."] = "An improved version of the game's default button style."

----------------------------------------
-- Core Settings
---

-- L["About"] = "About"
-- L["Click to load Masque's options."] = "Click to load Masque's options."
-- L["Load Options"] = "Load Options"
-- L["Masque's options are load on demand. Click the button below to load them."] = "Masque's options are load on demand. Click the button below to load them."
-- L["This action will increase memory usage."] = "This action will increase memory usage."
-- L["This section will allow you to view information about Masque and any skins you have installed."] = "This section will allow you to view information about Masque and any skins you have installed."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Masque가 애드온 혹은 스킨과의 문제에 부닥칠 때마다 언제든지 Lua 오류화하도록 합니다. "
-- L["Clean Database"] = "Clean Database"
-- L["Click to purge the settings of all unused add-ons and groups."] = "Click to purge the settings of all unused add-ons and groups."
L["Debug Mode"] = "디버그 모드"
-- L["Developer"] = "Developer"
-- L["Developer Settings"] = "Developer Settings"
L["Masque debug mode disabled."] = "Masque 디버그 모드를 비활성화합니다."
L["Masque debug mode enabled."] = "Masque 디버그 모드를 활성화합니다."
-- L["This action cannot be undone. Continue?"] = "This action cannot be undone. Continue?"
-- L["This section will allow you to adjust settings that affect working with Masque's API."] = "This section will allow you to adjust settings that affect working with Masque's API."

----------------------------------------
-- Dream Skin
---

-- L["A square skin with trimmed icons and a semi-transparent background."] = "A square skin with trimmed icons and a semi-transparent background."

----------------------------------------
-- General Settings
---

-- L["General Settings"] = "General Settings"
-- L["This section will allow you to adjust Masque's interface and performance settings."] = "This section will allow you to adjust Masque's interface and performance settings."

----------------------------------------
-- Installed Skins
---

-- L["Author"] = "Author"
-- L["Authors"] = "Authors"
-- L["Click for details."] = "Click for details."
-- L["Compatible"] = "Compatible"
-- L["Description"] = "Description"
-- L["Incompatible"] = "Incompatible"
-- L["Installed Skins"] = "Installed Skins"
-- L["No description available."] = "No description available."
-- L["Status"] = "Status"
-- L["The status of this skin is unknown."] = "The status of this skin is unknown."
-- L["This section provides information on any skins you have installed."] = "This section provides information on any skins you have installed."
-- L["This skin is compatible with Masque."] = "This skin is compatible with Masque."
-- L["This skin is outdated and is incompatible with Masque."] = "This skin is outdated and is incompatible with Masque."
-- L["This skin is outdated but is still compatible with Masque."] = "This skin is outdated but is still compatible with Masque."
-- L["Unknown"] = "Unknown"
-- L["Version"] = "Version"
-- L["Website"] = "Website"
-- L["Websites"] = "Websites"

----------------------------------------
-- Interface Settings
---

L["Enable the Minimap icon."] = "미니맵 아이콘을 활성화 합니다."
-- L["Interface"] = "Interface"
-- L["Interface Settings"] = "Interface Settings"
L["Minimap Icon"] = "미니맵 아이콘"
-- L["Stand-Alone GUI"] = "Stand-Alone GUI"
-- L["This section will allow you to adjust settings that affect Masque's interface."] = "This section will allow you to adjust settings that affect Masque's interface."
-- L["Use a resizable, stand-alone options window."] = "Use a resizable, stand-alone options window."

----------------------------------------
-- LDB Launcher
---

-- L["Click to open Masque's settings."] = "Click to open Masque's settings."

----------------------------------------
-- Performance Settings
---

-- L["Click to load reload the interface."] = "Click to load reload the interface."
-- L["Load the skin information panel."] = "Load the skin information panel."
-- L["Performance"] = "Performance"
-- L["Performance Settings"] = "Performance Settings"
-- L["Reload Interface"] = "Reload Interface"
-- L["Requires an interface reload."] = "Requires an interface reload."
-- L["Skin Information"] = "Skin Information"
-- L["This section will allow you to adjust settings that affect Masque's performance."] = "This section will allow you to adjust settings that affect Masque's performance."

----------------------------------------
-- Profile Settings
---

-- L["Profile Settings"] = "Profile Settings"

----------------------------------------
-- Skin Settings
---

L["Backdrop"] = "바탕 설정"
L["Checked"] = "선택된 버튼"
L["Color"] = "색상"
L["Colors"] = "색상"
L["Cooldown"] = "재사용 대기시간"
L["Disable"] = "비활성화"
L["Disable the skinning of this group."] = "이 그룹의 스킨 씌우기를 비활성화합니다."
L["Disabled"] = "비활성화된 버튼"
L["Enable"] = "활성화"
L["Enable the Backdrop texture."] = "바탕 텍스쳐를 활성화합니다."
-- L["Enable the Gloss texture."] = "Enable the Gloss texture."
-- L["Enable the Shadow texture."] = "Enable the Shadow texture."
L["Flash"] = "번쩍임"
L["Global"] = "공통 옵션"
-- L["Global Settings"] = "Global Settings"
L["Gloss"] = "광택 효과 설정"
L["Highlight"] = "강조된 버튼"
L["Normal"] = "평상 시 버튼"
-- L["Pulse"] = "Pulse"
L["Pushed"] = "눌려진 버튼"
L["Reset all skin options to the defaults."] = "모든 색상을 기본값으로 초기화 합니다."
L["Reset Skin"] = "스킨 초기화"
L["Set the color of the Backdrop texture."] = "바탕 텍스쳐의 색상을 설정합니다."
L["Set the color of the Checked texture."] = "선택된 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Cooldown animation."] = "재사용 대기시간 움직임의 색상을 변경합니다."
L["Set the color of the Disabled texture."] = "비활성화된 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Flash texture."] = "번쩍임 텍스처의 색상을 변경합니다."
L["Set the color of the Gloss texture."] = "광택 효과 텍스처의 색상을 변경합니다."
L["Set the color of the Highlight texture."] = "강조된 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Normal texture."] = "평상 시 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Pushed texture."] = "눌려진 버튼 텍스처의 색상을 변경합니다."
-- L["Set the color of the Shadow texture."] = "Set the color of the Shadow texture."
L["Set the skin for this group."] = "이 그룹을 위한 스킨을 설정합니다."
-- L["Shadow"] = "Shadow"
-- L["Show the pulse effect when a cooldown finishes."] = "Show the pulse effect when a cooldown finishes."
L["Skin"] = "스킨"
-- L["Skin Settings"] = "Skin Settings"
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "This section will allow you to adjust the skin settings of all buttons registered to %s."
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."
-- L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "이 항목은 Masque와 함께 등록된 애드온과 애드온 그룹의 버튼의 스킨을 씌울 수 있도록 합니다."

----------------------------------------
-- Zoomed Skin
---

-- L["A square skin with zoomed icons and a semi-transparent background."] = "A square skin with zoomed icons and a semi-transparent background."
