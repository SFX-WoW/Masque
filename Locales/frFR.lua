--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\frFR.lua

	frFR Locale

	[ Notes ]

	To help with translations, use the localization system on WoWAce (https://www.wowace.com/projects/masque/localization)
	or contribute directly on GitHub (https://github.com/SFX-WoW/Masque).

]]

if GetLocale() ~= "frFR" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

L["About Masque"] = "À propos de Masque"
L["API"] = "API"
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

L["About"] = "À propos"
-- L["Click to load Masque's options."] = "Click to load Masque's options."
L["Load Options"] = "Options de chargement"
-- L["Masque's options are load on demand. Click the button below to load them."] = "Masque's options are load on demand. Click the button below to load them."
-- L["This action will increase memory usage."] = "This action will increase memory usage."
-- L["This section will allow you to view information about Masque and any skins you have installed."] = "This section will allow you to view information about Masque and any skins you have installed."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Masque ignorera les erreurs Lua lorsqu'il rencontre un problème avec un add-on ou un skin (style)."
L["Clean Database"] = "Nettoyer la base de donnée"
-- L["Click to purge the settings of all unused add-ons and groups."] = "Click to purge the settings of all unused add-ons and groups."
L["Debug Mode"] = "Mode débogage"
-- L["Developer"] = "Developer"
-- L["Developer Settings"] = "Developer Settings"
L["Masque debug mode disabled."] = "Débogage de Masque désactivé."
L["Masque debug mode enabled."] = "Débogage de Masque activé."
-- L["This action cannot be undone. Continue?"] = "This action cannot be undone. Continue?"
-- L["This section will allow you to adjust settings that affect working with Masque's API."] = "This section will allow you to adjust settings that affect working with Masque's API."

----------------------------------------
-- Dream Skin
---

-- L["A square skin with trimmed icons and a semi-transparent background."] = "A square skin with trimmed icons and a semi-transparent background."

----------------------------------------
-- General Settings
---

L["General Settings"] = "Paramètres généraux"
-- L["This section will allow you to adjust Masque's interface and performance settings."] = "This section will allow you to adjust Masque's interface and performance settings."

----------------------------------------
-- Installed Skins
---

L["Author"] = "Auteur"
L["Authors"] = "Auteurs"
-- L["Click for details."] = "Click for details."
L["Compatible"] = "Compatible"
L["Description"] = "Description"
L["Incompatible"] = "Incompatible"
-- L["Installed Skins"] = "Installed Skins"
L["No description available."] = "Description Indisponible"
L["Status"] = "État"
-- L["The status of this skin is unknown."] = "The status of this skin is unknown."
-- L["This section provides information on any skins you have installed."] = "This section provides information on any skins you have installed."
-- L["This skin is compatible with Masque."] = "This skin is compatible with Masque."
-- L["This skin is outdated and is incompatible with Masque."] = "This skin is outdated and is incompatible with Masque."
-- L["This skin is outdated but is still compatible with Masque."] = "This skin is outdated but is still compatible with Masque."
L["Unknown"] = "Inconnu"
L["Version"] = "Version"
L["Website"] = "Site Internet"
L["Websites"] = "Sites Internet"

----------------------------------------
-- Interface Settings
---

L["Enable the Minimap icon."] = "Active l'icône de la minicarte."
L["Interface"] = "Interface"
L["Interface Settings"] = "Paramètres d'interface"
L["Minimap Icon"] = "Icône de la minicarte"
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
L["Performance"] = "Performance"
L["Performance Settings"] = "Paramètres de Performance"
L["Reload Interface"] = "Recharger l'Interface"
-- L["Requires an interface reload."] = "Requires an interface reload."
-- L["Skin Information"] = "Skin Information"
-- L["This section will allow you to adjust settings that affect Masque's performance."] = "This section will allow you to adjust settings that affect Masque's performance."

----------------------------------------
-- Profile Settings
---

L["Profile Settings"] = "Paramètres de Profil"

----------------------------------------
-- Skin Settings
---

L["Backdrop"] = "Paramètres de fond"
L["Checked"] = "Coché"
L["Color"] = "Couleur"
L["Colors"] = "Couleurs"
L["Cooldown"] = "Cooldown"
L["Disable"] = "Désactiver"
L["Disable the skinning of this group."] = "Désactiver le skin (style) de ce groupe."
L["Disabled"] = "Désactivé"
L["Enable"] = "Activer"
L["Enable the Backdrop texture."] = "Activer la texture de fond."
-- L["Enable the Gloss texture."] = "Enable the Gloss texture."
-- L["Enable the Shadow texture."] = "Enable the Shadow texture."
L["Flash"] = "Flash"
L["Global"] = "Global"
L["Global Settings"] = "Paramètres Globaux"
L["Gloss"] = "Paramètres du vernis"
L["Highlight"] = "Surbrillance"
L["Normal"] = "Normal"
-- L["Pulse"] = "Pulse"
L["Pushed"] = "Enfoncé"
L["Reset all skin options to the defaults."] = "Restaure les couleurs par défauts."
L["Reset Skin"] = "Réinit. toutes les couleurs"
L["Set the color of the Backdrop texture."] = "Définir la couleur de la texture de fond."
L["Set the color of the Checked texture."] = "Définir la couleur de la texture cochée."
L["Set the color of the Cooldown animation."] = "Définir la couleur de l'animation du cooldown"
L["Set the color of the Disabled texture."] = "Définir la couleur de la texture désactivée."
L["Set the color of the Flash texture."] = "Définir la couleur de la texture clignotante."
L["Set the color of the Gloss texture."] = "Définir la couleur de la texture du vernis. "
L["Set the color of the Highlight texture."] = "Définir la couleur de la surbrillance."
L["Set the color of the Normal texture."] = "Définir la couleur de la texture normale."
L["Set the color of the Pushed texture."] = "Définir la couleur de la texture appuyée."
-- L["Set the color of the Shadow texture."] = "Set the color of the Shadow texture."
L["Set the skin for this group."] = "Définir le skin (style) pour ce groupe."
L["Shadow"] = "Ombrage"
-- L["Show the pulse effect when a cooldown finishes."] = "Show the pulse effect when a cooldown finishes."
L["Skin"] = "Skin"
-- L["Skin Settings"] = "Skin Settings"
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "This section will allow you to adjust the skin settings of all buttons registered to %s."
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."
-- L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "Cette section vous permet de définir le skin (style) des boutons des add-ons et des groupes d'add-ons enregistrés avec Masque."

----------------------------------------
-- Zoomed Skin
---

-- L["A square skin with zoomed icons and a semi-transparent background."] = "A square skin with zoomed icons and a semi-transparent background."
