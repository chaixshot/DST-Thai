_G = GLOBAL
rawget = _G.rawget
tonumber = _G.tonumber
mods=_G.rawget(_G,"mods") or (function() local m={}_G.rawset (_G,"mods",m) return m end)()
mods.ThaiLanguagePack = {}
t = mods.ThaiLanguagePack
t.SelectedLanguage = "th"
TheSim = _G.TheSim
STRINGS = _G.STRINGS
IsDST = _G.MOD_API_VERSION == 10

modimport("scripts/utility.lua")

if GetModConfigData("DISABLE_MOD_WARNING") then
	_G.DISABLE_MOD_WARNING = true
end

Config = {}
Config.UI = GetModConfigData("CFG_UI")
Config.CON = GetModConfigData("CFG_CON")
Config.ITEM = GetModConfigData("CFG_ITEM")
Config.CFG_ITEM_TWO = GetModConfigData("CFG_ITEM_TWO")
Config.CFG_OTHER_MOD = GetModConfigData("CFG_OTHER_MOD")

--โหลดฟอนต์
function ApplyLocalizedFonts()
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

	if Config.UI == "enable" or Config.CON == "enable" or Config.ITEM == "enable" then
        if rawget(_G,"DEFAULTFONT") then
            _G.DEFAULTFONT = t.SelectedLanguage.."_opensans50"
        end
        if rawget(_G,"DIALOGFONT") then
            _G.DIALOGFONT = t.SelectedLanguage.."_opensans50"
        end
        if rawget(_G,"TITLEFONT") then
            _G.TITLEFONT = t.SelectedLanguage.."_belisaplumilla100"
        end
        if rawget(_G,"UIFONT") then
            _G.UIFONT = t.SelectedLanguage.."_belisaplumilla50"
        end
        if rawget(_G,"BUTTONFONT") then
            _G.BUTTONFONT = t.SelectedLanguage.."_buttonfont"
        end
        if rawget(_G,"HEADERFONT") then
            _G.HEADERFONT = t.SelectedLanguage.."_hammerhead50"
        end
        if rawget(_G,"CHATFONT_OUTLINE") then
            _G.NUMBERFONT = t.SelectedLanguage.."_stint-ucr50"
        end
        if rawget(_G,"SMALLNUMBERFONT") then
            _G.SMALLNUMBERFONT = t.SelectedLanguage.."_stint-ucr20"
        end
        if rawget(_G,"BODYTEXTFONT") then
            _G.BODYTEXTFONT = t.SelectedLanguage.."_stint-ucr50"
        end
        if rawget(_G,"CHATFONT_OUTLINE") then
            _G.CHATFONT_OUTLINE = t.SelectedLanguage.."_bellefair50_outline"
        end
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
    if rawget(_G,"CHATFONT") then
        _G.CHATFONT = t.SelectedLanguage.."_bellefair50"
    end
    if rawget(_G,"TALKINGFONT") then
        _G.TALKINGFONT = t.SelectedLanguage.."_talkingfont"
    end
    if rawget(_G,"TALKINGFONT_HERMIT") then
        _G.TALKINGFONT_HERMIT = t.SelectedLanguage.."_talkingfont"
    end
    if rawget(_G,"TALKINGFONT_TRADEIN") then
        _G.TALKINGFONT_TRADEIN = t.SelectedLanguage.."_talkingfont_tradein"
    end
    if rawget(_G,"TALKINGFONT_WORMWOOD") then
        _G.TALKINGFONT_WORMWOOD = t.SelectedLanguage.."_talkingfont_wormwood"
    end
    if _G.rawget(_G, "TALKINGFONT_WATHGRITHR") then
		_G.TALKINGFONT_WATHGRITHR = t.SelectedLanguage.."_talkingfont_wathgrithr"
	end
end

