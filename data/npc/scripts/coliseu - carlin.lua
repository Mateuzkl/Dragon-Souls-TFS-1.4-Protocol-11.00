local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    COLISEUM_CONFIRM = 1
}

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if msgcontains(msg, 'coliseum') then
        npcHandler:say('Do you wish to travel to Coliseum for 1000 gold coins?', cid)
        npcHandler.topic[cid] = topicList.COLISEUM_CONFIRM
    elseif npcHandler.topic[cid] == topicList.COLISEUM_CONFIRM and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:removeMoney(1000) then
                player:teleportTo(Position(163, 395, 7))
                Position(163, 395, 7):sendMagicEffect(CONST_ME_TELEPORT)
                npcHandler.topic[cid] = topicList.NONE
            else
                npcHandler:say('Sorry, you don\'t have this money.', cid)
                npcHandler.topic[cid] = topicList.NONE
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif npcHandler.topic[cid] == topicList.COLISEUM_CONFIRM and msgcontains(msg, 'no') then
        npcHandler:say('I wouldn\'t go there either.', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

keywordHandler:addKeyword({'destination'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I can take you to Coliseum for just a small fee.'
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
    text = 'I can take you to Coliseum for just a small fee.'
})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
