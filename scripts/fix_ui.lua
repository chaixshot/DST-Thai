_G.StringUITable = {}

local function TranslateStringTable(text, data)
    for a,b in pairs(data) do
        if type(b) == "table" then
            TranslateStringTable(text.."."..a, b)
        else
            _G.StringUITable[data[a]] = t.PO[text.."."..a]
        end
    end
end

if Config.CON ~= "disable" then -- แปลบทพูดตัวละครในเซิร์ฟเวอร์คนอื่น
    TranslateStringTable("STRINGS.CHARACTERS", STRINGS.CHARACTERS)
end

if Config.UI ~= "disable" then -- แปล UI ทั้งหมด
	TranslateStringTable("STRINGS.UI", STRINGS.UI)

	-- แปลหน้าสร้างโลก > ป่า > รูปแบบวัน
	_G.StringUITable["Long Day"] = "ช่วงเช้ายาวนาน"
	_G.StringUITable["Long Dusk"] = "ช่วงเย็นยาวนาน"
	_G.StringUITable["Long Night"] = "กลางคืนยาวนาน"
	_G.StringUITable["No Day"] = "ไม่มีช่วงเช้า"
	_G.StringUITable["No Dusk"] = "ไม่มีช่วงเย็น"
	_G.StringUITable["No Night"] = "ไม่มีกลางคืน"
	_G.StringUITable["Only Day"] = "ช่วงเช้าเท่านั้น"
	_G.StringUITable["Only Dusk"] = "ช่วงเย็นเท่านั้น"
	_G.StringUITable["Only Night"] = "กลางคืนเท่านั้น"
	
	-- โฆณาหน้าแรก
	_G.StringUITable["New Update!"] = "อัพเดทใหม่!"
	_G.StringUITable["The Moon vs. Shadow Chest!"] = "ดวงจันทร์ vs หีบแห่งเงา!"
	_G.StringUITable["From Beyond: Terrors Below is now live!"] = "จากบียอนด์: ความหวาดกลัวด้านล่าง\nมาแล้ว"
	_G.StringUITable["Get Walter's Triumphant Set!"] = "รับเซ็ตชัยชนะของวอลเตอร์!"
	_G.StringUITable["Get Warly's Triumphant Set!"] = "รับเซ็ตชัยชนะของวอล่า!"
	_G.StringUITable["Get the Wortox Triumphant Set!"] = "รับเซ็ตชัยชนะของวอร์ทอกซ์!"
	_G.StringUITable["Get Wigfrid's Moonbound Set!"] = "รับเซ็ตมูนบาวด์ของวิกฟริด!"
	_G.StringUITable["Get Winona's Moonbound Set!"] = "รับเซ็ตมูนบาวด์ของวิโนน่า!"
	_G.StringUITable["Get Wolfgang's Moonbound Set!"] = "รับเซ็ตมูนบาวด์ของโวล์ฟกัง!"
	_G.StringUITable["Roadmap 2023"] = "โรดแม็ปปี 2566"
	_G.StringUITable["Check out the new roadmap."] = "ตรวจสอบแผนงานใหม่"
	_G.StringUITable["20 New T-Shirt Designs!"] = "แบบเสื้อยืด20 ใหม่ตัว!"
	_G.StringUITable["Save Up to 20% on the Klei Shop!"] = "ประหยัดสูงสุดถึง 20% ที่ร้านค้า Klei!"
    
	_G.StringUITable["No previous recipe found"] = "ไม่พบสูตรล่าสุด"

	local oldSetString = _G.TextWidget.SetString
	_G.TextWidget.SetString = function(guid, str)
		if type(str)=="string" then
			str = _G.StringUITable[str] or str
		end
		oldSetString(guid, str)
	end
end

if Config.CFG_OTHER_MOD ~= "disable" then -- แปลภาษามอดที่เปิดใช้งานอยู่
	local mod_enable = {}
	if not (_G.KnownModIndex and _G.KnownModIndex.savedata and _G.KnownModIndex.savedata.known_mods) then

	else
		for folder, mod in pairs(_G.KnownModIndex.savedata.known_mods) do
			local name = mod.modinfo.name
			if name then
				mod_enable[name] = true
			end
		end
	end
	
	local mod_main_do = {}
	mod_main_do["Minimap HUD Customizable"] = 842702425
	mod_main_do["Geometric Placement"] = 351325790
	mod_main_do["Item Info"] = 836583293
	mod_main_do["Combined Status"] = 376333686
    
	for k,v in pairs(mod_main_do) do
		if mod_enable[k] then
			modimport("scripts/mods/"..tostring(v))
		end
	end
end