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

shopModule:addBuyableItem({'life fluid', 'lifefluid'},2006, 80,	10,'life fluid')
shopModule:addBuyableItem({'bag'},1987, 4, 1,'bag')
shopModule:addBuyableItem({'rope'},2120, 50,1,'rope')
shopModule:addBuyableItem({'fishing rod'},2580, 150,1,'fishing rod')
shopModule:addBuyableItem({'torch'},2050, 2,1,'torch')
shopModule:addBuyableItem({'shovel'},2554, 10,1,'shovel')
shopModule:addBuyableItem({'worm'},3976, 1,1,'worm')

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the owner of this shop.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no ones for you now.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no ones for you now.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am selling life fluids, bags, rope, fishing rods, torchs, shovels, worms and also buying vials.'})

npcHandler:addModule(FocusModule:new())