_G = GLOBAL
rawget = _G.rawget
tonumber = _G.tonumber
tostring = _G.tostring
TheSim = _G.TheSim
STRINGS = _G.STRINGS
IsDST = _G.MOD_API_VERSION == 10
Thai = {
    SelectedLanguage = "th",
    StringUITable = {},
}

modimport("scripts/utility.lua")

if GetModConfigData("DISABLE_MOD_WARNING") then
    _G.DISABLE_MOD_WARNING = true
end

Config = {
    UI = GetModConfigData("CFG_UI"),
    CON = GetModConfigData("CFG_CON"),
    ITEM = GetModConfigData("CFG_ITEM"),
    ITEM_TWO = GetModConfigData("CFG_ITEM_TWO"),
    CON_ITEM_TWO = GetModConfigData("CFG_CON_ITEM_TWO"),
    OTHER_MOD = GetModConfigData("CFG_OTHER_MOD"),
}

--โหลดฟอนต์
local function applyLocalizedFonts()
    local LocalizedFontList = {
        ["belisaplumilla50"] = true,
        ["belisaplumilla100"] = true,
        ["bellefair50"] = true,
        ["bellefair50_outline"] = true,
        ["buttonfont"] = true,
        ["hammerhead50"] = true,
        ["opensans50"] = true,
        ["spirequal"] = rawget(_G, "NEWFONT") and true or nil,
        ["spirequal_small"] = rawget(_G, "NEWFONT_SMALL") and true or nil,
        ["spirequal_outline"] = rawget(_G, "NEWFONT_OUTLINE") and true or nil,
        ["spirequal_outline_small"] = rawget(_G, "NEWFONT_OUTLINE_SMALL") and true or nil,
        ["stint-ucr50"] = true,
        ["stint-ucr20"] = true,
        ["talkingfont"] = true,
        ["talkingfont_hermit"] = true,
        ["talkingfont_tradein"] = true,
        ["talkingfont_wormwood"] = true,
    }

    for FontName in pairs(LocalizedFontList) do
        TheSim:UnloadFont(Thai.SelectedLanguage.."_"..FontName)
    end
    TheSim:UnloadPrefabs({Thai.SelectedLanguage.."_fonts_"..modname})

    local LocalizedFontAssets = {}
    for FontName in pairs(LocalizedFontList) do
        table.insert(LocalizedFontAssets, _G.Asset("FONT", MODROOT.."fonts/"..FontName.."__"..Thai.SelectedLanguage..".zip"))
    end

    local LocalizedFontsPrefab = _G.Prefab("common/"..Thai.SelectedLanguage.."_fonts_"..modname, nil, LocalizedFontAssets)
    _G.RegisterPrefabs(LocalizedFontsPrefab)
    TheSim:LoadPrefabs({Thai.SelectedLanguage.."_fonts_"..modname})

    for FontName in pairs(LocalizedFontList) do
        TheSim:LoadFont(MODROOT.."fonts/"..FontName.."__"..Thai.SelectedLanguage..".zip", Thai.SelectedLanguage.."_"..FontName)
    end

    local fallbacks = {}
    for _, v in pairs(_G.FONTS) do
        local FontName = v.filename:sub(7, -5)
        if LocalizedFontList[FontName] then
            fallbacks[FontName] = {v.alias, _G.unpack(type(v.fallback) == "table" and v.fallback or {})}
        end
    end
    for FontName in pairs(LocalizedFontList) do
        TheSim:SetupFontFallbacks(Thai.SelectedLanguage.."_"..FontName, fallbacks[FontName])
    end

    if IsTranslateEnabled() then
        if rawget(_G, "DEFAULTFONT") then
            _G.DEFAULTFONT = Thai.SelectedLanguage.."_opensans50"
        end
        if rawget(_G, "DIALOGFONT") then
            _G.DIALOGFONT = Thai.SelectedLanguage.."_opensans50"
        end
        if rawget(_G, "TITLEFONT") then
            _G.TITLEFONT = Thai.SelectedLanguage.."_belisaplumilla100"
        end
        if rawget(_G, "UIFONT") then
            _G.UIFONT = Thai.SelectedLanguage.."_belisaplumilla50"
        end
        if rawget(_G, "BUTTONFONT") then
            _G.BUTTONFONT = Thai.SelectedLanguage.."_buttonfont"
        end
        if rawget(_G, "HEADERFONT") then
            _G.HEADERFONT = Thai.SelectedLanguage.."_hammerhead50"
        end
        if rawget(_G, "CHATFONT_OUTLINE") then
            _G.NUMBERFONT = Thai.SelectedLanguage.."_stint-ucr50"
        end
        if rawget(_G, "SMALLNUMBERFONT") then
            _G.SMALLNUMBERFONT = Thai.SelectedLanguage.."_stint-ucr20"
        end
        if rawget(_G, "BODYTEXTFONT") then
            _G.BODYTEXTFONT = Thai.SelectedLanguage.."_stint-ucr50"
        end
        if rawget(_G, "CHATFONT_OUTLINE") then
            _G.CHATFONT_OUTLINE = Thai.SelectedLanguage.."_bellefair50_outline"
        end
        if rawget(_G, "NEWFONT") then
            _G.NEWFONT = Thai.SelectedLanguage.."_spirequal"
        end
        if rawget(_G, "NEWFONT_SMALL") then
            _G.NEWFONT_SMALL = Thai.SelectedLanguage.."_spirequal_small"
        end
        if rawget(_G, "NEWFONT_OUTLINE") then
            _G.NEWFONT_OUTLINE = Thai.SelectedLanguage.."_spirequal_outline"
        end
        if rawget(_G, "NEWFONT_OUTLINE_SMALL") then
            _G.NEWFONT_OUTLINE_SMALL = Thai.SelectedLanguage.."_spirequal_outline_small"
        end
    end
    if rawget(_G, "CHATFONT") then
        _G.CHATFONT = Thai.SelectedLanguage.."_bellefair50"
    end
    if rawget(_G, "TALKINGFONT") then
        _G.TALKINGFONT = Thai.SelectedLanguage.."_talkingfont"
    end
    if rawget(_G, "TALKINGFONT_HERMIT") then
        _G.TALKINGFONT_HERMIT = Thai.SelectedLanguage.."_talkingfont"
    end
    if rawget(_G, "TALKINGFONT_TRADEIN") then
        _G.TALKINGFONT_TRADEIN = Thai.SelectedLanguage.."_talkingfont_tradein"
    end
    if rawget(_G, "TALKINGFONT_WORMWOOD") then
        _G.TALKINGFONT_WORMWOOD = Thai.SelectedLanguage.."_talkingfont_wormwood"
    end
    if _G.rawget(_G, "TALKINGFONT_WATHGRITHR") then
        _G.TALKINGFONT_WATHGRITHR = Thai.SelectedLanguage.."_talkingfont_wathgrithr"
    end
