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
    CON_ITEM = GetModConfigData("CFG_CON_ITEM"),
    OTHER_MOD = GetModConfigData("CFG_OTHER_MOD"),
}

--โหลดฟอนต์
local function applyLocalizedFonts()
    -- List of font assets file
    local fontAssetsList = {
        ["kodchasan50"] = true,
        ["leelawadeeui50"] = true,
        ["leelawadeeui_small"] = true,
        ["leelawadeeui50_outline"] = true,
        ["leelawadeeui_outline_small"] = true,
        ["dilleniaupc50"] = true,
        ["dilleniaupc50_outline"] = true,
    }

    -- Index of game original font to thai custom font
    local fontIndex = {
        ["belisaplumilla100"] = "kodchasan50",
        ["belisaplumilla50"] = "kodchasan50",
        ["bellefair50"] = "leelawadeeui50",
        ["bellefair50_outline"] = "leelawadeeui50_outline",
        ["buttonfont"] = "kodchasan50",
        ["hammerhead50"] = "leelawadeeui50",
        ["opensans50"] = "leelawadeeui50_outline",
        ["spirequal"] = "leelawadeeui50",
        ["spirequal_outline"] = "leelawadeeui50_outline",
        ["spirequal_outline_small"] = "leelawadeeui_outline_small",
        ["spirequal_small"] = "leelawadeeui_small",
        ["stint-ucr20"] = "dilleniaupc50_outline",
        ["stint-ucr50"] = "dilleniaupc50",
        ["talkingfont"] = "leelawadeeui50_outline",
        ["talkingfont_hermit"] = "leelawadeeui50_outline",
        ["talkingfont_tradein"] = "leelawadeeui50_outline",
        ["talkingfont_wathgrithr"] = "leelawadeeui50_outline",
        ["talkingfont_wormwood"] = "leelawadeeui50_outline",
    }
    local fontPrefab = Thai.SelectedLanguage.."_fonts_"..modname

    -- Unload thai font and prefab on reloading mod
    for fontName, fontUseName in pairs(fontIndex) do
        local fontID = Thai.SelectedLanguage.."_"..fontName
        TheSim:UnloadFont(fontID)
    end
    TheSim:UnloadPrefabs({fontPrefab})

    -- Loading font file assets
    local localFontAssets = {}
    for fontName in pairs(fontAssetsList) do
        local fontPath = MODROOT.."fonts/"..fontName.."__"..Thai.SelectedLanguage..".zip"
        table.insert(localFontAssets, _G.Asset("FONT", fontPath))
    end

    -- Load thai fonts to engine
    local localizedFontsPrefab = _G.Prefab("common/"..fontPrefab, nil, localFontAssets)
    _G.RegisterPrefabs(localizedFontsPrefab)
    TheSim:LoadPrefabs({fontPrefab})
    for fontName, fontUseName in pairs(fontIndex) do
        local fontID = Thai.SelectedLanguage.."_"..fontName
        local fontPath = MODROOT.."fonts/"..fontUseName.."__"..Thai.SelectedLanguage..".zip"
        TheSim:LoadFont(fontPath, fontID)
    end

    -- Set fallback font for misssing charactor to game original
    for _, v in pairs(_G.FONTS) do
        local fontName = v.filename:sub(7, -5)
        if fontIndex[fontName] then
            local fontID = Thai.SelectedLanguage.."_"..fontName
            TheSim:SetupFontFallbacks(fontID, {v.alias, _G.unpack(type(v.fallback) == "table" and v.fallback or {})})
        end
    end

    -- Apple font to the engine
    if IsTranslateEnabled() then
        if rawget(_G, "DEFAULTFONT") then
            _G.DEFAULTFONT = Thai.SelectedLanguage.."_".."opensans50"
        end
        if rawget(_G, "DIALOGFONT") then
            _G.DIALOGFONT = Thai.SelectedLanguage.."_".."opensans50"
        end
        if rawget(_G, "TITLEFONT") then
            _G.TITLEFONT = Thai.SelectedLanguage.."_".."belisaplumilla100"
        end
        if rawget(_G, "UIFONT") then
            _G.UIFONT = Thai.SelectedLanguage.."_".."belisaplumilla50"
        end
        if rawget(_G, "BUTTONFONT") then
            _G.BUTTONFONT = Thai.SelectedLanguage.."_".."buttonfont"
        end
        if rawget(_G, "HEADERFONT") then
            _G.HEADERFONT = Thai.SelectedLanguage.."_".."hammerhead50"
        end
        if rawget(_G, "NUMBERFONT") then
            _G.NUMBERFONT = Thai.SelectedLanguage.."_".."stint-ucr50"
        end
        if rawget(_G, "SMALLNUMBERFONT") then
            _G.SMALLNUMBERFONT = Thai.SelectedLanguage.."_".."stint-ucr20"
        end
        if rawget(_G, "BODYTEXTFONT") then
            _G.BODYTEXTFONT = Thai.SelectedLanguage.."_".."stint-ucr50"
        end
        if rawget(_G, "CHATFONT_OUTLINE") then
            _G.CHATFONT_OUTLINE = Thai.SelectedLanguage.."_".."bellefair50_outline"
        end
        if rawget(_G, "NEWFONT") then
            _G.NEWFONT = Thai.SelectedLanguage.."_".."spirequal"
        end
        if rawget(_G, "NEWFONT_SMALL") then
            _G.NEWFONT_SMALL = Thai.SelectedLanguage.."_".."spirequal_small"
        end
        if rawget(_G, "NEWFONT_OUTLINE") then
            _G.NEWFONT_OUTLINE = Thai.SelectedLanguage.."_".."spirequal_outline"
        end
        if rawget(_G, "NEWFONT_OUTLINE_SMALL") then
            _G.NEWFONT_OUTLINE_SMALL = Thai.SelectedLanguage.."_".."spirequal_outline_small"
        end
    end
    if rawget(_G, "CHATFONT") then
        _G.CHATFONT = Thai.SelectedLanguage.."_".."bellefair50"
    end
    if rawget(_G, "TALKINGFONT") then
        _G.TALKINGFONT = Thai.SelectedLanguage.."_".."talkingfont"
    end
    if rawget(_G, "TALKINGFONT_HERMIT") then
        _G.TALKINGFONT_HERMIT = Thai.SelectedLanguage.."_".."talkingfont_hermit"
    end
    if rawget(_G, "TALKINGFONT_TRADEIN") then
        _G.TALKINGFONT_TRADEIN = Thai.SelectedLanguage.."_".."talkingfont_tradein"
    end
    if rawget(_G, "TALKINGFONT_WORMWOOD") then
        _G.TALKINGFONT_WORMWOOD = Thai.SelectedLanguage.."_".."talkingfont_wormwood"
    end
    if rawget(_G, "TALKINGFONT_WATHGRITHR") then
        _G.TALKINGFONT_WATHGRITHR = Thai.SelectedLanguage.."_".."talkingfont_wathgrithr"
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

    modimport("scripts/conItem/conItem.lua")

    local uiStrings = {
        "STRINGS.UI",
        "STRINGS.ACTIONS",
        "STRINGS.RECIPE_DESC",
        "STRINGS.ANTIADDICTION",
        "STRINGS.CHARACTER_",
        "STRINGS.SKILLTREE",
        "STRINGS.SKIN_DESCRIPTIONS",
    }
    local conStrings = {
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
    }
    local itemStrings = {
        "STRINGS.NAMES",
        "STRINGS.BUNNYMANNAMES",
        "STRINGS.CHARACTER_NAMES",
        "STRINGS.MERMNAMES",
        "STRINGS.PIGNAMES",
    }

    if IsDST then
        table.insert(itemStrings, "STRINGS.BEEFALONAMING")
        table.insert(itemStrings, "STRINGS.CROWNAMES")
        table.insert(itemStrings, "STRINGS.KITCOON_NAMING")
        table.insert(itemStrings, "STRINGS.SWAMPIGNAMES")
    else
        table.insert(itemStrings, "STRINGS.CITYPIGNAMES")
        table.insert(itemStrings, "STRINGS.ANTNAMES")
        table.insert(itemStrings, "STRINGS.ANTWARRIORNAMES")
        table.insert(itemStrings, "STRINGS.BALLPHINNAMES")
        table.insert(itemStrings, "STRINGS.MANDRAKEMANNAMES")
        table.insert(itemStrings, "STRINGS.PARROTNAMES")
        table.insert(itemStrings, "STRINGS.SHIPNAMES")
    end

    -- ไอเทมสองภาษาในชื่อไอเทมเลย
    if Config.ITEM and Config.ITEM_TWO then
        for _, text in ipairs(itemStrings) do
            for itemIndex, itemEN in pairs(GetOriginalStringsFromIndex(text)) do
                local itemTH = Thai.PO[itemIndex]

                if itemTH then
                    if not itemTH:find("%s") then
                        Thai.PO[itemIndex] = itemTH..(itemEN and "\n("..itemEN..")" or "")
                    end
                end
            end
        end
    end

    if not Config.UI or not Config.CON or not Config.ITEM then
        for stringIndex in pairs(Thai.PO) do
            -- ปิดการแปล UI
            if not Config.UI then
                for _, v in ipairs(uiStrings) do
                    if stringIndex:find(v) then
                        Thai.PO[stringIndex] = nil
                    end
                end
            end

            -- ปิดการแปลบทพูด
            if not Config.CON then
                for _, v in ipairs(conStrings) do
                    if stringIndex:find(v) then
                        Thai.PO[stringIndex] = nil
                    end
                end
            end

            -- ปิดการแปลชื่อไอเทม
            if not Config.ITEM then
                for _, v in ipairs(itemStrings) do
                    if stringIndex:find(v) then
                        Thai.PO[stringIndex] = nil
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
