if not IsAddOnLoaded("Masque") then
	LoadAddOn("Masque")
end

-- Dirty hack for SBF.
local AceAddon = LibStub("AceAddon-3.0", true)
if AceAddon then
	AceAddon:NewAddon("ButtonFacade")
end