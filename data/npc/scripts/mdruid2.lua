local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local DRUID_CONFIG = {
    questStorage = 1002,
    blueberryId = 2677,
    blueberryAmount = 100,
    druidVocation = 2,
    carlinTownId = 2,
    destinationPos = {x = 121, y = 311, z = 7},
    maxDistance = 2
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local book = player:getStorageValue(DRUID_CONFIG.questStorage)
    
    if npcHandler:getDistanceToCreature(cid) > DRUID_CONFIG.maxDistance then
        selfSay('Come closer to me!', cid)
        return true
    end
    
    if msgcontains(msg, '100 blueberry') or msgcontains(msg, 'blueberry') then
        if player:getItemCount(DRUID_CONFIG.blueberryId) >= DRUID_CONFIG.blueberryAmount then
            player:removeItem(DRUID_CONFIG.blueberryId, DRUID_CONFIG.blueberryAmount)
            selfSay('Excellent job!', cid)
            selfSay('Go to Calona in Carlin, and say you are a "novice", she will help you mortal, so... You are ready to become a Druid?', cid)
            player:setStorageValue(DRUID_CONFIG.questStorage, 1)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You delivered 100 blueberries!")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            selfSay('Be patient, I need exactly 100 blueberries. Get them for me.', cid)
        end
        
    elseif msgcontains(msg, 'yes') and player:getVocation():getId() == 0 then
        if book == -1 then
            selfSay('Yes? I don\'t understand! Bring me the blueberries first.', cid)
        else
            selfSay('Good luck novice Druid!', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You are now a Druid!")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:addHealth(185)
            player:setVocation(Vocation(DRUID_CONFIG.druidVocation))
            player:setTown(Town(DRUID_CONFIG.carlinTownId))
            player:setStorageValue(DRUID_CONFIG.questStorage, 2)
            player:teleportTo(Position(DRUID_CONFIG.destinationPos))
            Position(DRUID_CONFIG.destinationPos):sendMagicEffect(CONST_ME_TELEPORT)
        end
        
    elseif msgcontains(msg, 'no') then
        selfSay('Ok, all in your time.', cid)
        
    elseif msgcontains(msg, 'calona') then
        selfSay('Calona is a wise trainer in Carlin. She will teach you the advanced ways of druidcraft.', cid)
        
    elseif msgcontains(msg, 'novice') then
        selfSay('Tell Calona you are a novice and she will guide you in the druidic arts.', cid)
        
    elseif msgcontains(msg, 'druid') then
        selfSay('Druids are masters of nature magic, healing and elemental control. They seek harmony with all living things.', cid)
        
    elseif msgcontains(msg, 'nature') then
        selfSay('Nature provides us with everything we need. The blueberries are a test of your patience and respect for natural gifts.', cid)
        
    elseif msgcontains(msg, 'carlin') then
        selfSay('Carlin will be your new home as a druid. It\'s a city where nature and civilization coexist.', cid)
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        local book = player:getStorageValue(DRUID_CONFIG.questStorage)
        
        if npcHandler:getDistanceToCreature(cid) <= DRUID_CONFIG.maxDistance then
            if book == -1 then
                selfSay('On right time ' .. player:getName() .. '. What did you bring to me? "100 blueberry"?', cid)
            else
                selfSay('Go to Calona in Carlin, and say you are a "novice", she will help you mortal, so... You are ready to become a Druid?', cid)
            end
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
