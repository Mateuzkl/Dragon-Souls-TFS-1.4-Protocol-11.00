local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local QUEST_CONFIG = {
    mainStorage = 30002,
    parte2Storage = 31000,
    parte3Storage = 31001,
    mapItemId = 1956,
    flameItemId = 2392
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local addon = player:getStorageValue(QUEST_CONFIG.mainStorage)
    local parte2 = player:getStorageValue(QUEST_CONFIG.parte2Storage)
    local parte3 = player:getStorageValue(QUEST_CONFIG.parte3Storage)
    
    if msgcontains(msg, 'backpack') then
        selfSay('Oh, the backpack wasn\'t so important, but I lost a map inside it, the map was stolen from orcs.', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'job') then
        selfSay('I am a treasure hunter!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('I am not selling or buying anything!', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'quest') or msgcontains(msg, 'mission') then
        selfSay('I don\'t share my quests with anyone!', cid)
        
    elseif msgcontains(msg, 'map') then
        if addon == -1 and npcHandler.topic[cid] == 1 then
            selfSay('It was written in Orchish, I didn\'t translate it all. Oh, I need it back! Find it for me PLEASE!', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "New quest added: 'O segredo de Kar\'ce'.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(QUEST_CONFIG.mainStorage, 1)
            npcHandler.topic[cid] = 0
            
        elseif addon == 1 then
            if player:getItemCount(QUEST_CONFIG.mapItemId) >= 1 then
                selfSay('I can\'t believe it! How did you get it back? Many thanks and.. Oh! I need an assistant, would you be interested?', cid)
                npcHandler.topic[cid] = 3
            else
                selfSay('I need it back! Find it for me PLEASE!', cid)
            end
            
        elseif addon == 2 then
            if parte2 == 2 then
                selfSay('Map? The map is no longer important now, tell me, what is the news?', cid)
                npcHandler.topic[cid] = 5
            elseif parte3 == 1 then
                selfSay('Map? Why do you keep saying map to me? Go find Thordain!', cid)
                npcHandler.topic[cid] = 5
            else
                selfSay('So? I\'m eager to know the news.', cid)
                npcHandler.topic[cid] = 4
            end
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 3 then
        if player:getItemCount(QUEST_CONFIG.mapItemId) >= 1 then
            if addon == 1 then
                player:removeItem(QUEST_CONFIG.mapItemId, 1)
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
                player:setStorageValue(QUEST_CONFIG.mainStorage, 2)
                player:setStorageValue(QUEST_CONFIG.parte2Storage, 1)
                selfSay('Great! Let me see... Here on the map, I don\'t know the exact place but it\'s next to where you found my body, there is a place to dig. Good luck and later bring me news!', cid)
            else
                selfSay('Sorry, you already helped me with this.', cid)
            end
        else
            selfSay('Hey, where is the map? I don\'t see it in your hands.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif (msgcontains(msg, 'news') and npcHandler.topic[cid] == 4) or (msgcontains(msg, 'news') and addon == 2) then
        selfSay('So! What news do you have for me?', cid)
        npcHandler.topic[cid] = 5
        
    elseif npcHandler.topic[cid] == 5 then
        if msgcontains(msg, 'kar') then
            if player:getItemCount(QUEST_CONFIG.flameItemId) >= 1 then
                if parte2 == 2 then
                    selfSay('Wow! I can\'t believe it! That in your hand is The Flame of Kar\'ce?! Oh God, go talk about Kar\'ce with Thordain!', cid)
                    selfSay('Good luck!', cid)
                    player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
                    player:setStorageValue(QUEST_CONFIG.parte3Storage, 1)
                    npcHandler.topic[cid] = 0
                else
                    selfSay('Wow! How do you know that?', cid)
                    npcHandler.topic[cid] = 5
                end
            else
                selfSay('Wow! Really? But you didn\'t find any item?', cid)
                npcHandler.topic[cid] = 5
            end
        else
            selfSay('Hmm... I\'m lost now, how can this help us?', cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'thordain') then
        selfSay('Thordain is a wise old dwarf. He knows much about ancient artifacts and legends.', cid)
        
    elseif msgcontains(msg, 'treasure') then
        selfSay('I\'ve spent years searching for the legendary treasures of Kar\'ce. Some say they\'re just myths, but I believe they exist.', cid)
        
    elseif msgcontains(msg, 'orc') or msgcontains(msg, 'orcs') then
        selfSay('Those damned orcs! They stole my precious map. I hope you can recover it from them.', cid)
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        selfSay('Greetings, ' .. player:getName() .. '! Are you perhaps interested in treasure hunting?', cid)
    end
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('May fortune smile upon your adventures, ' .. player:getName() .. '!', cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())
