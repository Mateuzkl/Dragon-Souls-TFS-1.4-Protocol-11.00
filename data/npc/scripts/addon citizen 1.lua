local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ADDON_CONFIG = {
    storage = 40000,
    timeStorage = 7000,
    waitTime = 3600,
    leatherItemId = 5878,
    leatherAmount = 100,
    addonOutfitMale = 128,
    addonOutfitFemale = 136
}

local function checkWaitTime(player, timeStorage, waitTime)
    local lastTime = player:getStorageValue(timeStorage)
    if lastTime == -1 then
        player:setStorageValue(timeStorage, os.time())
        return false
    end
    
    local currentTime = os.time()
    if (currentTime - lastTime) >= waitTime then
        return true 
    end
    
    return false 
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local addonProgress = player:getStorageValue(ADDON_CONFIG.storage)
    
    local needPremium = 'Sorry, you need a premium account to get addons.'
    local alreadyHave = 'Sorry, you already have this addon.'
    local noItems = 'Sorry, you don\'t have these items.'
    local giveAddon = 'Just in time! Your backpack is finished. Here you go, I hope you like it.'
    
    if msgcontains(msg, 'job') then
        selfSay('I am a traveler, lost in the wonders of this world!', cid)
        
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
        
    elseif msgcontains(msg, 'addon') and addonProgress == 1 then
        selfSay('You will like this backpack, I promise!', cid)
        
    elseif msgcontains(msg, 'backpack') and addonProgress == -1 then
        selfSay('Pretty, isn\'t it?!', cid)
        
    elseif msgcontains(msg, 'backpack') and addonProgress == 2 then
        selfSay('You will like your new addon!', cid)
        
    elseif msgcontains(msg, 'addon') and addonProgress == 3 then
        selfSay('Sorry, I can\'t give another one to you.', cid)
        
    elseif msgcontains(msg, 'backpack') and addonProgress == 3 then
        selfSay('Hmm... Any problem with your backpack?', cid)
        
    elseif msgcontains(msg, 'addon') and addonProgress == -1 then
        if player:isPremium() then
            selfSay('Sorry, this backpack is not for sale, it\'s handmade from rare minotaur leather.', cid)
            npcHandler.topic[cid] = 1
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'minotaur leather') and addonProgress == -1 and npcHandler.topic[cid] == 1 then
        selfSay('Well, if you really like this backpack, I could make one for you, but minotaur leather is hard to come by these days. Are you willing to put some work into this?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        selfSay('Alright then, if you bring me 100 pieces of fine minotaur leather I will see what I can do for you. You probably have to kill really many minotaurs though... So good luck!', cid)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "New quest added '(Addon) Citizen Backpack.'")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
        player:setStorageValue(ADDON_CONFIG.storage, 1)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'backpack') and addonProgress == 1 then
        if player:isPremium() then
            selfSay('Ah, right, almost forgot about the backpack! Have you brought me 100 pieces of minotaur leather as requested?', cid)
            npcHandler.topic[cid] = 3
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 3 then
        if player:getItemCount(ADDON_CONFIG.leatherItemId) >= ADDON_CONFIG.leatherAmount then
            selfSay('Great! Alright, I need a while, maybe 1 hour to finish this backpack for you. Come ask me later, okay?', cid)
            player:removeItem(ADDON_CONFIG.leatherItemId, ADDON_CONFIG.leatherAmount)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.storage, 2)
            player:setStorageValue(ADDON_CONFIG.timeStorage, os.time())
            npcHandler.topic[cid] = 0
        else
            selfSay(noItems, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'addon') and addonProgress == 2 then
        if checkWaitTime(player, ADDON_CONFIG.timeStorage, ADDON_CONFIG.waitTime) then
            selfSay(giveAddon, cid)
            player:addOutfitAddon(ADDON_CONFIG.addonOutfitMale, 1)
            player:addOutfitAddon(ADDON_CONFIG.addonOutfitFemale, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest '(Addon) Citizen Backpack.' completed.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.storage, 3)
        else
            selfSay('The backpack is not done yet, come back later.', cid)
        end
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
