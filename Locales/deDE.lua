local L = LibStub("AceLocale-3.0"):NewLocale("ButtonFacade", "deDE")

if L then
	-- Addon Title
	L["ButtonFacade"] = "ButtonFacade"

	-- Broker Tool Tip
	L["Right-Click to open the options window."] = "Right-Click to open the options window."

	-- Global Settings
	L["Global"] = "Global"
	L["GLOBAL_INFO"] = "This section allows you adjust the skin settings globally. Any changes here will affect all registered elements. Please note that this section will not update itself after a reload."

	-- Addon Settings
	L["Addons"] = "Addon"
	L["ADDON_INFO"] = "This section allows you adjust skin settings on a per-addon basis. You can also adjust the settings of individual groups, bars and buttons of the addon if available."

	-- General Options
	L["Options"] = "Options"
	L["OPTION_INFO"] = "This section allows you to adjust any options that are available for ButtonFacade."
	L["Minimap Icon"] = "Minimap Icon"
	L["Show the minimap icon."] = "Show the minimap icon."
	L["OPTWIN_ISSUE"] = "If you're having trouble accessing some of the options due to the window size, you may want to download and install |cffffcc00BetterBlizzOptions|r. Alternatively, you can use the button below or the |cffffcc00/bfo|r chat command to open a standalone options window."
	L["Standalone Options"] = "Standalone Options"
	L["Open a standalone options window."] = "Open a standalone options window."
	
	-- Plugins
	L["Plugins"] = "Plugins"
	L["PLUGIN_INFO"] = "This section allows you adjust the settings of individual plugins."

	-- Profiles
	L["Profiles"] = "Profiles"

	-- About
	L["BF_INFO"] = "ButtonFacade is a small addon that allows the dynamic skinning of button-based addons."

	-- Elements
	L["Apply skin to all buttons registered with %s."] = "Apply skin to all buttons registered with %s."
	L["Apply skin to all buttons registered with %s: %s."] = "Apply skin to all buttons registered with %s: %s."
	L["Apply skin to all buttons registered with %s: %s/%s."] = "Apply skin to all buttons registered with %s: %s/%s."

	-- Settings
	L["Skin"] = "Skin"
	L["Gloss"] = "Gloss"
	L["Backdrop"] = "Backdrop"
	L["Color Options"] = "Color Options"
	L["Flash"] = "Flash"
	L["Normal Border"] = "Normal Border"
	L["Pushed Border"] = "Pushed Border"
	L["Disabled Border"] = "Disabled Border"
	L["Checked"] = "Checked"
	L["Equipped"] = "Equipped"
	L["Highlight"] = "Highlight"
	L["Gloss"] = "Gloss"
	L["Reset Colors"] = "Reset Colors"
end
