local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Distance weapons and ammunition
shopModule:addSellableItem({'crossbow'}, 2455, 500, 'crossbow')
shopModule:addSellableItem({'bow'}, 2456, 350, 'bow')
shopModule:addSellableItem({'arrow'}, 2544, 2, 'arrow')
shopModule:addSellableItem({'bolt'}, 2543, 10, 'bolt')
shopModule:addSellableItem({'spear'}, 2389, 10, 'spear')

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('Hello ' .. player:getName() .. '! Welcome to my distance weaponry!', cid)
    return true
end

keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I offer you bows, crossbows, arrows, bolts, spears and burst arrows.'
})

keywordHandler:addKeyword({'sell'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am not buying anything.'
})

keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am the shopkeeper of this distance weaponry.'
})

keywordHandler:addKeyword({'quest'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'A quest is nothing I want to be involved in.'
})

keywordHandler:addKeyword({'mission'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I cannot help you in that area, son.'
})

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! Welcome to my distance weaponry!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Please, |PLAYERNAME|. I will talk to you in one minute!')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:addModule(FocusModule:new())
