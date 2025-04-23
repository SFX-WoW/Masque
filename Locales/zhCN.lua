--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\zhCN.lua

	zhCN Locale

	[ Notes ]

	To help with translations, use the localization system on CurseForge (https://www.curseforge.com/wow/addons/masque/localization)
	or contribute directly on GitHub (https://github.com/SFX-WoW/Masque).

]]

if GetLocale() ~= "zhCN" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

L["About Masque"] = "关于 Masque"
L["API"] = "API"
L["For more information, please visit one of the sites listed below."] = "查阅更多信息，请访问下边列表中的网页站点。"
L["Masque is a skinning engine for button-based add-ons."] = "Masque 一款基于按钮的外观美化插件。"
L["Select to view."] = "选择来查看。"
L["Supporters"] = "支持者"
L["You must have an add-on that supports Masque installed to use it."] = "必须安装一个支持 Masque 的插件才能使用。"

----------------------------------------
-- Advanced Settings
---

L["Advanced"] = "高级"
L["Advanced Settings"] = "高级设置"
L["Cast Animations"] = "施法动画"
L["Cooldown Animations"] = "冷却动画"
L["Enable animations when action button cooldowns finish."] = "当动作按钮冷却结束时启用动画。"
L["Enable cast animations on action buttons."] = "启用动作按钮施法动画。"
L["Enable interrupt animations on action buttons."] = "启用动作按钮打断动画。"
L["Enable targeting reticles on action buttons."] = "启用动作按钮瞄准线。"
L["Flash and Loop"] = "闪光并循环"
L["Interrupt Animations"] = "打断动画"
L["Loop Only"] = "仅循环"
L["Select the spell alert style."] = "选择法术警报样式。"
L["Select which spell alert animations are enabled."] = "选择要用哪种法术提醒动画。"
L["Spell Alert Animations"] = "法术警报动画"
L["Spell Alert Style"] = "法术警报样式"
L["Targeting Reticles"] = "瞄准线"
L["This section will allow you to adjust button settings for the default interface."] = "此部分可以调整默认界面的按钮设置。"

----------------------------------------
-- Blizzard Classic Skin
---

L["The default Classic button style."] = "默认的经典按钮样式。"

----------------------------------------
-- Blizzard Modern Skin
---

L["The default Dragonflight button style."] = "默认的巨龙时代按钮样式。"

----------------------------------------
-- Classic Enhanced Skin
---

L["A modified version of the Classic button style."] = "一款游戏默认按钮样式的改进版本。"

----------------------------------------
-- Core Settings
---

L["About"] = "关于"
L["This section will allow you to view information about Masque and any skins you have installed."] = "此部分将允许查看关于 Masque 的信息或任意一款已安装的皮肤。"

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "无论何时 Masque 遇到了一个插件问题或者皮肤问题，都让其屏蔽 Lua 错误。"
L["Clean Database"] = "清除数据库"
L["Click to purge the settings of all unused add-ons and groups."] = "点击清除全部未使用插件和群组设置。"
L["Debug Mode"] = "调试模式"
L["Developer"] = "开发者"
L["Developer Settings"] = "开发者设置"
L["Masque debug mode disabled."] = "Masque 调试模式已禁用。"
L["Masque debug mode enabled."] = "Masque 调试模式已启用。"
L["This action cannot be undone. Continue?"] = "此操作不可撤销。继续？"
L["This section will allow you to adjust settings that affect working with Masque's API."] = "此部分将允许调整影响 Masque 使用的 API。"

----------------------------------------
-- Dream Skin
---

L["A square skin with trimmed icons and a semi-transparent background."] = "一款方形皮肤带有修剪过的图标和半透明背景。"

----------------------------------------
-- General Settings
---

L["General Settings"] = "一般设置"
L["This section will allow you to adjust Masque's interface and performance settings."] = "此部分将允许调整 Masque 界面和性能设置。"

----------------------------------------
-- Installed Skins
---

L["Author"] = "作者"
L["Authors"] = "作者"
L["Compatible"] = "兼容"
L["Description"] = "描述"
L["Discord"] = "Discord"
L["Installed Skins"] = "已安装皮肤"
L["No description available."] = "没有可用的描述。"
L["Status"] = "状态"
L["The status of this skin is unknown."] = "此皮肤的状态未知。"
L["This section provides information on any skins you have installed."] = "此部分提供所有已安装皮肤的信息。"
L["This skin is compatible with Masque."] = "此皮肤与 Masque 兼容。"
L["This skin is outdated but is still compatible with Masque."] = "此皮肤已过期但仍与 Masque 兼容。"
L["Unknown"] = "未知"
L["Version"] = "版本"
L["Website"] = "网站"
L["Websites"] = "网站"

