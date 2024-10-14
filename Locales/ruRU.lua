--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\ruRU.lua

	ruRU Locale

	[ Notes ]

	To help with translations, use the localization system on CurseForge (https://www.curseforge.com/wow/addons/masque/localization)
	or contribute directly on GitHub (https://github.com/SFX-WoW/Masque).

]]

if GetLocale() ~= "ruRU" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

L["About Masque"] = "О Masque"
L["API"] = "API"
L["For more information, please visit one of the sites listed below."] = "Для получения подробной информации, пожалуйста посетите один из сайтов расположенных ниже."
L["Masque is a skinning engine for button-based add-ons."] = "Masque - это аддон для изменения внешнего вида кнопок."
L["Select to view."] = "Выберите, чтобы посмотреть."
L["Supporters"] = "Поддержка"
L["You must have an add-on that supports Masque installed to use it."] = "У Вас должны быть установлены аддоны, поддерживающие Masque"

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

L["The default Classic button style."] = "Классический стиль кнопки по умолчанию."

----------------------------------------
-- Blizzard Modern Skin
---

L["The default Dragonflight button style."] = "Стиль кнопки Dragonflight по умолчанию."

----------------------------------------
-- Classic Enhanced Skin
---

L["A modified version of the Classic button style."] = "Улучшенная версия стандартных кнопок"

----------------------------------------
-- Core Settings
---

L["About"] = "Об аддоне"
L["This section will allow you to view information about Masque and any skins you have installed."] = "Этот раздел позволяет смотреть информацию о Masque и любом скине, который установлен."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Заставляет Masque выдавать ошибки Lua, с чем бы они не были связаны: аддоном или скином."
L["Clean Database"] = "Очистить базу"
L["Click to purge the settings of all unused add-ons and groups."] = "Нажмите для очистки настроек всех неиспользованных аддонов и групп."
L["Debug Mode"] = "Режим отладки"
L["Developer"] = "Разработка"
L["Developer Settings"] = "Настройки разработчика"
L["Masque debug mode disabled."] = "Режим отладки Masque отключен."
L["Masque debug mode enabled."] = "Режим отладки Masque включен."
L["This action cannot be undone. Continue?"] = "Действие необратимо. Продолжить?"
L["This section will allow you to adjust settings that affect working with Masque's API."] = "Этот раздел позволяет настраивать Masque для работы с API."

----------------------------------------
-- Dream Skin
---

L["A square skin with trimmed icons and a semi-transparent background."] = "Квадратный скин с обрезанными иконками и полупрозрачным фоном."

----------------------------------------
-- General Settings
---

L["General Settings"] = "Общие настройки"
L["This section will allow you to adjust Masque's interface and performance settings."] = "Этот раздел позволяет изменять настройки интерфейса и производительности Masque."

----------------------------------------
-- Installed Skins
---

L["Author"] = "Автор"
L["Authors"] = "Авторы"
L["Compatible"] = "Совместим"
L["Description"] = "Описание"
-- L["Discord"] = "Discord"
L["Installed Skins"] = "Установленные скины"
L["No description available."] = "Нет описания."
L["Status"] = "Статус"
L["The status of this skin is unknown."] = "Статус скина неизвестен."
L["This section provides information on any skins you have installed."] = "В этом разделе показана информация об установленных скинах."
L["This skin is compatible with Masque."] = "Скин совместим с Masque."
L["This skin is outdated but is still compatible with Masque."] = "Скин устарел, но всё ещё совместим с Masque."
L["Unknown"] = "Неизвестно"
L["Version"] = "Версия"
L["Website"] = "Сайт"
L["Websites"] = "Сайты"

----------------------------------------
-- Interface Settings
---

