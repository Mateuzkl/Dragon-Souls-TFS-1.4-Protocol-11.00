local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'extreme sudden death', 'esd'}, 					2267, 100000, 	10, 	'extreme sudden death 10x')

shopModule:addBuyableItem({'extreme explosion', 'eexpl'}, 					2315, 150000, 	30, 	'extreme explosion 30x')

shopModule:addBuyableItem({'concentrated demonic blood', 'blood'}, 					6558, 150000, 	1, 	'concentrated demonic blood')

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Job? Im just a traveller'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I cant talk about that now!'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I cant talk about that now!'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am buying all equipaments of valans and selling some rare runes and concentrated demonic bloods.'})
keywordHandler:addKeyword({'runes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Hmm... I got some rare runes here, like extreme sudden death(esd) and extreme explosion(eexpl).'})

npcHandler:addModule(FocusModule:new())