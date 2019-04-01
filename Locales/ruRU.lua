--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file.

	* File...: Locales\ruRU.lua

	ruRU Locale

	[ Notes ]

	To help with translations, use the localization system on WoWAce (https://www.wowace.com/projects/masque/localization)
	or contribute directly on GitHub (https://github.com/stormfx/masque).

]]

-- GLOBALS: GetLocale

if GetLocale() ~= "ruRU" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

-- L["About Masque"] = "About Masque"
-- L["API"] = "API"
-- L["For more information, please visit one of the sites listed below."] = "For more information, please visit one of the sites listed below."
-- L["Masque is a skinning engine for button-based add-ons."] = "Masque is a skinning engine for button-based add-ons."
-- L["Select to view."] = "Select to view."
-- L["You must have an add-on that supports Masque installed to use it."] = "You must have an add-on that supports Masque installed to use it."

----------------------------------------
-- Classic Skin
---

-- L["An improved version of the game's default button style."] = "An improved version of the game's default button style."

----------------------------------------
-- Core Settings
---

-- L["About"] = "About"
-- L["Click to load Masque's options."] = "Click to load Masque's options."
-- L["Load Options"] = "Load Options"
-- L["Masque's options are load on demand. Click the button below to load them."] = "Masque's options are load on demand. Click the button below to load them."
-- L["This section will allow you to view information about Masque and any skins you have installed."] = "This section will allow you to view information about Masque and any skins you have installed."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Заставляет Masque выдавать ошибки Lua, с чем бы они не были связаны: аддоном или скином."
L["Debug Mode"] = "Режим отладки"
-- L["Developer"] = "Developer"
-- L["Developer Settings"] = "Developer Settings"
L["Masque debug mode disabled."] = "Режим отладки Masque отключен."
L["Masque debug mode enabled."] = "Режим отладки Masque включен."
-- L["This section will allow you to adjust settings that affect working with Masque's API."] = "This section will allow you to adjust settings that affect working with Masque's API."

----------------------------------------
-- Dream Skin
---

-- L["A square skin with trimmed icons and a semi-transparent background."] = "A square skin with trimmed icons and a semi-transparent background."

----------------------------------------
-- General Settings
---

-- L["General Settings"] = "General Settings"
-- L["This section will allow you to adjust Masque's interface and performance settings."] = "This section will allow you to adjust Masque's interface and performance settings."

----------------------------------------
-- Installed Skins
---

-- L["Author"] = "Author"
-- L["Authors"] = "Authors"
-- L["Click for details."] = "Click for details."
-- L["Compatible"] = "Compatible"
-- L["Description"] = "Description"
-- L["Incompatible"] = "Incompatible"
-- L["Installed Skins"] = "Installed Skins"
-- L["No description available."] = "No description available."
-- L["Status"] = "Status"
-- L["The status of this skin is unknown."] = "The status of this skin is unknown."
-- L["This section provides information on any skins you have installed."] = "This section provides information on any skins you have installed."
-- L["This skin is compatible with Masque."] = "This skin is compatible with Masque."
-- L["This skin is outdated and is incompatible with Masque."] = "This skin is outdated and is incompatible with Masque."
-- L["This skin is outdated but is still compatible with Masque."] = "This skin is outdated but is still compatible with Masque."
-- L["Unknown"] = "Unknown"
-- L["Version"] = "Version"
-- L["Website"] = "Website"
-- L["Websites"] = "Websites"

----------------------------------------
-- Interface Settings
---

L["Enable the Minimap icon."] = "Отображать иконку у миникарты."
-- L["Interface"] = "Interface"
-- L["Interface Settings"] = "Interface Settings"
L["Minimap Icon"] = "Иконка у миникарты"
-- L["Stand-Alone GUI"] = "Stand-Alone GUI"
-- L["This section will allow you to adjust settings that affect Masque's interface."] = "This section will allow you to adjust settings that affect Masque's interface."
-- L["Use a resizable, stand-alone options window."] = "Use a resizable, stand-alone options window."

----------------------------------------
-- LDB Launcher
---

-- L["Click to open Masque's settings."] = "Click to open Masque's settings."

----------------------------------------
-- Performance Settings
---

-- L["Click to load reload the interface."] = "Click to load reload the interface."
-- L["Load the skin information panel."] = "Load the skin information panel."
-- L["Performance"] = "Performance"
-- L["Performance Settings"] = "Performance Settings"
-- L["Reload Interface"] = "Reload Interface"
-- L["Requires an interface reload."] = "Requires an interface reload."
-- L["Skin Information"] = "Skin Information"
-- L["This section will allow you to adjust settings that affect Masque's performance."] = "This section will allow you to adjust settings that affect Masque's performance."

----------------------------------------
-- Profile Settings
---

-- L["Profile Settings"] = "Profile Settings"

----------------------------------------
-- Skin Settings
---

L["Backdrop"] = "Настройки фона"
L["Checked"] = "При выделении"
L["Color"] = "Цвет"
L["Colors"] = "Цвета"
-- L["Cooldown"] = "Cooldown"
L["Disable"] = "Отключить"
L["Disable the skinning of this group."] = "Отключить скины для этой группы."
L["Disabled"] = "Отключенный"
L["Enable"] = "Включить"
L["Enable the Backdrop texture."] = "Включить настройки фона текстуры."
-- L["Enable the Gloss texture."] = "Enable the Gloss texture."
-- L["Enable the Shadow texture."] = "Enable the Shadow texture."
L["Flash"] = "Сверкание"
L["Global"] = "Общее"
-- L["Global Settings"] = "Global Settings"
L["Gloss"] = "Настройки глянца"
L["Highlight"] = "При наведении"
L["Normal"] = "Нормальный"
L["Pushed"] = "При нажатии"
L["Reset all skin options to the defaults."] = "Установить значения цветов по умолчанию."
L["Reset Skin"] = "Сбросить цвета"
L["Set the color of the Backdrop texture."] = "Установить цвет фона текстуры."
L["Set the color of the Checked texture."] = "Установить цвет текстуры при выделении."
-- L["Set the color of the Cooldown animation."] = "Set the color of the Cooldown animation."
L["Set the color of the Disabled texture."] = "Установить цвет отключенной текстуры."
L["Set the color of the Flash texture."] = "Установить цвет текстуры с подсветкой."
L["Set the color of the Gloss texture."] = "Задать цвет для глянца текстур."
L["Set the color of the Highlight texture."] = "Установить цвет текстуры при наведении."
L["Set the color of the Normal texture."] = "Установить нормальный цвет текстуры."
L["Set the color of the Pushed texture."] = "Установить цвет текстуры при нажатии."
-- L["Set the color of the Shadow texture."] = "Set the color of the Shadow texture."
L["Set the skin for this group."] = "Установить скин для данной группы."
-- L["Shadow"] = "Shadow"
L["Skin"] = "Скины"
-- L["Skin Settings"] = "Skin Settings"
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "This section will allow you to adjust the skin settings of all buttons registered to %s."
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."
-- L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "Этот раздел позволяет настроить скины для панелей команд аддонов и групп аддонов, использующих Masque."

----------------------------------------
-- Zoomed Skin
---

-- L["A square skin with zoomed icons and a semi-transparent background."] = "A square skin with zoomed icons and a semi-transparent background."
