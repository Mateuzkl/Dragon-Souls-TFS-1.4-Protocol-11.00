local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'chain armor'}, 2464, 100, 'chain armor')
shopModule:addBuyableItem({'brass armor'}, 2465, 250, 'brass armor')
shopModule:addBuyableItem({'scale armor'}, 2483, 500, 'scale armor')

shopModule:addBuyableItem({'chain legs'}, 2648, 80, 'chain legs')
shopModule:addBuyableItem({'brass legs'}, 2478, 200, 'brass legs')

shopModule:addBuyableItem({'brass helmet'}, 2460, 50, 'brass helmet')
shopModule:addBuyableItem({'viking helmet'}, 2473, 100, 'viking helmet')
shopModule:addBuyableItem({'iron helmet'}, 2459, 190, 'iron helmet')

shopModule:addBuyableItem({'sandals'}, 2642, 10, 'sandals')
shopModule:addBuyableItem({'leather boots'}, 2443, 20, 'leather boots')

shopModule:addBuyableItem({'plate shield'}, 2510, 50, 'plate shield')
shopModule:addBuyableItem({'black shield'}, 2529, 70, 'black shield')
shopModule:addBuyableItem({'cooper shield'}, 2530, 120, 'cooper shield')
shopModule:addBuyableItem({'bone shield'}, 2541, 150, 'bone shield')
shopModule:addBuyableItem({'ornamented shield'}, 2524, 200, 'ornamented shield')

keywordHandler:addKeyword({'armors', 'armaduras'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell chain armor, brass armor and scale armor.'})
keywordHandler:addKeyword({'legs'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell chain and brass legs.'})
keywordHandler:addKeyword({'helmets', 'capacetes'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell brass helmet, viking helmet and iron helmet.'})
keywordHandler:addKeyword({'boots', 'botas'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell leather boots and sandals.'})
keywordHandler:addKeyword({'shields', 'escudos'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell plate shield, black shield, cooper shield, bone shield and ornamented shield.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell armors, legs, helmets, boots and shields.'})

keywordHandler:addAliasKeyword({'oi'})
keywordHandler:addAliasKeyword({'tchau'})
keywordHandler:addAliasKeyword({'xau'})

npcHandler:addModule(FocusModule:new())