-- L["Add-On Compartment"] = "Add-On Compartment"
L["Alternate Sorting"] = "Альтернативная сортировка"
L["Causes the skins included with Masque to be listed above third-party skins."] = "Приводит к тому, что скины, включенные в Masque, будут в списке выше сторонних скинов."
L["Click to reload the interface."] = "Нажмите для перезагрузки интерфейса."
L["Interface"] = "Интерфейс"
L["Interface Settings"] = "Настройки интерфейса"
L["Load the skin information panel."] = "Загрузить информационную панель скинов."
-- L["Menu Icon"] = "Menu Icon"
-- L["Minimap"] = "Minimap"
-- L["None"] = "None"
L["Reload Interface"] = "Перезагрузить интерфейс"
L["Requires an interface reload."] = "Требует перезагрузки интерфейса"
-- L["Select where Masque's menu icon is displayed."] = "Select where Masque's menu icon is displayed."
L["Skin Information"] = "Информация о скинах"
L["Stand-Alone GUI"] = "Внешний фрейм настроек"
L["This section will allow you to adjust settings that affect Masque's interface."] = "Этот раздел позволяет настраивать то, как Masque влияет на интерфейс."
L["Use a resizable, stand-alone options window."] = "Использовать отдельное окно настроек."

----------------------------------------
-- LDB Launcher
---

L["Click to open Masque's settings."] = "Нажмите для открытия настроек Masque."
-- L["Unavailable in combat."] = "Unavailable in combat."

----------------------------------------
-- Modern Enhanced Skin
---

-- L["An enhanced version of the Dragonflight button style."] = "An enhanced version of the Dragonflight button style."

----------------------------------------
-- Profile Settings
---

L["Profile Settings"] = "Настройки профиля"

----------------------------------------
-- Skin Settings
---

L["Adjust the scale of this group's skin."] = "Отрегулировать масштаб скина этой группы."
L["Backdrop"] = "Фон"
L["Checked"] = "При выделении"
L["Color"] = "Цвет"
L["Colors"] = "Цвета"
L["Cooldown"] = "Анимация перезарядки способности"
L["Disable"] = "Отключить"
L["Disable the skinning of this group."] = "Отключить скины для этой группы."
L["Enable"] = "Включить"
L["Enable skin scaling."] = "Включить масштабирование скина."
L["Enable the Backdrop texture."] = "Включить настройки фона текстуры."
L["Enable the Gloss texture."] = "Включить настройки глянцевой текстуры."
L["Enable the Shadow texture."] = "Включить настройки текстуры тени."
L["Flash"] = "Сверкание"
L["Global"] = "Общее"
L["Global Settings"] = "Настройки"
L["Gloss"] = "Глянец"
L["Highlight"] = "При наведении"
L["Normal"] = "Нормальный"
L["Pulse"] = "Импульс"
L["Pushed"] = "При нажатии"
L["Reset all skin options to the defaults."] = "Установить значения цветов по умолчанию."
L["Reset Skin"] = "Сбросить цвета"
L["Scale"] = "Масштаб"
L["Set the color of the Backdrop texture."] = "Установить цвет фона текстуры."
L["Set the color of the Checked texture."] = "Установить цвет текстуры при выделении."
L["Set the color of the Cooldown animation."] = "Установить цвет анимации перезарядки способностей."
L["Set the color of the Flash texture."] = "Установить цвет текстуры с подсветкой."
L["Set the color of the Gloss texture."] = "Задать цвет для глянца текстур."
L["Set the color of the Highlight texture."] = "Установить цвет текстуры при наведении."
L["Set the color of the Normal texture."] = "Установить нормальный цвет текстуры."
L["Set the color of the Pushed texture."] = "Установить цвет текстуры при нажатии."
L["Set the color of the Shadow texture."] = "Установить цвет тени."
L["Set the skin for this group."] = "Установить скин для данной группы."
L["Shadow"] = "Тень"
L["Show the pulse effect when a cooldown finishes."] = "Показать пульсацию по окончании перезарядки."
L["Skin"] = "Скины"
L["Skin Settings"] = "Настройки скинов"
L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "Этот раздел позволяет менять настройки сразу для всех кнопок %s."
L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "Этот раздел позволяет менять настройки сразу для всех кнопок %s. Изменения будут важнее любых, сделанных в подгруппах этого аддона."
L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "Этот раздел позволяет менять настройки сразу для всех кнопок. Изменения будут важнее любых, сделанных где-либо ещё."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "Этот раздел позволяет настроить скины для панелей команд аддонов и групп аддонов, использующих Masque."

----------------------------------------
-- Zoomed Skin
---

L["A square skin with zoomed icons and a semi-transparent background."] = "Квадратный скин с увеличенными иконками и полупрозрачным фоном."
