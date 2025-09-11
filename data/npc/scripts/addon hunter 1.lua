local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ADDON_CONFIG = {
    sniperStorage = 40003,
    sniperGloves = 5875
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local addon = player:getStorageValue(ADDON_CONFIG.sniperStorage)
    local needPremium = 'Sorry, you need a premium account to get addons.'
    
    if msgcontains(msg, 'job') then
        selfSay('I am the hunter guild master of this town!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('Hmm... Now I don\'t have nothing ready!', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I don\'t have nothing already done!', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('Nah...', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('I am not getting involved in quests anymore!', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('I am not getting involved in missions anymore!', cid)
        
    elseif msgcontains(msg, 'knowledge') then
        selfSay('I have been on long trips and quests! One more dangerous than the other, now I am just traveling and wondering the world beauties!', cid)
        
    elseif msgcontains(msg, 'addon') then
        selfSay('I won those Sniper Gloves by my bravery!', cid)
        
    elseif msgcontains(msg, 'sniper gloves') and addon == 2 then
        selfSay('You look great using them!', cid)
        
    elseif msgcontains(msg, 'sniper gloves') and addon == -1 then
        if player:isPremium() then
            selfSay('That is an incredible rare item! If you find one, run and tell me, would you?', cid)
            npcHandler.topic[cid] = 1
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
        selfSay('Great! But I don\'t think you will find it in the next two months ha!', cid)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "New quest added '(Addon) Sniper Gloves.'")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
        player:setStorageValue(ADDON_CONFIG.sniperStorage, 1)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'sniper gloves') and addon == 1 then
        if player:isPremium() then
            selfSay('You found sniper gloves?! Incredible! Listen, if you give them to me, I will grant you the right to wear the sniper gloves accessory. How about it?', cid)
            npcHandler.topic[cid] = 2
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        if player:getItemCount(ADDON_CONFIG.sniperGloves) >= 1 then
            player:removeItem(ADDON_CONFIG.sniperGloves, 1)
            player:addOutfitAddon(129, 2)
            player:addOutfitAddon(137, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest '(Addon) Sniper Gloves.' completed.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.sniperStorage, 2)
            selfSay('Great! I hereby grant you the right to wear the sniper gloves as accessory. Congratulations!', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('I knew that it was a lie! Where is it?', cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
