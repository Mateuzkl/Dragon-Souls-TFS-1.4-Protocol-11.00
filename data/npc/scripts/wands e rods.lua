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

shopModule:addBuyableItem({'wand of inferno', 'inferno'}, 				2187, 5000, 	'wand of inferno')
shopModule:addBuyableItem({'wand of plague', 'plague'}, 				2188, 1000, 	'wand of plague')
shopModule:addBuyableItem({'wand of cosmic energy', 'cosmic energy'}, 	2189, 2500, 	'explosion rune')
shopModule:addBuyableItem({'wand of vortex', 'vortex'}, 				2190, 100, 	 	'wand of cosmic energy')
shopModule:addBuyableItem({'wand of dragonbreath', 'dragonbreath'}, 	2191, 500, 	'wand of dragonbreath')

shopModule:addBuyableItem({'quagmire rod', 'quagmire'}, 				2181, 2500, 	'quagmire rod')
shopModule:addBuyableItem({'snakebite rod', 'snakebite'}, 				2182, 100, 	 	'snakebite rod')
shopModule:addBuyableItem({'tempest rod', 'tempest'}, 					2183, 5000, 	'tempest rod')
shopModule:addBuyableItem({'volcanic rod', 'volcanic'}, 				2185, 1000, 	'volcanic rod')
shopModule:addBuyableItem({'moonlight rod', 'moonlight'}, 				2186, 500,   	'moonlight rod')

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the owner of this wand shop.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no ones for you now.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no ones for you now.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am selling all types of wands and rods.'})
keywordHandler:addKeyword({'wands'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am selling Wand of vortex(100gps), Wand of dragonbreath(500gps), Wand of plage(1k), Wand of cosmic energy(2,5k) e Wand of inferno(5k).'})
keywordHandler:addKeyword({'rods'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am selling snakebite rod(100gps), moonlight rod(500gps), volcanic rod(1k), quagmire rod(2,5k) e tempest rod(5k).'})


npcHandler:addModule(FocusModule:new())