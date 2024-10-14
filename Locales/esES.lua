--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\esES.lua

	esMX/esES Locale

	[ Notes ]

	To help with translations, use the localization system on CurseForge (https://www.curseforge.com/wow/addons/masque/localization)
	or contribute directly on GitHub (https://github.com/SFX-WoW/Masque).

]]

local Locale = GetLocale()
if Locale ~= "esMX" and Locale ~= "esES" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

L["About Masque"] = "Acerca de Masque"
L["API"] = "API"
L["For more information, please visit one of the sites listed below."] = "Para más información, visita uno de los sitios listados a continuación."
L["Masque is a skinning engine for button-based add-ons."] = "Masque es un sistema de cambio de apariencia para los addons de botones."
L["Select to view."] = "Selecciona para ver."
-- L["Supporters"] = "Supporters"
-- L["You must have an add-on that supports Masque installed to use it."] = "You must have an add-on that supports Masque installed to use it."

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

L["A modified version of the Classic button style."] = "Una versión mejorada del diseño de los botones por defecto del juego."

----------------------------------------
-- Core Settings
---

L["About"] = "Acerca de"
-- L["This section will allow you to view information about Masque and any skins you have installed."] = "This section will allow you to view information about Masque and any skins you have installed."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Mostrar errores Lua al encontrar una problema con un add-on o una tema."
L["Clean Database"] = "Limpiar base de datos"
L["Click to purge the settings of all unused add-ons and groups."] = "Haz clic para purgar la configuración de todos los add-ons y grupos no utilizados."
L["Debug Mode"] = "Depuración"
L["Developer"] = "Desarrollador"
L["Developer Settings"] = "Ajustes de desarrollador"
L["Masque debug mode disabled."] = "La depuración de Masque se ha desactivada."
L["Masque debug mode enabled."] = "La depuración de Masque se ha activada."
-- L["This action cannot be undone. Continue?"] = "This action cannot be undone. Continue?"
-- L["This section will allow you to adjust settings that affect working with Masque's API."] = "This section will allow you to adjust settings that affect working with Masque's API."

----------------------------------------
-- Dream Skin
---

L["A square skin with trimmed icons and a semi-transparent background."] = "Una apariencia cuadrada con iconos recortados y un fondo semitransparente."

----------------------------------------
-- General Settings
---

L["General Settings"] = "Ajustes generales"
-- L["This section will allow you to adjust Masque's interface and performance settings."] = "This section will allow you to adjust Masque's interface and performance settings."

----------------------------------------
-- Installed Skins
---

L["Author"] = "Autor"
L["Authors"] = "Autores"
L["Compatible"] = "Compatible"
L["Description"] = "Descripción"
-- L["Discord"] = "Discord"
L["Installed Skins"] = "Apariencias instaladas"
L["No description available."] = "Descripción no disponible."
-- L["Status"] = "Status"
-- L["The status of this skin is unknown."] = "The status of this skin is unknown."
-- L["This section provides information on any skins you have installed."] = "This section provides information on any skins you have installed."
-- L["This skin is compatible with Masque."] = "This skin is compatible with Masque."
-- L["This skin is outdated but is still compatible with Masque."] = "This skin is outdated but is still compatible with Masque."
-- L["Unknown"] = "Unknown"
L["Version"] = "Versión"
L["Website"] = "Sitio web"
L["Websites"] = "Sitios web"

----------------------------------------
-- Interface Settings
---

