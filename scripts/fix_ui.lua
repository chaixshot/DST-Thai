_G.StringUITable = {}

local function TranslateStringTable(text, data)
	for k, v in pairs(data) do
		if type(v) == "table" then
			TranslateStringTable(text.."."..k, v)
		else
			_G.StringUITable[data[k]] = t.PO[text.."."..k]
		end
	end
end

if Config.CON == "enable" then -- แปลบทพูดตัวละครในเซิร์ฟเวอร์คนอื่น
	TranslateStringTable("STRINGS.CHARACTERS", STRINGS.CHARACTERS)
end

if Config.UI == "enable" then -- แปล UI ทั้งหมด
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
	_G.StringUITable["The Archaic Attire Chest!"] = "หีบเครื่องแต่งกายโบราณ!"
	_G.StringUITable["Archaic Artifacts Chest!"] = "หีบสิ่งประดิษฐ์โบราณ!"
	_G.StringUITable["Check out the new roadmap."] = "ตรวจสอบแผนงานใหม่"
	_G.StringUITable["Official Discord"] = "Discord อย่างเป็นทางการ"
	_G.StringUITable["Check out the official Klei Discord!"] = "ตรวจสอบ Klei Discord อย่างเป็นทางการ"

	_G.StringUITable["No previous recipe found"] = "ไม่พบสูตรล่าสุด"

	local oldSetString = _G.TextWidget.SetString
	_G.TextWidget.SetString = function(guid, str)
		if type(str) == "string" then
			str = _G.StringUITable[str] or str
		end
		oldSetString(guid, str)
	end
end
