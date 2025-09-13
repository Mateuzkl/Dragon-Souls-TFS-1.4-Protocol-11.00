local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local QUEST_CONFIG = {
    promoStorage = 30002
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local promo = player:getStorageValue(QUEST_CONFIG.promoStorage)
    
    if msgcontains(msg, 'job') then
        selfSay('I am a seller of exotic fruits!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('Hmm... Would you like to try my exotic fruits?', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('Nothing for sale right now!', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('I don\'t share my quests with anyone!', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('Not now, Jatu is a good assistant!', cid)
        
    elseif msgcontains(msg, 'orc place') then
        selfSay('Oh! Want to know where the orc place is? I\'m busy now to show, ask my assistant Jatu, he will show you.', cid)
        
    elseif msgcontains(msg, 'jatu') then
        selfSay('Jatu is my trustworthy assistant. He knows many places around here and can guide travelers.', cid)
        
    elseif msgcontains(msg, 'fruits') then
        selfSay('I have the most exotic fruits from distant lands! Each one has unique flavors you\'ve never tasted before.', cid)
        
    elseif msgcontains(msg, 'exotic') then
        selfSay('These fruits come from the far corners of the world. Some say they have magical properties!', cid)
        
    elseif msgcontains(msg, 'assistant') then
        selfSay('Yes, Jatu has been helping me for years. He\'s very knowledgeable about the surrounding areas.', cid)
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        selfSay('Welcome, ' .. player:getName() .. '! I have the finest exotic fruits in all the land!', cid)
    end
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('Come back anytime for fresh exotic fruits, ' .. player:getName() .. '!', cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())
