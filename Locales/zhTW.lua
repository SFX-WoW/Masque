local L = LibStub("AceLocale-3.0"):NewLocale("ButtonFacade", "zhTW")

if L then
	-- Addon Title
	L["ButtonFacade"] = "ButtonFacade"

	-- Broker Tool Tip
	L["Right-Click to open the options window."] = "右擊打開選項視窗。"

	-- Global Settings
	L["Global"] = "Global"
	L["GLOBAL_INFO"] = "這部分可以調整皮膚全局設置。這部分的任何更改將影響所有已註冊的插件部分。請注意：這部分重新加載插件後將不會更新。"

	-- Addon Settings
	L["Addons"] = "Addons"
	L["ADDON_INFO"] = "這部分可以調整每個插件的皮膚設置。也可以調整插件的設置單獨分組，動作條和按鈕。"

	-- General Options
	L["Options"] = "Options"
	L["OPTION_INFO"] = "This section allows you to adjust any options that are available for ButtonFacade."
	L["Minimap Icon"] = "小地圖圖示"
	L["Show the minimap icon."] = "顯示小地圖圖示。"
	L["OPTWIN_ISSUE"] = "If you're having trouble accessing some of the options due to the window size, you may want to download and install |cffffcc00BetterBlizzOptions|r. Alternatively, you can use the button below or the |cffffcc00/bfo|r chat command to open a standalone options window."
	L["Standalone Options"] = "Standalone Options"
	L["Open a standalone options window."] = "Open a standalone options window."
	
	-- Plugins
	L["Plugins"] = "Plugins"
	L["PLUGIN_INFO"] = "這部分可以整設置的單獨插件。"

	-- Profiles
	L["Profiles"] = "用户资料"

	-- About
	L["BF_INFO"] = "ButtonFacade 是基於按鈕的動態皮膚小型插件。"

	-- Elements
	L["Apply skin to all buttons registered with %s."] = "將皮膚套用到所有註冊給%s的按鈕上。"
	L["Apply skin to all buttons registered with %s: %s."] = "將皮膚套用到所有註冊給%s: %s的按鈕上。"
	L["Apply skin to all buttons registered with %s: %s/%s."] = "將皮膚套用到所有註冊給%s: %s/%s的按鈕上。"

	-- Settings
	L["Skin"] = "皮膚"
	L["Gloss"] = "光澤"
	L["Backdrop"] = "背景"
	L["Color Options"] = "顏色選項"
	L["Flash"] = "閃光"
	L["Normal Border"] = "正常邊框"
	L["Pushed Border"] = "加粗邊框"
	L["Disabled Border"] = "無邊框"
	L["Checked"] = "選中"
	L["Equipped"] = "已裝備"
	L["Highlight"] = "高亮"
	L["Gloss"] = "光澤"
	L["Reset Colors"] = "重置顏色"
end
