--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\itIT.lua

	itIT Locale

	[ Notes ]

	To help with translations, use the localization system on CurseForge (https://www.curseforge.com/wow/addons/masque/localization)
	or contribute directly on GitHub (https://github.com/SFX-WoW/Masque).

]]

if GetLocale() ~= "itIT" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

-- L["About Masque"] = "About Masque"
L["API"] = "API"
L["For more information, please visit one of the sites listed below."] = "Per ulteriori informazioni, visita uno dei siti elencati di seguito."
L["Masque is a skinning engine for button-based add-ons."] = "Masque è un sistema di gestione skin per add-on basati sui pulsanti."
L["Select to view."] = "Seleziona per visualizzare."
L["Supporters"] = "Sostenitori"
L["You must have an add-on that supports Masque installed to use it."] = "Per usare Masque devi avere installato un add-on che lo supporta."

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

-- L["The default Classic button style."] = "The default Classic button style."

----------------------------------------
-- Blizzard Modern Skin
---

-- L["The default Dragonflight button style."] = "The default Dragonflight button style."

----------------------------------------
-- Classic Enhanced Skin
---

L["A modified version of the Classic button style."] = "Una versione modificata dello stile per pulsanti Classico."

----------------------------------------
-- Core Settings
---

-- L["About"] = "About"
L["This section will allow you to view information about Masque and any skins you have installed."] = "Questa sezione ti permetterà di visualizzare le informazioni su Masque e ogni skin installata."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Forza Masque a visualizzare un errore Lua ogni volta che c'é un problema con un'add-on o una skin."
L["Clean Database"] = "Pulisci Database"
L["Click to purge the settings of all unused add-ons and groups."] = "Clicca per pulire le impostazioni di tutti gli add-on e gruppi inutilizzati."
L["Debug Mode"] = "Modalità Debug"
L["Developer"] = "Sviluppatore"
L["Developer Settings"] = "Impostazioni Sviluppatore"
L["Masque debug mode disabled."] = "Modalità Debug Masque Disbilitata."
L["Masque debug mode enabled."] = "Modalità Debug Masque Abilitata."
L["This action cannot be undone. Continue?"] = "Questa azione non può essere annullata. Continuare?"
L["This section will allow you to adjust settings that affect working with Masque's API."] = "Questa sezione ti permetterà di modificare le impostazioni che riguardano l'API di Masque."

----------------------------------------
-- Dream Skin
---

-- L["A square skin with trimmed icons and a semi-transparent background."] = "A square skin with trimmed icons and a semi-transparent background."

----------------------------------------
-- General Settings
---

L["General Settings"] = "Impostazioni Generali"
L["This section will allow you to adjust Masque's interface and performance settings."] = "Questa sezione ti permetterà di modificare le impostazioni che riguardano l'interfaccia e le prestazioni di Masque."

----------------------------------------
-- Installed Skins
---

L["Author"] = "Autore"
L["Authors"] = "Autori"
L["Compatible"] = "Compatibile"
L["Description"] = "Descrizione"
L["Discord"] = "Discord"
L["Installed Skins"] = "Skin Installate"
L["No description available."] = "Descrizione non disponibile."
L["Status"] = "Stato"
L["The status of this skin is unknown."] = "Lo stato di questa skin è sconosciuto."
L["This section provides information on any skins you have installed."] = "Questa sezione fornisce informazioni su ogni skin installata."
L["This skin is compatible with Masque."] = "Questa skin è compatibile con Masque."
L["This skin is outdated but is still compatible with Masque."] = "Questa skin è obsoleta ma ancora compatibile con Masque."
L["Unknown"] = "Sconosciuto"
L["Version"] = "Versione"
L["Website"] = "Sito"
L["Websites"] = "Siti"

----------------------------------------
-- Interface Settings
---

