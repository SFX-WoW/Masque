--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\esES.lua

	esMX/esES Locale

	[ Notes ]

	To help with translations, use the localization system on WoWAce (https://www.wowace.com/projects/masque/localization)
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
-- L["You must have an add-on that supports Masque installed to use it."] = "You must have an add-on that supports Masque installed to use it."

----------------------------------------
-- Classic Skin
---

L["An improved version of the game's default button style."] = "Una versión mejorada del diseño de los botones por defecto del juego."

----------------------------------------
-- Core Settings
---

L["About"] = "Acerca de"
L["Click to load Masque's options."] = "Haz clic para cargar las opciones de Masque."
L["Load Options"] = "Cargar opciones"
L["Masque's options are load on demand. Click the button below to load them."] = "Las opciones de Masque se cargan bajo demanda. Haz clic abajo para cargarlas."
-- L["This action will increase memory usage."] = "This action will increase memory usage."
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
L["Click for details."] = "Haz clic para más detalles."
L["Compatible"] = "Compatible"
L["Description"] = "Descripción"
L["Incompatible"] = "Incompatible"
L["Installed Skins"] = "Apariencias instaladas"
L["No description available."] = "Descripción no disponible."
-- L["Status"] = "Status"
-- L["The status of this skin is unknown."] = "The status of this skin is unknown."
-- L["This section provides information on any skins you have installed."] = "This section provides information on any skins you have installed."
-- L["This skin is compatible with Masque."] = "This skin is compatible with Masque."
-- L["This skin is outdated and is incompatible with Masque."] = "This skin is outdated and is incompatible with Masque."
-- L["This skin is outdated but is still compatible with Masque."] = "This skin is outdated but is still compatible with Masque."
-- L["Unknown"] = "Unknown"
L["Version"] = "Versión"
L["Website"] = "Sitio web"
L["Websites"] = "Sitios web"

----------------------------------------
-- Interface Settings
---

L["Enable the Minimap icon."] = "Mostrar un icono en el minimapa."
L["Interface"] = "Interfaz"
L["Interface Settings"] = "Ajustes de interfaz"
L["Minimap Icon"] = "Icono en minimapa"
-- L["Stand-Alone GUI"] = "Stand-Alone GUI"
-- L["This section will allow you to adjust settings that affect Masque's interface."] = "This section will allow you to adjust settings that affect Masque's interface."
-- L["Use a resizable, stand-alone options window."] = "Use a resizable, stand-alone options window."

----------------------------------------
-- LDB Launcher
---

L["Click to open Masque's settings."] = "Haz clic para abrir los ajustes de Masque."

----------------------------------------
-- Performance Settings
---

L["Click to load reload the interface."] = "Haz clic para recargar la interfaz."
L["Load the skin information panel."] = "Cargar panel de información de apariencias."
L["Performance"] = "Rendimiento"
L["Performance Settings"] = "Ajustes de rendimiento"
L["Reload Interface"] = "Recargar interfaz"
L["Requires an interface reload."] = "Recarga de interfaz requerida."
L["Skin Information"] = "Información de apariencia"
-- L["This section will allow you to adjust settings that affect Masque's performance."] = "This section will allow you to adjust settings that affect Masque's performance."

----------------------------------------
-- Profile Settings
---

L["Profile Settings"] = "Ajustes de perfil"

----------------------------------------
-- Skin Settings
---

L["Backdrop"] = "Opciones de Fondo"
L["Checked"] = "Activado"
L["Color"] = "Color"
L["Colors"] = "Colores"
L["Cooldown"] = "Enfriamiento"
L["Disable"] = "Desactivado"
L["Disable the skinning of this group."] = "Deshabilitar las texturas para este grupo."
L["Disabled"] = "Desactivado"
L["Enable"] = "Activado"
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
L["Set the color of the Backdrop texture."] = "Establece el color de la textura del fondo."
L["Set the color of the Checked texture."] = "Establece el color de la textura activada."
L["Set the color of the Cooldown animation."] = "Establece el color de la animación de enfriamiento."
L["Set the color of the Disabled texture."] = "Establece el color de la textura desactivada."
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
