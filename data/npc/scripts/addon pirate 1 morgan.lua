local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ADDON_CONFIG = {
    pirateStorage = 40006
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local addon = player:getStorageValue(ADDON_CONFIG.pirateStorage)
    local needPremium = 'Sorry, you need a premium account to get addons.'
    
    if msgcontains(msg, 'job') then
        selfSay('I hunt boats! haha!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('The pirate wisdom is unshareable!', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I used to sell stuff.. but not anymore.', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('No need for buy, we steal!', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('Yeah, yeah... we make lots of quests, but I dont wanna share them...', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('Yeah, yeah... we make lots of missions, but I dont wanna share them...', cid)
        
    elseif msgcontains(msg, 'firebird') and addon == -1 then
        selfSay('Get Lost...', cid)
        
    elseif msgcontains(msg, 'firebird') and addon == 1 then
        selfSay('Get Lost...', cid)
        
    elseif msgcontains(msg, 'firebird') and addon == 3 then
        selfSay('You proved to be loyal, hehe.', cid)
        
    elseif msgcontains(msg, 'firebird') and addon == 2 then
        if player:isPremium() then
            selfSay('Ahh. So Duncan sent you, eh? You must have done something really impressive. Okay, take this fine sabre from me, mate.', cid)
            player:addOutfitAddon(155, 1)
            player:addOutfitAddon(151, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest '(Addon) Pirate Sabre.' completed.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.pirateStorage, 3)
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('So why do you bother me?', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
