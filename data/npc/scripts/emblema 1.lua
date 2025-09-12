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
    npcHandler:say('What do you want here? This boat is only for the royal family!', cid)
    return true
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
    local addon = player:getStorageValue(30000)
    
    if npcHandler.topic[cid] == topicList.TRAVEL_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(2122) >= 1 then
            npcHandler:say('Set the Sails!', cid)
            player:teleportTo(Position(56, 431, 7))
            Position(56, 431, 7):sendMagicEffect(CONST_ME_TELEPORT)
            player:say("Oh God", TALKTYPE_MONSTER_SAY)
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('You are not with the broch!', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif msgcontains(msg, 'royal family') then
        if addon == -1 then
            npcHandler:say('Go bother someone else!', cid)
        elseif addon == 1 then
            if player:getItemCount(2122) >= 1 then
                npcHandler:say('I dont know how did you get the royal family broch, but is my job to take you to the prince, the king\'s son of dagmar. Can we go now?', cid)
                npcHandler.topic[cid] = topicList.TRAVEL_CONFIRM
            else
                npcHandler:say('Go bother someone else!', cid)
            end
        elseif addon == 2 then
            if player:getItemCount(2122) >= 1 then
                npcHandler:say('You need find Narzan the prince, the king\'s son of dagmar! Can we go now?', cid)
                npcHandler.topic[cid] = topicList.TRAVEL_CONFIRM
            else
                npcHandler:say('I can\'t go whitout the broch!', cid)
            end
        elseif addon >= 3 then
            npcHandler:say('now, we just need wait the orders of the queen!', cid)
        end
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'What do you want here? This boat is only for the royal family!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
