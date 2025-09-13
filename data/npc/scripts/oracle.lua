local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

local voc = 0

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local talk_state = npcHandler.topic[cid] or 0

    if msgcontains(msg, 'sorcerer') then
        selfSay('Are you sure that you wish to become a sorcerer? This decision is irreversible!', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'druid') then
        selfSay('Are you sure that you wish to become a druid? This decision is irreversible!', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'paladin') then
        selfSay('Are you sure that you wish to become a paladin? This decision is irreversible!', cid)
        npcHandler.topic[cid] = 3
        
    elseif msgcontains(msg, 'knight') then
        selfSay('Are you sure that you wish to become a knight? This decision is irreversible!', cid)
        npcHandler.topic[cid] = 4

    elseif msgcontains(msg, 'yes') then
        if talk_state >= 1 and talk_state <= 4 then
            if player:getLevel() < 8 then
                selfSay('You are not yet worthy. Come back when you are ready!', cid)
                npcHandler:resetNpc()
                npcHandler.topic[cid] = 0
                return true
            end
            
            if player:getVocation():getId() ~= 0 then
                selfSay('You already have a vocation!', cid)
                npcHandler:resetNpc()
                npcHandler.topic[cid] = 0
                return true
            end
            
            local vocationNames = {
                [1] = "sorcerer",
                [2] = "druid", 
                [3] = "paladin",
                [4] = "knight"
            }
            
            player:setVocation(Vocation(talk_state))
            player:setTown(Town(1)) -- Set town if needed
            player:teleportTo(Position(438, 504, 8))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            
            selfSay('Congratulations! You are now a ' .. vocationNames[talk_state] .. '!', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('What do you want to confirm?', cid)
        end

    elseif msgcontains(msg, 'no') then
        if talk_state >= 1 and talk_state <= 4 then
            selfSay('Allright then. What vocation do you wish to become? A sorcerer, druid, paladin or knight?', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('Then come back when you are ready!', cid)
            npcHandler:resetNpc()
            npcHandler.topic[cid] = 0
        end

    elseif msgcontains(msg, 'vocation') or msgcontains(msg, 'job') then
        if player:getVocation():getId() == 0 then
            selfSay('What vocation do you wish to become? A sorcerer, druid, paladin or knight?', cid)
        else
            selfSay('You already have a vocation!', cid)
        end
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay(player:getName() .. '! Are you prepared to face your destiny?', cid)
    npcHandler.topic[cid] = 0
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Farewell, ' .. player:getName() .. '!', cid)
    npcHandler.topic[cid] = 0
    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
