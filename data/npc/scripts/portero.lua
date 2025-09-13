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

    if msgcontains(msg, 'yes') then
        selfSay('Let\'s go!', cid)
        player:teleportTo(Position(449, 272, 7))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        npcHandler:releaseFocus()

    elseif msgcontains(msg, 'no') then
        selfSay('Ok then... bye!', cid)
        npcHandler:releaseFocus()

    elseif msgcontains(msg, 'tirith') or msgcontains(msg, 'city') then
        selfSay('I can take you inside Tirith, want come in?', cid)

    elseif msgcontains(msg, 'help') then
        selfSay('I can transport premium players to Tirith city.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    if player:isPremium() then
        selfSay('Hello ' .. player:getName() .. '! I can take you inside Tirith, want come in?', cid)
        return true
    else
        selfSay('Sorry, only premium players can go in the city.', cid)
        return false
    end
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Good bye, ' .. player:getName() .. '!', cid)
    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