----------------------------------------
-- Interface Settings
---

L["Add-On Compartment"] = "插件列表"
L["Alternate Sorting"] = "另一种排序"
L["Causes the skins included with Masque to be listed above third-party skins."] = "使 Masque 内置的皮肤排在第三方皮肤之上。"
L["Click to reload the interface."] = "点击重载界面。"
L["Interface"] = "界面"
L["Interface Settings"] = "界面设置"
L["Load the skin information panel."] = "载入这个皮肤信息面板。"
L["Menu Icon"] = "菜单图标"
L["Minimap"] = "小地图"
L["None"] = "无"
L["Reload Interface"] = "重载界面"
L["Requires an interface reload."] = "需要重载当前界面。"
L["Select where Masque's menu icon is displayed."] = "选择 Masque 菜单图标的显示位置。"
L["Skin Information"] = "皮肤信息"
L["Stand-Alone GUI"] = "独立用户界面"
L["This section will allow you to adjust settings that affect Masque's interface."] = "此部分将允许调整影响 Masque 界面的设置。"
L["Use a resizable, stand-alone options window."] = "使用可调整大小的独立选项窗口。"

----------------------------------------
-- LDB Launcher
---

L["Click to open Masque's settings."] = "点击打开 Masque 设置。"
L["Unavailable in combat."] = "战斗中不可用。"

----------------------------------------
-- Modern Enhanced Skin
---

L["An enhanced version of the Dragonflight button style."] = "巨龙时代按钮样式的增强版。"

----------------------------------------
-- Profile Settings
---

L["Profile Settings"] = "配置文件设置"

----------------------------------------
-- Skin Settings
---

L["Adjust the scale of this group's skin."] = "调整此群组皮肤的缩放。"
L["Backdrop"] = "背景设置"
L["Checked"] = "已选中"
L["Color"] = "颜色"
L["Colors"] = "颜色"
L["Cooldown"] = "冷却"
L["Disable"] = "禁用"
L["Disable the skinning of this group."] = "禁用此群组换肤。"
L["Enable"] = "启用"
L["Enable skin scaling."] = "启用皮肤缩放。"
L["Enable the Backdrop texture."] = "启用背景材质。"
L["Enable the Gloss texture."] = "启用光泽材质。"
L["Enable the Shadow texture."] = "启用阴影材质。"
L["Flash"] = "闪光"
L["Global"] = "全局"
L["Global Settings"] = "全局设置"
L["Gloss"] = "光泽设置"
L["Highlight"] = "高亮"
L["Normal"] = "正常"
L["Pulse"] = "脉动"
L["Pushed"] = "按下"
L["Reset all skin options to the defaults."] = "重置所有皮肤选项为默认。"
L["Reset Skin"] = "重置皮肤"
L["Scale"] = "缩放"
L["Set the color of the Backdrop texture."] = "设置背景材质颜色。"
L["Set the color of the Checked texture."] = "设置已选中材质颜色。"
L["Set the color of the Cooldown animation."] = "设置冷却动画颜色。"
L["Set the color of the Flash texture."] = "设置闪光材质颜色。"
L["Set the color of the Gloss texture."] = "设置光泽材质颜色。"
L["Set the color of the Highlight texture."] = "设置高亮材质颜色。"
L["Set the color of the Normal texture."] = "设置一般材质颜色。"
L["Set the color of the Pushed texture."] = "设置加粗材质颜色。"
L["Set the color of the Shadow texture."] = "设置阴影材质颜色。"
L["Set the skin for this group."] = "为此群组设置皮肤。"
L["Shadow"] = "阴影"
L["Show the pulse effect when a cooldown finishes."] = "冷却结束时显示脉动效果。"
L["Skin"] = "皮肤"
L["Skin Settings"] = "皮肤设置"
L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "此部分将允许调整注册到 %s 皮肤设置到全部按钮。"
L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "此部分将允许调整注册到 %s 皮肤设置到全部按钮。这将覆盖任意群组设置。"
L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "此部分将允许调整注册皮肤设置到全部按钮。这将覆盖任意群组设置。"
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "此部分将允许将使用 Masque 注册的插件与插件群组的按钮。"

----------------------------------------
-- Zoomed Skin
---

L["A square skin with zoomed icons and a semi-transparent background."] = "一款方形皮肤带有缩放图标和半透明背景。"
