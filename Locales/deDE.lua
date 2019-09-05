--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For license information,
	please see the included License.txt file or visit https://github.com/StormFX/Masque.

	* File...: Locales\deDE.lua

	deDE Locale

	[ Notes ]

	To help with translations, use the localization system on WoWAce (https://www.wowace.com/projects/masque/localization)
	or contribute directly on GitHub (https://github.com/StormFX/Masque).

]]

-- GLOBALS: GetLocale

if GetLocale() ~= "deDE" then return end

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

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Veranlasst Masque Lua-Fehler auszugeben, wann immer es ein Problem mit einem Addon oder einer Optik gibt."
-- L["Clean Database"] = "Clean Database"
-- L["Click to purge the settings of all unused add-ons and groups."] = "Click to purge the settings of all unused add-ons and groups."-- L["Debug Mode"] = "Debug Mode"
L["Debug Mode"] = "Debugmodus"
-- L["Developer"] = "Developer"
-- L["Developer Settings"] = "Developer Settings"
L["Masque debug mode disabled."] = "Masque Debugmodus deaktiviert."
L["Masque debug mode enabled."] = "Masque Debugmodus aktiviert."
-- L["This action cannot be undone. Continue?"] = "This action cannot be undone. Continue?"
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

L["Author"] = "Autor"
L["Authors"] = "Autoren"
-- L["Click for details."] = "Click for details."
L["Compatible"] = "Kompatibel"
L["Description"] = "Beschreibung"
L["Incompatible"] = "Inkompatibel"
L["Installed Skins"] = "Installierte Optiken"
L["No description available."] = "Keine Beschreibung verfügbar."
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

L["Enable the Minimap icon."] = "Aktiviert das Minikartensymbol"
-- L["Interface"] = "Interface"
-- L["Interface Settings"] = "Interface Settings"
L["Minimap Icon"] = "Minikartensymbol"
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

L["Profile Settings"] = "Profileinstellungen."

----------------------------------------
-- Skin Settings
---

L["Backdrop"] = "Hintergruneinstellungen"
L["Checked"] = "Ausgewählt"
L["Color"] = "Farbe"
L["Colors"] = "Farben"
L["Cooldown"] = "Abklingzeit"
L["Disable"] = "Deaktivieren"
L["Disable the skinning of this group."] = "Deaktiviert die Aussehensveränderung dieser Gruppe."
L["Disabled"] = "Deaktiviert"
L["Enable"] = "Aktivieren"
L["Enable the Backdrop texture."] = "Aktiviert die Hintergrundtextur."
-- L["Enable the Gloss texture."] = "Enable the Gloss texture."
-- L["Enable the Shadow texture."] = "Enable the Shadow texture."
L["Flash"] = "Leuchten"
L["Global"] = "Global"
-- L["Global Settings"] = "Global Settings"
L["Gloss"] = "Glanzeinstellungen"
L["Highlight"] = "Hervorheben"
L["Normal"] = "Normal"
L["Pushed"] = "Gedrückt"
L["Reset all skin options to the defaults."] = "Setzt alle Optikoptionen auf Standard zurück."
L["Reset Skin"] = "Optik zurücksetzen"
L["Set the color of the Backdrop texture."] = "Lege die Farbe der Hintergrundtextur fest"
L["Set the color of the Checked texture."] = "Lege die Farbe der Markiert-Textur fest"
L["Set the color of the Cooldown animation."] = "Lege die Farbe der Abklingzeit-Animation fest."
L["Set the color of the Disabled texture."] = "Lege die Farbe der Deaktiviert-Textur fest"
L["Set the color of the Flash texture."] = "Lege die Farbe der Leucht-Textur fest"
L["Set the color of the Gloss texture."] = "Lege die Farbe der Glanz-Textur fest"
L["Set the color of the Highlight texture."] = "Lege die Farbe Hervorgehoben-Textur"
L["Set the color of the Normal texture."] = "Lege die Farbe der Normal-Textur fest"
L["Set the color of the Pushed texture."] = "Lege die Farbe der Gedrückt-Textur fest"
-- L["Set the color of the Shadow texture."] = "Set the color of the Shadow texture."
L["Set the skin for this group."] = "Lege die Optik dieser Gruppe fest"
-- L["Shadow"] = "Shadow"
L["Skin"] = "Optik"
-- L["Skin Settings"] = "Skin Settings"
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "This section will allow you to adjust the skin settings of all buttons registered to %s."
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."
-- L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "Dieser Abschnitt ermöglicht es dir, das Aussehen von Buttons der Addons und Addongruppen anzupassen, die mit Masque verbunden sind."

----------------------------------------
-- Zoomed Skin
---

-- L["A square skin with zoomed icons and a semi-transparent background."] = "A square skin with zoomed icons and a semi-transparent background."
