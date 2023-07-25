_G = GLOBAL
rawget = _G.rawget
mods=_G.rawget(_G,"mods") or (function() local m={}_G.rawset (_G,"mods",m) return m end)()
mods.ThaiLanguagePack = {}
t = mods.ThaiLanguagePack
t.SelectedLanguage = "th"
TheSim = _G.TheSim
STRINGS = _G.STRINGS
modimport("scripts/utility.lua")

if GetModConfigData("DISABLE_MOD_WARNING") then
	_G.DISABLE_MOD_WARNING = true
end

Config = {}
Config.UI = GetModConfigData("CFG_UI")
Config.CON = GetModConfigData("CFG_CON")
Config.ITEM = GetModConfigData("CFG_ITEM")
Config.CFG_ITEM_TWO = GetModConfigData("CFG_ITEM_TWO")

--โหลดฟอนต์
function ApplyLocalizedFonts()
	local FontNames = {
		DEFAULTFONT = _G.DEFAULTFONT,
		DIALOGFONT = _G.DIALOGFONT,
		TITLEFONT = _G.TITLEFONT,
		UIFONT = _G.UIFONT,
		BUTTONFONT = _G.BUTTONFONT,
		NUMBERFONT = _G.NUMBERFONT,
		SMALLNUMBERFONT = _G.SMALLNUMBERFONT,
		BODYTEXTFONT = _G.BODYTEXTFONT,
		NEWFONT = rawget(_G,"NEWFONT"),
		NEWFONT_SMALL = rawget(_G,"NEWFONT_SMALL"),
		NEWFONT_OUTLINE = rawget(_G,"NEWFONT_OUTLINE"),
		NEWFONT_OUTLINE_SMALL = rawget(_G,"NEWFONT_OUTLINE_SMALL"),
		TALKINGFONT = _G.TALKINGFONT,
		TALKINGFONT_HERMIT = _G.TALKINGFONT_HERMIT,
		TALKINGFONT_TRADEIN = _G.TALKINGFONT_TRADEIN,
		TALKINGFONT_WORMWOOD = _G.TALKINGFONT_WORMWOOD,
	}
	
	if Config.UI ~= "disable" or Config.CON ~= "disable" or Config.ITEM ~= "disable" then
		_G.DEFAULTFONT = FontNames.DEFAULTFONT
		_G.DIALOGFONT = FontNames.DIALOGFONT
		_G.TITLEFONT = FontNames.TITLEFONT
		_G.UIFONT = FontNames.UIFONT
		_G.BUTTONFONT = FontNames.BUTTONFONT
		_G.HEADERFONT = FontNames.HEADERFONT
		_G.NUMBERFONT = FontNames.NUMBERFONT		
		_G.SMALLNUMBERFONT = FontNames.SMALLNUMBERFONT
		_G.BODYTEXTFONT = FontNames.BODYTEXTFONT
		_G.CHATFONT_OUTLINE = FontNames.CHATFONT_OUTLINE
		if rawget(_G,"NEWFONT") then
			_G.NEWFONT = FontNames.NEWFONT
		end
		if rawget(_G,"NEWFONT_SMALL") then
			_G.NEWFONT_SMALL = FontNames.NEWFONT_SMALL
		end
		if rawget(_G,"NEWFONT_OUTLINE") then
			_G.NEWFONT_OUTLINE = FontNames.NEWFONT_OUTLINE
		end
		if rawget(_G,"NEWFONT_OUTLINE_SMALL") then
			_G.NEWFONT_OUTLINE_SMALL = FontNames.NEWFONT_OUTLINE_SMALL
		end
	end
	_G.CHATFONT = FontNames.CHATFONT
	_G.TALKINGFONT = FontNames.TALKINGFONT
	_G.TALKINGFONT_HERMIT = FontNames.TALKINGFONT_HERMIT
	_G.TALKINGFONT_TRADEIN = FontNames.TALKINGFONT_TRADEIN
	_G.TALKINGFONT_WORMWOOD = FontNames.TALKINGFONT_WORMWOOD

	local LocalizedFontList = {
		["belisaplumilla50"] = true,
		["belisaplumilla100"] = true,
		["bellefair50"] = true,
		["bellefair50_outline"] = true,
		["buttonfont"] = true,
		["hammerhead50"] = true,
		["opensans50"] = true,
		["spirequal"] = rawget(_G,"NEWFONT") and true or nil,
		["spirequal_small"] = rawget(_G,"NEWFONT_SMALL") and true or nil,
		["spirequal_outline"] = rawget(_G,"NEWFONT_OUTLINE") and true or nil,
		["spirequal_outline_small"] = rawget(_G,"NEWFONT_OUTLINE_SMALL") and true or nil,
		["stint-ucr50"] = true,
		["stint-ucr20"] = true,
		["talkingfont"] = true,
		["talkingfont_hermit"] = true,
		["talkingfont_tradein"] = true,
		["talkingfont_wormwood"] = true,
	}
	
	for FontName in pairs(LocalizedFontList) do
		TheSim:UnloadFont(t.SelectedLanguage.."_"..FontName)
	end
	TheSim:UnloadPrefabs({t.SelectedLanguage.."_fonts_"..modname}) 

	local LocalizedFontAssets = {}
	for FontName in pairs(LocalizedFontList) do 
		table.insert(LocalizedFontAssets, _G.Asset("FONT", MODROOT.."fonts/"..FontName.."__"..t.SelectedLanguage..".zip"))
	end

	local LocalizedFontsPrefab = _G.Prefab("common/"..t.SelectedLanguage.."_fonts_"..modname, nil, LocalizedFontAssets)
	_G.RegisterPrefabs(LocalizedFontsPrefab)
	TheSim:LoadPrefabs({t.SelectedLanguage.."_fonts_"..modname})

	for FontName in pairs(LocalizedFontList) do
		TheSim:LoadFont(MODROOT.."fonts/"..FontName.."__"..t.SelectedLanguage..".zip", t.SelectedLanguage.."_"..FontName)
	end

	local fallbacks = {}
	for _, v in pairs(_G.FONTS) do
		local FontName = v.filename:sub(7, -5)
		if LocalizedFontList[FontName] then
			fallbacks[FontName] = {v.alias, _G.unpack(type(v.fallback) == "table" and v.fallback or {})}
		end
	end
	for FontName in pairs(LocalizedFontList) do
		TheSim:SetupFontFallbacks(t.SelectedLanguage.."_"..FontName, fallbacks[FontName])
	end

	if Config.UI ~= "disable" or Config.CON ~= "disable" or Config.ITEM ~= "disable" then
		_G.DEFAULTFONT = t.SelectedLanguage.."_opensans50"
		_G.DIALOGFONT = t.SelectedLanguage.."_opensans50"
		_G.TITLEFONT = t.SelectedLanguage.."_belisaplumilla100"
		_G.UIFONT = t.SelectedLanguage.."_belisaplumilla50"
		_G.BUTTONFONT = t.SelectedLanguage.."_buttonfont"
		_G.HEADERFONT = t.SelectedLanguage.."_hammerhead50"
		_G.NUMBERFONT = t.SelectedLanguage.."_stint-ucr50"
		_G.SMALLNUMBERFONT = t.SelectedLanguage.."_stint-ucr20"
		_G.BODYTEXTFONT = t.SelectedLanguage.."_stint-ucr50"
		_G.CHATFONT_OUTLINE = t.SelectedLanguage.."_bellefair50_outline"
		if rawget(_G,"NEWFONT") then
			_G.NEWFONT = t.SelectedLanguage.."_spirequal"
		end
		if rawget(_G,"NEWFONT_SMALL") then
			_G.NEWFONT_SMALL = t.SelectedLanguage.."_spirequal_small"
		end
		if rawget(_G,"NEWFONT_OUTLINE") then
			_G.NEWFONT_OUTLINE = t.SelectedLanguage.."_spirequal_outline"
		end
		if rawget(_G,"NEWFONT_OUTLINE_SMALL") then
			_G.NEWFONT_OUTLINE_SMALL = t.SelectedLanguage.."_spirequal_outline_small"
		end
	end
	_G.CHATFONT = t.SelectedLanguage.."_bellefair50"
	_G.TALKINGFONT = t.SelectedLanguage.."_talkingfont"
	_G.TALKINGFONT_HERMIT = t.SelectedLanguage.."_talkingfont"
	_G.TALKINGFONT_TRADEIN = t.SelectedLanguage.."_talkingfont_tradein"
	_G.TALKINGFONT_WORMWOOD = t.SelectedLanguage.."_talkingfont_wormwood"
