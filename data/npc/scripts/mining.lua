local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the Mining Supervisor.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Transform a rock into gold! haha!'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Transform a rock into gold! haha!'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am buing almost all types of gems, some stones and i sell picks.'})


keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Mining is first step on a iten forge! You only need a Pick, after getting one use it in stalagmites or silver dirt walls. Dont forget to sell me the stones!'})
keywordHandler:addKeyword({'HELP'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Mining is first step on a iten forge! You only need a Pick, after getting one use it in stalagmites or silver dirt walls. Dont forget to sell me the stones!'})

npcHandler:addModule(FocusModule:new())