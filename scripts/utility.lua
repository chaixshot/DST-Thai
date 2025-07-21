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

---comment
---@param text string
---@return table<string, string>
function GetOriginalStringFromIndex(text)
	local block = text:gsub("STRINGS.", ""):split(".")
	local strings = STRINGS[block[1]]
	local result = {}

	for i = 2, #block do
		if tonumber(block[i]) then
			strings = strings[tonumber(block[i])]
		else
			strings = strings[block[i]]
		end
	end

	if strings then
		for index, data in pairs(strings) do
			if type(data) == "table" then
				local _strings = GetOriginalStringFromIndex(text.."."..index)

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
