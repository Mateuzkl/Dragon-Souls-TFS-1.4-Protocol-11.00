local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if msgcontains(msg, 'yes') then
        player:teleportTo(Position(154, 345, 7))
        Position(154, 345, 7):sendMagicEffect(CONST_ME_TELEPORT)
    end
    
    return true
end

keywordHandler:addKeyword({'no'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I wouldn\'t go there either.'
})

keywordHandler:addKeyword({'destination'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I can take you to Edron for just a small fee.'
})

keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am the Captain of this boat!'
})

keywordHandler:addKeyword({'mission'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I never get involved in quests.'
})

keywordHandler:addKeyword({'quest'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I never get involved in quests.'
})

keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I can take you to Carlin free.'
})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
