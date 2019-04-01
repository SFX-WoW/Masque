--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Locales\zhCN.lua

	zhCN Locale

	[ Notes ]

	To help with translations, use the localization system on WoWAce (https://www.wowace.com/projects/masque/localization)
	or contribute directly on GitHub (https://github.com/stormfx/masque).

]]

-- GLOBALS: GetLocale

if GetLocale() ~= "zhCN" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

L["About Masque"] = "关于Masque"
-- L["API"] = "API"
L["For more information, please visit one of the sites listed below."] = "查阅更多信息，请访问下边列表中的网页站点。"
-- L["Masque is a skinning engine for button-based add-ons."] = "Masque is a skinning engine for button-based add-ons."
L["Select to view."] = "选择来演示"
L["You must have an add-on that supports Masque installed to use it."] = "你必须有一个已安装的Masque类皮肤附加插件才能启用。"

----------------------------------------
-- Classic Skin
---

-- L["An improved version of the game's default button style."] = "An improved version of the game's default button style."

----------------------------------------
-- Core Settings
---

L["About"] = "关于"
L["Click to load Masque's options."] = "点击载入Masque选项。"
L["Load Options"] = "载入选项"
-- L["Masque's options are load on demand. Click the button below to load them."] = "Masque's options are load on demand. Click the button below to load them."
-- L["This section will allow you to view information about Masque and any skins you have installed."] = "This section will allow you to view information about Masque and any skins you have installed."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "无论何时 Masque 遇到了一个插件问题或者皮肤问题，都让其屏蔽 Lua 错误。"
L["Debug Mode"] = "调试模式"
L["Developer"] = "开发者"
L["Developer Settings"] = "开发者设置"
L["Masque debug mode disabled."] = "Masque 调试模式禁用。"
L["Masque debug mode enabled."] = "Masque 调试模式启用。"
-- L["This section will allow you to adjust settings that affect working with Masque's API."] = "This section will allow you to adjust settings that affect working with Masque's API."

----------------------------------------
-- Dream Skin
---

-- L["A square skin with trimmed icons and a semi-transparent background."] = "A square skin with trimmed icons and a semi-transparent background."

----------------------------------------
-- General Settings
---

L["General Settings"] = "一般设置"
-- L["This section will allow you to adjust Masque's interface and performance settings."] = "This section will allow you to adjust Masque's interface and performance settings."

----------------------------------------
-- Installed Skins
---

L["Author"] = "作者"
L["Authors"] = "作者"
L["Click for details."] = "点击查看更多信息。"
L["Compatible"] = "兼容"
L["Description"] = "描述"
L["Incompatible"] = "不兼容"
L["Installed Skins"] = "已安装皮肤包"
L["No description available."] = "没有可用的描述"
L["Status"] = "状态"
-- L["The status of this skin is unknown."] = "The status of this skin is unknown."
-- L["This section provides information on any skins you have installed."] = "This section provides information on any skins you have installed."
-- L["This skin is compatible with Masque."] = "This skin is compatible with Masque."
-- L["This skin is outdated and is incompatible with Masque."] = "This skin is outdated and is incompatible with Masque."
-- L["This skin is outdated but is still compatible with Masque."] = "This skin is outdated but is still compatible with Masque."
L["Unknown"] = "未知"
L["Version"] = "版本"
L["Website"] = "网站"
L["Websites"] = "网页站点"

----------------------------------------
-- Interface Settings
---

L["Enable the Minimap icon."] = "启用小地图图标。"
L["Interface"] = "界面"
L["Interface Settings"] = "界面设置"
L["Minimap Icon"] = "小地图图标"
L["Stand-Alone GUI"] = "独立的GUI"
-- L["This section will allow you to adjust settings that affect Masque's interface."] = "This section will allow you to adjust settings that affect Masque's interface."
L["Use a resizable, stand-alone options window."] = "使用可调整大小的独立选项窗口。"

----------------------------------------
-- LDB Launcher
---

L["Click to open Masque's settings."] = "点击打开Masque的设置。"

----------------------------------------
-- Performance Settings
---

L["Click to load reload the interface."] = "点击重载当前界面。"
L["Load the skin information panel."] = "载入这个皮肤信息面板"
L["Performance"] = "性能"
L["Performance Settings"] = "性能设置"
L["Reload Interface"] = "重载界面"
L["Requires an interface reload."] = "需要重载当前界面才能生效。"
L["Skin Information"] = "皮肤信息"
-- L["This section will allow you to adjust settings that affect Masque's performance."] = "This section will allow you to adjust settings that affect Masque's performance."

----------------------------------------
-- Profile Settings
---

L["Profile Settings"] = "档案设置"

----------------------------------------
-- Skin Settings
---

L["Backdrop"] = "背景设置"
L["Checked"] = "已选中"
L["Color"] = "颜色"
L["Colors"] = "颜色"
L["Cooldown"] = "冷却"
L["Disable"] = "禁用"
L["Disable the skinning of this group."] = "禁用此群组换肤。"
L["Disabled"] = "已禁用"
L["Enable"] = "启用"
L["Enable the Backdrop texture."] = "启用背景材质。"
-- L["Enable the Gloss texture."] = "Enable the Gloss texture."
-- L["Enable the Shadow texture."] = "Enable the Shadow texture."
L["Flash"] = "闪光"
L["Global"] = "全局"
L["Global Settings"] = "全局设置"
L["Gloss"] = "光泽设置"
L["Highlight"] = "高亮"
L["Normal"] = "正常"
L["Pushed"] = "加粗"
L["Reset all skin options to the defaults."] = "重置所有皮肤选项为默认。"
L["Reset Skin"] = "重置皮肤"
L["Set the color of the Backdrop texture."] = "设置背景材质颜色"
L["Set the color of the Checked texture."] = "设置已选中材质颜色。"
-- L["Set the color of the Cooldown animation."] = "Set the color of the Cooldown animation."
L["Set the color of the Disabled texture."] = "设置已禁用材质颜色。"
L["Set the color of the Flash texture."] = "设置闪光材质颜色。"
L["Set the color of the Gloss texture."] = "设置光泽材质颜色。"
L["Set the color of the Highlight texture."] = "设置高亮材质颜色。"
L["Set the color of the Normal texture."] = "设置一般材质颜色。"
L["Set the color of the Pushed texture."] = "设置加粗材质颜色。"
-- L["Set the color of the Shadow texture."] = "Set the color of the Shadow texture."
L["Set the skin for this group."] = "为此群组设置皮肤。"
-- L["Shadow"] = "Shadow"
L["Skin"] = "皮肤"
L["Skin Settings"] = "皮肤设置"
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "This section will allow you to adjust the skin settings of all buttons registered to %s."
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."
-- L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "这个部分将允许你将使用 Masque 注册的插件与插件群组的按钮进行换肤。"

----------------------------------------
-- Zoomed Skin
---

-- L["A square skin with zoomed icons and a semi-transparent background."] = "A square skin with zoomed icons and a semi-transparent background."