-- โหลดฟอนต์ในหน้าที่เกมไม่โหลดให้
local oldSetFont = _G.TextWidget.SetFont
_G.TextWidget.SetFont = function(guid, font)
	if font == "opensans" then
		oldSetFont(guid, _G.DEFAULTFONT)
	elseif font == "opensans" then
		oldSetFont(guid, _G.DIALOGFONT)
	elseif font == "bp100" then
		oldSetFont(guid, _G.TITLEFONT)
	elseif font == "bp50" then
		oldSetFont(guid, _G.UIFONT)
	elseif font == "buttonfont" then
		oldSetFont(guid, _G.BUTTONFONT)
	elseif font == "hammerhead" then
		oldSetFont(guid, _G.HEADERFONT)
	elseif font == "stint-ucr" then
		oldSetFont(guid, _G.NUMBERFONT)
	elseif font == "stint-small" then
		oldSetFont(guid, _G.SMALLNUMBERFONT)
	elseif font == "stint-ucr" then
		oldSetFont(guid, _G.BODYTEXTFONT)
	elseif font == "bellefair_outline" then
		oldSetFont(guid, _G.CHATFONT_OUTLINE)
	elseif font == "spirequal" then
		oldSetFont(guid, _G.NEWFONT)
	elseif font == "spirequal_small" then
		oldSetFont(guid, _G.NEWFONT_SMALL)
	elseif font == "spirequal_outline" then
		oldSetFont(guid, _G.NEWFONT_OUTLINE)
	elseif font == "spirequal_outline_small" then
		oldSetFont(guid, _G.NEWFONT_OUTLINE_SMALL)
	elseif font == "bellefair" then
		oldSetFont(guid, _G.CHATFONT)
	elseif font == "talkingfont" then
		oldSetFont(guid, _G.TALKINGFONT)
	elseif font == "talkingfont_hermit" then
		oldSetFont(guid, _G.TALKINGFONT_HERMIT)
	elseif font == "talkingfont_tradein" then
		oldSetFont(guid, _G.TALKINGFONT_TRADEIN)
	elseif font == "talkingfont_wormwood" then
		oldSetFont(guid, _G.TALKINGFONT_WORMWOOD)
	else
		oldSetFont(guid, font)
	end
