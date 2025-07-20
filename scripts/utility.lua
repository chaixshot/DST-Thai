--[[ function string.split(inputstr, sep) --INFO game crashed
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	local i = 1
	for str in string.gmatch(inputstr or "", "([^"..sep.."]+)") do
		t[i] = str
		i += 1
	end
	return t
end ]]

function TranslateStringTable(text, data)
	for k, v in pairs(data) do
		if type(v) == "table" then
			TranslateStringTable(text.."."..k, v)
		else
			Thai.StringUITable[data[k]] = Thai.PO[text.."."..k]
		end
	end
end

function IsTranslateEnabled()
	return Config.UI or Config.CON or Config.ITEM
end

function GetOriginalStringFromTextIndex(text)
	local data = text:gsub("STRINGS.", ""):split(".")
	local strings = STRINGS[data[1]]

	for i = 2, #data do
		if tonumber(data[i]) then
			strings = strings[tonumber(data[i])]
		else
			strings = strings[data[i]]
		end
	end

	return strings
end