end

-- โหลดฟอนต์ไทย
local OldStart = _G.Start
function _G.Start()
    applyLocalizedFonts()
    OldStart()
end

_G.getmetatable(TheSim).__index.UnregisterAllPrefabs = (function()
    local oldUnregisterAllPrefabs = _G.getmetatable(TheSim).__index.UnregisterAllPrefabs
    return function(self, ...)
        oldUnregisterAllPrefabs(self, ...)
        applyLocalizedFonts()
    end
end)()

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
if IsTranslateEnabled() then
    LoadPOFile("scripts/languages/thai.po", Thai.SelectedLanguage)
    Thai.PO = _G.LanguageTranslator.languages[Thai.SelectedLanguage]

    -- ไอเทมสองภาษาใน STRING.CHARACTERS, STRING.SKILLTREE, STRING.SKIN_DESCRIPTIONS, STRINGS.RECIPE_DESC
    if Config.CON and Config.CON_ITEM_TWO then
        local itemNameTH = {}
        for k, v in pairs(STRINGS.NAMES) do
            local nameTH = tostring(Thai.PO["STRINGS.NAMES."..k])
            local nameEN = v
            itemNameTH[nameTH] = nameEN
        end

        local function itemTwoConversation(text, dataToCheck)
            local blackList = {["Nothing"] = true, ["X"] = true, ["Health"] = true, ["Sanity"] = true, ["Fire"] = true, ["Plant"] = true}
            for k, v in pairs(dataToCheck) do
                if type(v) == "table" then
                    itemTwoConversation(text.."."..k, v)
                else
                    local data = string.split(text.."."..k, ".")
                    local conversationTH = tostring(Thai.PO[text.."."..k])
                    local conversationEN = STRINGS[data[2]]
                    for i = 3, #data do
                        if tonumber(data[i]) then
                            conversationEN = conversationEN[tonumber(data[i])]
                        else
                            conversationEN = conversationEN[data[i]]
                        end
                    end
                    conversationEN = tostring(conversationEN)

                    for thainame, engname in pairs(itemNameTH) do
                        if not blackList[engname] and thainame ~= "nil" then
                            if string.find(conversationEN, engname) then -- Fast check
                                if string.find(conversationEN, "%f[%a]"..engname.."%f[%A]") then -- Slow check
                                    local newcon = string.gsub(conversationTH, "%f[%a]"..engname.."%f[%A]", thainame)
                                    if Config.ITEM then
                                        newcon = string.gsub(newcon, thainame, thainame.."("..engname..")")
                                    else -- ปิดแปลชื่อไอเทมในบทสนทนา
                                        newcon = string.gsub(newcon, thainame, " "..engname.." ")
                                    end
                                    conversationTH = string.gsub(newcon, "  ", " ")
                                    Thai.PO[text.."."..k] = conversationTH
                                end
                            end
                        end
                    end
                end
            end
        end

        itemTwoConversation("STRINGS.CHARACTERS", STRINGS.CHARACTERS)
        if Config.UI then
            itemTwoConversation("STRINGS.RECIPE_DESC", STRINGS.RECIPE_DESC)
            if IsDST then
                itemTwoConversation("STRINGS.SKILLTREE", STRINGS.SKILLTREE)
                itemTwoConversation("STRINGS.SKIN_DESCRIPTIONS", STRINGS.SKIN_DESCRIPTIONS)
            end
        end
    end

    -- ไอเทมสองภาษาในชื่อไอเทมเลย
    if Config.ITEM and Config.ITEM_TWO then
        local function itemTwoName(text, block)
            for k, v in pairs(block) do
                if type(v) == "table" then
                    itemTwoName(text.."."..k, v)
                else
                    local data = string.split(text.."."..k, ".")
                    local ItemTH = tostring(Thai.PO[text.."."..k])
                    local ItemEN = STRINGS[data[2]]
                    if ItemTH ~= "nil" then
                        for i = 3, #data do
                            if tonumber(data[i]) then
                                ItemEN = ItemEN[tonumber(data[i])]
                            else
                                ItemEN = ItemEN[data[i]]
                            end
                        end
                        if not string.find(ItemTH, "%s") then
                            Thai.PO[text.."."..k] = ItemTH..(ItemEN and "\n("..ItemEN..")" or "")
                        end
                    end
                end
            end
        end

        itemTwoName("STRINGS.NAMES", STRINGS.NAMES)
        itemTwoName("STRINGS.BUNNYMANNAMES", STRINGS.BUNNYMANNAMES)
        itemTwoName("STRINGS.CHARACTER_NAMES", STRINGS.CHARACTER_NAMES)
        itemTwoName("STRINGS.MERMNAMES", STRINGS.MERMNAMES)
        itemTwoName("STRINGS.PIGNAMES", STRINGS.PIGNAMES)

        if IsDST then
            itemTwoName("STRINGS.BEEFALONAMING", STRINGS.BEEFALONAMING)
            itemTwoName("STRINGS.CROWNAMES", STRINGS.CROWNAMES)
            itemTwoName("STRINGS.KITCOON_NAMING", STRINGS.KITCOON_NAMING)
            itemTwoName("STRINGS.SWAMPIGNAMES", STRINGS.SWAMPIGNAMES)
        else
            itemTwoName("STRINGS.CITYPIGNAMES", STRINGS.CITYPIGNAMES)
            itemTwoName("STRINGS.ANTNAMES", STRINGS.ANTNAMES)
            itemTwoName("STRINGS.ANTWARRIORNAMES", STRINGS.ANTWARRIORNAMES)
            itemTwoName("STRINGS.BALLPHINNAMES", STRINGS.BALLPHINNAMES)
            itemTwoName("STRINGS.MANDRAKEMANNAMES", STRINGS.MANDRAKEMANNAMES)
            itemTwoName("STRINGS.PARROTNAMES", STRINGS.PARROTNAMES)
            itemTwoName("STRINGS.SHIPNAMES", STRINGS.SHIPNAMES)
        end
    end

    if not Config.UI or not Config.CON or not Config.ITEM then
        for _string in pairs(Thai.PO) do
            -- ปิดการแปล UI
            if not Config.UI then
                for _, v in ipairs({
                    "STRINGS.UI",
                    "STRINGS.ACTIONS",
                    "STRINGS.RECIPE_DESC",
                    "STRINGS.ANTIADDICTION",
                    "STRINGS.CHARACTER_",
                }) do
                    if string.find(_string, v) then
                        Thai.PO[_string] = nil
                    end
                end
            end

            -- ปิดการแปลบทพูด
            if not Config.CON then
                for _, v in ipairs({
                    "STRINGS.CHARACTERS",
                    "STRINGS.BOARLORD_",
                    "STRINGS.CARNIVAL_",
                    "STRINGS.GOATMUM_",
                    "STRINGS.HERMITCRAB_",
                    "STRINGS.VOIDCLOTH_",
                    "STRINGS.YOTB_",
                    "STRINGS.LUCY",
                    "STRINGS.MERM_KING_TALK_",
                    "STRINGS.MERM_TALK",
                }) do
                    if string.find(_string, v) then
                        Thai.PO[_string] = nil
                    end
                end
            end

            -- ปิดการแปลชื่อไอเทม
            if not Config.ITEM then
                for _, v in ipairs({
                    "STRINGS.NAMES",
                }) do
                    if string.find(_string, v) then
                        Thai.PO[_string] = nil
                    end
                end
            end
        end
    end
