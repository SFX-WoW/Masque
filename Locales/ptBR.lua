--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\ptBR.lua

	ptBR Locale

	[ Notes ]

	To help with translations, use the localization system on WoWAce (https://www.wowace.com/projects/masque/localization)
	or contribute directly on GitHub (https://github.com/SFX-WoW/Masque).

]]

if GetLocale() ~= "ptBR" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

L["About Masque"] = "Sobre Masque"
L["API"] = "API"
L["For more information, please visit one of the sites listed below."] = "Para mais informações, por favor, visite um dos sites listados abaixo."
-- L["Masque is a skinning engine for button-based add-ons."] = "Masque is a skinning engine for button-based add-ons."
-- L["Select to view."] = "Select to view."
-- L["You must have an add-on that supports Masque installed to use it."] = "You must have an add-on that supports Masque installed to use it."

----------------------------------------
-- Classic Skin
---

L["An improved version of the game's default button style."] = "Uma versão aprimorada do estilo de botão padrão do jogo."

----------------------------------------
-- Core Settings
---

L["About"] = "Sobre"
L["Click to load Masque's options."] = "Clique para opções do Masque."
-- L["Load Options"] = "Load Options"
-- L["Masque's options are load on demand. Click the button below to load them."] = "Masque's options are load on demand. Click the button below to load them."
-- L["This action will increase memory usage."] = "This action will increase memory usage."
-- L["This section will allow you to view information about Masque and any skins you have installed."] = "This section will allow you to view information about Masque and any skins you have installed."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Faz com que o Masque envie erros de Lua sempre que encontrar um problema com um add-on ou skin."
L["Clean Database"] = "Limpar Banco de Dados"
L["Click to purge the settings of all unused add-ons and groups."] = "Clique para limpar as configurações de todos os complementos e grupos não usados."
L["Debug Mode"] = "Modo de Depuração"
L["Developer"] = "Desenvolver"
L["Developer Settings"] = "Configurações do Desenvolvedor"
L["Masque debug mode disabled."] = "Modo de depuração do Masque desativado."
L["Masque debug mode enabled."] = "Modo de depuração do Masque ativado."
-- L["This action cannot be undone. Continue?"] = "This action cannot be undone. Continue?"
-- L["This section will allow you to adjust settings that affect working with Masque's API."] = "This section will allow you to adjust settings that affect working with Masque's API."

----------------------------------------
-- Dream Skin
---

-- L["A square skin with trimmed icons and a semi-transparent background."] = "A square skin with trimmed icons and a semi-transparent background."

----------------------------------------
-- General Settings
---

L["General Settings"] = "Configurações Gerais."
-- L["This section will allow you to adjust Masque's interface and performance settings."] = "This section will allow you to adjust Masque's interface and performance settings."

----------------------------------------
-- Installed Skins
---

L["Author"] = "Autor"
L["Authors"] = "Autores"
L["Click for details."] = "Clique para detalhes."
L["Compatible"] = "Compatível"
L["Description"] = "Descrição"
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

L["Enable the Minimap icon."] = "Ativa o ícone do minimapa."
-- L["Interface"] = "Interface"
-- L["Interface Settings"] = "Interface Settings"
L["Minimap Icon"] = "Ícone do Minimapa"
-- L["Stand-Alone GUI"] = "Stand-Alone GUI"
-- L["This section will allow you to adjust settings that affect Masque's interface."] = "This section will allow you to adjust settings that affect Masque's interface."
-- L["Use a resizable, stand-alone options window."] = "Use a resizable, stand-alone options window."

----------------------------------------
-- LDB Launcher
---

L["Click to open Masque's settings."] = "Clique para abrir configurações do Masque."

----------------------------------------
-- Performance Settings
---

L["Click to load reload the interface."] = "Clique para carregar a interface."
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

L["Backdrop"] = "Fundo"
L["Checked"] = "Marcado"
L["Color"] = "Cor"
L["Colors"] = "Cores"
L["Cooldown"] = "Cooldown"
L["Disable"] = "Desativar"
L["Disable the skinning of this group."] = "Desatica a skin deste grupo."
L["Disabled"] = "Desativado"
L["Enable"] = "Ativar"
L["Enable the Backdrop texture."] = "Ativa a textura de fundo."
L["Enable the Gloss texture."] = "Ativa a textura do Brilho."
L["Enable the Shadow texture."] = "Ativa a textura de Sombra."
L["Flash"] = "Flash"
L["Global"] = "Global"
L["Global Settings"] = "Configurações Global."
L["Gloss"] = "Brilho"
L["Highlight"] = "Destaque"
L["Normal"] = "Normal"
-- L["Pulse"] = "Pulse"
L["Pushed"] = "Pressionado"
L["Reset all skin options to the defaults."] = "Redefine todas as opções da skin para seus padrões."
L["Reset Skin"] = "Redefinir Skin"
L["Set the color of the Backdrop texture."] = "Define a cor da textura de fundo."
L["Set the color of the Checked texture."] = "Define a cor da textura de marcado."
-- L["Set the color of the Cooldown animation."] = "Set the color of the Cooldown animation."
L["Set the color of the Disabled texture."] = "Define a cor da textura de desativado."
L["Set the color of the Flash texture."] = "Define a cor da textura de flash."
L["Set the color of the Gloss texture."] = "Define a cor da textura de brilho."
L["Set the color of the Highlight texture."] = "Define a cor da textura de destaque."
L["Set the color of the Normal texture."] = "Define a cor da textura normal."
L["Set the color of the Pushed texture."] = "Define a cor da textura de pressionado."
-- L["Set the color of the Shadow texture."] = "Set the color of the Shadow texture."
L["Set the skin for this group."] = "Define a skin para este grupo."
-- L["Shadow"] = "Shadow"
-- L["Show the pulse effect when a cooldown finishes."] = "Show the pulse effect when a cooldown finishes."
L["Skin"] = "Skin"
-- L["Skin Settings"] = "Skin Settings"
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "This section will allow you to adjust the skin settings of all buttons registered to %s."
-- L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."
-- L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "Esta seção permitirá que você coloque skins nos botões dos add-ons e grupos de add-ons registrados no Masque."

----------------------------------------
-- Zoomed Skin
---

-- L["A square skin with zoomed icons and a semi-transparent background."] = "A square skin with zoomed icons and a semi-transparent background."
