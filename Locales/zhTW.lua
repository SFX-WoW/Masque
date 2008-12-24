local L = LibStub("AceLocale-3.0"):NewLocale("ButtonFacade", "zhTW")

if L then
	-- Addon Title
	L["ButtonFacade"] = "ButtonFacade"

	-- Broker Tool Tip
	L["Right-Click to open the options window."] = "右擊打開選項視窗。"

	-- Global Settings
	L["Global"] = "全局"
	L["GLOBAL_INFO"] = "這部分可以調整皮膚全局設置。這部分的任何更改將影響所有已註冊的插件部分。請注意：這部分重新加載插件後將不會更新。"

	-- Addon Settings
	L["Addons"] = "插件"
	L["ADDON_INFO"] = "這部分可以調整每個插件的皮膚設置。也可以調整插件的設置單獨分組，動作條和按鈕。"

	-- Elements
	L["Apply skin to all buttons registered with %s."] = "將皮膚套用到所有註冊給%s的按鈕上。"
	L["Apply skin to all buttons registered with %s: %s."] = "將皮膚套用到所有註冊給%s：%s的按鈕上。"
	L["Apply skin to all buttons registered with %s: %s/%s."] = "將皮膚套用到所有註冊給%s：%s/%s的按鈕上。"

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

	-- General Options
	L["Options"] = "選項"
	L["OPTION_INFO"] = "這部分可以調整可用於 ButtonFacade 的任何選項。"
	L["Minimap Icon"] = "小地圖圖示"
	L["Show the minimap icon."] = "顯示小地圖圖示。"
	L["OPTWIN_ISSUE"] = "如果無法訪問一些選擇適當窗口大小的選項，你需要下載並安裝 |cffffcc00BetterBlizzOptions|r。或者，你可以使用下面的按鈕或 |cffffcc00/bfo| 聊天命令打開一個獨立的選項窗口。"
	L["Standalone Options"] = "獨立選項"
	L["Open a standalone options window."] = "打開獨立選項窗口。"

	-- Plugins
	L["Plugins"] = "插件"
	L["PLUGIN_INFO"] = "這部分可以整設置的單獨插件。"

	-- Profiles
	L["Profiles"] = "用戶資料"

	-- About
	L["About"] = "About"
	L["BF_INFO"] = "ButtonFacade 是基於按鈕的動態皮膚小型插件。"
	L["Version"] = "Version"
	L["Authors"] = "Authors"
	L["Web Site"] = "Web Site"
	L["Feedback"] = "Feedback"
	L["FB_TEXT"] = "If you have questions or comments or would like to submit a bug, please visit the project page and submit a ticket. You will also find a list of frequently asked questions covering the most common issues."
	L["Translations"] = "Translations"
	L["TRANS_TEXT"] = "If you would like to help translate ButtonFacade, please visit the project page and follow the directions for submitting translations."
end
