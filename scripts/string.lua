-- Apply Thai.StringUITable to game SetString
local oldSetString = _G.TextWidget.SetString
_G.TextWidget.SetString = function(guid, str)
	if type(str) == "string" then
		str = Thai.StringUITable[str] or str
	end
	oldSetString(guid, str)
end
