local AceLocale = LibStub("AceLocale-3.0")

local L = AceLocale:NewLocale( "ButtonFacade", "zhCN", false )

if L then
	L["BF"] = "BF" -- Short for ButtonFacade
	L["ButtonFacade"] = "ButtonFacade"
	L["|cffffff00Right-click|r to open the Configuration GUI"] = "|cffffff00鼠标右键|r打开配置图形界面"
	L["Apply skin to all registered buttons."] = "将皮肤应用到所有已注册的按钮上"
	L["Apply skin to all buttons registered with %s."] = "将皮肤应用到所有注册给 %s 的按钮上。"
	L["Apply skin to all buttons registered with %s/%s."] = "将皮肤应用到所有注册给 %s/%s 的按钮上。"
	L["Apply skin to all buttons registered with %s/%s/%s."] = "将皮肤应用到所有注册给 %s/%s/%s 的按钮上。"
	L["Elements"] = "元素"
	L["Skin"] = "皮肤"
	L["Gloss"] = "光泽"
	L["Backdrop"] = "背景"
	L["FuBar options"] = "FuBar选项"
	L["Attach to minimap"] = "附着到小地图"
	L["Hide minimap/FuBar icon"] = "隐藏小地图/FuBar图标"
	L["Show icon"] = "显示图标"
	L["Show text"] = "显示文本"
	L["Position"] = "位置"
	L["Left"] = "左"
	L["Center"] = "中"
	L["Right"] = "右"
end
