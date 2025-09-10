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

	if msgcontains(msg, 'castle') then
		selfSay('Do you wish to travel to Castle of Carlin for 100 gold coins?')
		talk_state = 1

	elseif msgcontains(msg, 'raccoon') then
		selfSay('Do you wish to travel to Raccoon for 300 gold coins?')
		talk_state = 2

	elseif msgcontains(msg, 'edron') then
		selfSay('Do you wish to travel to Edron for 400 gold coins?')
		talk_state = 3

	elseif msgcontains(msg, 'tirith') then
		selfSay('Do you wish to travel to Minas Tirith for 400 gold coins?')
		talk_state = 4

	elseif msgcontains(msg, 'draynor') then
		selfSay('Well... I promissed to myself that I would never travel back there, but if you pay me..hmm.. 800 coins we have a deal! Wanna go?')
		talk_state = 5

	elseif msgcontains(msg, 'bree') then
		selfSay('Do you wish to travel to Bree for 500 gold coins?')
		talk_state = 7

--

	elseif talk_state == 1 then
		if msgcontains(msg, 'yes') then
		if talk_state == 1 then
		if pay(cid,100) then
		travel(cid, 543, 528, 6)
        	doCreateItem(2152,1,pos)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end
		else
		selfSay('Repeat all again.')
		talk_state = 0
 		end
	end

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

	elseif talk_state == 5 and msgcontains(msg, 'yes') then
		selfSay('Are you sure wanna go there? I will not be there to bring you back... You will have to find the way out yourself! Wanna go anyway?')
		talk_state = 6

		elseif msgcontains(msg, 'no') and talk_state > 0 then
		selfSay('Thank God! I was having a terrible felling.')
		talk_state = 0

	elseif talk_state == 6 then
		if msgcontains(msg, 'yes') then
		if isPremium(cid) then
		if talk_state == 6 then
		if pay(cid,800) then
		travel(cid, 250, 442, 6)
		selfSay('GoodLuck!')
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

	elseif talk_state == 7 then
		if msgcontains(msg, 'yes') then
		if isPremium(cid) then
		if talk_state == 7 then
		if pay(cid,500) then
		travel(cid, 818, 2030, 6)
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

keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Edron, Raccoon, Minas Tirith, to the castle of carlin, for just a small fee... And i known the way to Draynor Island'})


keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the Captian of this ship.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Since i get busted by pirates in Draynor Island, i never get involved in quests again... You should look around there.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Since i get busted by pirates in Draynor Island, i never get involved in quests again... You should look around there.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Edron, Raccoon, Minas Tirith, Bree, to the castle of carlin, for just a small fee... And i known the way to Draynor Island.'})

-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())