end
--------------------------

AddClassPostConstruct("widgets/inventorybar", function(self, owner) -- แก้ฟ้อนช่องเก็บของไม่โหลด
	if Config.UI ~= "disable" then
		ApplyLocalizedFonts()
	end
end)

AddClassPostConstruct("screens/popupdialog", function(self, title, text, buttons, scale_bg, spacing_override, style) -- โหลดฟอนต์ในหน้าที่เกมไม่โหลดให้
	if Config.UI ~= "disable" then
		ApplyLocalizedFonts()
		self.title:SetFont(_G.BUTTONFONT)
		self.text:SetFont(_G.NEWFONT)
	end
end)

AddClassPostConstruct("screens/worldgenscreen", function(self) -- โหลดฟอนต์ในหน้าที่เกมไม่โหลดให้
	if Config.UI ~= "disable" then
		ApplyLocalizedFonts()
		self.worldgentext:SetFont(_G.TITLEFONT)
		self.flavourtext:SetFont(_G.UIFONT)
	end
end)

AddClassPostConstruct("widgets/spinner", function(self, options, width, height, textinfo, editable, atlas, textures, lean, textwidth, textheight) -- โหลดฟอนต์ในหน้าที่เกมไม่โหลดให้
	if textinfo then return end
	if Config.UI ~= "disable" then
		ApplyLocalizedFonts()
		self.text:SetFont(_G.NEWFONT)
	end
end)