-- L["Add-On Compartment"] = "Add-On Compartment"
L["Alternate Sorting"] = "Ordinamento Alternativo"
L["Causes the skins included with Masque to be listed above third-party skins."] = "Elenca le skin incluse con Masque prima delle skin di terze parti."
L["Click to reload the interface."] = "Clicca per ricaricare l'interfaccia."
L["Interface"] = "Interfaccia"
L["Interface Settings"] = "Impostazioni Interfaccia"
L["Load the skin information panel."] = "Carica il pannello di informazioni delle skin."
L["Menu Icon"] = "Pulsante Menu"
L["Minimap"] = "Minimappa"
L["None"] = "Nessuna"
L["Reload Interface"] = "Ricarica Interfaccia"
L["Requires an interface reload."] = "Richiede di ricaricare l'interfaccia."
L["Select where Masque's menu icon is displayed."] = "Seleziona dove mostrare il pulsante per aprire il menu di Masque."
L["Skin Information"] = "Informazioni Skin"
-- L["Stand-Alone GUI"] = "Stand-Alone GUI"
L["This section will allow you to adjust settings that affect Masque's interface."] = "Questa sezione ti permetterà di modificare le impostazioni che riguardano l'interfaccia di Masque."
-- L["Use a resizable, stand-alone options window."] = "Use a resizable, stand-alone options window."

----------------------------------------
-- LDB Launcher
---

L["Click to open Masque's settings."] = "Clicca per aprire le impostazioni di Masque."
-- L["Unavailable in combat."] = "Unavailable in combat."

----------------------------------------
-- Modern Enhanced Skin
---

L["An enhanced version of the Dragonflight button style."] = "Una versione migliorata dello stile di pulsanti Dragonflight."

----------------------------------------
-- Profile Settings
---

L["Profile Settings"] = "Impostazioni Profili"

----------------------------------------
-- Skin Settings
---

L["Adjust the scale of this group's skin."] = "Regola le dimensioni di questo gruppo di skin."
L["Backdrop"] = "Impostazioni Sfondo"
L["Checked"] = "Controllato"
L["Color"] = "Colore"
L["Colors"] = "Colori"
L["Cooldown"] = "Cooldown"
L["Disable"] = "Disabilita"
L["Disable the skinning of this group."] = "Disabilita lo skinning per questo gruppo."
L["Enable"] = "Abilita"
L["Enable skin scaling."] = "Attiva il ridimensionamento della skin."
L["Enable the Backdrop texture."] = "Abilita la texture di sfondo."
-- L["Enable the Gloss texture."] = "Enable the Gloss texture."
-- L["Enable the Shadow texture."] = "Enable the Shadow texture."
L["Flash"] = "Lampeggio"
L["Global"] = "Globale"
L["Global Settings"] = "Impostazioni Globali"
L["Gloss"] = "Impostazioni Gloss"
L["Highlight"] = "Evidenziato"
L["Normal"] = "Normale"
-- L["Pulse"] = "Pulse"
L["Pushed"] = "Forzata"
L["Reset all skin options to the defaults."] = "Reimposta i valori predefiniti della skin. "
L["Reset Skin"] = "Reimposta Skin"
L["Scale"] = "Dimensione"
L["Set the color of the Backdrop texture."] = "Imposta il colore della texture di sfondo."
L["Set the color of the Checked texture."] = "Imposta il colore della texture controllata."
L["Set the color of the Cooldown animation."] = "Imposta il colore dell'animazione del coldown"
L["Set the color of the Flash texture."] = "Imposta il colore della texture lampeggiante."
L["Set the color of the Gloss texture."] = "Imposta il colore della texture gloss."
L["Set the color of the Highlight texture."] = "Imposta il colore della texture evidenziata."
L["Set the color of the Normal texture."] = "Imposta il colore della texture normale."
L["Set the color of the Pushed texture."] = "Imposta il colore della texture forzata."
-- L["Set the color of the Shadow texture."] = "Set the color of the Shadow texture."
L["Set the skin for this group."] = "Imposta la skin per questo gruppo."
L["Shadow"] = "Ombra"
-- L["Show the pulse effect when a cooldown finishes."] = "Show the pulse effect when a cooldown finishes."
L["Skin"] = "Skin"
L["Skin Settings"] = "Impostazioni Skin"
L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "Questa sezione ti permetterà di modificare le impostazioni delle skin di tutti i pulsanti registrati a %s."
L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "Questa sezione ti permetterà di modificare le impostazioni delle skin di tutti i pulsanti registrati a %s. Fare ciò sovrascriverà le impostazioni a livello di gruppo."
L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "Questa sezione ti permetterà di modificare le impostazioni delle skin di tutti i pulsanti registrati. Fare ciò sovrascriverà le impostazioni a livello di add-on."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "Questa sezione ti permetterà di gestire le skin dei pulsanti degli add-on o a gruppi di add-on registrati con Masque."

----------------------------------------
-- Zoomed Skin
---

-- L["A square skin with zoomed icons and a semi-transparent background."] = "A square skin with zoomed icons and a semi-transparent background."
