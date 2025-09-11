local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ADDON_CONFIG = {
    addonStorage = 10002,
    honeycombsItem = 5902,
    honeycombsAmount = 50,
    chickenFeathersItem = 5890,
    chickenFeathersAmount = 100,
    legionHelmetItem = 2480,
    maleOutfit = 128,
    femaleOutfit = 136
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local addon = player:getStorageValue(ADDON_CONFIG.addonStorage)
    
    local needPremium = 'Sorry, you need a premium account to get addons.'
    local alreadyHave = 'Sorry, you already have this addon.'
    local notEnoughItems = 'Sorry, you don\'t have these items.'
    local addonComplete = 'Great job! That must have taken a lot of work. Okay, you put it like this... then glue like this... here!'
    
    if msgcontains(msg, 'addon') then
        selfSay('Pretty, isn\'t it? I love wearing this outfit!', cid)
        
    elseif msgcontains(msg, 'job') then
        selfSay('I am an adventurer, I have no home, so I put my step on the road!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('The only thing I can offer you is the knowledge of what I have experienced until now!', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('I am not getting involved in quests anymore!', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('I am not getting involved in missions anymore!', cid)
        
    elseif msgcontains(msg, 'knowledge') then
        selfSay('I have been on long trips and quests! One more dangerous than the other, now I am just traveling and wondering the world beauties!', cid)
        
    elseif msgcontains(msg, 'outfit') then
        if player:isPremium() then
            if player:getItemCount(ADDON_CONFIG.honeycombsItem) >= ADDON_CONFIG.honeycombsAmount then
                selfSay('Oh, you\'re back already? Did you bring a legion helmet, 100 chicken feathers and 50 honeycombs?', cid)
                npcHandler.topic[cid] = 3
            else
                selfSay('Pretty, isn\'t it? My friend Amber taught me how to make it, but I could help you with one if you like. What do you say?', cid)
                npcHandler.topic[cid] = 2
            end
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        if addon == -1 then
            selfSay('Okay, here we go, listen closely! I need a few things... a basic hat of course, maybe a legion helmet would do. Then about 100 chicken feathers... and 50 honeycombs as glue. That\'s it, come back to me once you gathered it!', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay(alreadyHave, cid)
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 3 then
        if player:getItemCount(ADDON_CONFIG.honeycombsItem) >= ADDON_CONFIG.honeycombsAmount and
           player:getItemCount(ADDON_CONFIG.chickenFeathersItem) >= ADDON_CONFIG.chickenFeathersAmount and
           player:getItemCount(ADDON_CONFIG.legionHelmetItem) >= 1 then
            if addon == -1 then
                player:removeItem(ADDON_CONFIG.honeycombsItem, ADDON_CONFIG.honeycombsAmount)
                player:removeItem(ADDON_CONFIG.chickenFeathersItem, ADDON_CONFIG.chickenFeathersAmount)
                player:removeItem(ADDON_CONFIG.legionHelmetItem, 1)
                player:setStorageValue(ADDON_CONFIG.addonStorage, 1)
                selfSay('Great! Alright, come back and ask for your hat anytime!', cid)
                npcHandler.topic[cid] = 0
            else
                selfSay(alreadyHave, cid)
            end
        else
            selfSay(notEnoughItems, cid)
        end
        
    elseif msgcontains(msg, 'hat') then
        if addon == 1 then
            selfSay(addonComplete, cid)
            player:addOutfitAddon(ADDON_CONFIG.maleOutfit, 2)
            player:addOutfitAddon(ADDON_CONFIG.femaleOutfit, 2)
            player:setStorageValue(ADDON_CONFIG.addonStorage, 2)
        else
            selfSay('Pretty, isn\'t it?', cid)
        end
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
