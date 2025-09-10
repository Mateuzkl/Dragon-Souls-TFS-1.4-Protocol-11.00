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
	if(npcHandler.focus ~= cid) then
		return false
	end


	if msgcontains(msg, 'enter') then
		selfSay('Do you wish enter on arena?')
		talk_state = 1

	elseif msgcontains(msg, 'leave') then
		selfSay('Do you wish leave arena?')
		talk_state = 2

	elseif msgcontains(msg, 'yes') and talk_state == 1 then
		if isPremium(cid) then
		travel(cid, 49, 462, 7)
		talk_state = 0
		else
		selfSay('Sorry, only premmys can enter.')
		talk_state = 0
 		end

	elseif msgcontains(msg, 'yes') and talk_state == 2 then
		travel(cid, 121, 318, 7)
		talk_state = 0

		elseif msgcontains(msg, 'no') and talk_state > 0 then
		selfSay('I wouldn\'t go there either.')
		talk_state = 0


end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)


-- Don't forget npcHandler = npcHandler in the parameters. It is required for all StdModule functions!

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can let you Enter or Leave arena.'})

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the gate guard.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no time for this.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no time for this.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can let you Enter or Leave arena.'})


-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())