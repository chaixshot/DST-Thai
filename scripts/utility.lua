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