local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    TRAVEL_CONFIRM = 1
}

local function greetCallback(cid)
    local player = Player(cid)
    local addon = player:getStorageValue(30000)
    
    if addon == 3 then
        npcHandler:say('Did you found Narzan? Lets go now?', cid)
        npcHandler.topic[cid] = topicList.TRAVEL_CONFIRM
    else
        npcHandler:say('We cant go before we have sure that Narzan is alive!', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    npcHandler:say('Good luck, ' .. player:getName() .. '!', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        -- Handle "oh god" trigger even when not focused
        if msgcontains(msg, 'oh god') then
            local player = Player(cid)
            if player then
                npcHandler:say('Oh! What is going on? Find Narzan, i am going to find help!', cid)
                player:setStorageValue(30000, 2)
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            end
            return true
        end
        return false
    end
    
    local player = Player(cid)
    
    if npcHandler.topic[cid] == topicList.TRAVEL_CONFIRM and msgcontains(msg, 'yes') then
        npcHandler:say('As you wish!', cid)
        player:teleportTo(Position(31, 298, 7))
        Position(31, 298, 7):sendMagicEffect(CONST_ME_TELEPORT)
        npcHandler:releaseFocus(cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Did you found Narzan? Lets go now?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good luck, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Go go, fast!')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