AddClassPostConstruct("widgets/redux/craftingmenu_skinselector", function(self, recipe, owner, skin_name) -- โหลดฟอนต์ในหน้าที่เกมไม่โหลดให้
	self.spinner.text:SetFont(_G.BUTTONFONT)
end)

_G.getmetatable(TheSim).__index.UnregisterAllPrefabs = (function() -- โหลดฟอนต์ในหน้าที่เกมไม่โหลดให้
	local oldUnregisterAllPrefabs = _G.getmetatable(TheSim).__index.UnregisterAllPrefabs
	return function(self, ...)
		oldUnregisterAllPrefabs(self, ...)
		ApplyLocalizedFonts()
	end
end)()

--------------------------

--โหลดรูปภาพที่แปลภาษาแล้ว
Assets = {
	Asset("IMAGE", MODROOT.."images/skinsscreen.tex"),
	Asset("ATLAS", MODROOT.."images/skinsscreen.xml"),
	Asset("IMAGE", MODROOT.."images/tradescreen.tex"),
	Asset("ATLAS", MODROOT.."images/tradescreen.xml"),
	Asset("IMAGE", MODROOT.."images/tradescreen_overflow.tex"),
	Asset("ATLAS", MODROOT.."images/tradescreen_overflow.xml"),
	Asset("IMAGE", MODROOT.."images/worldgen_customization.tex"),
	Asset("ATLAS", MODROOT.."images/worldgen_customization.xml"),
	Asset("IMAGE", MODROOT.."images/worldsettings_customization.tex"),
	Asset("ATLAS", MODROOT.."images/worldsettings_customization.xml"),
}

