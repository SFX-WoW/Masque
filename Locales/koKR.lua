--[[
	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Locales\koKR.lua

	[ Notes ]

	To help with translations, use the localization system on WoWAce (https://www.wowace.com/projects/masque/localization)
	or contribute directly on GitHub (https://github.com/stormfx/masque).
]]

if GetLocale() ~= "koKR" then return end

local _, Core = ...
local L = Core.Locale

L["Addons"] = "애드온"
L["Adjust the skin of all buttons registered to %s. This will overwrite any per-group settings."] = "%s|1으로;로; 등록된 모든 버튼의 스킨을 조절합니다. 이 옵션은 그룹당 설정은 어떤 것이던지 덧씌우게 됩니다."
L["Adjust the skin of all buttons registered to %s: %s."] = "%s: %s|1으로;로; 등록된 모든 버튼의 스킨을 조절합니다."
L["Adjust the skin of all registered buttons. This will overwrite any per-add-on settings."] = "등록된 모든 버튼의 스킨을 조절합니다. 이 옵션은 애드온당 설정은 어떤 것이던지 덧씌우게 됩니다."
L["Backdrop Settings"] = "바탕 설정"
L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Masque가 애드온 혹은 스킨과의 문제에 부닥칠 때마다 언제든지 Lua 오류화하도록 합니다. "
L["Checked"] = "선택된 버튼"
L["Click this button to load Masque's options. You can also use the %s or %s chat command."] = "Masque 옵션을 불러들이려면 이 버튼을 클릭하세요. %s 혹은 %s 대화 명령어 또한 사용할 수 있습니다."
L["Click to open Masque's options window."] = "Masque의 옵션창을 열려면 클릭하세요."
L["Color"] = "색상"
L["Colors"] = "색상"
L["Cooldown"] = "재사용 대기시간"
L["Debug Mode"] = "디버그 모드"
L["Disable"] = "비활성화"
L["Disable the skinning of this group."] = "이 그룹의 스킨 씌우기를 비활성화합니다."
L["Disabled"] = "비활성화된 버튼"
L["Enable"] = "활성화"
L["Enable the Backdrop texture."] = "바탕 텍스쳐를 활성화합니다."
L["Enable the Minimap icon."] = "미니맵 아이콘을 활성화 합니다."
L["Equipped"] = "착용"
L["Flash"] = "번쩍임"
L["General"] = "일반"
L["Global"] = "공통 옵션"
L["Gloss Settings"] = "광택 효과 설정"
L["Highlight"] = "강조된 버튼"
L["Load Masque Options"] = "Masque 옵션 불러들이기"
L["Loading Masque Options..."] = "Masque 옵션을 불려 오는 중..."
L["Masque debug mode disabled."] = "Masque 디버그 모드를 비활성화합니다."
L["Masque debug mode enabled."] = "Masque 디버그 모드를 활성화합니다."
L["Masque is a dynamic button skinning add-on."] = "Masque는 동적인 버튼 스킨 입히기 애드온 입니다."
L["Minimap Icon"] = "미니맵 아이콘"
L["Normal"] = "평상 시 버튼"
L["Opacity"] = "불투명도"
L["Profiles"] = "프로필"
L["Pushed"] = "눌려진 버튼"
L["Reset all skin options to the defaults."] = "모든 색상을 기본값으로 초기화 합니다."
L["Reset Skin"] = "스킨 초기화"
L["Set the color of the Backdrop texture."] = "바탕 텍스쳐의 색상을 설정합니다."
L["Set the color of the Checked texture."] = "선택된 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Cooldown animation."] = "재사용 대기시간 움직임의 색상을 변경합니다."
L["Set the color of the Disabled texture."] = "비활성화된 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Equipped item texture."] = "착용 아이템 텍스처의 색상을 변경합니다."
L["Set the color of the Flash texture."] = "번쩍임 텍스처의 색상을 변경합니다."
L["Set the color of the Gloss texture."] = "광택 효과 텍스처의 색상을 변경합니다."
L["Set the color of the Highlight texture."] = "강조된 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Normal texture."] = "평상 시 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Pushed texture."] = "눌려진 버튼 텍스처의 색상을 변경합니다."
L["Set the intensity of the Gloss color."] = "번들거림 색상의 농도를 설정합니다."
L["Set the skin for this group."] = "이 그룹을 위한 스킨을 설정합니다."
L["Skin"] = "스킨"
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "이 항목은 Masque와 함께 등록된 애드온과 애드온 그룹의 버튼의 스킨을 씌울 수 있도록 합니다."
