-- ไอเทมสองภาษาใน STRING.CHARACTERS, STRING.SKILLTREE, STRING.SKIN_DESCRIPTIONS, STRINGS.RECIPE_DESC
if not Config.CON_ITEM or (not Config.ITEM and not Config.ITEM_TWO) then
   return
end

-- Anti duplicate names (STRINGS.NAMES.TICOON)
local itemsName = {}
for nameIndex, nameEng in pairs(GetOriginalStringsFromIndex("STRINGS.NAMES")) do
   itemsName[nameEng:gsub("?", "")] = tostring(Thai.PO[nameIndex])
end

-- INFO: Tool to generate conItemIndex
--[[ local conStrings = {"STRINGS.CHARACTERS"}
if Config.UI then
   table.insert(conStrings, "STRINGS.RECIPE_DESC")
   if IsDST then
      table.insert(conStrings, "STRINGS.SKILLTREE")
      table.insert(conStrings, "STRINGS.SKIN_DESCRIPTIONS")
   end
end

for _, text in ipairs(conStrings) do
   local blackList = {["Nothing"] = true, ["X"] = true, ["Health"] = true, ["Sanity"] = true, ["Fire"] = true, ["Plant"] = true}
   for conIndex, conEng in pairs(GetOriginalStringsFromIndex(text)) do
      local conThai = Thai.PO[conIndex]

      if conThai then
         local found = {}

         for nameEng, nameThai in pairs(itemsName) do
            if not blackList[nameEng] then
               if conEng:find(nameEng) then -- Fast check
                  if conEng:find("%f[%a]"..nameEng.."%f[%A]") then -- Slow check
                     table.insert(found, nameEng)
                  end
               end
            end
         end

         if #found > 0 then
            local index = ""
            for k, v in pairs(found) do
               index = index.."[\""..v.."\"] = true, "
            end
            print("[\""..conIndex.."\"] = {"..index.."},")
         end
      end
   end
end ]]

local conItemIndex = require("conItem/conItemIndex")
for conIndex, checkList in pairs(conItemIndex) do
   local conThai = Thai.PO[conIndex]
   local block = conIndex:gsub("STRINGS.", ""):split(".")
   local conEng = STRINGS[block[1]]

   for i = 2, #block do
      conEng = conEng[tonumber(block[i]) or block[i]]
   end

   for nameEng, nameThai in pairs(itemsName) do
      if checkList[nameEng] then
         conThai = conThai:gsub("%f[%a]"..nameEng.."%f[%A]", nameThai)

         if not Config.ITEM then -- ปิดการแปลชื่อไอเทม
            conThai = conThai:gsub(nameThai, " "..nameEng.." ")
         elseif Config.ITEM_TWO then
            conThai = conThai:gsub(nameThai, nameThai.."("..nameEng..")")
         end

         conThai = conThai:gsub("  ", " ")
         Thai.PO[conIndex] = conThai
      end
   end
end
