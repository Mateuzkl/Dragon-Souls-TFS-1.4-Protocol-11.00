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

shopModule:addBuyableItem({'light wand', 'lightwand'}, 					2163, 500, 		'magic light wand')

shopModule:addBuyableItem({'heavy magic missile dec', 'hmm dec'}, 				2311, 1200, 	50,	'heavy magic missile dec rune')
shopModule:addBuyableItem({'heavy magic missile', 'hmm'}, 				2311, 105, 	5,	'heavy magic missile rune')

shopModule:addBuyableItem({'great fireball dec', 'gfb dec'}, 					2304, 2100, 	20, 	'great fireball dec rune')
shopModule:addBuyableItem({'great fireball', 'gfb'}, 					2304, 180, 	2, 	'great fireball rune')

shopModule:addBuyableItem({'explosion dec', 'expl dec'}, 							2313, 3150, 	30, 	'explosion dec rune')
shopModule:addBuyableItem({'explosion', 'expl'}, 							2313, 270, 	3, 	'explosion rune')

shopModule:addBuyableItem({'ultimate healing dec', 'uh dec'}, 					2273, 1750, 	10, 	'ultimate healing dec rune')
shopModule:addBuyableItem({'ultimate healing', 'uh'}, 					2273, 150, 	1, 	'ultimate healing rune')

shopModule:addBuyableItem({'sudden death dec', 'sd dec'}, 						2268, 3850, 	10, 	'sudden death dec rune')
shopModule:addBuyableItem({'sudden death', 'sd'}, 						2268, 330, 	1, 	'sudden death rune')

shopModule:addBuyableItem({'blank', 'rune'}, 							2260, 10, 		'blank rune')

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the owner of this runes shop.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no ones for you now.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no ones for you now.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am selling some kind of magic runes, light wands and life fluids.'})

npcHandler:addModule(FocusModule:new())