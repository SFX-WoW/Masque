--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Locales\zhTW.lua

	zhTW Locale

	[ Notes ]

	To help with translations, use the localization system on WoWAce (https://www.wowace.com/projects/masque/localization)
	or contribute directly on GitHub (https://github.com/stormfx/masque).

]]

-- GLOBALS: GetLocale

if GetLocale() ~= "zhTW" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

L["About Masque"] = "關於按鈕外觀 Masque"
L["API"] = "API"
L["For more information, please visit one of the sites listed below."] = "請拜訪上面列出的網站以獲得更多資訊。"
L["Masque is a skinning engine for button-based add-ons."] = "Masque 是幫插件按鈕更換外觀的引擎。"
-- L["Select to view."] = "Select to view."
L["You must have an add-on that supports Masque installed to use it."] = "必須安裝支援 Masque 按鈕外觀的插件才能使用。"

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
-- L["This section will allow you to view information about Masque and any skins you have installed."] = "This section will allow you to view information about Masque and any skins you have installed."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "每當遭遇插件或是佈景問題都會讓Masque丟出Lua錯誤。"
L["Debug Mode"] = "除錯模式"
-- L["Developer"] = "Developer"
-- L["Developer Settings"] = "Developer Settings"
L["Masque debug mode disabled."] = "Masque 除錯模式已停用。"
L["Masque debug mode enabled."] = "Masque除錯模式已啟用。"
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

L["Author"] = "作者"
L["Authors"] = "作者"
-- L["Click for details."] = "Click for details."
L["Compatible"] = "相容"
L["Description"] = "說明"
L["Incompatible"] = "不相容"
L["Installed Skins"] = "已安裝的外觀"
L["No description available."] = "沒有說明。"
L["Status"] = "狀態"
-- L["The status of this skin is unknown."] = "The status of this skin is unknown."
-- L["This section provides information on any skins you have installed."] = "This section provides information on any skins you have installed."
-- L["This skin is compatible with Masque."] = "This skin is compatible with Masque."
-- L["This skin is outdated and is incompatible with Masque."] = "This skin is outdated and is incompatible with Masque."
-- L["This skin is outdated but is still compatible with Masque."] = "This skin is outdated but is still compatible with Masque."
L["Unknown"] = "未知"
L["Version"] = "版本"
L["Website"] = "網站"
L["Websites"] = "網站"

----------------------------------------
-- Interface Settings
---

L["Enable the Minimap icon."] = "啟用小地圖按鈕。"
-- L["Interface"] = "Interface"
-- L["Interface Settings"] = "Interface Settings"
L["Minimap Icon"] = "小地圖按鈕"
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

L["Profile Settings"] = "設定檔設定"

----------------------------------------
-- Skin Settings
---

L["Backdrop Settings"] = "背景設定"
L["Checked"] = "已勾選"
L["Color"] = "顏色"
L["Colors"] = "顏色"
L["Cooldown"] = "冷卻中"
L["Disable"] = "停用"
L["Disable the skinning of this group."] = "停用這個群組的按鈕外觀。"
L["Disabled"] = "已停用"
L["Enable"] = "啟用"
L["Enable the Backdrop texture."] = "啟用背景材質。"
L["Equipped"] = "已裝備"
L["Flash"] = "閃光"
L["Global"] = "全部"
-- L["Global Settings"] = "Global Settings"
L["Gloss Settings"] = "光澤設定"
L["Highlight"] = "顯著標示"
L["Normal"] = "一般"
L["Opacity"] = "不透明度"
L["Pushed"] = "按下"
L["Reset all skin options to the defaults."] = "重置所有佈景主題為預設值。"
L["Reset Skin"] = "重置佈景主題"
L["Set the color of the Backdrop texture."] = "設定背景材質顏色。"
L["Set the color of the Checked texture."] = "設定已勾選材質顏色。"
L["Set the color of the Cooldown animation."] = "設定冷卻倒數動畫顏色。"
L["Set the color of the Disabled texture."] = "設定已停用材質顏色。"
L["Set the color of the Equipped item texture."] = "設定已裝備物品材質顏色。"
L["Set the color of the Flash texture."] = "設定閃光材質顏色。"
L["Set the color of the Gloss texture."] = "設定光澤材質顏色。"
L["Set the color of the Highlight texture."] = "設定高亮材質顏色。"
L["Set the color of the Normal texture."] = "設定一般材質顏色。"
L["Set the color of the Pushed texture."] = "設定按下材質顏色。"
L["Set the intensity of the Gloss color."] = "設定光澤顏色亮度。"
L["Set the skin for this group."] = "設定佈景主題套用在此群組。"
L["Skin"] = "佈景主題"
-- L["Skin Settings"] = "Skin Settings"
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "This section will allow you to adjust the skin settings of all buttons registered to %s."
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."
-- L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "此區塊允許使用者將註冊在Masque底下的插件按鈕套用佈景主題。"

----------------------------------------
-- Zoomed Skin
---

-- L["A square skin with zoomed icons and a semi-transparent background."] = "A square skin with zoomed icons and a semi-transparent background."
