local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'blue bp', 'blue backpack'}, 2807, 50, 'blue backpack')
shopModule:addBuyableItem({'red bp', 'red backpack'}, 2805, 50, 'red backpack')
shopModule:addBuyableItem({'yellow bp', 'yellow backpack'}, 2809, 50, 'yellow backpack')
shopModule:addBuyableItem({'tiquanda', 'tiquanda bp'}, 2810, 50, 'tiquanda backpack')
shopModule:addBuyableItem({'green bp', 'green backpack'}, 2803, 50, 'green backpack')
shopModule:addBuyableItem({'gray bp', 'gray backpack'}, 2808, 50, 'gray backpack')

shopModule:addSellableItem({'vial', 'vials'}, 2006, 10, 'vial')

keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell blue bp (50gps), red bp (50gps), yellow bp (50gps), tiquanda bp (50gps), green bp (50gps) and gray bp (50gps). I buy vials (10gps).'})
keywordHandler:addKeyword({'backpack', 'backpacks'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell blue bp (50gps), red bp (50gps), yellow bp (50gps), tiquanda bp (50gps), green bp (50gps) and gray bp (50gps).'})

npcHandler:addModule(FocusModule:new())
