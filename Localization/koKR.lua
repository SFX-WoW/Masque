local AceLocale = LibStub("AceLocale-3.0")

local L = AceLocale:NewLocale( "ButtonFacade", "koKR")

if L then
	L["BF"] = true -- Short for ButtonFacade
	L["ButtonFacade"] = true
	L["|cffffff00Right-click|r to open the Configuration GUI"] = "|cffffff00우클릭|r시 설정창을 엽니다"
	L["Apply skin to all registered buttons."] = "등록된 모든 버튼에 스킨을 적용합니다."
	L["Apply skin to all buttons registered with %s."] = "%s에 등록된 모든 버튼에 스킨을 적용합니다."
	L["Apply skin to all buttons registered with %s/%s."] = "%s의 %s에 등록된 모든 버튼에 스킨을 적용합니다."
	L["Apply skin to all buttons registered with %s/%s/%s."] = "%s의 %s의 %s에 등록된 모든 버튼에 스킨을 적용합니다."
	L["Elements"] = "구성 요소"
	L["Skin"] = "스킨"
	L["Gloss"] = "광택 효과"
	L["Backdrop"] = "배경"
	L["FuBar options"] = "FuBar 설정"
	L["Attach to minimap"] = "미니맵에 표시"
	L["Hide minimap/FuBar icon"] = "미니맵/FuBar 아이콘 숨김"
	L["Show icon"] = "아이콘 표시"
	L["Show text"] = "텍스트 표시"
	L["Position"] = "위치"
	L["Left"] = "좌"
	L["Center"] = "중앙"
	L["Right"] = "우"

	L["Button Test"] = "버튼 테스트"
	L["Enable Module"] = "모듈 사용"
	L["Drag"] = "잡아끌기"
	L["Displays a set of buttons that can be used to verify the functionality of a skin.  In order from left to right, the buttons inherit from the following templates: ActionBarButtonTemplate, BonusActionButtonTemplate, ShapeshiftButtonTemplate, ItemButtonTemplate, PetActionButtonTemplate."] = "스킨 적용을 확인 할 수 있는 버튼들을 표시합니다.  왼쪽 부터 순서대로 적용될 버튼의 종류: ActionBarButtonTemplate, BonusActionButtonTemplate, ShapeshiftButtonTemplate, ItemButtonTemplate, PetActionButtonTemplate."
end