end
--------------------------

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
if Config.UI == "enable" or Config.CON == "enable" or Config.ITEM == "enable" then
	LoadPOFile("scripts/languages/thai.po", t.SelectedLanguage)
	t.PO = _G.LanguageTranslator.languages[t.SelectedLanguage]

    -- ไอเทมสองภาษาใน STRING.CHARACTERS, STRING.SKILLTREE, STRING.SKIN_DESCRIPTIONS, STRINGS.RECIPE_DESC
    if Config.CON == "enable" then
        local ItemNameTH = {}
        for k,v in pairs(STRINGS.NAMES) do
            local nameTH = tostring(t.PO["STRINGS.NAMES."..k])
            local nameEN = v
            ItemNameTH[nameTH] = nameEN
        end
        local function ItemTwoConversation(text, data)
            for k,v in pairs(data) do
                if type(v) == "table" then
                    ItemTwoConversation(text.."."..k, v)
                else
                    local data = split(text.."."..k, ".")
                    local ConversationTH = tostring(t.PO[text.."."..k])
                    local ConversationEN = STRINGS[data[2]]
                    for i=3, #data do
                        if tonumber(data[i]) then
                            ConversationEN = ConversationEN[tonumber(data[i])]
                        else
                            ConversationEN = ConversationEN[data[i]]
                        end
                    end
                    ConversationEN = tostring(ConversationEN)
                    
                    local BlackList = {
                        ["Nothing"] = true,
                        ["X"] = true,
                        ["Health"] = true,
                        ["Sanity"] = true,
                        ["Fire"] = true,
                        ["Plant"] = true,
                    }
                    
                    for thainame, engname in pairs(ItemNameTH) do
                        if not BlackList[engname] then
                            if string.find(ConversationEN, engname) then -- Fast check
                                if string.find(ConversationEN, "%f[%a]"..engname.."%f[%A]") then -- Slow check
                                    local newcon = string.gsub(ConversationTH, "%f[%a]"..engname.."%f[%A]", thainame)
                                    if Config.ITEM == "disable" then -- ปิดแปลชื่อไอเทมในบทสนทนา
                                        newcon = string.gsub(newcon, thainame, " "..engname.." ")
                                    else
                                        newcon = string.gsub(newcon, thainame, thainame.."("..engname..")")
                                    end
                                    ConversationTH = string.gsub(newcon, "  ", " ")
                                    t.PO[text.."."..k] = ConversationTH
                                end
                            end
                        end
                    end
                end
            end
        end
        ItemTwoConversation("STRINGS.CHARACTERS", STRINGS.CHARACTERS)
        ItemTwoConversation("STRINGS.RECIPE_DESC", STRINGS.RECIPE_DESC)
        if IsDST then
            ItemTwoConversation("STRINGS.SKILLTREE", STRINGS.SKILLTREE)
            ItemTwoConversation("STRINGS.SKIN_DESCRIPTIONS", STRINGS.SKIN_DESCRIPTIONS)
        end
    end
    
    -- ไอเทมสองภาษาในชื่อไอเทมเลย
    if Config.ITEM == "enable" and Config.CFG_ITEM_TWO == "enable" then
        local function ItemTwoName(text, data)
            for k,v in pairs(data) do
                if type(v) == "table" then
                    ItemTwoName(text.."."..k, v)
                else
                    local data = split(text.."."..k, ".")
                    local ItemTH = tostring(t.PO[text.."."..k])
                    local ItemEN = STRINGS[data[2]]
                    for i=3, #data do
                        if tonumber(data[i]) then
                            ItemEN = ItemEN[tonumber(data[i])]
                        else
                            ItemEN = ItemEN[data[i]]
                        end
                    end
                    t.PO[text.."."..k]=ItemTH..(ItemEN and "\n("..ItemEN..")" or "")
                end
            end
        end
        ItemTwoName("STRINGS.NAMES", STRINGS.NAMES)
        ItemTwoName("STRINGS.BUNNYMANNAMES", STRINGS.BUNNYMANNAMES)
        ItemTwoName("STRINGS.CHARACTER_NAMES", STRINGS.CHARACTER_NAMES)
        ItemTwoName("STRINGS.MERMNAMES", STRINGS.MERMNAMES)
        ItemTwoName("STRINGS.PIGNAMES", STRINGS.PIGNAMES)
        if IsDST then
            ItemTwoName("STRINGS.BEEFALONAMING", STRINGS.BEEFALONAMING)
            ItemTwoName("STRINGS.CROWNAMES", STRINGS.CROWNAMES)
            ItemTwoName("STRINGS.KITCOON_NAMING", STRINGS.KITCOON_NAMING)
            ItemTwoName("STRINGS.SWAMPIGNAMES", STRINGS.SWAMPIGNAMES)
        else
            ItemTwoName("STRINGS.CITYPIGNAMES", STRINGS.CITYPIGNAMES)
            ItemTwoName("STRINGS.ANTNAMES", STRINGS.ANTNAMES)
            ItemTwoName("STRINGS.ANTWARRIORNAMES", STRINGS.ANTWARRIORNAMES)
            ItemTwoName("STRINGS.BALLPHINNAMES", STRINGS.BALLPHINNAMES)
            ItemTwoName("STRINGS.MANDRAKEMANNAMES", STRINGS.MANDRAKEMANNAMES)
            ItemTwoName("STRINGS.PARROTNAMES", STRINGS.PARROTNAMES)
            ItemTwoName("STRINGS.SHIPNAMES", STRINGS.SHIPNAMES)
        end
	end
    
    for k,v in pairs(t.PO) do
        -- ปิดการแปล UI
        if Config.UI == "disable" then
			if string.find(k, "STRINGS.UI") or string.find(k, "STRINGS.ACTIONS") or string.find(k, "STRINGS.RECIPE_DESC") or string.find(k, "STRINGS.ANTIADDICTION") or string.find(k, "STRINGS.CHARACTER_") then
				t.PO[k]=""
			end
		end
        
        -- ปิดการแปลบทพูด
        if Config.CON == "disable" then
            if string.find(k, "STRINGS.CHARACTERS.GENERIC") or string.find(k, "STRINGS.BOARLORD_") or string.find(k, "STRINGS.CARNIVAL_") or string.find(k, "STRINGS.GOATMUM_") or string.find(k, "STRINGS.HERMITCRAB_") or string.find(k, "STRINGS.VOIDCLOTH_") or string.find(k, "STRINGS.YOTB_") or string.find(k, "STRINGS.LUCY") or string.find(k, "STRINGS.MERM_KING_TALK_") or string.find(k, "STRINGS.MERM_TALK") then
                t.PO[k]=""
            end
        end
        
        -- ปิดการแปลชื่อไอเทม
        if Config.ITEM == "disable" then 
            if string.find(k, "STRINGS.NAMES") then
				t.PO[k]=""
			end
        end
	end
	
	modimport("scripts/EMPTY.lua")
end
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
end)

local function postintentionpicker(self)
	if self.headertext then -- แก้สระหายของ STRINGS.UI.SERVERCREATIONSCREEN.INTENTION_TITLE
		local w,h = self.headertext:GetRegionSize()
		self.headertext:SetRegionSize(w,h+10)
	end
end
AddClassPostConstruct("widgets/intentionpicker", postintentionpicker)
AddClassPostConstruct("widgets/redux/intentionpicker", postintentionpicker)

-- แก้ข้อความบังคับอัตโนมัติ เช่น "Moon Shard"
_G.setfenv(1, _G)
TranslateStringTable(STRINGS)