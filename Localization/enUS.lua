local AceLocale = LibStub("AceLocale-3.0")

local L = AceLocale:NewLocale( "ButtonFacade", "enUS", true )

if L then
	L["BF"] = true -- Short for ButtonFacade
	L["ButtonFacade"] = true
	L["|cffffff00Right-click|r to open the Configuration GUI"] = true
	L["Apply skin to all registered buttons."] = true
	L["Apply skin to all buttons registered with %s."] = true
	L["Apply skin to all buttons registered with %s/%s."] = true
	L["Apply skin to all buttons registered with %s/%s/%s."] = true
	L["Elements"] = true
	L["Skin"] = true
	L["Gloss"] = true
	L["Backdrop"] = true
	L["FuBar options"] = true
	L["Attach to minimap"] = true
	L["Hide minimap/FuBar icon"] = true
	L["Show icon"] = true
	L["Show text"] = true
	L["Position"] = true
	L["Left"] = true
	L["Center"] = true
	L["Right"] = true
	L["Color Options"] = true
	L["Backdrop"] = true
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
