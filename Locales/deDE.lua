--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\deDE.lua

	deDE Locale

	[ Notes ]

	To help with translations, use the localization system on WoWAce (https://www.wowace.com/projects/masque/localization)
	or contribute directly on GitHub (https://github.com/SFX-WoW/Masque).

]]

if GetLocale() ~= "deDE" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

L["About Masque"] = "Über Masque"
L["API"] = "API"
-- L["For more information, please visit one of the sites listed below."] = "For more information, please visit one of the sites listed below."
-- L["Masque is a skinning engine for button-based add-ons."] = "Masque is a skinning engine for button-based add-ons."
-- L["Select to view."] = "Select to view."
-- L["You must have an add-on that supports Masque installed to use it."] = "You must have an add-on that supports Masque installed to use it."

----------------------------------------
-- Classic Skin
---

L["An improved version of the game's default button style."] = "Eine optisch verbesserte Version der Standardschaltflächen des Spiels."

----------------------------------------
-- Core Settings
---

L["About"] = "Über"
L["Click to load Masque's options."] = "Klicken, um die Masque-Optionen zu laden."
-- L["Load Options"] = "Load Options"
-- L["Masque's options are load on demand. Click the button below to load them."] = "Masque's options are load on demand. Click the button below to load them."
-- L["This action will increase memory usage."] = "This action will increase memory usage."
L["This section will allow you to view information about Masque and any skins you have installed."] = "Dieser Abschnitt zeigt dir Infomationen über Masque und aller installierten Skins."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Veranlasst Masque Lua-Fehler auszugeben, wann immer es ein Problem mit einem Addon oder einer Optik gibt."
L["Clean Database"] = "Datenbank bereinigen"
L["Click to purge the settings of all unused add-ons and groups."] = "Klicken, um die Einstellungen von allen ungenutzten Add-Ons und Gruppen zu bereinigen."
L["Debug Mode"] = "Debugmodus"
L["Developer"] = "Entwickler"
L["Developer Settings"] = "Entwicklereinstellungen"
L["Masque debug mode disabled."] = "Masque Debugmodus deaktiviert."
L["Masque debug mode enabled."] = "Masque Debugmodus aktiviert."
-- L["This action cannot be undone. Continue?"] = "This action cannot be undone. Continue?"
-- L["This section will allow you to adjust settings that affect working with Masque's API."] = "This section will allow you to adjust settings that affect working with Masque's API."

----------------------------------------
-- Dream Skin
---

L["A square skin with trimmed icons and a semi-transparent background."] = "Eine rechteckige Optik mit beschnittenen Symbolen und einem halbtransparenten Hintergrund."

----------------------------------------
-- General Settings
---

L["General Settings"] = "Allgemeine Einstellungen"
-- L["This section will allow you to adjust Masque's interface and performance settings."] = "This section will allow you to adjust Masque's interface and performance settings."

----------------------------------------
-- Installed Skins
---

L["Author"] = "Autor"
L["Authors"] = "Autoren"
L["Click for details."] = "Klicken, um Details anzuzeigen."
L["Compatible"] = "Kompatibel"
L["Description"] = "Beschreibung"
L["Incompatible"] = "Inkompatibel"
L["Installed Skins"] = "Installierte Optiken"
L["No description available."] = "Keine Beschreibung verfügbar."
L["Status"] = "Status"
L["The status of this skin is unknown."] = "Der Status dieser Optik ist unbekannt."
-- L["This section provides information on any skins you have installed."] = "This section provides information on any skins you have installed."
L["This skin is compatible with Masque."] = "Diese Optik ist mit Masque kompatibel."
L["This skin is outdated and is incompatible with Masque."] = "Diese Optik ist veraltet und nicht mit Masque kompatibel."
L["This skin is outdated but is still compatible with Masque."] = "Dieser Skin ist veraltet, aber noch immer mit Masque kompatibel."
L["Unknown"] = "Unbekannt"
L["Version"] = "Version"
L["Website"] = "Webseite"
L["Websites"] = "Webseiten"

----------------------------------------
-- Interface Settings
---

L["Enable the Minimap icon."] = "Aktiviert das Minikartensymbol"
L["Interface"] = "Interface"
L["Interface Settings"] = "Interfaceeinstellungen"
L["Minimap Icon"] = "Minikartensymbol"
-- L["Stand-Alone GUI"] = "Stand-Alone GUI"
-- L["This section will allow you to adjust settings that affect Masque's interface."] = "This section will allow you to adjust settings that affect Masque's interface."
-- L["Use a resizable, stand-alone options window."] = "Use a resizable, stand-alone options window."

----------------------------------------
-- LDB Launcher
---

L["Click to open Masque's settings."] = "Klicken, um die Masque-Einstellungen zu öffnen."

----------------------------------------
-- Performance Settings
---

L["Click to load reload the interface."] = "Klicken, um die Benutzeroberfläche neu zu laden."
-- L["Load the skin information panel."] = "Load the skin information panel."
L["Performance"] = "Leistung"
L["Performance Settings"] = "Leistungseinstellungen"
L["Reload Interface"] = "Benutzeroberfläche neu laden."
-- L["Requires an interface reload."] = "Requires an interface reload."
L["Skin Information"] = "Optikinformation"
-- L["This section will allow you to adjust settings that affect Masque's performance."] = "This section will allow you to adjust settings that affect Masque's performance."

----------------------------------------
-- Profile Settings
---

L["Profile Settings"] = "Profileinstellungen."

----------------------------------------
-- Skin Settings
---

L["Backdrop"] = "Hintergrund Einstellungen"
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
L["Global Settings"] = "Globale Einstellungen"
L["Gloss"] = "Glanz"
L["Highlight"] = "Hervorheben"
L["Normal"] = "Normal"
-- L["Pulse"] = "Pulse"
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
L["Shadow"] = "Schatten"
-- L["Show the pulse effect when a cooldown finishes."] = "Show the pulse effect when a cooldown finishes."
L["Skin"] = "Optik"
L["Skin Settings"] = "Optikeinstellungen"
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "This section will allow you to adjust the skin settings of all buttons registered to %s."
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."
L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "Dieser Abschnitt ermöglicht es dir die Einstellungen der Optiken von allen registrierten Schaltflächen zu verändern. Dies wird jegliche addonspezifischen Einstellungen überschreiben."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "Dieser Abschnitt ermöglicht es dir, das Aussehen von Buttons der Addons und Addongruppen anzupassen, die mit Masque verbunden sind."

----------------------------------------
-- Zoomed Skin
---

L["A square skin with zoomed icons and a semi-transparent background."] = "Eine rechteckige Optik mit vergrößerten Symbolen und einem halbtransparenten Hintergrund."
