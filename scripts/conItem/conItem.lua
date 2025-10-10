-- ไอเทมสองภาษาใน STRING.CHARACTERS, STRING.SKILLTREE, STRING.SKIN_DESCRIPTIONS, STRINGS.RECIPE_DESC
if not Config.CON_ITEM or (not Config.ITEM and not Config.ITEM_TWO) then
   return
end

local conItemIndex = require("conItem/conItemIndex")
for conIndex, conThai in pairs(conItemIndex) do
   Thai.PO[conIndex] = conThai
end

--[[ -- INFO: Tool to generate conItemIndex
-- Anti duplicate names (STRINGS.NAMES.TICOON)
local itemsName = {
   ["beefalo bell"] = Thai.PO["STRINGS.NAMES.BEEF_BELL"],
   ["beefalo"] = Thai.PO["STRINGS.NAMES.BEEFALO"],
   ["acid rain"] = Thai.PO["STRINGS.NAMES.ACIDRAIN"],
   ["algae"] = Thai.PO["STRINGS.NAMES.POND_ALGAE"],
   ["anchor"] = Thai.PO["STRINGS.NAMES.ANCHOR"],
   ["ashes"] = Thai.PO["STRINGS.NAMES.ASH"],
   ["asparagus"] = Thai.PO["STRINGS.NAMES.ASPARAGUS"],
   ["axe"] = Thai.PO["STRINGS.NAMES.AXE"],
   ["balloon"] = Thai.PO["STRINGS.NAMES.BALLOON"],
   ["banana"] = Thai.PO["STRINGS.NAMES.CAVE_BANANA"],
   ["barnacles"] = Thai.PO["STRINGS.NAMES.BARNACLE"],
   ["beeswax"] = Thai.PO["STRINGS.NAMES.BEESWAX"],
   ["berries"] = Thai.PO["STRINGS.NAMES.BERRIES"],
}
for nameIndex, nameEng in pairs(GetOriginalStringsFromIndex("STRINGS.NAMES")) do
   itemsName[nameEng:gsub("?", "")] = Thai.PO[nameIndex]
end

local conStrings = {"STRINGS.CHARACTERS"}
if Config.UI then
   table.insert(conStrings, "STRINGS.RECIPE_DESC")
   if IsDST then
      table.insert(conStrings, "STRINGS.SKILLTREE")
      table.insert(conStrings, "STRINGS.SKIN_DESCRIPTIONS")
   end
end

local test = 0
for _, text in ipairs(conStrings) do
   local blackList = {["Nothing"] = true, ["X"] = true, ["Health"] = true, ["Sanity"] = true, ["Fire"] = true, ["Plant"] = true}
   for conIndex, conEng in pairs(GetOriginalStringsFromIndex(text)) do
      local conThai = Thai.PO[conIndex]
      local found = {}
      local foundLower = {}
      local countEng = {}
      local countThai = {}

      if conThai then
         for nameEng, nameThai in pairs(itemsName) do
            if not blackList[nameEng] then
               if conEng:find(nameEng) then -- Fast check
                  if conEng:find("%f[%a]"..nameEng.."%f[%A]") then -- Slow check
                     conThai = conThai:gsub("%f[%a]"..nameEng.."%f[%A]", nameThai)
                     table.insert(countEng, nameEng)
                     table.insert(found, nameEng)
                  end
               elseif conEng:find("%f[%a]"..nameEng:lower().."%f[%A]") and not conEng:find("_") and not blackList[nameEng:lower()] then
                  table.insert(foundLower, nameEng:lower())
               end
            end
            if conThai:find(nameThai) then -- Fast check
               table.insert(countThai, nameThai)
            end
         end

         -- Print conItemIndex table
         if #found > 0 then
            local checkList = {}

            for k, v in pairs(found) do
               checkList[v] = true
            end

            for nameEng, nameThai in pairs(itemsName) do
               if checkList[nameEng] then
                  conThai = conThai:gsub("%f[%a]"..nameEng.."%f[%A]", nameThai)

                  if not Config.ITEM then -- ปิดการแปลชื่อไอเทม
                     conThai = conThai:gsub(nameThai, " "..nameEng.." ")
                  elseif Config.ITEM_TWO then
                     conThai = conThai:gsub(nameThai, nameThai.."("..nameEng..")")
                  end
               end
            end

            print("[\""..conIndex.."\"] = \""..conThai:gsub("\n", "/n"):gsub("  ", " ").."\",")

            if test > 500 then
               break
            end
            test = test+1
         end

         -- Print lowercase item name in conversion
         -- if #foundLower > 0 then
         --    local index = ""
         --    for k, v in pairs(foundLower) do
         --       index = index.."\""..v.."\", "
         --    end
         --    print(index)
         -- end

         -- Print missing thai name from conversation
         -- if #countEng > #countThai then
         --    local missing = ""
         --    for i, j in pairs(countEng) do
         --       missing = missing.."\""..j.."\", "
         --    end
         --    print("\""..conIndex.."\"\t\t"..missing)
         -- end
      end
   end
end]]
