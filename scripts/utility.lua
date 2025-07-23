--[[ function inputstr:split(sep) --INFO game crashed
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	local i = 1
	for str in inputstr:gmatch(r "", "([^"..sep.."]+)") do
		t[i] = str
		i += 1
	end
	return t
end ]]

---comment
---@param text string
function TranslateStringTable(text)
	local strings = GetOriginalStringsFromIndex(text)

	for stringIndex, stringEng in pairs(strings) do
		Thai.StringUITable[stringEng] = Thai.PO[stringIndex]
	end
end

---Check if any translate config enable
---@return boolean
function IsTranslateEnabled()
	return Config.UI or Config.CON or Config.ITEM
end

---comment
---@param text string
---@return table<string, string>
function GetOriginalStringsFromIndex(text)
	local block = text:gsub("STRINGS.", ""):split(".")
	local strings = STRINGS[block[1]]
	local result = {}

	for i = 2, #block do
		strings = strings[tonumber(block[i]) or block[i]]
	end

	if type(strings) == "table" then
		for index, data in pairs(strings) do
			if type(data) == "table" then
				local _strings = GetOriginalStringsFromIndex(text.."."..index)

				for _index, _data in pairs(_strings) do
					result[_index] = _data
				end
			else
				result[text.."."..index] = data
			end
		end
	end

	return result
end
