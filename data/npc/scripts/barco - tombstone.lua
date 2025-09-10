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

  pos = {x=540, y=456, z=5}


	if msgcontains(msg, 'carlin') then
		selfSay('Do you wish to travel to Carlin for 200 gold coins?')
		talk_state = 1

	elseif msgcontains(msg, 'tirith') then
		selfSay('Do you wish to travel to Minas Tirith for 400 gold coins?')
		talk_state = 2

	elseif msgcontains(msg, 'edron') then
		selfSay('Do you wish to travel to Edron for 400 gold coins?')
		talk_state = 3

	elseif msgcontains(msg, 'bree') then
		selfSay('Do you wish to travel to Bree for 500 gold coins?')
		talk_state = 4

	elseif talk_state == 1 and msgcontains(msg, 'yes') then
		if isPremium(cid) then
		if pay(cid,200) then
		travel(cid, 151, 356, 6)
        	doCreateItem(2152,2,pos)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end

		elseif msgcontains(msg, 'no') and talk_state > 0 then
		selfSay('I wouldn\'t go there either.')
		talk_state = 0

	elseif talk_state == 2 and msgcontains(msg, 'yes') then
		if isPremium(cid) then
		if pay(cid,400) then
		travel(cid, 476, 293, 6)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end

		elseif msgcontains(msg, 'no') and talk_state > 0 then
		selfSay('I wouldn\'t go there either.')
		talk_state = 0

	elseif talk_state == 3 and msgcontains(msg, 'yes') then
		if isPremium(cid) then
		if pay(cid,400) then
		travel(cid, 736, 795, 6)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end

		elseif msgcontains(msg, 'no') and talk_state > 0 then
		selfSay('I wouldn\'t go there either.')
		talk_state = 0

	elseif talk_state == 4 and msgcontains(msg, 'yes') then
		if isPremium(cid) then
		if pay(cid,500) then
		travel(cid, 818, 2030, 6)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('Sorry, only premmys can travel whit me.')
		talk_state = 0
 		end

		elseif msgcontains(msg, 'no') and talk_state > 0 then
		selfSay('I wouldn\'t go there either.')
		talk_state = 0
end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)



-- Don't forget npcHandler = npcHandler in the parameters. It is required for all StdModule functions!

keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Edron, Carlin and Minas Tirith for just a small fee.'})

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the Captian of this ship.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Since i get busted by pirates, i never get involved in quests again.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Since i get busted by pirates, i never get involved in quests again.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Edron, Carlin, Minas Tirith and Bree for just a small fee.'})


-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())