end

modimport("scripts/CHARACTER.lua")
modimport("scripts/fix_ui.lua")
modimport("scripts/mods/main.lua")
modimport("scripts/string.lua")

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
---------------------------

-- Version Check
-- ^^ SimLuaProxy::QueryServer() tried to access a URL not permitted by the game.
--[[ AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self, prev_screen, profile, offline, session_data)
    TheSim:QueryServer("https://raw.githubusercontent.com/chaixshot/DST-Thai/main/version.txt", function(result, isSuccessful, resultCode)
        if resultCode == 200 and isSuccessful then
            local json = require("json")
            local data = json.decode(result)
            if modinfo.version ~= data.version then
                local PopupDialogScreen = require("screens/redux/popupdialog")
                local ModsScreen = require("screens/redux/modsscreen")
                _G.TheFrontEnd:PushScreen(PopupDialogScreen("อัพเดท", "ส่วนเสริม \"ภาษาไทย\" มีอัพเดทใหม่\nกรุณาไปที่เมนู \"ส่วนเสริม\" เพื่ออัพเดท",
                    {
                        {
                            text = "อัพเดทเลย!",
                            cb = function()
                                _G.TheFrontEnd:PopScreen()
                                self:OnModsButton()
                            end
                        },
                        {
                            text = "ปิด",
                            cb = function()
                                _G.TheFrontEnd:PopScreen()
                            end
                        }
                    }))
            end
        end
    end, "GET")
end) ]]

local function postintentionpicker(self)
    if self.headertext then -- แก้สระหายของ STRINGS.UI.SERVERCREATIONSCREEN.INTENTION_TITLE
        local w, h = self.headertext:GetRegionSize()
        self.headertext:SetRegionSize(w, h + 10)
    end
end
AddClassPostConstruct("widgets/intentionpicker", postintentionpicker)
AddClassPostConstruct("widgets/redux/intentionpicker", postintentionpicker)

-- แก้ข้อความบังคับอัตโนมัติ เช่น "Moon Shard"
_G.setfenv(1, _G)
TranslateStringTable(STRINGS)
