-- แปลภาษามอดที่รองรับ
if not Config.OTHER_MOD then
   return
end

local modInfo = {
   ["Minimap HUD Customizable"] = "842702425",
   ["Geometric Placement"] = "351325790",
   ["Item Info"] = "836583293",
   ["Combined Status"] = "376333686",
}

if _G.KnownModIndex and _G.KnownModIndex.savedata and _G.KnownModIndex.savedata.known_mods then
   for folder, modData in pairs(_G.KnownModIndex.savedata.known_mods) do
      local name = modData.modinfo.name
      if name then
         if modInfo[name] then
            modimport("scripts/mods/"..modInfo[name])
         end
      end
   end
end