--โหลดไฟล์ภาษา
if Config.UI ~= "disable" or Config.CON ~= "disable" or Config.ITEM ~= "disable" then
	LoadPOFile("scripts/languages/thai.po", t.SelectedLanguage)

	t.PO = _G.LanguageTranslator.languages[t.SelectedLanguage]

	-- ปิดการแปล UI
	if Config.UI == "disable" then
		for i,v in pairs(t.PO) do
			if string.find(i, "STRINGS.UI") or string.find(i, "STRINGS.ACTIONS") or string.find(i, "STRINGS.RECIPE_DESC") or string.find(i, "STRINGS.ANTIADDICTION") or string.find(i, "STRINGS.CHARACTER_") then
				t.PO[i]=""
			end
		end
	end

	-- ปิดการแปลบทพูด
	if Config.CON == "disable" then
		for i,v in pairs(t.PO) do
			if string.find(i, "STRINGS.CHARACTERS.GENERIC") or string.find(i, "STRINGS.BOARLORD_") or string.find(i, "STRINGS.CARNIVAL_") or string.find(i, "STRINGS.GOATMUM_") or string.find(i, "STRINGS.HERMITCRAB_") or string.find(i, "STRINGS.VOIDCLOTH_") or string.find(i, "STRINGS.YOTB_") or string.find(i, "STRINGS.LUCY") or string.find(i, "STRINGS.MERM_KING_TALK_") or string.find(i, "STRINGS.MERM_TALK") then
				t.PO[i]=""
			end
		end
	end

	-- ปิดการแปลชื่อไอเทม
	if Config.ITEM == "disable" then 
		for i,v in pairs(t.PO) do
			if string.find(i, "STRINGS.NAMES") then
				t.PO[i]=""
			end
		end
	elseif Config.CFG_ITEM_TWO == "enable" then  -- ไอเทมสองภาษา
		for i,v in pairs(t.PO) do
			if string.find(i, "STRINGS.NAMES") or string.find(i, "STRINGS.BEEFALONAMING") or string.find(i, "STRINGS.BUNNYMANNAMES") or string.find(i, "STRINGS.CHARACTER_NAMES") or string.find(i, "STRINGS.CROWNAMES") or string.find(i, "STRINGS.KITCOON_NAMING.NAMES") or string.find(i, "STRINGS.MERMNAMES") or string.find(i, "STRINGS.PIGNAMES") or string.find(i, "STRINGS.SWAMPIGNAMES") then
				local data = split(i, ".")
				local text
				if #data == 7 then
					text = STRINGS[data[2]][data[3]][data[4]][data[5]][data[6]][data[7]]
					if not text then
						text = STRINGS[data[2]][data[3]][data[4]][data[5]][data[6]][_G.tonumber(data[7])]
					end
				elseif #data == 6 then
					text = STRINGS[data[2]][data[3]][data[4]][data[5]][data[6]]
					if not text then
						text = STRINGS[data[2]][data[3]][data[4]][data[5]][_G.tonumber(data[6])]
					end
				elseif #data == 5 then
					text = STRINGS[data[2]][data[3]][data[4]][data[5]]
					if not text then
						text = STRINGS[data[2]][data[3]][data[4]][_G.tonumber(data[5])]
					end
				elseif #data == 4 then
					text = STRINGS[data[2]][data[3]][data[4]]
					if not text then
						text = STRINGS[data[2]][data[3]][_G.tonumber(data[4])]
					end
				elseif #data == 3 then
					text = STRINGS[data[2]][data[3]]
					if not text then
						text = STRINGS[data[2]][_G.tonumber(data[3])]
					end
				elseif #data == 2 then
					text = STRINGS[data[2]]
					if not text then
						text = STRINGS[_G.tonumber(data[2])]
					end
				end
				t.PO[i]=v..(text and "\n("..text..")" or "")
			end
		end
	end
	
	modimport("scripts/EMPTY.lua")
end

modimport("scripts/CHARACTER.lua")
modimport("scripts/fix_ui.lua")

--ปิดผิวขนาดเล็กป้องกันฟอนต์ไทยแตก
local SMALL_TEXTURES = GetModConfigData("SMALL_TEXTURES")
local ISPLAYINGNOW = (_G.TheNet:GetIsClient() or _G.TheNet:GetIsServer())
if SMALL_TEXTURES and not ISPLAYINGNOW then
	if _G.TheNet:GetIsServer() and _G.TheNet:GetServerIsDedicated() then
		print("[Thai] ตรวจพบว่าโปรแกรมปัจจุบันเป็นเซิร์ฟเวอร์และฟังก์ชั่นพื้นผิวขนาดเล็กจะปิดโดยอัตโนมัติโดยไม่ต้องโหลด")
		return
	else
		print("[Thai] ตรวจพบคุณสมบัติพื้นผิวขนาดเล็ก")
	end

	AddClassPostConstruct("widgets/widget", function(self, ...)
		if _G.TheFrontEnd and _G.TheFrontEnd:GetGraphicsOptions() and _G.TheFrontEnd:GetGraphicsOptions():IsSmallTexturesMode() then
			_G.TheFrontEnd:GetGraphicsOptions():SetSmallTexturesMode(false)
			print("[Thai] พื้นผิวขนาดเล็กจะถูกปิดโดยอัตโนมัติ!!")
		end
	end)
