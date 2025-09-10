local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)

npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end

function creatureSayCallback(cid, type, msg)
	if(npcHandler.focus ~= cid) then
		return false
	end

	if msgcontains(msg, 'bramun') then
	if getPlayerLevel(cid) < 100 then
		selfSay('Do you wish to travel to Bramun for 500 gold coins?')
		talk_state = 2
	else
		selfSay('I only can travel to there on level 8 to 99.')
	end

	elseif msgcontains(msg, 'canudis') then
	if getPlayerLevel(cid) > 99 and getPlayerLevel(cid) < 200 then
		selfSay('Do you wish to travel to Canudis for 1000 gold coins?')
		talk_state = 3
	else
		selfSay('I only can travel to there on level 100 to 199.')
	end

	elseif msgcontains(msg, 'morgun') then
	if getPlayerLevel(cid) > 199 and getPlayerLevel(cid) < 300 then
		selfSay('Do you wish to travel to Morgun for 2000 gold coins?')
		talk_state = 4
	else
		selfSay('I only can travel to there on level 200 to 299.')
	end

	elseif msgcontains(msg, 'mordor') then
	if getPlayerVocation(cid) > 8 then
		selfSay('Do you wish to travel to Mordor for 5000 gold coins?')
		talk_state = 5
	else
		selfSay('I only Valans can travel to there.')
	end
	
	elseif msgcontains(msg, 'tan53oris') then
	if getPlayerVocation(cid) > 12 then
		selfSay('Do you wish to travel to tanoris for 100 DSPs?')
		talk_state = 6
	else
		selfSay('I only gods can travel to there.')
	end
--

	elseif talk_state == 2 then
		if msgcontains(msg, 'yes') then
		if talk_state == 2 then
		if isPremium(cid) then
		if getPlayerLevel(cid) < 100 then
		if pay(cid,500) then
		travel(cid, 794, 2058, 6)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('I only can travel to there on level 8 to 99.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end
		else
		selfSay('Repeat all again.')
		talk_state = 0
 		end
	end


	elseif talk_state == 3 then
		if msgcontains(msg, 'yes') then
		if talk_state == 3 then
		if isPremium(cid) then
		if getPlayerLevel(cid) > 99 and getPlayerLevel(cid) < 200 then
		if pay(cid,1000) then
		travel(cid, 753, 1932, 6)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('I only can travel to there on level 100 to 199.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end
		else
		selfSay('Repeat all again.')
		talk_state = 0
 		end
	end

	elseif talk_state == 4 then
		if msgcontains(msg, 'yes') then
		if talk_state == 4 then
		if isPremium(cid) then
		if getPlayerLevel(cid) > 199 and getPlayerLevel(cid) < 299 then
		if pay(cid,2000) then
		travel(cid, 880, 1879, 6)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('I only can travel to there on level 200 to 299.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end
		else
		selfSay('Repeat all again.')
		talk_state = 0
 		end
	end

	elseif talk_state == 5 then
		if msgcontains(msg, 'yes') then
		if talk_state == 5 then
		if isPremium(cid) then
		if getPlayerVocation(cid) > 8 then
		if pay(cid,5000) then
		travel(cid, 1024, 1858, 6)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('I only can travel only valans whit me.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end
		else
		selfSay('Repeat all again.')
		talk_state = 0
 		end
	end

	elseif talk_state == 6 then
		if msgcontains(msg, 'yes') then
		if talk_state == 6 then
		if isPremium(cid) then
		if getPlayerVocation(cid) > 12 then
		if getPlayerItemCount(cid,6527) >= 100 then
		travel(cid, 1093, 1883, 6)
		doPlayerTakeItem(cid,6527,100)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this.')
		talk_state = 0
 		end
		else
		selfSay('I only can travel only gods whit me.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end
		else
		selfSay('Repeat all again.')
		talk_state = 0
 		end
	end

		elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
			selfSay('Ok than.')
			talk_state = 0
		end


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)


-- Don't forget npcHandler = npcHandler in the parameters. It is required for all StdModule functions!

keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Bramun on level 8 to 99, Canudis on level 100 to 199, Morgun on level 200 to 299 and to Mordor only for Valans and Tanoris for gods.'})


keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the Carpet Man!'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Bramun on level 8 to 99, Canudis on level 100 to 199, Morgun on level 200 to 299 and to Mordor only for Valans and Tanoris for gods.'})

-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())