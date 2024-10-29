name = " ภาษาไทย"
version = "6.22"
author = "H@mer"
description = [[Don't Starve Together: ภาษาไทย
เวอร์ชั่น: ]]..version..
[[


	เปลี่ยนเกม Don't Starve Together ทั้งหมดเป็นภาษาไทย
และสามารถพิมพ์ไทยในเกมได้โดยไม่เป็นเครื่องหมาย "???"

	หากพบเห็นข้อผิดพลาดเช่น การแปลผิด ส่วนเสริมมีปัญหา กรุณาแจ้งผู้พัฒนาด้วยที่โพสปักหมุด เพื่อจะได้ทำการแก้ไขในการอัพเดท หรือสามารถอ่านคำแนะนำสำหรับปัญหาต่างๆได้เช่นกัน
สามารถพูดคุยหรือติดต่อสอบถามและพิมพ์เป็นกำลังใจได้ที่ความคิดเห็นบนสตรีมเวิร์คชอป

โดย H@mer
]]
forumthread = ""
api_version = 10
priority = 9999
icon = "ModThai.tex"
icon_atlas = "images/ModThai.xml"
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
gorge_compatible = false
forge_compatible = false
dst_compatible = true
client_only_mod = true
server_only_mod = false
all_clients_require_mod = false
server_filter_tags = {"thai", "ไทย"}

configuration_options =
{
	{	
		name = "--1--",
		label = "(1)",
		hover = "",
		options =
		{	
			{description = "เกมหลัก!", data = "nope", hover = "หมวดหมู่การตั้งค่าตัวเลือกสำหรับตัวเกม"},
		},
		default = "nope",
	},
	{
        name = "CFG_UI",
		label = "พื้นฐาน",
		hover = "การแปลส่วนพื้นฐาน ยูสเซอร์อินเตอร์เฟส, ข้อความอธิบาย",
        options =
        {
			{description = "ปิด", data = "disable", hover = "ปิดการใช้งานการแปลพื้นฐาน"},
            {description = "เปิด", data = "enable", hover = "เปิดการใช้งานการแปลพื้นฐาน"},
        },
        default = "enable",
    },
	{
        name = "CFG_CON",
		label = "บทพูด",
		hover = "การแปลบทพูดของตัวละคร\n(\"พื้นฐาน\" จะต้องไม่ถูกปิด)",
        options =
        {
			{description = "ปิด", data = "disable", hover = "ปิดการใช้งานการแปลบทพูด"},
            {description = "เปิด", data = "enable", hover = "เปิดการใช้งานการแปลบทพูด"},
        },
        default = "enable",
    },
	{
        name = "CFG_ITEM",
		label = "ไอเทม",
		hover = "การแปลชื่อไอเทม และชื่อสิ่งมีชีวิต\n(\"พื้นฐาน\" จะต้องไม่ถูกปิด)",
        options =
        {
			{description = "ปิด", data = "disable", hover = "ปิดการใช้งานการแปลไอเทม"},
            {description = "เปิด", data = "enable", hover = "เปิดการใช้งานการแปลไอเทม"},
        },
        default = "enable",
    },
	{
        name = "CFG_ITEM_TWO",
		label = "ไอเทมสองภาษา",
		hover = "ชื่อไอเทม สัตว์ สิ่งของ จะแสดงทั้งสองภาษา",
        options =
        {
			{description = "ปิด", data = "disable", hover = "ปิดการใช้งานไอเทมสองภาษา"},
            {description = "เปิด", data = "enable", hover = "เปิดการใช้งานไอเทมสองภาษา"},
        },
        default = "enable",
    },
	{
        name = "CFG_CON_ITEM_TWO",
		label = "บทพูดไอเทมสองภาษา",
		hover = "ไอเทมสองภาษาในบทพูดตัวละคร, คำอธิบายสกิน, คำอธิบายทักษะ, คำอธิบายเมนูคราฟ\n(การเปิดใช้งานอาจจะทำให้โหลดเกมช้าขึ้นเล็กน้อย)",
        options =
        {
			{description = "ปิด", data = "disable", hover = "ปิดการใช้งานบทพูดไอเทมสองภาษา"},
            {description = "เปิด", data = "enable", hover = "เปิดการใช้งานบทพูดไอเทมสองภาษา"},
        },
        default = "disable",
    },
	{
        name = "CFG_OTHER_MOD",
		label = "แปลส่วนเสริมอื่น",
		hover = "แปลส่วนเสริมอื่นๆที่สนับสนุนและเปิดการใช้งานอยู่เป็นภาษาไทย",
        options =
        {
			{description = "ปิด", data = "disable", hover = "ปิดการแปลส่วนเสริมอื่น"},
            {description = "เปิด", data = "enable", hover = "เปิดการแปลส่วนเสริมอื่น"},
        },
        default = "enable",
    },
	{	
		name = "--2--",
		label = "(2)",
		hover = "",
		options =
		{	
			{description = "อื่นๆ", data = "nope", hover = "หมวดหมู่การตั้งค่าตัวเลือกเพิ่มเติม"},
		},
		default = "nope",
	},
	{
		name = "DISABLE_MOD_WARNING",
		label = "ข้ามข้อความเตือนส่วนเสริม",
		hover = "ปิดใช้งานข้อความเตือนส่วนเสริมเมื่อเข้าเกมและข้อความเตือนอื่นๆเมื่อคุณพยายามเล่น Forge",
		options =	{
			{description = "เปิดใช้งาน", data = true, hover = "ข้ามข้อความเตือนส่วนเสริม"},
			{description = "ปิดใช้งาน", data = false, hover = "ไม่ข้ามข้อความเตือนส่วนเสริม"},
		},
		default = true,
	},
	{
		name = "SMALL_TEXTURES",
		label = "ปิดกราฟฟิคพื้นผิวเล็กอัตโนมัติ",
		hover = "การเปิดใช้งานพื้นผิวเล็กอาจทำให้ตัวหนังสือไม่ชัด เปิดใช้งานตัวเลือกนี้ไว้",
		options =	{
			{description = "เปิดใช้งาน", data = true, hover = "อนุญาตให้ส่วนเสริมปิดพื้นผิวเล็กโดยอัตโนมัติ (แนะนำ)"},
			{description = "ปิดใช้งาน", data = false, hover = "ไม่ให้ส่วนเสริมปิดพื้นผิวเล็ก"},
		},
		default = true,
	},
}