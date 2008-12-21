local L = LibStub("AceLocale-3.0"):NewLocale("ButtonFacade", "enUS", true)

if L then
	-- Addon Title
	L["ButtonFacade"] = true

	-- Broker Tool Tip
	L["Right-Click to open the options window."] = true

	-- Global Settings
	L["Global"] = true
	L["GLOBAL_INFO"] = "This section allows you adjust the skin settings globally. Any changes here will affect all registered elements. Please note that this section will not update itself after a reload."

	-- Addon Settings
	L["Addons"] = true
	L["ADDON_INFO"] = "This section allows you adjust skin settings on a per-addon basis. You can also adjust the settings of individual groups, bars and buttons of the addon if available."

	-- General Options
	L["Options"] = true
	L["OPTION_INFO"] = "This section allows you to adjust any options that are available for ButtonFacade."
	L["Minimap Icon"] = true
	L["Show the minimap icon."] = true
	L["OPTWIN_ISSUE"] = "If you're having trouble accessing some of the options due to the window size, you may want to download and install |cffffcc00BetterBlizzOptions|r. Alternatively, you can use the button below or the |cffffcc00/bfo|r chat command to open a standalone options window."
	L["Standalone Options"] = true
	L["Open a standalone options window."] = true

	-- Plugins
	L["Plugins"] = true
	L["PLUGIN_INFO"] = "This section allows you adjust the options of individual plugins."

	-- Profiles
	L["Profiles"] = true

	-- About
	L["BF_INFO"] = "ButtonFacade is a small addon that allows the dynamic skinning of button-based addons."

	-- Elements
	L["Apply skin to all buttons registered with %s."] = true
	L["Apply skin to all buttons registered with %s: %s."] = true
	L["Apply skin to all buttons registered with %s: %s/%s."] = true

	-- Settings
	L["Skin"] = true
	L["Gloss"] = true
	L["Backdrop"] = true
	L["Color Options"] = true
	L["Flash"] = true
	L["Normal Border"] = true
	L["Pushed Border"] = true
	L["Disabled Border"] = true
	L["Checked"] = true
	L["Equipped"] = true
	L["Highlight"] = true
	L["Gloss"] = true
	L["Reset Colors"] = true
end
