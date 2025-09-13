local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local DRUID_CONFIG = {
    trainingArea = {x = 264, y = 179, z = 8},
    maxDistance = 2,
    timeout = 120
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if npcHandler:getDistanceToCreature(cid) > DRUID_CONFIG.maxDistance then
        selfSay('Come closer to me!', cid)
        return true
    end
    
    if msgcontains(msg, 'test') then
        selfSay('Nice choice, pure soul. Where are you from, Brazil or foreigner?', cid)
        npcHandler.topic[cid] = 1
        
    elseif npcHandler.topic[cid] == 1 then
        if msgcontains(msg, 'brazil') or msgcontains(msg, 'brasil') then
            selfSay('Que ótimo! Vamos ao treinamento.', cid)
            selfSay('Druids(Druidas), sua força provém da elevação do espírito e o contato com os elementos, suas magias são focadas em cura e domínio de elementos, mas seu corpo e sua constituição são fracos.', cid)
            selfSay('E então... Vamos ao teste?', cid)
            npcHandler.topic[cid] = 2
        else
            selfSay('Hmm, I never traveled there, but... Let\'s start the training!', cid)
            selfSay('Druids, their strength is gained by spirit elevation and contact with elements, their magic is focused on healing and element domain, but their body and constitution are weak.', cid)
            selfSay('So, let\'s go to the test... Ready?', cid)
            npcHandler.topic[cid] = 4
        end
        
    elseif npcHandler.topic[cid] == 2 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('Seu teste consiste no convívio na natureza e a paciência que isso nos traz.', cid)
            selfSay('Meu jardim provém de frutos que a natureza pode nos oferecer, quero que traga para mim, 100 Blueberry colhidos na hora, e pacientemente.', cid)
            selfSay('Vamos?', cid)
            npcHandler.topic[cid] = 3
        end
        
    elseif npcHandler.topic[cid] == 4 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('What you will need to do is!', cid)
            selfSay('My garden has fruits that nature can provide, I want you to bring me 100 fresh Blueberries, be patient!', cid)
            selfSay('Ready?', cid)
            npcHandler.topic[cid] = 5
        end
        
    elseif npcHandler.topic[cid] == 3 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('Lhe aguardo no final, e lembre-se, paciência é uma virtude.', cid)
            player:teleportTo(Position(DRUID_CONFIG.trainingArea))
            Position(DRUID_CONFIG.trainingArea):sendMagicEffect(CONST_ME_TELEPORT)
        end
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 5 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('I will be waiting for you at the end, and remember, patience is a virtue.', cid)
            player:teleportTo(Position(DRUID_CONFIG.trainingArea))
            Position(DRUID_CONFIG.trainingArea):sendMagicEffect(CONST_ME_TELEPORT)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'druid') then
        selfSay('Druids are masters of nature magic, healing and elemental control. They connect with the spiritual world.', cid)
        
    elseif msgcontains(msg, 'nature') then
        selfSay('Nature provides us with everything we need. Patience and harmony are the keys to understanding its power.', cid)
        
    elseif msgcontains(msg, 'blueberry') then
        selfSay('Blueberries are sacred fruits that test your patience and connection with nature. Gather them carefully.', cid)
        
    elseif msgcontains(msg, 'garden') then
        selfSay('My garden is a sanctuary where nature\'s gifts grow. It will teach you patience and respect for all living things.', cid)
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Come back when you are ready for the path of nature.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        if npcHandler:getDistanceToCreature(cid) <= DRUID_CONFIG.maxDistance then
            selfSay('Ialas ' .. player:getName() .. '! Are you sure you want to train to be a Pure Druid? So say "test".', cid)
        else
            selfSay('Come closer, ' .. player:getName() .. '!', cid)
        end
    end
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('Good bye, ' .. player:getName() .. '!', cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())
