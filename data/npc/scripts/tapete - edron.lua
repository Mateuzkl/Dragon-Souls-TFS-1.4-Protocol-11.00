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

  pos = {x=539, y=456, z=5}

	if msgcontains(msg, 'hills') then
		selfSay('Do you wish to travel to Femur hills for 400 gold coins?')
		talk_state = 1

	elseif msgcontains(msg, 'femur') then
		selfSay('Do you wish to travel to Femur hills for 400 gold coins?')
		talk_state = 1

	elseif talk_state == 1 then
		if msgcontains(msg, 'yes') then
		if pay(cid,400) then
		travel(cid, 307, 378, 4)
        	doCreateItem(2152,4,pos)
		talk_state = 0
		else
		selfSay('Sorry, you don\'t have this money.')
		talk_state = 0
 		end

	elseif talk_state == 1 then
		if msgcontains(msg, 'no') then
		selfSay('I wouldn\'t go there either.')
		talk_state = 0
		end
end
end


	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Don't forget npcHandler = npcHandler in the parameters. It is required for all StdModule functions!

keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Femur Hills for just a small fee.'})

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the Carpet Man!'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to  Femur Hills for just a small fee.'})

-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())