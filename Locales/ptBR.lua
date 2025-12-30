--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Locales\ptBR.lua

	ptBR Locale

	[ Notes ]

	To help with translations, use the localization system on CurseForge (https://www.curseforge.com/wow/addons/masque/localization)
	or contribute directly on GitHub (https://github.com/SFX-WoW/Masque).

]]

if GetLocale() ~= "ptBR" then return end

local _, Core = ...
local L = Core.Locale

----------------------------------------
-- About Masque
---

L["About Masque"] = "Sobre o Masque"
L["API"] = "API"
L["For more information, please visit one of the sites listed below."] = "Para mais informações, por favor, visite um dos sites listados abaixo."
L["Masque is a skinning engine for button-based add-ons."] = "Masque é um motor de aparências para addons baseados em botões."
L["Select to view."] = "Selecione para visualizar."
L["Supporters"] = "Apoiadores"
L["You must have an add-on that supports Masque installed to use it."] = "Você deve ter um addon que suporte o Masque instalado para usá-lo."

----------------------------------------
-- Advanced Settings
---

L["Advanced"] = "Avançado"
L["Advanced Settings"] = "Configurações Avançadas"
L["Cast Animations"] = "Animações de Lançamento"
L["Cooldown Animations"] = "Animações de Recarga"
L["Enable animations when action button cooldowns finish."] = "Ativar animações quando as recargas dos botões de ação terminarem."
L["Enable cast animations on action buttons."] = "Ativar animações de lançamento nos botões de ação."
L["Enable interrupt animations on action buttons."] = "Ativar animações de interrupção nos botões de ação."
L["Enable targeting reticles on action buttons."] = "Ativar retículos de mira nos botões de ação."
L["Flash and Loop"] = "Piscar e Repetir"
L["Interrupt Animations"] = "Animações de Interrupção"
L["Loop Only"] = "Apenas Repetir"
L["Select the spell alert style."] = "Selecione o estilo do alerta de feitiço."
L["Select which spell alert animations are enabled."] = "Selecione quais animações de alerta de feitiço estão ativadas."
L["Spell Alert Animations"] = "Animações de Alerta de Feitiço"
L["Spell Alert Style"] = "Estilo de Alerta de Feitiço"
L["Targeting Reticles"] = "Retículos de Mira"
L["This section will allow you to adjust button settings for the default interface."] = "Esta seção permitirá que você ajuste as configurações de botão para a interface padrão."

----------------------------------------
-- Blizzard Classic Skin
---

L["The default classic button style."] = "O estilo de botão clássico padrão."

----------------------------------------
-- Blizzard Modern Skin
---

L["The default modern button style."] = "O estilo de botão moderno padrão."

----------------------------------------
-- Classic Enhanced Skin
---

L["An enhanced version of the classic button style."] = "Uma versão aprimorada do estilo de botão clássico."

----------------------------------------
-- Core Settings
---

L["About"] = "Sobre"
L["This section will allow you to view information about Masque and any skins you have installed."] = "Esta seção permitirá que você visualize informações sobre o Masque e quaisquer aparências que você tenha instalado."

----------------------------------------
-- Developer Settings
---

L["Causes Masque to throw Lua errors whenever it encounters a problem with an add-on or skin."] = "Faz com que o Masque envie erros de Lua sempre que encontrar um problema com um add-on ou aparência."
L["Clean Database"] = "Limpar Banco de Dados"
L["Click to purge the settings of all unused add-ons and groups."] = "Clique para limpar as configurações de todos os complementos e grupos não utilizados."
L["Debug Mode"] = "Modo de Depuração"
L["Developer"] = "Desenvolvedor"
L["Developer Settings"] = "Configurações de Desenvolvedor"
L["Masque debug mode disabled."] = "Modo de depuração do Masque desativado."
L["Masque debug mode enabled."] = "Modo de depuração do Masque ativado."
L["This action cannot be undone. Continue?"] = "Esta ação não pode ser desfeita. Continuar?"
L["This section will allow you to adjust settings that affect working with Masque's API."] = "Esta seção permitirá que você ajuste configurações que afetam o trabalho com a API do Masque."

----------------------------------------
-- Dream Skin
---

L["A square skin with trimmed icons and a semi-transparent background."] = "Uma aparência quadrada com ícones recortados e um fundo semitransparente."

----------------------------------------
-- General Settings
---

L["General Settings"] = "Configurações Gerais"
L["This section will allow you to adjust Masque's interface and performance settings."] = "Esta seção permitirá que você ajuste as configurações de interface e desempenho do Masque."

----------------------------------------
-- Installed Skins
---

L["Author"] = "Autor"
L["Authors"] = "Autores"
L["Compatible"] = "Compatível"
L["Description"] = "Descrição"
L["Discord"] = "Discord"
L["Installed Skins"] = "Aparências Instaladas"
L["No description available."] = "Nenhuma descrição disponível."
L["Status"] = "Status"
L["The status of this skin is unknown."] = "O status desta aparência é desconhecido."
L["This section provides information on any skins you have installed."] = "Esta seção fornece informações sobre quaisquer aparências que você tenha instalado."
L["This skin is compatible with Masque."] = "Esta aparência é compatível com o Masque."
L["This skin is outdated but is still compatible with Masque."] = "Esta aparência está desatualizada, mas ainda é compatível com o Masque."
L["Unknown"] = "Desconhecido"
L["Version"] = "Versão"
L["Website"] = "Site"
L["Websites"] = "Sites"

