local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local QUEST_CONFIG = {
    maceStorage = 30005,
    maceItemId = 2398,
    clericalMaceId = 2423,
    warHammerId = 2391,
    specialItemId = 9999
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local mace = player:getStorageValue(QUEST_CONFIG.maceStorage)
    
    if msgcontains(msg, 'monster') then
        selfSay('I kill monsters.', cid)
        
    elseif msgcontains(msg, 'job') then
        selfSay('I am a traveler, lost in the wonders of this world!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('The only thing I can offer you is the knowledge of what I have experienced until now!', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('I am not getting involved in quests anymore!', cid)
        
    elseif msgcontains(msg, 'dwarf') then
        selfSay('I am a dwarfcrafter! I can make you a dwarven axe!', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('I am not getting involved in missions anymore!', cid)
        
    elseif msgcontains(msg, 'knowledge') then
        selfSay('I have been on long trips and quests! One more dangerous than the other, now I am just traveling and wondering the world beauties!', cid)
        
    elseif msgcontains(msg, 'mace') then
        if mace == -1 then
            if player:getItemCount(QUEST_CONFIG.maceItemId) >= 1 then
                selfSay('I don\'t believe you have it! Want to trade it for my Clerical Mace?', cid)
                npcHandler.topic[cid] = 3
            else
                selfSay('When I was training on Recruiting island, I lost my mace... It was my father\'s present! It\'s very important for me, but I am already giving up...', cid)
            end
        else
            selfSay('Sorry, you already have received my help.', cid)
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 3 then
        if player:getItemCount(QUEST_CONFIG.maceItemId) >= 1 then
            if mace == 0 then
                selfSay('You don\'t have it!', cid)
            else
                player:setStorageValue(QUEST_CONFIG.maceStorage, 1)
                player:removeItem(QUEST_CONFIG.maceItemId, 1)
                player:addItem(QUEST_CONFIG.clericalMaceId, 1)
                selfSay('Oh my god! A lot of thanks sir! But... would you like to help me in another thing?', cid)
                npcHandler.topic[cid] = 2
            end
        else
            selfSay('Sorry, you don\'t have the required item.', cid)
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        if mace == 1 then
            selfSay('In a Wild Warrior house, located North East from here, they have a locked chest. Use the mace I just gave you to break it, bring me the inside item. I will be waiting.', cid)
            player:setStorageValue(QUEST_CONFIG.maceStorage, 2)
            npcHandler.topic[cid] = 0
        else
            selfSay('Sorry, you already have received my help.', cid)
        end
        
    elseif msgcontains(msg, 'item') then
        if mace == 2 then
            if player:getItemCount(QUEST_CONFIG.clericalMaceId) >= 1 then
                player:setStorageValue(QUEST_CONFIG.maceStorage, 3)
                player:removeItem(QUEST_CONFIG.clericalMaceId, 1)
                player:addItem(QUEST_CONFIG.warHammerId, 1)
                selfSay('I don\'t have words to say thanks! Take this, it\'s yours now!', cid)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "You completed the dwarfcrafter's quest!")
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            else
                selfSay('What?', cid)
            end
        else
            selfSay('Sorry, you already have received my help.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 4 then
        if player:getItemCount(QUEST_CONFIG.specialItemId) >= 1 then
            player:setStorageValue(QUEST_CONFIG.maceStorage, 3)
            player:removeItem(QUEST_CONFIG.specialItemId, 1)
            player:addItem(QUEST_CONFIG.warHammerId, 1)
            selfSay('I don\'t have words to say thanks! Take this, it\'s yours now!', cid)
        else
            selfSay('You don\'t have it!', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        selfSay('Greetings, ' .. player:getName() .. '! I am a traveler and dwarfcrafter.', cid)
    end
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('Safe travels, ' .. player:getName() .. '!', cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())
