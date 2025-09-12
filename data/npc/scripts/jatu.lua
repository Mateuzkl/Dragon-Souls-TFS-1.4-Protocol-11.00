local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    ORC_PLACE = 1
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    -- Initialize topic if needed
    if not npcHandler.topic[cid] then
        npcHandler.topic[cid] = topicList.NONE
    end
    
    local promo = player:getStorageValue(30002)
    
    if msgcontains(msg, 'job') then
        npcHandler:say('I get exotics fruits!', cid)
        
    elseif msgcontains(msg, 'offer') then
        npcHandler:say('Go talk whit Fartun!', cid)
        
    elseif msgcontains(msg, 'sell') then
        npcHandler:say('Go talk whit Fartun!', cid)
        
    elseif msgcontains(msg, 'buy') then
        npcHandler:say('Dont have money now!', cid)
        
    elseif msgcontains(msg, 'quest') then
        npcHandler:say('Hehe!', cid)
        
    elseif msgcontains(msg, 'mission') then
        npcHandler:say('Nothing now.', cid)
        
    elseif msgcontains(msg, 'orc place') then
        npcHandler:say('Oh! Its here! Come i show you... on this hole!', cid)
        local npc = Npc()
        if npc then
            npc:teleportTo(Position(327, 296, 7))
            npc:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        end
        npcHandler.topic[cid] = topicList.ORC_PLACE
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > topicList.NONE then
        npcHandler:say('Ok than.', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

-- Keywords for automatic responses
keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I get exotics fruits!'
})

keywordHandler:addKeyword({'offer', 'sell'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Go talk whit Fartun!'
})

keywordHandler:addKeyword({'buy'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Dont have money now!'
})

keywordHandler:addKeyword({'quest'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Hehe!'
})

keywordHandler:addKeyword({'mission'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Nothing now.'
})

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! Welcome!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, I am busy right now.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
