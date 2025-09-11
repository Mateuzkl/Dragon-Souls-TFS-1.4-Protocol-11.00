local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ADDON_CONFIG = {
    citizenStorage = 40001,
    citizenTimeStorage = 2224,
    citizenWaitTime = 3600,
    nobleHatStorage = 40004,
    nobleHatTimeStorage = 2224,
    nobleHatPrice = 500000,
    nobleHatWaitTime = 3600,
    nobleCoatStorage = 40005,
    nobleCoatTimeStorage = 2225,
    nobleCoatPrice = 500000,
    nobleCoatWaitTime = 3600,
    postmanStorage = 2078,
    honeycombs = 5902,
    chickenFeathers = 5890,
    legionHelmet = 2480,
    brownCloth = 5913,
    leatherArmor = 2467,
    leatherLegs = 2649,
    postmanUniform = 6114
}

local function checkWaitTime(player, timeStorage, waitTime)
    local lastTime = player:getStorageValue(timeStorage)
    if lastTime == -1 then
        return false
    end
    local currentTime = os.time()
    if (currentTime - lastTime) >= waitTime then
        return true
    end
    return false
end

local function startWaitTime(player, timeStorage)
    player:setStorageValue(timeStorage, os.time())
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local citizenAddon = player:getStorageValue(ADDON_CONFIG.citizenStorage)
    local nobleHat = player:getStorageValue(ADDON_CONFIG.nobleHatStorage)
    local nobleCoat = player:getStorageValue(ADDON_CONFIG.nobleCoatStorage)
    local postman = player:getStorageValue(ADDON_CONFIG.postmanStorage)
    
    local needPremium = 'Sorry, you need a premium account to get addons.'
    local alreadyHave = 'Sorry, you already have this addon.'
    local noItems = 'Sorry, you don\'t have these items.'
    local giveAddon = 'Great job! That must have taken a lot of work. Okay, you put it like this... then glue like this... here!'
    
    if msgcontains(msg, 'job') then
        selfSay('I am an adventurer, I have no home, so I put my step on the road!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('Hmm... Now I don\'t have nothing ready just some things to sell, but... I\'m buying some chicken feathers and honeycombs!', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('Oh! I\'m selling Noble Hats and Noble Coats, and some other things.', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('Oh, I buy chicken feathers and honeycombs!', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('I am not getting involved in quests anymore!', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('I am not getting involved in missions anymore!', cid)
        
    elseif msgcontains(msg, 'knowledge') then
        selfSay('I have been on long trips and quests! One more dangerous than the other, now I am just traveling and wondering the world beauties!', cid)
        
    elseif msgcontains(msg, 'hat') and citizenAddon == -1 then
        selfSay('Pretty, isn\'t it?', cid)
        
    elseif msgcontains(msg, 'addon') and citizenAddon == 1 then
        selfSay('You will love this hat!', cid)
        
    elseif msgcontains(msg, 'hat') and citizenAddon >= 2 then
        selfSay('I do a great job on your hat, hehe.', cid)
        
    elseif msgcontains(msg, 'addon') and citizenAddon >= 2 then
        selfSay('I do a great job on your hat, hehe.', cid)
        
    elseif msgcontains(msg, 'noble hat') and nobleHat == -1 then
        selfSay('Oh, dear nobleman, I can sell a wonderful noble hat for you, the price is 500,000 gps, can I start make your hat?', cid)
        npcHandler.topic[cid] = 20
        
    elseif msgcontains(msg, 'noble hat') and nobleHat == 2 then
        selfSay('I do a great job on your noble hat, hehe.', cid)
        
    elseif msgcontains(msg, 'noble coat') and nobleCoat == -1 then
        selfSay('Oh, dear nobleman, I can sell a wonderful noble coat for you, the price is 500,000 gps, can I start make your coat?', cid)
        npcHandler.topic[cid] = 21
        
    elseif msgcontains(msg, 'noble coat') and nobleCoat == 2 then
        selfSay('I do a great job on your noble coat, hehe.', cid)
        
    elseif msgcontains(msg, 'addon') and citizenAddon == -1 then
        if player:isPremium() then
            selfSay('Pretty, isn\'t it? My friend Arber taught me how to make it, but I could help you with one if you like. What do you say?', cid)
            npcHandler.topic[cid] = 2
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        selfSay('Okay, here we go, listen closely! I need a few things... A basic hat of course, maybe a legion helmet would do. Then about 100 chicken feathers... And 50 honeycombs as glue. That\'s it, come back to me once you gathered it!', cid)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "New quest added '(Addon) Citizen Hat.'")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
        player:setStorageValue(ADDON_CONFIG.citizenStorage, 1)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'hat') and citizenAddon == 1 then
        if player:isPremium() then
            selfSay('Oh, you\'re back already? Did you bring a legion helmet, 100 chicken feathers and 50 honeycombs?', cid)
            npcHandler.topic[cid] = 3
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 3 then
        if player:getItemCount(ADDON_CONFIG.honeycombs) >= 50 and 
           player:getItemCount(ADDON_CONFIG.chickenFeathers) >= 100 and 
           player:getItemCount(ADDON_CONFIG.legionHelmet) >= 1 then
            player:removeItem(ADDON_CONFIG.honeycombs, 50)
            player:removeItem(ADDON_CONFIG.legionHelmet, 1)
            player:removeItem(ADDON_CONFIG.chickenFeathers, 100)
            player:addOutfitAddon(128, 2)
            player:addOutfitAddon(136, 2)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest '(Addon) Citizen Hat.' completed.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.citizenStorage, 2)
            selfSay(giveAddon, cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('You don\'t have the items with you!', cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'uniform') and postman == 4 then
        selfSay('Hmm, new postman? Hehe, yeah I can do it, no problem, I just need you to bring me 1 brown piece of cloth, 1 leather armor and 1 leather legs, when you gather all this, come back here and I will do one cool uniform for you.', cid)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
        player:setStorageValue(ADDON_CONFIG.postmanStorage, 5)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'uniform') and postman == 5 then
        selfSay('Wow you are quickly, already acting like a postman! Well, here we go, did you bring me everything I asked?', cid)
        npcHandler.topic[cid] = 4
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 4 then
        if player:getItemCount(ADDON_CONFIG.brownCloth) >= 1 and 
           player:getItemCount(ADDON_CONFIG.leatherArmor) >= 1 and 
           player:getItemCount(ADDON_CONFIG.leatherLegs) >= 1 then
            player:removeItem(ADDON_CONFIG.brownCloth, 1)
            player:removeItem(ADDON_CONFIG.leatherArmor, 1)
            player:removeItem(ADDON_CONFIG.leatherLegs, 1)
            local uniform = player:addItem(ADDON_CONFIG.postmanUniform, 1)
            if uniform then
                uniform:setSpecialDescription("It's your new uniform.")
                uniform:setActionId(100)
            end
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.postmanStorage, 6)
            selfSay('Great job! That must have taken a lot of work. Okay, you put it like this... then glue like this... here! A new uniform!', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('You don\'t have the items with you!', cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 20 then
        if player:isPremium() then
            if player:removeMoney(ADDON_CONFIG.nobleHatPrice) then
                selfSay('Oh, grateful, will start now! Come back in 1 hour and ask me about your new noble hat!', cid)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "New quest added '(Addon) Nobleman Hat.'")
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
                player:setStorageValue(ADDON_CONFIG.nobleHatStorage, 1)
                startWaitTime(player, ADDON_CONFIG.nobleHatTimeStorage)
                npcHandler.topic[cid] = 0
            else
                selfSay('Sorry, but you don\'t have this money!', cid)
                npcHandler.topic[cid] = 0
            end
        else
            selfSay('Sorry, but only premium players can pay for that!', cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 21 then
        if player:isPremium() then
            if player:removeMoney(ADDON_CONFIG.nobleCoatPrice) then
                selfSay('Oh, grateful, will start now! Come back here in 1 hour and ask me about your new noble coat!', cid)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "New quest added '(Addon) Nobleman Coat.'")
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
                player:setStorageValue(ADDON_CONFIG.nobleCoatStorage, 1)
                startWaitTime(player, ADDON_CONFIG.nobleCoatTimeStorage)
                npcHandler.topic[cid] = 0
            else
                selfSay('Sorry, but you don\'t have this money!', cid)
                npcHandler.topic[cid] = 0
            end
        else
            selfSay('Sorry, but only premium players can pay for that!', cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'noble hat') and nobleHat == 1 then
        if checkWaitTime(player, ADDON_CONFIG.nobleHatTimeStorage, ADDON_CONFIG.nobleHatWaitTime) then
            player:addOutfitAddon(132, 2)
            player:addOutfitAddon(140, 2)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest '(Addon) Nobleman Hat.' completed.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.nobleHatStorage, 2)
            selfSay('It\'s a great job! Here is your new noble hat!', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('The noble hat is not done yet, come back later.', cid)
        end
        
    elseif msgcontains(msg, 'noble coat') and nobleCoat == 1 then
        if checkWaitTime(player, ADDON_CONFIG.nobleCoatTimeStorage, ADDON_CONFIG.nobleCoatWaitTime) then
            player:addOutfitAddon(132, 1)
            player:addOutfitAddon(140, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest '(Addon) Nobleman Coat.' completed.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.nobleCoatStorage, 2)
            selfSay('It\'s a great job! Here is your new noble coat!', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('The noble coat is not done yet, come back later.', cid)
        end
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
