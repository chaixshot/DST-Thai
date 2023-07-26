if Config.UI ~= "disable" then
	local StringTable = {}

	-- แปล UI ทั้งหมด
	local function GetStringTable(text, data)
		for a,b in pairs(data) do
			if type(b) == "table" then
				GetStringTable(text.."."..a, b)
			else
				StringTable[data[a]] = t.PO[text.."."..a]
			end
		end
	end
	GetStringTable("STRINGS.UI", STRINGS.UI)

	-- แปลหน้าสร้างโลก > ป่า > รูปแบบวัน
	StringTable["Long Day"] = "ช่วงเช้ายาวนาน"
	StringTable["Long Dusk"] = "ช่วงเย็นยาวนาน"
	StringTable["Long Night"] = "กลางคืนยาวนาน"
	StringTable["No Day"] = "ไม่มีช่วงเช้า"
	StringTable["No Dusk"] = "ไม่มีช่วงเย็น"
	StringTable["No Night"] = "ไม่มีกลางคืน"
	StringTable["Only Day"] = "ช่วงเช้าเท่านั้น"
	StringTable["Only Dusk"] = "ช่วงเย็นเท่านั้น"
	StringTable["Only Night"] = "กลางคืนเท่านั้น"
	
	-- โฆณาหน้าแรก
	StringTable["New Update!"] = "อัพเดทใหม่!"
	StringTable["The Moon vs. Shadow Chest!"] = "ดวงจันทร์ vs. หีบแห่งเงา!"
	StringTable["From Beyond: Terrors Below is now live!"] = "จากบียอนด์: ความหวาดกลัวด้านล่าง\nมาแล้ว"
	StringTable["Get Walter's Triumphant Set!"] = "รับชุดชัยชนะของวอลเตอร์!"

	local oldSetString = _G.TextWidget.SetString
	_G.TextWidget.SetString = function(guid, str)
		if type(str)=="string" then
			str = StringTable[str] or str
		end
		oldSetString(guid, str)
	end
end