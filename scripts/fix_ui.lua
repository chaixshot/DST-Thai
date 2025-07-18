if Config.UI then -- แปล UI ทั้งหมด
	-- TranslateStringTable("STRINGS.UI", STRINGS.UI)

	-- แปลหน้าสร้างโลก > ป่า > รูปแบบวัน
	Thai.StringUITable["Long Day"] = "ช่วงเช้ายาวนาน"
	Thai.StringUITable["Long Dusk"] = "ช่วงเย็นยาวนาน"
	Thai.StringUITable["Long Night"] = "กลางคืนยาวนาน"
	Thai.StringUITable["No Day"] = "ไม่มีช่วงเช้า"
	Thai.StringUITable["No Dusk"] = "ไม่มีช่วงเย็น"
	Thai.StringUITable["No Night"] = "ไม่มีกลางคืน"
	Thai.StringUITable["Only Day"] = "ช่วงเช้าเท่านั้น"
	Thai.StringUITable["Only Dusk"] = "ช่วงเย็นเท่านั้น"
	Thai.StringUITable["Only Night"] = "กลางคืนเท่านั้น"

	-- โฆณาหน้าแรก
	Thai.StringUITable["New Update!"] = "อัพเดทใหม่!"
	Thai.StringUITable["The Moonbound and Stampeder Collections!"] = "คอลเลกชั่น Moonbound และ Stampeder!"
	Thai.StringUITable["The Hostile Takeover Update is live!"] = "การอัปเดต Hostile Takeover เริ่มแล้ว"

	Thai.StringUITable["New Twitch Drop!"] = "Twitch Drop ใหม่!"
	Thai.StringUITable["The Gathering Amulet"] = "เครื่องรางแห่งการรวบรวม"

	Thai.StringUITable["Official Discord"] = "Discord อย่างเป็นทางการ"
	Thai.StringUITable["Check out the official Klei Discord!"] = "Klei Discord อย่างเป็นทางการ"

	Thai.StringUITable["No previous recipe found"] = "ไม่พบสูตรล่าสุด"

	local oldSetString = _G.TextWidget.SetString
	_G.TextWidget.SetString = function(guid, str)
		if type(str) == "string" then
			str = Thai.StringUITable[str] or str
		end
		oldSetString(guid, str)
	end
end
