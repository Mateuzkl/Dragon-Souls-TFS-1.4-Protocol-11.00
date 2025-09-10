local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end


-- Don't forget npcHandler = npcHandler in the parameters. It is required for all StdModule functions!

keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can incube your Monster Egg and i can train your pet to the next level.'})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Sell What?'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the owner of this PetShop.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no missions for you.'})
keywordHandler:addKeyword({'buy'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Sorry but I do not sell those.'})


keywordHandler:addKeyword({'demon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You dont have this egg.'})
keywordHandler:addKeyword({'dragon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You dont have this egg.'})
keywordHandler:addKeyword({'tortoise'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You dont have this egg.'})
keywordHandler:addKeyword({'dragon lord'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You dont have this egg.'})
keywordHandler:addKeyword({'wolf'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You dont have this egg.'})
keywordHandler:addKeyword({'egg'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You can obtain eggs by killing monsters or completing some quests.'})


-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())