local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    MYSTIC_CONFIRM = 1
}

local function greetCallback(cid)
    local player = Player(cid)
    if player:isPremium() then
        npcHandler:say('Hello ' .. player:getName() .. '! I can take you to the Mystic Island for 50 gold.', cid)
        return true
    else
        npcHandler:say('Sorry, only premium players can travel by boat.', cid)
        return false
    end
end

local function farewellCallback(cid)
    local player = Player(cid)
    npcHandler:say('Good bye, ' .. player:getName() .. '!', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if msgcontains(msg, 'mystic island') then
        npcHandler:say('Are you sure you want to go to Mystic Island?', cid)
        npcHandler.topic[cid] = topicList.MYSTIC_CONFIRM
    elseif npcHandler.topic[cid] == topicList.MYSTIC_CONFIRM and msgcontains(msg, 'yes') then
        if player:removeMoney(50) then
            npcHandler:say('Let\'s go!', cid)
            player:teleportTo(Position(1447, 1504, 7))
            Position(1447, 1504, 7):sendMagicEffect(CONST_ME_TELEPORT)
        else
            npcHandler:say('Sorry, you don\'t have enough money.', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif npcHandler.topic[cid] == topicList.MYSTIC_CONFIRM and msgcontains(msg, 'no') then
        npcHandler:say('Where do you want to go then?', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I can take you to the Mystic Island for 50 gold.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
