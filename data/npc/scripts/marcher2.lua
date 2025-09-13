local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ARCHER_CONFIG = {
    destinationPos = {x = 121, y = 311, z = 7},
    maxDistance = 2,
    archerVocation = 3,
    carlinTownId = 2,
    questStorage = 1002
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if npcHandler:getDistanceToCreature(cid) > ARCHER_CONFIG.maxDistance then
        selfSay('Come closer to me!', cid)
        return true
    end
    
    if msgcontains(msg, 'yes') and player:getVocation():getId() == 0 then
        selfSay('Good luck my little Archer!', cid)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You are now an Archer!")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
        player:addHealth(185)
        player:setVocation(Vocation(ARCHER_CONFIG.archerVocation))
        player:setTown(Town(ARCHER_CONFIG.carlinTownId))
        player:setStorageValue(ARCHER_CONFIG.questStorage, 2)
        player:teleportTo(Position(ARCHER_CONFIG.destinationPos))
        Position(ARCHER_CONFIG.destinationPos):sendMagicEffect(CONST_ME_TELEPORT)
        
    elseif msgcontains(msg, 'no') then
        selfSay('Ok my friend... I will wait.', cid)
        
    elseif msgcontains(msg, 'calona') then
        selfSay('Calona is a wise trainer in Carlin. She will teach you the ways of archery.', cid)
        
    elseif msgcontains(msg, 'novice') then
        selfSay('Tell Calona you are a novice and she will help you with basic training.', cid)
        
    elseif msgcontains(msg, 'archer') then
        selfSay('Archers are skilled warriors who excel at ranged combat and balanced fighting.', cid)
        
    elseif msgcontains(msg, 'carlin') then
        selfSay('Carlin will be your new home as an archer. It\'s a great city for training.', cid)
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        if npcHandler:getDistanceToCreature(cid) <= ARCHER_CONFIG.maxDistance then
            selfSay('Congratulations ' .. player:getName() .. '! You passed the test!', cid)
            selfSay('Go to Calona in Carlin, and say you are a "novice", she will help you. So... Are you ready to become an Archer?', cid)
        else
            selfSay('Come closer, ' .. player:getName() .. '!', cid)
        end
    end
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('Good bye, come back here when you are ready ' .. player:getName() .. '!', cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())
