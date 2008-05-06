local AceLocale = LibStub("AceLocale-3.0")

local L = AceLocale:NewLocale( "ButtonFacade", "zhTW", false )

if L then
	L["BF"] = "BF" -- Short for ButtonFacade
	L["ButtonFacade"] = "ButtonFacade"
	L["|cffffff00Right-click|r to open the Configuration GUI"] = "|cffffff00滑鼠右鍵|r打開設定圖形界面"
	L["Apply skin to all registered buttons."] = "將 Skin 應用到所有已註冊的按鈕上"
	L["Apply skin to all buttons registered with %s."] = "將 Skin 應用到所有註冊給 %s 的按鈕上"
	L["Apply skin to all buttons registered with %s/%s."] = "將 Skin 應用到所有註冊給 %s/%s 的按鈕上"
	L["Apply skin to all buttons registered with %s/%s/%s."] = "將 Skin 應用到所有註冊給 %s/%s/%s 的按鈕上"
	L["Elements"] = "元素"
	L["Skin"] = "Skin"
	L["Gloss"] = "光澤"
	L["Backdrop"] = "背景"
	L["FuBar options"] = "FuBar 選項"
	L["Attach to minimap"] = "依附到小地圖"
	L["Hide minimap/FuBar icon"] = "隱藏 小地圖/FuBar 圖示"
	L["Show icon"] = "顯示圖示"
	L["Show text"] = "顯示文字"
	L["Position"] = "位置"
	L["Left"] = "左"
	L["Center"] = "中"
	L["Right"] = "右"
end
