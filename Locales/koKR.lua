local L = LibStub("AceLocale-3.0"):NewLocale("ButtonFacade", "koKR")

if L then
	-- Main Info
	L["ButtonFacade"] = "ButtonFacade"
	L["BF_INFO"] = "ButtonFacade is a small add-on that allows the dynamic skinning of button-based add-ons."

	-- Broker Tool Tip
	L["Right-Click to open the options window."] = "Right-Click to open the options window."

	-- Minimap Options
	L["Minimap Icon"] = "Minimap Icon"
	L["Show the minimap icon."] = "Show the minimap icon."
	L["LibDBIcon-1.0 is not installed."] = "LibDBIcon-1.0 is not installed."
	
	-- Skin Settings
	L["Skins"] = "Skins"

	-- Global Settings
	L["Global Settings"] = "Global Settings"
	L["GLOBAL_INFO"] = "This section allows you adjust the skin settings globally. Any changes here will affect all registered elements. Please note that this section will not update itself after a reload."

	-- Add-on Settings
	L["Addon Settings"] = "Addon Settings"
	L["ADDON_INFO"] = "This section allows you adjust skin settings on a per-add-on basis. You can also adjust the settings of individual groups, bars and buttons in the add-on if the add-on allows it."

	-- Plug-ins
	L["Plugins"] = "Plugins"
	L["PLUGIN_INFO"] = "This section allows you adjust the settings of individual plug-ins."

	-- Profiles
	L["Profiles"] = "Profiles"

	-- Elements
	L["Apply skin to all buttons registered with %s."] = "%s에 등록된 모든 버튼에 스킨을 적용합니다."
	L["Apply skin to all buttons registered with %s: %s."] = "%s의 %s에 등록된 모든 버튼에 스킨을 적용합니다."
	L["Apply skin to all buttons registered with %s: %s/%s."] = "%s의 %s의 %s에 등록된 모든 버튼에 스킨을 적용합니다."

	-- Settings
	L["Skin"] = "스킨"
	L["Gloss"] = "광택 효과"
	L["Backdrop"] = "배경"
	L["Color Options"] = "색상 설정"
	L["Flash"] = "반짝임"
	L["Normal Border"] = "보통 테두리"
	L["Pushed Border"] = "압축 테두리"
	L["Disabled Border"] = "테두리 없음"
	L["Checked"] = "선택"
	L["Equipped"] = "착용"
	L["Highlight"] = "강조"
	L["Gloss"] = "Gloss"
	L["Reset Colors"] = "색상 초기화"
end
