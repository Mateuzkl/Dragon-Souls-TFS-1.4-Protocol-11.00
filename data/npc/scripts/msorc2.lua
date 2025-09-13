local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local talk_state = npcHandler.topic[cid] or 0
    local book = player:getStorageValue(1002)

    if msgcontains(msg, 'book') then
        if player:getItemCount(1973) >= 1 then
            player:removeItem(1973, 1)
            selfSay('Hmm... You do a nice work for an mortal.', cid)
            selfSay('Go to Calona on Carlin, and say you are a "novice", her will help you mortal, so... You are ready to become a Sorcerer?', cid)
            player:setStorageValue(1002, 1)
            npcHandler.topic[cid] = 0
        else
            selfSay('I dont have time for that, go get this book fast!', cid)
            npcHandler:releaseFocus()
            npcHandler.topic[cid] = 0
        end

    elseif msgcontains(msg, 'yes') and player:getVocation():getId() == 0 then
        if book == -1 then
            selfSay('Yes?! Yes what?!', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('Good luck mortal!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You are now a Sorcerer!')
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:addHealth(185)
            player:setVocation(Vocation(1))
            player:setTown(Town(2))
            player:teleportTo(Position(121, 311, 7))
            player:setStorageValue(1002, 2)
            npcHandler:releaseFocus()
            npcHandler.topic[cid] = 0
        end

    elseif msgcontains(msg, 'no') then
        selfSay('HA! You are joking me!', cid)
        npcHandler:releaseFocus()
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'novice') then
        selfSay('Are you ready to become a Sorcerer?', cid)
        npcHandler.topic[cid] = 0
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    local book = player:getStorageValue(1002)
    
    if book == -1 then
        selfSay('Why so late ' .. player:getName() .. '? whatever, what you bring to me? please say a "book", i dont have time to lost!', cid)
    else
        selfSay('Go to Calona on Carlin, and say you are a "novice", her will help you mortal, so... You are ready to become a Sorcerer?', cid)
    end
    
    npcHandler.topic[cid] = 0
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Good bye, back here when you ready ' .. player:getName() .. '!', cid)
    npcHandler.topic[cid] = 0
    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
