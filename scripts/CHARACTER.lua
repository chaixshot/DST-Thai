-- แปลบทพูดตัวละครในเซิร์ฟเวอร์คนอื่น
if not Config.CON then
	return
end

TranslateStringTable("STRINGS.CHARACTERS", STRINGS.CHARACTERS)

local function ParseTranslationTags(message, char, talker, optionaltags)
	if not (message and message:find("[", 1, true)) then return message end

	local gender = "neutral"
	local function parse(str)
		local vars = str:split("|")
		local tags = {}
		local counter = 0

		local function SelectByCustomTags(CustomTags)
			if not CustomTags then return false end
			if type(CustomTags) == "string" then return tags[CustomTags] end
			for _, tag in ipairs(CustomTags) do
				if tags[tag] then return tags[tag] end
			end
			return false
		end

		for _, v in ipairs(vars) do
			local vars2 = v:split("=")
			if #vars2 == 1 then counter = counter + 1 end
			local path = (#vars2 == 2) and vars2[1] or
				 (((counter == 1) and "he")
					 or ((counter == 2) and "she")
					 or ((counter == 3) and "it")
					 or ((counter == 4) and "plural")
					 or ((counter == 5) and "neutral")
					 or ((counter > 5) and nil))
			if path then
				local vars3 = path:split(",")
				for _, vv in ipairs(vars3) do
					local c = vv and vv:match("^%s*(.*%S)")
					c = c and c:lower()
					if c == "they" or c == "pl" then
						c = "plural"
					elseif c == "nog" or c == "nogender" then
						c = "neutral"
					elseif c == "def" then
						c = "default"
					end
					if c then tags[c] = (#vars2 == 2) and vars2[2] or v end
				end
			end
		end

		str = tags and (tags[char]
			or SelectByCustomTags(Thai.CharacterInherentTags[char])
			or tags[gender]
			or SelectByCustomTags(optionaltags)
			or tags["default"]
			or tags["neutral"]
			or tags["he"]
			or "") or ""

		return str
	end

	local function search(part)
		part = part:sub(2, -2)

		if not part:find("[", 1, true) then
			part = parse(part)
		else
			part = parse(part:gsub("%b[]", search))
		end

		return part
	end

	local CaseAdoptationNeeded
	message, CaseAdoptationNeeded = message:gsub("%[adoptcase]", "<adoptcase>")
	message = message:gsub("%[marker=(.-)]", function(marker)
		if not optionaltags then
			optionaltags = {}
		elseif type(optionaltags) == "string" then
			optionaltags = {optionaltags}
		end
		table.insert(optionaltags, marker)
		return ""
	end)

	if char then
		char = char:lower()
		if char == "generic" then char = "wilson" end

		if rawget(GLOBAL, "CHARACTER_GENDERS") then
			if _G.CHARACTER_GENDERS.MALE and table.contains(_G.CHARACTER_GENDERS.MALE, char) then
				gender = "he"
			elseif _G.CHARACTER_GENDERS.FEMALE and table.contains(_G.CHARACTER_GENDERS.FEMALE, char) then
				gender = "she"
			elseif _G.CHARACTER_GENDERS.ROBOT and table.contains(_G.CHARACTER_GENDERS.ROBOT, char) then
				gender = "he"
			elseif _G.CHARACTER_GENDERS.IT and table.contains(_G.CHARACTER_GENDERS.IT, char) then
				gender = "it"
			elseif _G.CHARACTER_GENDERS.NEUTRAL and table.contains(_G.CHARACTER_GENDERS.IT, char) then
				gender = "neutral"
			elseif _G.CHARACTER_GENDERS.PLURAL and table.contains(_G.CHARACTER_GENDERS.PLURAL, char) then
				gender = "plural"
			end
		end
		if char == "webber" and (not talker or talker:lower() == char) then gender = "plural" end
	end

	message = search("["..message.."]") or message

	if CaseAdoptationNeeded then
		message = message:gsub("([^.!? ]?)(%s*)<adoptcase>(.)", function(before, space, symbol)
			return ((before or "")..(space or "")..(symbol or ""))
		end)
	end

	return message
end

local function GetFromSpeechesHash(message, char)
	local function GetMentioned(message, char)
		if not (message and Thai.SpeechHashTbl[char] and Thai.SpeechHashTbl[char]["mentioned_class"] and type(Thai.SpeechHashTbl[char]["mentioned_class"]) == "table") then return nil end

		for i, v in pairs(Thai.SpeechHashTbl[char]["mentioned_class"]) do
			local mentions = {message:match("^"..(i:gsub("%%s", "(.*)")).."$")}
			if mentions and #mentions > 0 then
				return v, mentions
			end
		end

		return nil
	end

	local mentions
	if not char then char = "GENERIC" end
	if message and Thai.SpeechHashTbl[char] then
		local umlautified = false

		if char == "WATHGRITHR" then
			local tmp = message:gsub("[\246ö]", "o"):gsub("[\214Ö]", "O") or message
			umlautified = tmp ~= message
			message = tmp
		end

		local msg = Thai.SpeechHashTbl[char][message] or Thai.SpeechHashTbl["GENERIC"][message]
		if not msg and char == "WX78" then
			for i, v in pairs(Thai.SpeechHashTbl["GENERIC"]) do
				if message == i:upper() then
					msg = v
					break
				end
			end
		end

		if not msg then msg, mentions = GetMentioned(message, char) end
		if not msg then msg, mentions = GetMentioned(message, "GENERIC") end

		message = msg or message
		message = (type(message) == "table") and _G.GetRandomItem(message) or message

		if umlautified then
			if rawget(GLOBAL, "GetSpecialCharacterPostProcess") then
				local tmp = message:gsub("о", "o"):gsub("О", "O") or message
				message = _G.GetSpecialCharacterPostProcess("wathgrithr", tmp) or message
			else
				message = message:gsub("о", "ö"):gsub("О", "Ö") or message
			end
		end
	end

	return message, mentions
end

local function BuildCharacterHash(charname)
	local source = source or Thai.PO
	local function CreateThaiHashTable(hashtbl, tbl, str)
		for i, v in pairs(tbl) do
			if type(v) == "table" then
				CreateThaiHashTable(hashtbl, tbl[i], str.."."..i)
			else
				local val = source[str.."."..i] or v

				if v and v:find("%s", 1, true) then
					hashtbl["mentioned_class"] = hashtbl["mentioned_class"] or {}
					hashtbl["mentioned_class"][v] = val
				end

				if not hashtbl[v] then
					hashtbl[v] = val
				elseif type(hashtbl[v]) == "string" and val ~= hashtbl[v] then
					local temp = hashtbl[v]
					hashtbl[v] = {}
					table.insert(hashtbl[v], temp)
					table.insert(hashtbl[v], val)
				elseif type(hashtbl[v]) == "table" then
					local found = false

					for _, vv in ipairs(hashtbl[v]) do
						if vv == val then
							found = true
							break
						end
					end

					if not found then table.insert(hashtbl[v], val) end
				end
			end
		end
	end

	charname = charname:upper()

	if charname == "WILSON" then charname = "GENERIC" end
	if charname == "MAXWELL" then charname = "WAXWELL" end
	if charname == "WIGFRID" then charname = "WATHGRITHR" end

	Thai.SpeechHashTbl[charname] = {}

	CreateThaiHashTable(Thai.SpeechHashTbl[charname], STRINGS.CHARACTERS[charname] or Thai.SpeechHashTbl[charname], "STRINGS.CHARACTERS."..charname)
end

local function TranslateToThai(message, entity)
	if not (entity and entity.prefab and entity.components.talker and type(message) == "string") then return message end

	if entity:HasTag("playerghost") then
		message = message:gsub("h", "у")
		return message
	end

	if Thai.SpeechHashTbl.EPITAPHS[message] then
		return Thai.SpeechHashTbl.EPITAPHS[message]
	end

	local ent = entity
	entity = entity.prefab:upper()
	if entity == "WILSON" then entity = "GENERIC" end
	if entity == "MAXWELL" then entity = "WAXWELL" end
	if entity == "WIGFRID" then entity = "WATHGRITHR" end

	local function TranslateMessage(message)
		if not message then return end
		local NotTranslated = message
		local msg, mentions = GetFromSpeechesHash(message, entity)
		message = msg or message

		if NotTranslated == message then return message end

		local killerkey
		if mentions then
			if #mentions > 1 then
				killerkey = Thai.SpeechHashTbl.NAMES.Eng2Key[mentions[2]]

				if not killerkey and entity == "WX78" then
					for eng, key in pairs(Thai.SpeechHashTbl.NAMES.Eng2Key) do
						if eng:upper() == mentions[2] then
							killerkey = key
							break
						end
					end
				end

				mentions[2] = killerkey and STRINGS.NAMES[killerkey] or mentions[2]

				if killerkey then
					if not mentions[2] then
						mentions[2] = ""
					end

					killerkey = killerkey:lower()
					if table.contains(_G.GetActiveCharacterList(), killerkey) then killerkey = nil end
				end
			end
		end

		message = (ParseTranslationTags(message, ent.prefab, nil, killerkey)) or message
		message = message:format(_G.unpack(mentions or {"", "", "", ""}))

		return message
	end

	local messages = message:split("\n") or {message}
	message = ""
	local i = 1

	while i <= #messages do
		local trans
		trans = TranslateMessage(messages[i])
		if trans ~= messages[i] then
			message = message..(i > 1 and "\n" or "")..trans

			if i < #messages then
				message = message..TranslateMessage("\n"..messages[i + 1])
				for k = i + 2, #messages do message = message.."\n"..messages[k] end
			end

			break
		elseif i < #messages then
			trans = TranslateMessage(messages[i].."\n"..messages[i + 1])
			if trans ~= messages[i].."\n"..messages[i + 1] then
				message = message..(i > 1 and "\n" or "")..trans
				for k = i + 2, #messages do message = message.."\n"..messages[k] end

				break
			else
				message = message..(i > 1 and "\n" or "")..messages[i]
				i = i + 1
			end
		else
			message = message..(i > 1 and "\n" or "")..messages[i]
			break
		end
	end

	return message
end


Thai.SpeechHashTbl = {}
Thai.SpeechHashTbl.EPITAPHS = {}
Thai.SpeechHashTbl.NAMES = {Eng2Key = {}, Thai2Eng = {}}
Thai.CharacterInherentTags = {}

for char in pairs(_G.GetActiveCharacterList()) do -- t.CharacterInherentTags
	Thai.CharacterInherentTags[char] = {}
end

for key, val in pairs(STRINGS.NAMES) do -- t.SpeechHashTbl.NAMES.Eng2Key
	Thai.SpeechHashTbl.NAMES.Eng2Key[val] = key
end

for charname, v in pairs(STRINGS.CHARACTERS) do
	BuildCharacterHash(charname)
end

if rawget(GLOBAL, "Networking_Talk") then
	local OldNetworking_Talk = _G.Networking_Talk

	function Networking_Talk(guid, message, ...)
		local entity = _G.Ents[guid]
		message = TranslateToThai(message, entity) or message
		if OldNetworking_Talk then OldNetworking_Talk(guid, message, ...) end
	end

	_G.Networking_Talk = Networking_Talk
end

if _G.TheNet.Talker then
	_G.getmetatable(_G.TheNet).__index.Talker = (function()
		local oldTalker = _G.getmetatable(_G.TheNet).__index.Talker
		return function(self, message, entity, ...)
			oldTalker(self, message, entity, ...)

			local inst = entity and entity:GetGUID() or nil
			inst = inst and _G.Ents[inst] or nil
			if inst and inst.components.talker.widget then
				if message and type(message) == "string" then
					local OldSetString = inst.components.talker.widget.text.SetString
					function inst.components.talker.widget.text:SetString(str, ...)
						str = TranslateToThai(str, inst) or str
						OldSetString(self, str, ...)
						self.SetString = OldSetString
					end
				end
			end
		end
	end)()
end
