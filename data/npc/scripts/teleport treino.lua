local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end

function creatureSayCallback(cid, type, msg)
	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	if(npcHandler.focus ~= cid) then
		return false
	end

		if msgcontains(msg, 'enter') then
   			selfSay('Do you wish to enter the training camp for 500 gold coins?')
			talk_state = 1

		elseif msgcontains(msg, 'leave') then
   			selfSay('Do you wish to leave the training camp?')
			talk_state = 2

		elseif msgcontains(msg, 'yes') and talk_state == 1 then
		if getPlayerSkull(cid) == 0 then
		if pay(cid,500) then
			travel(cid, 165, 315, 7)
   			selfSay('Come on, lets train!')
			talk_state = 1
			else
   			selfSay('Sorry, you dont have this money!')
			end
			else
   			selfSay('Sorry, we can\'t admit peoples whit skull marked!')
			end

		elseif msgcontains(msg, 'yes') and talk_state == 2 then
		if getPlayerSkull(cid) == 0 then
			travel(cid, 165, 317, 7)
   			selfSay('See ya.')
			talk_state = 1
			else
   			selfSay('Sorry, i can\'t let you go whit skull marked! GUARDS!')
  		 	attack = 1
   			Attack(focus)
			following = true
			target = cid
			end
		end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Don't forget npcHandler = npcHandler in the parameters. It is required for all StdModule functions!

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can let you ENTER or LEAVE the Training Camp.'})

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the Owner of the training camp.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests again.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests again.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can let you ENTER or LEAVE the Training Camp.'})


-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())