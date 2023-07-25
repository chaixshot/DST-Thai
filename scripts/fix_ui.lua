--Change game mode names/descriptions
local uifix = {}

for a,b in pairs(STRINGS.UI) do
	if type(b) == "table" then
		for c,d in pairs(b) do
			if type(d) == "table" then
				for e,f in pairs(d) do
					if type(f) == "table" then
						for g,h in pairs(f) do
							if type(h) == "table" then
								for i,j in pairs(h) do
									if type(j) == "table" then
										for k,l in pairs(j) do
											if type(l) == "table" then
												for m,n in pairs(l) do
													if type(n) == "table" then
														for o,p in pairs(n) do
															if type(p) == "table" then
																for q,r in pairs(p) do
																	if type(r) == "table" then
																	
																	else
																		uifix[STRINGS.UI[a][c][e][g][i][k][m][o][q]] = t.PO["STRINGS.UI."..a.."."..c.."."..e.."."..g.."."..i.."."..k.."."..m.."."..o.."."..q]
																	end
																end
															else
																uifix[STRINGS.UI[a][c][e][g][i][k][m][o]] = t.PO["STRINGS.UI."..a.."."..c.."."..e.."."..g.."."..i.."."..k.."."..m.."."..o]
															end
														end
													else
														uifix[STRINGS.UI[a][c][e][g][i][k][m]] = t.PO["STRINGS.UI."..a.."."..c.."."..e.."."..g.."."..i.."."..k.."."..m]
													end
												end
											else
												uifix[STRINGS.UI[a][c][e][g][i][k]] = t.PO["STRINGS.UI."..a.."."..c.."."..e.."."..g.."."..i.."."..k]
											end
										end
									else
										uifix[STRINGS.UI[a][c][e][g][i]] = t.PO["STRINGS.UI."..a.."."..c.."."..e.."."..g.."."..i]
									end
								end
							else
								uifix[STRINGS.UI[a][c][e][g]] = t.PO["STRINGS.UI."..a.."."..c.."."..e.."."..g]
							end
						end
					else
						uifix[STRINGS.UI[a][c][e]] = t.PO["STRINGS.UI."..a.."."..c.."."..e]
					end
				end
			else
				uifix[c] = t.PO["STRINGS.UI."..a.."."..c]
			end
		end
	else
		uifix[a] = t.PO["STRINGS.UI."..a]
	end
end

if Config.UI ~= "disable" then
	local oldSetString = _G.TextWidget.SetString
	_G.TextWidget.SetString = function(guid, str)
		if type(str)=="string" then
			str = uifix[str] or str
		end
		oldSetString(guid, str)
	end
end