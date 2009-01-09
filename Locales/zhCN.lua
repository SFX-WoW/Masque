local L = LibStub("AceLocale-3.0"):NewLocale("ButtonFacade", "zhCN")

if L then
	-- Addon Title
	L["ButtonFacade"] = "ButtonFacade"

	-- Broker Tool Tip
	L["Right-Click to open the options window."] = "右击打开选项窗口。"

	-- Global Settings
	L["Global"] = "全局"
	L["GLOBAL_INFO"] = "这里可以调整全局皮肤设置。这部分的任何更改将影响所有已注册的插件部分。请注意：这部分重新加载插件后将不会更新。"

	-- Addon Settings
	L["Addons"] = "插件"
	L["ADDON_INFO"] = "这部分可以调整每个插件的皮肤设置。也可以调整插件的设置单独分组，动作条和按钮。"

	-- Elements
	L["Apply skin to all buttons registered with %s."] = "将皮肤应用到所有注册给%s的按钮上。"
	L["Apply skin to all buttons registered with %s: %s."] = "将皮肤应用到所有注册给%s：%s的按钮上。"
	L["Apply skin to all buttons registered with %s: %s/%s."] = "将皮肤应用到所有注册给%s：%s/%s的按钮上。"

	-- Settings
	L["Skin"] = "皮肤"
	L["Gloss"] = "光泽"
	L["Backdrop"] = "背景"
	L["Color Options"] = "颜色选项"
	L["Flash"] = "闪光"
	L["Normal Border"] = "正常边框"
	L["Pushed Border"] = "加粗边框"
	L["Disabled Border"] = "无边框"
	L["Checked"] = "选中"
	L["Equipped"] = "已装备"
	L["Highlight"] = "高亮"
	L["Reset Colors"] = "重置颜色"

	-- General Options
	L["Options"] = "选项"
	L["OPTION_INFO"] = "这部分可以调整可用于 ButtonFacade 的任何选项。"
	L["Minimap Icon"] = "小地图图标"
	L["Show the minimap icon."] = "显示小地图图标。"
	L["OPTWIN_ISSUE"] = "如果因为窗口大小的原因无法查看某些选项，你需要下载并安装 |cffffcc00BetterBlizzOptions|r。或者，你可以使用下面的按钮或 |cffffcc00/bfo| 聊天命令打开一个独立的选项窗口。"
	L["Standalone Options"] = "独立选项"
	L["Open a standalone options window."] = "打开独立选项窗口。"

	-- Plugins
	L["Plugins"] = "插件"
	L["PLUGIN_INFO"] = "这里可以对每个独立的组件进行设置。"

	-- Profiles
	L["Profiles"] = "配置文件"

	-- About
	L["About"] = "关于"
	L["BF_INFO"] = "ButtonFacade 是基于按钮的动态皮肤小型插件。"
	L["Version"] = "版本"
	L["Authors"] = "作者"
	L["Web Site"] = "主页"
	L["Feedback"] = "反馈"
	L["FB_TEXT"] = "如果您有任何建议或希望提交一个错误，请访问项目页面提交一个 Ticket。你可以在那里找到一份包含常见问题的 FAQ 列表。"
	L["Translations"] = "本地化"
	L["TRANS_TEXT"] = "如果您希望帮助 ButtonFacade 进行本地化，请访问项目页面使用 Translation 功能。"
end
