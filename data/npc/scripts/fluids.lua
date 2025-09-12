local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'small manafluid', 'small mana fluid'}, 2006, 100, 7, 'small mana fluid')
shopModule:addSellableItem({'medium mana fluid', 'medium manafluid'}, 2006, 250, 31, 'medium mana fluid')
shopModule:addSellableItem({'large mana fluid', 'large manafluid'}, 2006, 500, 39, 'large mana fluid')
shopModule:addSellableItem({'life fluid', 'lifefluid'}, 2006, 80, 10, 'life fluid')

keywordHandler:addKeyword({'mistery invisible liquid'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'Sorry, we don\'t sell to inexperient players.'
})

keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am the town alchemist.'
})

keywordHandler:addKeyword({'mission'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I have been in many quests, now i am retired.'
})

keywordHandler:addKeyword({'quest'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I have been in many missions, now i am retired.'
})

keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am selling some kind of magic fluids and small, medium and large mana fluids.'
})

keywordHandler:addKeyword({'magic fluids'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'With the current resources, I can create Mana Fluids and Life Fluids.'
})

npcHandler:addModule(FocusModule:new())
