local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local TRAVEL_CONFIG = {
    destinations = {
        tombstone = {x = 173, y = 65, z = 7},
        carlin = {x = 151, y = 356, z = 6}
    },
    costs = {
        tombstone = 80,
        carlin = 80
    }
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'offer') or msgcontains(msg, 'travel') then
        selfSay('I can take you from here to tombstone and carlin.', cid)
        
    elseif msgcontains(msg, 'tombstone') then
        selfSay('Do you wish to travel to tombstone for 80 gold coins?', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'carlin') then
        selfSay('Do you wish to travel to carlin for 80 gold coins?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'yes') then
        if npcHandler.topic[cid] == 1 then
            if player:removeMoney(TRAVEL_CONFIG.costs.tombstone) then
                selfSay('Set the sails!', cid)
                player:teleportTo(Position(TRAVEL_CONFIG.destinations.tombstone))
                Position(TRAVEL_CONFIG.destinations.tombstone):sendMagicEffect(CONST_ME_TELEPORT)
            else
                selfSay('You do not have enough money!', cid)
            end
            npcHandler.topic[cid] = 0
            
        elseif npcHandler.topic[cid] == 2 then
            if player:removeMoney(TRAVEL_CONFIG.costs.carlin) then
                selfSay('Set the sails!', cid)
                player:teleportTo(Position(TRAVEL_CONFIG.destinations.carlin))
                Position(TRAVEL_CONFIG.destinations.carlin):sendMagicEffect(CONST_ME_TELEPORT)
            else
                selfSay('You do not have enough money!', cid)
            end
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'no') then
        if npcHandler.topic[cid] >= 1 then
            selfSay('Where do you wish to go then?', cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I am not buying anything.', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('I am just selling passages for carlin and tombstone.', cid)
        
    elseif msgcontains(msg, 'job') then
        selfSay('I am the Captain of this Ship!', cid)
        
    elseif msgcontains(msg, 'quest') or msgcontains(msg, 'mission') then
        selfSay('Since I got busted by pirates in my quests, I never get out of route again!', cid)
    end
    
    return true
end

function onGreet(cid)
    selfSay('Hello ' .. Player(cid):getName() .. '! Welcome to my five stars Ship!', cid)
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