----------------------------------------
-- Interface Settings
---

L["Add-On Compartment"] = "Compartimento de Addons"
L["Alternate Sorting"] = "Ordenação Alternativa"
L["Causes the skins included with Masque to be listed above third-party skins."] = "Faz com que as aparências incluídas no Masque sejam listadas acima das aparências de terceiros."
L["Click to reload the interface."] = "Clique para recarregar a interface."
L["Increases the font size of the text on Ace3 profile panels."] = "Aumenta o tamanho da fonte do texto nos painéis de perfil do Ace3."
L["Interface"] = "Interface"
L["Interface Settings"] = "Configurações de Interface"
L["Load the skin information panel."] = "Carregar o painel de informações da aparência."
L["Menu Icon"] = "Ícone do Menu"
L["Minimap"] = "Minimapa"
L["None"] = "Nenhum"
L["Profile Panel Font Fix"] = "Correção da Fonte do Painel de Perfil"
L["Reload Interface"] = "Recarregar Interface"
L["Requires an interface reload."] = "Requer recarregar a interface."
L["Select where Masque's menu icon is displayed."] = "Selecione onde o ícone de menu do Masque será exibido."
L["Skin Information"] = "Informações da Aparência"
L["Stand-Alone GUI"] = "Interface Independente"
L["This section will allow you to adjust settings that affect Masque's interface."] = "Esta seção permitirá que você ajuste configurações que afetam a interface do Masque."
L["Use a resizable, stand-alone options window."] = "Usar uma janela de opções redimensionável e independente."

----------------------------------------
-- LDB Launcher
---

L["Click to open Masque's settings."] = "Clique para abrir configurações do Masque."
L["Unavailable in combat."] = "Indisponível em combate."

----------------------------------------
-- Modern Enhanced Skin
---

L["An enhanced version of the modern button style."] = "Uma versão aprimorada do estilo de botão moderno."

----------------------------------------
-- Profile Settings
---

L["Profile Settings"] = "Configurações de Perfil"

----------------------------------------
-- Skin Settings
---

L["Adjust the scale of this group's skin."] = "Ajusta a escala deste grupo de aparência."
L["Backdrop"] = "Fundo"
L["Checked"] = "Marcado"
L["Color"] = "Cor"
L["Colors"] = "Cores"
L["Cooldown"] = "Recarga"
L["Disable"] = "Desativar"
L["Disable the skinning of this group."] = "Desativar a aparência deste grupo."
L["Enable"] = "Ativar"
L["Enable skin scaling."] = "Ativar escala da aparência."
L["Enable the Backdrop texture."] = "Ativar a textura de Fundo."
L["Enable the Gloss texture."] = "Ativar a textura de Brilho."
L["Enable the Shadow texture."] = "Ativar a textura de Sombra."
L["Flash"] = "Piscar"
L["Global"] = "Global"
L["Global Settings"] = "Configurações Globais"
L["Gloss"] = "Brilho"
L["Highlight"] = "Realce"
L["Normal"] = "Normal"
L["Pulse"] = "Pulsar"
L["Pushed"] = "Pressionado"
L["Reset all skin options to the defaults."] = "Redefinir todas as opções de aparência para os padrões."
L["Reset Skin"] = "Redefinir Aparência"
L["Scale"] = "Escala"
L["Set the color of the Backdrop texture."] = "Defina a cor da textura de Fundo."
L["Set the color of the Checked texture."] = "Defina a cor da textura de Marcado."
L["Set the color of the Cooldown animation."] = "Defina a cor da animação de Recarga."
L["Set the color of the Flash texture."] = "Defina a cor da textura de Piscar."
L["Set the color of the Gloss texture."] = "Defina a cor da textura de Brilho."
L["Set the color of the Highlight texture."] = "Defina a cor da textura de Realce."
L["Set the color of the Normal texture."] = "Defina a cor da textura Normal."
L["Set the color of the Pushed texture."] = "Defina a cor da textura de Pressionado."
L["Set the color of the Shadow texture."] = "Defina a cor da textura de Sombra."
L["Set the skin for this group."] = "Defina a aparência para este grupo."
L["Shadow"] = "Sombra"
L["Show the pulse effect when a cooldown finishes."] = "Mostra o efeito de pulso quando uma recarga termina."
L["Skin"] = "Aparência"
L["Skin Settings"] = "Configurações de Aparência"
L["This section will allow you to adjust the skin settings of all buttons registered to %s."] = "Esta seção permitirá que você ajuste as configurações de aparência de todos os botões registrados em %s."
L["This section will allow you to adjust the skin settings of all buttons registered to %s. This will overwrite any per-group settings."] = "Esta seção permitirá que você ajuste as configurações de aparência de todos os botões registrados em %s. Isso sobrescreverá quaisquer configurações por grupo."
L["This section will allow you to adjust the skin settings of all registered buttons. This will overwrite any per-add-on settings."] = "Esta seção permitirá que você ajuste as configurações de aparência de todos os botões registrados. Isso sobrescreverá quaisquer configurações por addon."
L["This section will allow you to skin the buttons of the add-ons and add-on groups registered with Masque."] = "Esta seção permitirá que você personalize a aparência dos botões dos addons e grupos de addons registrados no Masque."

----------------------------------------
-- Zoomed Skin
---

L["A square skin with zoomed icons and a semi-transparent background."] = "Uma aparência quadrada com ícones ampliados e um fundo semitransparente."
