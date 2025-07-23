-- แปล UI ทั้งหมด
if not Config.UI then
	return
end

TranslateStringTable("STRINGS.UI")

Thai.StringUITable[" Thai Language Pack"] = "ภาษาไทย"

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

-- Remove new line of item two language from crafting menu
AddClassPostConstruct("widgets/redux/craftingmenu_details", function(self, ...)
	self.UpdateNameString = function()
		local recipe = self.data.recipe
		local meta = self.data.meta

		local namestr = STRINGS.NAMES[string.upper(recipe.nameoverride or recipe.name)] or STRINGS.NAMES[string.upper(recipe.product)]
		if meta.limitedamount then
			namestr = subfmt(STRINGS.UI.CRAFTING.LIMITEDAMOUNTFMT, {name = namestr, number = meta.limitedamount})
		end
		namestr = namestr:gsub("\n", " ")

		local title_width = self.panel_width / 2 - 30
		self.namestring:SetMultilineTruncatedString(namestr, 1, title_width, nil, nil, true)
	end
end)
