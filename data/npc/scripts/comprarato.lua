local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Add buyable items (rats)
shopModule:addBuyableItem({'rat'}, 2962, 30, 'rat')                -- Flesh rats for 30gp
shopModule:addBuyableItem({'dead rat'}, 2813, 10, 'dead rat')      -- Dead rats for 10gp

keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am the owner of this shop.'
})

keywordHandler:addKeyword({'mission'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I have no ones for you now.'
})

keywordHandler:addKeyword({'quest'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I have no ones for you now.'
})

keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am buying dead rats, pay 30 gps for flesh rats and 10 gps for other rats.'
})

npcHandler:addModule(FocusModule:new())
