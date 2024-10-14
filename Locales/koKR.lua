--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\koKR.lua

	koKR Locale

	[ Notes ]

	To help with translations, use the localization system on CurseForge (https://www.curseforge.com/wow/addons/masque/localization)
	or contribute directly on GitHub (https://github.com/SFX-WoW/Masque).

]]

if GetLocale() ~= "koKR" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

L["About Masque"] = "Masque 정보"
L["API"] = "API"
L["For more information, please visit one of the sites listed below."] = "자세한 내용은 아래 나열된 사이트 중 하나를 방문해 주세요."
L["Masque is a skinning engine for button-based add-ons."] = "Masque는 버튼 기반 애드온을 위한 스킨 엔진입니다."
L["Select to view."] = "보려면 선택하세요."
L["Supporters"] = "후원자"
L["You must have an add-on that supports Masque installed to use it."] = "Masque를 사용하려면 Masque를 지원하는 애드온이 설치되어 있어야 합니다."

----------------------------------------
-- Advanced Settings
---

-- L["Advanced"] = "Advanced"
-- L["Advanced Settings"] = "Advanced Settings"
-- L["Cast Animations"] = "Cast Animations"
-- L["Cooldown Animations"] = "Cooldown Animations"
-- L["Enable animations when action button cooldowns finish."] = "Enable animations when action button cooldowns finish."
-- L["Enable cast animations on action buttons."] = "Enable cast animations on action buttons."
-- L["Enable interrupt animations on action buttons."] = "Enable interrupt animations on action buttons."
-- L["Enable targeting reticles on action buttons."] = "Enable targeting reticles on action buttons."
-- L["Flash and Loop"] = "Flash and Loop"
-- L["Interrupt Animations"] = "Interrupt Animations"
-- L["Loop Only"] = "Loop Only"
-- L["Select the spell alert style."] = "Select the spell alert style."
-- L["Select which spell alert animations are enabled."] = "Select which spell alert animations are enabled."
-- L["Spell Alert Animations"] = "Spell Alert Animations"
-- L["Spell Alert Style"] = "Spell Alert Style"
-- L["Targeting Reticles"] = "Targeting Reticles"
-- L["This section will allow you to adjust button settings for the default interface."] = "This section will allow you to adjust button settings for the default interface."

----------------------------------------
-- Blizzard Classic Skin
---

L["The default Classic button style."] = "기본 클래식 버튼 스타일입니다."

----------------------------------------
-- Blizzard Modern Skin
---

L["The default Dragonflight button style."] = "기본 용군단 버튼 스타일입니다."

----------------------------------------
-- Classic Enhanced Skin
---

L["A modified version of the Classic button style."] = "클래식 버튼 스타일을 개선한 버전입니다."

----------------------------------------
-- Core Settings
---

L["About"] = "정보"
L["This section will allow you to view information about Masque and any skins you have installed."] = "여기는 Masque 및 설치한 스킨에 대한 정보를 볼 수 있습니다."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "애드온이나 스킨에 문제가 생길 때마다 Masque가 Lua 오류를 발생시킵니다."
L["Clean Database"] = "데이터베이스 정리"
L["Click to purge the settings of all unused add-ons and groups."] = "사용하지 않는 모든 애드온 및 그룹 설정을 제거하려면 클릭하세요."
L["Debug Mode"] = "디버그 모드"
L["Developer"] = "개발자"
L["Developer Settings"] = "개발자 설정"
L["Masque debug mode disabled."] = "Masque 디버그 모드를 비활성화합니다."
L["Masque debug mode enabled."] = "Masque 디버그 모드를 활성화합니다."
L["This action cannot be undone. Continue?"] = "이 작업은 취소할 수 없습니다. 계속할까요?"
L["This section will allow you to adjust settings that affect working with Masque's API."] = "여기는 Masque API 작업에 영향을 주는 설정을 조정할 수 있습니다."

----------------------------------------
-- Dream Skin
---

L["A square skin with trimmed icons and a semi-transparent background."] = "다듬은 아이콘과 반투명 배경이 있는 정사각형 스킨입니다."

----------------------------------------
-- General Settings
---

L["General Settings"] = "일반 설정"
L["This section will allow you to adjust Masque's interface and performance settings."] = "여기는 Masque 인터페이스 및 성능 설정을 조정할 수 있습니다."

----------------------------------------
-- Installed Skins
---

L["Author"] = "제작자"
L["Authors"] = "제작자"
L["Compatible"] = "호환"
L["Description"] = "설명"
-- L["Discord"] = "Discord"
L["Installed Skins"] = "설치된 스킨"
L["No description available."] = "가능한 설명이 없습니다."
L["Status"] = "상태"
L["The status of this skin is unknown."] = "이 스킨의 상태는 알 수 없습니다."
L["This section provides information on any skins you have installed."] = "여기는 설치한 스킨에 대한 정보를 제공합니다."
L["This skin is compatible with Masque."] = "이 스킨은 Masque와 호환됩니다."
L["This skin is outdated but is still compatible with Masque."] = "이 스킨은 구식이지만 여전히 Masque와 호환됩니다."
L["Unknown"] = "알 수 없음"
L["Version"] = "버전"
L["Website"] = "웹사이트"
L["Websites"] = "웹사이트"