end

local OldStart = _G.Start
function _G.Start() -- โหลดฟอนต์ในหน้าที่เกมไม่โหลดให้
	ApplyLocalizedFonts()
	OldStart()
end

-- Version Check
AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self, prev_screen, profile, offline, session_data)
	TheSim:QueryServer("https://raw.githubusercontent.com/chaixshot/DST-Thai/main/version.txt", function (result, isSuccessful, resultCode)
		if resultCode == 200 and isSuccessful then
			local json = require("json")
			local data = json.decode(result)
			if modinfo.version ~= data.version then
				local PopupDialogScreen = require("screens/redux/popupdialog")
				local ModsScreen = require("screens/redux/modsscreen")
				_G.TheFrontEnd:PushScreen(PopupDialogScreen("อัพเดท", "ส่วนเสริม \"ภาษาไทย\" มีอัพเดทใหม่\nกรุณาไปที่เมนู \"ส่วนเสริม\" เพื่ออัพเดท",
				{
					{text="อัพเดทเลย!", cb = function() 
						_G.TheFrontEnd:PopScreen() 
						self:OnModsButton()
					end},
					{text="ปิด", cb = function() 
						_G.TheFrontEnd:PopScreen() 
					end}
				}))
			end
		end
	end, "GET")
	
	-- screens/redux/multiplayermainscreen ทำให้ STRINGS.UI.OPTIONS หน้าตัวเลือกแปลไม่ติด ต้องแก้ด้วยโค้ดนี้
	local OptionsScreen = require("databundles/screens/redux/optionsscreen")
	local oldSettings = self.Settings
	function self:Settings(default_section)
		oldSettings(self)
		self:_FadeToScreen(OptionsScreen, {default_section})
	end
end)

-- screens/redux/multiplayermainscreen ทำให้ STRINGS.UI.SERVERCREATIONSCREEN.PRIVACY แปลไม่ติด ต้องแก้ด้วยโค้ดนี้
local privacy_options = {}
for i,v in pairs(STRINGS.UI.SERVERCREATIONSCREEN.PRIVACY) do
	privacy_options[v] = i
end
AddClassPostConstruct("widgets/redux/serversettingstab", function(self)
	local oldRefreshPrivacyButtons = self.RefreshPrivacyButtons
	function self:RefreshPrivacyButtons() -- แก้ฟอนต์เป็น ???
		oldRefreshPrivacyButtons(self)
		for i,v in ipairs(self.privacy_type.buttons.buttonwidgets) do
			v.button.text:SetFont(_G.NEWFONT)
		end  
	end
	if self.privacy_type and self.privacy_type.buttons and self.privacy_type.buttons.buttonwidgets then
		for _,option in pairs(self.privacy_type.buttons.options) do
			if privacy_options[option.text] then
				option.text = STRINGS.UI.SERVERCREATIONSCREEN.PRIVACY[privacy_options[option.text]]
			end
		end
	end
end)

-- screens/redux/multiplayermainscreen ทำให้ STRINGS.UI.INTENTION แปลไม่ติด ต้องแก้ด้วยโค้ดนี้
local function postintentionpicker(self)
	if self.headertext then -- แก้สระหายของ STRINGS.UI.SERVERCREATIONSCREEN.INTENTION_TITLE
		local w,h = self.headertext:GetRegionSize()
		self.headertext:SetRegionSize(w,h+10)
	end
	local intention_options={{text=STRINGS.UI.INTENTION.SOCIAL},{text=STRINGS.UI.INTENTION.COOPERATIVE},{text=STRINGS.UI.INTENTION.COMPETITIVE},{text=STRINGS.UI.INTENTION.MADNESS},}
	for i, v in ipairs(intention_options) do
		self.buttons[i]:SetText(intention_options[i].text)
	end
end
AddClassPostConstruct("widgets/intentionpicker", postintentionpicker)
AddClassPostConstruct("widgets/redux/intentionpicker", postintentionpicker)

-- แก้ข้อความบังคับอัตโนมัติ เช่น "Moon Shard"
_G.setfenv(1, _G)
TranslateStringTable(STRINGS)