local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)                npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)            npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                    npcHandler:onThink()                    end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'bow'}, 2456, 400, 'bow')
shopModule:addBuyableItem({'crossbow'}, 2455, 500, 'crossbow')
shopModule:addBuyableItem({'spear'}, 2389, 10, 'spear')
shopModule:addBuyableItem({'arrow'}, 2544, 3, 'arrow')
shopModule:addBuyableItem({'bolt'}, 2543, 4, 'bolt')

shopModule:addSellableItem({'bow'}, 2456, 130, 'bow')
shopModule:addSellableItem({'crossbow'}, 2455, 160, 'crossbow')
shopModule:addSellableItem({'spear'}, 2389, 3, 'spear')

npcHandler:addModule(FocusModule:new())