-- L["Add-On Compartment"] = "Add-On Compartment"
L["Alternate Sorting"] = "Ordenación alternativa"
L["Causes the skins included with Masque to be listed above third-party skins."] = "Hace que las skins incluidas con Masque aparezcan por encima de las skins de terceros."
L["Click to reload the interface."] = "Haz clic para recargar la interfaz."
L["Interface"] = "Interfaz"
L["Interface Settings"] = "Ajustes de interfaz"
L["Load the skin information panel."] = "Cargar panel de información de apariencias."
-- L["Menu Icon"] = "Menu Icon"
-- L["Minimap"] = "Minimap"
-- L["None"] = "None"
L["Reload Interface"] = "Recargar interfaz"
L["Requires an interface reload."] = "Recarga de interfaz requerida."
-- L["Select where Masque's menu icon is displayed."] = "Select where Masque's menu icon is displayed."
L["Skin Information"] = "Información de apariencia"
-- L["Stand-Alone GUI"] = "Stand-Alone GUI"
-- L["This section will allow you to adjust settings that affect Masque's interface."] = "This section will allow you to adjust settings that affect Masque's interface."
-- L["Use a resizable, stand-alone options window."] = "Use a resizable, stand-alone options window."

----------------------------------------
-- LDB Launcher
---

L["Click to open Masque's settings."] = "Haz clic para abrir los ajustes de Masque."
-- L["Unavailable in combat."] = "Unavailable in combat."

----------------------------------------
-- Modern Enhanced Skin
---

L["An enhanced version of the Dragonflight button style."] = "Una versión mejorada del estilo de los botones de Dragonflight."

----------------------------------------
-- Profile Settings
---

L["Profile Settings"] = "Ajustes de perfil"

----------------------------------------
-- Skin Settings
---

-- L["Adjust the scale of this group's skin."] = "Adjust the scale of this group's skin."
L["Backdrop"] = "Opciones de Fondo"
L["Checked"] = "Activado"
L["Color"] = "Color"
L["Colors"] = "Colores"
L["Cooldown"] = "Enfriamiento"
L["Disable"] = "Desactivado"
L["Disable the skinning of this group."] = "Deshabilitar las texturas para este grupo."
L["Enable"] = "Activado"
-- L["Enable skin scaling."] = "Enable skin scaling."
L["Enable the Backdrop texture."] = "Habilitar la textura de fondo."
L["Enable the Gloss texture."] = "Activar textura brillante."
L["Enable the Shadow texture."] = "Activar textura de sombra."
L["Flash"] = "Destello"
L["Global"] = "Global"
L["Global Settings"] = "Ajustes globales"
L["Gloss"] = "Opciones de Brillo"
L["Highlight"] = "Resaltado"
L["Normal"] = "Normal"
-- L["Pulse"] = "Pulse"
L["Pushed"] = "Pulsado"
L["Reset all skin options to the defaults."] = "Reestablece todos los colores a los predefinidos."
L["Reset Skin"] = "Restablecer Colores"
-- L["Scale"] = "Scale"
L["Set the color of the Backdrop texture."] = "Establece el color de la textura del fondo."
L["Set the color of the Checked texture."] = "Establece el color de la textura activada."
L["Set the color of the Cooldown animation."] = "Establece el color de la animación de enfriamiento."
L["Set the color of the Flash texture."] = "Establece el color del textura destelleando."
L["Set the color of the Gloss texture."] = "Establece el color de la textura brillando."
L["Set the color of the Highlight texture."] = "Establece el color de la textura resaltada."
L["Set the color of the Normal texture."] = "Establece el color de la textura normal."
L["Set the color of the Pushed texture."] = "Establece el color de la textura pulsada."
L["Set the color of the Shadow texture."] = "Establece el color de la textura de las sombras."
L["Set the skin for this group."] = "Seleccionar la tema para este grupo."
L["Shadow"] = "Sombras"
-- L["Show the pulse effect when a cooldown finishes."] = "Show the pulse effect when a cooldown finishes."
L["Skin"] = "Textura"
-- L["Skin Settings"] = "Skin Settings"
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "This section will allow you to adjust the skin settings of all buttons registered to %s."
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."
-- L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "Estas opciones te permiten cambiar la aparencia de los botones de los add-ons que se han registrados en Masque."

----------------------------------------
-- Zoomed Skin
---

L["A square skin with zoomed icons and a semi-transparent background."] = "Una apariencia cuadrada con iconos ampliados y un fondo semitransparente."
