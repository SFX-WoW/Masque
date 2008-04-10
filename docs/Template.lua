--[[
	Overview
	--------
	The purpose of this file is to make creating skins as easy as possible. Since this and the add-on are a work in progress,
	the contents are subject to change. This file assumes at least a basic understanding of LUA syntax.

	Layers
	------

	A button's "skin" is composed of layers of textures, colors and text overlays. The following list defines the available
	layers in order from bottom (first) to (top).

		Layer           Type             Description
		-----           ----             -----------
		Backdrop       Texture   Layer under the entire button.
		Icon           Texture   Spell or skill icon for the button.
		Flash          Texture   Combat/attack indicator.
		Cooldown       Model     Cool-down animation.
		AutoCast       Model     Auto-cast animation. (Only use on square buttons)
		AutoCastable   Texture   Texture marking its auto-cast property.
		Normal         Texture   The "border" or "normal" texture file for the button.
		Pushed         Texture   Texture for the "pushed" state. Replaces the "normal" texture.
		Disabled       Texture   Texture for the "disabled" state. Replaces the "normal" texture.
		Border         Texture   Layer for the "equipped" state.
		Highlight      Texture   Highlight layer for mouse-overs, etc.
		Checked        Texture   Highlight layer for active skills like the current form.
		Gloss          Texture   "Gloss" or "glaze" layer.
		HotKey         Text      Text for the hot key.
		Count          Text      Text for the item count.
		Name           Text      Text for the macro name.

	Attributes
	----------
	A layer's attributes define how that layer is drawn on the screen. The following is a list of available attributes.

		- All layers -
		Width        The width of the layer.
		Height       The height of the layer.
		Scale        The scale of the layer.
		OffsetX      The X offset, in pixels, of the layer. Default = 0.
		OffsetY      The Y offset, in pixels, of the layer. Default = 0.
		Hide         Whether or not the layer is hidden/used. True or false.

		- All layers except Icon, Normal, Pushed, Disabled, Cooldown, and AutoCast -
		Red          Default = 1
		Green        Default = 1
		Blue         Default = 1
		Alpha        Default = 1
		
		- Texture layers -
        Texture      Required. Not available on Icon layer.
        TexCoords    Texture coordinates. Default = {0,1,0,1} = {minX,maxX,minY,maxY}.
        BlendMode    "BLEND"
		             "DISABLE"    No blending (Not a likely choice).
		             "BLEND"      Blends according to alpha channel.
		             "ALPHAKEY"   Blends according to 1-bit alpha channel (Not likely).
		             "ADD"        Alpha and additive.
		             "MOD"        No alpha, multiplicative.
		
	Other Notes
	-----------
	If a layer is unused, the only attribute it should have is Hide=True.

	When specifying paths, enclose them in double brackets (like in the examples below) to eliminate the need for escapes/quotes.
	
	To use this file as a template for a new skin, simply remove all of the comments in this section.
]]

-- Get the library and quit without error if it doesn't exist.
local LibButtonFacade = LibStub("LibButtonFacade",true)
if not LibButtonFacade then
	return
end

--[[
	Title...: SkinName
	Author..: Author
	Version.: 2.4.0
]]

-- Replace "SkinName" with your skin's name.
LibButtonFacade:AddSkin("SkinName",{

	-- Skin data start. (Data copied from DreamLayout as an example.)
	Backdrop = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Tooltips\UI-Tooltip-Background]],
		Red = 0,
		Green = 0,
		Blue = 0,
		Alpha = 0.6,
	},
	Icon = {
		Width = 30,
		Height = 30,
		TexCoords = {0.07,0.93,0.07,0.93},
	},
	Flash = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
	},
	Cooldown = {
		Width = 36,
		Height = 36,
	},
	AutoCast = {
		Width = 36,
		Height = 36,
	},
	AutoCastable = {
		Width = 58,
		Height = 58,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Normal = {
		Hide = true,
	},
	Pushed = {
		Hide = true,
	},
	Disabled = {
		Hide = true,
	},
	Highlight = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
		BlendMode = "ADD",
	},
	Checked = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		BlendMode = "ADD",
	},
	Border = {
		Width = 62,
		Height = 62,
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		BlendMode = "ADD",
	},
	Gloss = {
		Hide = true
	},
	HotKey = {
		Width = 36,
		Height = 10,
		OffsetX = -2,
		OffsetY = 11,
	},
	Count = {
		Width = 36,
		Height = 10,
		OffsetX = -2,
		OffsetY = -11,
	},
	Name = {
		Width = 36,
		Height = 10,
		OffsetY = -11,
	},
	-- Skin data end.

},true)
