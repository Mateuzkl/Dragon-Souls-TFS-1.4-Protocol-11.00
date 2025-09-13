local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}
local destination = {}

local DRUID_CONFIG = {
    trainingArea = {x = 264, y = 179, z = 8}
}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function greetCallback(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    local level = player:getLevel()
    if level < 8 then
        npcHandler:say('CHILD! COME BACK WHEN YOU HAVE GROWN UP!', cid)
        return false
    elseif level > 50 then
        npcHandler:say('YOU ARE TOO STRONG ALREADY!', cid)
        return false
    elseif player:getVocation():getId() > 4 then
        npcHandler:say('YOU ALREADY HAVE AN ADVANCED VOCATION!', cid)
        return false
    end
    
    npcHandler:say('Ialas ' .. player:getName() .. '! Are you sure you want to train to be a Pure Druid? So say "test".', cid)
    return true
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local talk_state = npcHandler.topic[cid] or 0
    msg = msg:lower()
    
    if msgcontains(msg, 'test') and talk_state == 0 then
        npcHandler:say('Nice choice, pure soul. Where are you from, Brazil or foreigner?', cid)
        npcHandler.topic[cid] = 1
        
    elseif talk_state == 1 then
        if msgcontains(msg, 'brazil') or msgcontains(msg, 'brasil') then
            npcHandler:say({
                'Que ótimo! Vamos ao treinamento.',
                'Druids(Druidas), sua força provém da elevação do espírito e o contato com os elementos, suas magias são focadas em cura e domínio de elementos, mas seu corpo e sua constituição são fracos.',
                'E então... Vamos ao teste?'
            }, cid)
            npcHandler.topic[cid] = 2
        else
            npcHandler:say({
                'Hmm, I never traveled there, but... Let\'s start the training!',
                'Druids, their strength is gained by spirit elevation and contact with elements, their magic is focused on healing and element domain, but their body and constitution are weak.',
                'So, let\'s go to the test... Ready?'
            }, cid)
            npcHandler.topic[cid] = 4
        end
        
    elseif talk_state == 2 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say({
                'Seu teste consiste no convívio na natureza e a paciência que isso nos traz.',
                'Meu jardim provém de frutos que a natureza pode nos oferecer, quero que traga para mim, 100 Blueberry colhidos na hora, e pacientemente.',
                'Vamos?'
            }, cid)
            npcHandler.topic[cid] = 3
        end
        
    elseif talk_state == 4 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say({
                'What you will need to do is!',
                'My garden has fruits that nature can provide, I want you to bring me 100 fresh Blueberries, be patient!',
                'Ready?'
            }, cid)
            npcHandler.topic[cid] = 5
        end
        
    elseif talk_state == 3 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say('Lhe aguardo no final, e lembre-se, paciência é uma virtude.', cid)
            player:teleportTo(Position(DRUID_CONFIG.trainingArea))
            Position(DRUID_CONFIG.trainingArea):sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:releaseFocus(cid)
        end
        
    elseif talk_state == 5 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say('I will be waiting for you at the end, and remember, patience is a virtue.', cid)
            player:teleportTo(Position(DRUID_CONFIG.trainingArea))
            Position(DRUID_CONFIG.trainingArea):sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:releaseFocus(cid)
        end
    end
    
    return true
end

local function onAddFocus(cid)
    vocation[cid] = 0
    town[cid] = 0
    destination[cid] = 0
end

local function onReleaseFocus(cid)
    vocation[cid] = nil
    town[cid] = nil
    destination[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
