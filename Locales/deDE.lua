--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\deDE.lua

	deDE Locale

	[ Notes ]

	To help with translations, use the localization system on CurseForge (https://www.curseforge.com/wow/addons/masque/localization)
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
L["For more information, please visit one of the sites listed below."] = "Für mehr Informationen, besuchen sie bitte die Seiten unten."
L["Masque is a skinning engine for button-based add-ons."] = "Masque ist eine Design-Engine für knopfbasierte Add-ons."
L["Select to view."] = "Auswählen zum ansehen."
L["Supporters"] = "Unterstützer "
L["You must have an add-on that supports Masque installed to use it."] = "Sie müssen ein Addon installiert haben das Masque unterstützt um es zu benutzen. "

----------------------------------------
-- Advanced Settings
---

L["Advanced"] = "Erweitert "
L["Advanced Settings"] = "Erweiterte Einstellungen "
L["Cast Animations"] = "Zauber Animationen "
L["Cooldown Animations"] = "Abklingzeit Animationen"
L["Enable animations when action button cooldowns finish."] = "Aktivieren Sie Animationen, wenn die Abklingzeit von Aktionstasten endet.  "
L["Enable cast animations on action buttons."] = "Aktivieren Sie Cast-Animationen auf Aktionsschaltflächen. "
L["Enable interrupt animations on action buttons."] = "Aktivieren Sie Unterbrechungsanimationen auf Aktionsschaltflächen. "
L["Enable targeting reticles on action buttons."] = "Aktivieren Sie Ziel Makierungen auf Aktionstasten."
L["Flash and Loop"] = "Blinken und Wiederhohlen "
L["Interrupt Animations"] = "Animationen unterbrechen"
L["Loop Only"] = "Nur Wiederhohlen "
-- L["Select the spell alert style."] = "Select the spell alert style."
L["Select which spell alert animations are enabled."] = "Auswahl welche Zauber Warnung aktiviert sein soll. "
-- L["Spell Alert Animations"] = "Spell Alert Animations"
-- L["Spell Alert Style"] = "Spell Alert Style"
L["Targeting Reticles"] = "Ziel Makierungen"
L["This section will allow you to adjust button settings for the default interface."] = "In diesem Abschnitt können Sie die Schaltflächeneinstellungen für die Standart Benutzeroberfläche anpassen. "

----------------------------------------
-- Blizzard Classic Skin
---

L["The default Classic button style."] = "Das klassische Tasten Design. "

----------------------------------------
-- Blizzard Modern Skin
---

L["The default Dragonflight button style."] = "Das Standart Dragonflight Tasten Design."

----------------------------------------
-- Classic Enhanced Skin
---

L["A modified version of the Classic button style."] = "Eine optisch verbesserte Version der Standardschaltflächen des Spiels."

----------------------------------------
-- Core Settings
---

L["About"] = "Über"
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
L["This action cannot be undone. Continue?"] = "Diese Aktion kann nicht rückgängig gemacht werden, Fortfahren? "
L["This section will allow you to adjust settings that affect working with Masque's API."] = "In diesem Abschnitt können Sie Einstellungen vornehmen, die sich auf die Arbeit mit der API von Masque auswirken."

----------------------------------------
-- Dream Skin
---

L["A square skin with trimmed icons and a semi-transparent background."] = "Eine rechteckige Optik mit beschnittenen Symbolen und einem halbtransparenten Hintergrund."

----------------------------------------
-- General Settings
---

L["General Settings"] = "Allgemeine Einstellungen"
L["This section will allow you to adjust Masque's interface and performance settings."] = "In diesem Abschnitt können Sie die Oberfläche- und Leistungseinstellungen von Masque anpassen."

----------------------------------------
-- Installed Skins
---

L["Author"] = "Autor"
L["Authors"] = "Autoren"
L["Compatible"] = "Kompatibel"
L["Description"] = "Beschreibung"
L["Discord"] = "Discord"
L["Installed Skins"] = "Installierte Optiken"
L["No description available."] = "Keine Beschreibung verfügbar."
L["Status"] = "Status"
L["The status of this skin is unknown."] = "Der Status dieser Optik ist unbekannt."
L["This section provides information on any skins you have installed."] = "In diesem Abschnitt finden Sie Informationen zu den von Ihnen installierten Designs."
L["This skin is compatible with Masque."] = "Diese Optik ist mit Masque kompatibel."
L["This skin is outdated but is still compatible with Masque."] = "Dieser Skin ist veraltet, aber noch immer mit Masque kompatibel."
L["Unknown"] = "Unbekannt"
L["Version"] = "Version"
L["Website"] = "Webseite"
L["Websites"] = "Webseiten"

----------------------------------------
-- Interface Settings
---

L["Add-On Compartment"] = "Addon Abteil  "
L["Alternate Sorting"] = "Alternative Sortierung "
L["Causes the skins included with Masque to be listed above third-party skins."] = "Bewirkt, dass die in Masque enthaltenen Skins vor den Skins von Drittanbietern aufgeführt werden."
L["Click to reload the interface."] = "Klicken, um die Benutzeroberfläche neu zu laden."
L["Interface"] = "Interface"
L["Interface Settings"] = "Interfaceeinstellungen"
L["Load the skin information panel."] = "Lade das Design Informations Fenster."
L["Menu Icon"] = "Menü-Symbol"
L["Minimap"] = "Minikarte"
L["None"] = "Keine "
L["Reload Interface"] = "Benutzeroberfläche neu laden."
L["Requires an interface reload."] = "Benötigt ein Neuladen des Benutzeroberfläche"
L["Select where Masque's menu icon is displayed."] = "Auswahl wo das Menüsymbol von Masque angezeigt wird. "
L["Skin Information"] = "Optikinformation"
L["Stand-Alone GUI"] = "Eigenständige Benutzeroberfläche"
L["This section will allow you to adjust settings that affect Masque's interface."] = "In diesem Abschnitt können Sie Einstellungen vornehmen, die die Masque-Oberfläche betreffen."
L["Use a resizable, stand-alone options window."] = "Verwenden Sie ein in der Größe veränderbares, eigenständiges Optionsfenster."

----------------------------------------
-- LDB Launcher
---

L["Click to open Masque's settings."] = "Klicken, um die Masque-Einstellungen zu öffnen."
L["Unavailable in combat."] = "Nicht verfügbar im Kampf."

----------------------------------------
-- Modern Enhanced Skin
---

L["An enhanced version of the Dragonflight button style."] = "Eine verbesserte Version des Dragonflight Button Styles. "

----------------------------------------
-- Profile Settings
---

L["Profile Settings"] = "Profileinstellungen."

----------------------------------------
-- Skin Settings
---

L["Adjust the scale of this group's skin."] = "Einstellung der skalierung des Gruppen Designs."
L["Backdrop"] = "Hintergrund Einstellungen"
L["Checked"] = "Ausgewählt"
L["Color"] = "Farbe"
L["Colors"] = "Farben"
L["Cooldown"] = "Abklingzeit"
L["Disable"] = "Deaktivieren"
L["Disable the skinning of this group."] = "Deaktiviert die Aussehensveränderung dieser Gruppe."
L["Enable"] = "Aktivieren"
L["Enable skin scaling."] = "Aktivieren Sie die Designskalierung. "
L["Enable the Backdrop texture."] = "Aktiviert die Hintergrundtextur."
L["Enable the Gloss texture."] = "Aktiviere die Glanztextur."
L["Enable the Shadow texture."] = "Schatten Texture aktivieren "
L["Flash"] = "Leuchten"
L["Global"] = "Global"
L["Global Settings"] = "Globale Einstellungen"
L["Gloss"] = "Glanz"
L["Highlight"] = "Hervorheben"
L["Normal"] = "Normal"
L["Pulse"] = "Pulsieren "
L["Pushed"] = "Gedrückt"
L["Reset all skin options to the defaults."] = "Setzt alle Optikoptionen auf Standard zurück."
L["Reset Skin"] = "Optik zurücksetzen"
L["Scale"] = "Skalierung "
L["Set the color of the Backdrop texture."] = "Lege die Farbe der Hintergrundtextur fest"
L["Set the color of the Checked texture."] = "Lege die Farbe der Markiert-Textur fest"
L["Set the color of the Cooldown animation."] = "Lege die Farbe der Abklingzeit-Animation fest."
L["Set the color of the Flash texture."] = "Lege die Farbe der Leucht-Textur fest"
L["Set the color of the Gloss texture."] = "Lege die Farbe der Glanz-Textur fest"
L["Set the color of the Highlight texture."] = "Lege die Farbe Hervorgehoben-Textur"
L["Set the color of the Normal texture."] = "Lege die Farbe der Normal-Textur fest"
L["Set the color of the Pushed texture."] = "Lege die Farbe der Gedrückt-Textur fest"
L["Set the color of the Shadow texture."] = "Legen Sie die Farbe der Schatten Textur fest."
L["Set the skin for this group."] = "Lege die Optik dieser Gruppe fest"
L["Shadow"] = "Schatten"
L["Show the pulse effect when a cooldown finishes."] = "Zeige den Pulseffekt, wenn eine Abklingzeit beendet ist."
L["Skin"] = "Optik"
L["Skin Settings"] = "Optikeinstellungen"
L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "In diesem Abschnitt können Sie die Design-Einstellungen für alle unter %s registrierten Schaltflächen anpassen."
L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "In diesem Abschnitt können Sie die Design-Einstellungen für alle unter %s registrierten Schaltflächen anpassen. Dadurch werden alle gruppenbezogenen Einstellungen überschrieben."
L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "Dieser Abschnitt ermöglicht es dir die Einstellungen der Optiken von allen registrierten Schaltflächen zu verändern. Dies wird jegliche addonspezifischen Einstellungen überschreiben."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "Dieser Abschnitt ermöglicht es dir, das Aussehen von Buttons der Addons und Addongruppen anzupassen, die mit Masque verbunden sind."

----------------------------------------
-- Zoomed Skin
---

L["A square skin with zoomed icons and a semi-transparent background."] = "Eine rechteckige Optik mit vergrößerten Symbolen und einem halbtransparenten Hintergrund."