----------------------------------------
-- Interface Settings
---

-- L["Add-On Compartment"] = "Add-On Compartment"
L["Alternate Sorting"] = "대체 정렬"
L["Causes the skins included with Masque to be listed above third-party skins."] = "Masque에 포함된 스킨이 타사 스킨 위에 나열되도록 합니다."
L["Click to reload the interface."] = "인터페이스를 다시 불러오려면 클릭하세요."
L["Interface"] = "인터페이스"
L["Interface Settings"] = "인터페이스 설정"
L["Load the skin information panel."] = "스킨 정보 패널을 불러옵니다."
-- L["Menu Icon"] = "Menu Icon"
-- L["Minimap"] = "Minimap"
-- L["None"] = "None"
L["Reload Interface"] = "인터페이스 새로 고침"
L["Requires an interface reload."] = "인터페이스 다시 불러와야 합니다."
-- L["Select where Masque's menu icon is displayed."] = "Select where Masque's menu icon is displayed."
L["Skin Information"] = "스킨 정보"
L["Stand-Alone GUI"] = "독립 실행형 GUI"
L["This section will allow you to adjust settings that affect Masque's interface."] = "여기는 Masque 인터페이스에 영향을 주는 설정을 조정할 수 있습니다."
L["Use a resizable, stand-alone options window."] = "크기 조정 가능한 독립 실행형 옵션 창을 사용합니다."

----------------------------------------
-- LDB Launcher
---

L["Click to open Masque's settings."] = "클릭으로 Masque 설정을 엽니다."
-- L["Unavailable in combat."] = "Unavailable in combat."

----------------------------------------
-- Modern Enhanced Skin
---

L["An enhanced version of the Dragonflight button style."] = "용군단 버튼 스타일의 향상된 버전입니다."

----------------------------------------
-- Profile Settings
---

L["Profile Settings"] = "프로필 설정"

----------------------------------------
-- Skin Settings
---

L["Adjust the scale of this group's skin."] = "이 그룹의 스킨 크기 비율을 조정합니다."
L["Backdrop"] = "배경"
L["Checked"] = "선택된 버튼"
L["Color"] = "색상"
L["Colors"] = "색상"
L["Cooldown"] = "재사용 대기시간"
L["Disable"] = "비활성화"
L["Disable the skinning of this group."] = "이 그룹의 스킨 씌우기를 비활성화합니다."
L["Enable"] = "활성화"
L["Enable skin scaling."] = "스킨 크기 비율을 활성화합니다."
L["Enable the Backdrop texture."] = "배경 텍스처를 활성화합니다."
L["Enable the Gloss texture."] = "광택 텍스처를 활성화합니다."
L["Enable the Shadow texture."] = "그림자 텍스처를 활성화합니다."
L["Flash"] = "번쩍임"
L["Global"] = "전역"
L["Global Settings"] = "전역 설정"
L["Gloss"] = "광택 효과 설정"
L["Highlight"] = "강조된 버튼"
L["Normal"] = "일반"
L["Pulse"] = "맥박"
L["Pushed"] = "눌려진 버튼"
L["Reset all skin options to the defaults."] = "모든 스킨 옵션을 기본값으로 재설정합니다."
L["Reset Skin"] = "스킨 재설정"
L["Scale"] = "크기 비율"
L["Set the color of the Backdrop texture."] = "배경 텍스처의 색상을 설정합니다."
L["Set the color of the Checked texture."] = "선택된 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Cooldown animation."] = "재사용 대기시간 애니메이션의 색상을 설정합니다."
L["Set the color of the Flash texture."] = "번쩍임 텍스처의 색상을 변경합니다."
L["Set the color of the Gloss texture."] = "광택 효과 텍스처의 색상을 변경합니다."
L["Set the color of the Highlight texture."] = "강조된 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Normal texture."] = "평상 시 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Pushed texture."] = "눌려진 버튼 텍스처의 색상을 변경합니다."
L["Set the color of the Shadow texture."] = "그림자 텍스처의 색상을 설정합니다."
L["Set the skin for this group."] = "이 그룹의 스킨을 설정합니다."
L["Shadow"] = "그림자"
L["Show the pulse effect when a cooldown finishes."] = "재사용 대기시간이 끝나면 맥박 효과를 표시합니다."
L["Skin"] = "스킨"
L["Skin Settings"] = "스킨 설정"
L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "여기는 %s에 등록된 모든 버튼의 스킨 설정을 조정할 수 있습니다."
L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "여기는 %s에 등록된 모든 버튼의 스킨 설정을 조정할 수 있습니다. 이는 그룹별 설정을 덮어씁니다."
L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "여기는 등록된 모든 버튼의 스킨 설정을 조정할 수 있습니다. 이는 애드온별 설정을 덮어씁니다."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "여기는 Masque에 등록된 애드온 및 애드온 그룹의 버튼에 스킨을 씌울 수 있습니다."

----------------------------------------
-- Zoomed Skin
---

L["A square skin with zoomed icons and a semi-transparent background."] = "확대된 아이콘과 반투명 배경이 있는 정사각형 스킨입니다."
