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

  pos = {x=541, y=456, z=5}

	if msgcontains(msg, 'raccoon') then
		selfSay('Do you wish to travel to Raccoon for 300 gold coins?')
		talk_state = 2

	elseif msgcontains(msg, 'edron') then
		selfSay('Do you wish to travel to Edron for 400 gold coins?')
		talk_state = 3

	elseif msgcontains(msg, 'tirith') then
		selfSay('Do you wish to travel to Minas Tirith for 400 gold coins?')
		talk_state = 4

	elseif msgcontains(msg, 'carlin') then
		selfSay('Do you wish to travel to Carlin for 200 gold coins?')
		talk_state = 5

--

	elseif talk_state == 2 then
		if msgcontains(msg, 'yes') then
		if isPremium(cid) then
		if talk_state == 2 then
		if pay(cid,300) then
		travel(cid, 209, 74, 6)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('Repeat all again.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end
	end

	elseif talk_state == 3 then
		if msgcontains(msg, 'yes') then
		if isPremium(cid) then
		if talk_state == 3 then
		if pay(cid,400) then
		travel(cid, 736, 795, 6)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('Repeat all again.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end
	end

	elseif talk_state == 4 then
		if msgcontains(msg, 'yes') then
		if isPremium(cid) then
		if talk_state == 4 then
		if pay(cid,400) then
		travel(cid, 476, 293, 6)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('Repeat all again.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end
	end

	elseif talk_state == 5 then
		if msgcontains(msg, 'yes') then
		if isPremium(cid) then
		if talk_state == 5 then
		if pay(cid,200) then
		travel(cid, 151, 356, 6)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('Repeat all again.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
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

keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Edron, Raccoon, Minas Tirith and Carlin.'})


keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the Captian of this ship.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Since i get busted by pirates, i never get involved in quests again.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Since i get busted by pirates, i never get involved in quests again.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Edron, Raccoon, Minas Tirith and Carlin.'})

-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())