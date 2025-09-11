local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ADDON_CONFIG = {
    pirateStorage = 40006,
    eyePatch = 6098,
    pegLeg = 6097,
    hook = 6126,
    itemAmount = 100
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
        
    elseif msgcontains(msg, 'addon') and addon == 2 then
        selfSay('What are you waiting to find Morgan? Dont forget the secret word: firebird!', cid)
        
    elseif msgcontains(msg, 'addon') and addon == 3 then
        selfSay('That looks great haha!', cid)
        
    elseif msgcontains(msg, 'addon') and addon == -1 then
        if player:isPremium() then
            selfSay('Are you up to the task which Im going to give you and willing to prove youre worthy of wearing such a sabre?', cid)
            npcHandler.topic[cid] = 2
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        selfSay('Listen, the task is not that hard. Simply prove that you are loyal by bringing me some pirate stuff. ...', cid)
        selfSay('Bring me 100 eye patchs, 100 peg legs and 100 hooks, all together ...', cid)
        selfSay('Have you understood everything I told you and are willing to handle this task?', cid)
        npcHandler.topic[cid] = 10
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 10 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "New quest added '(Addon) Pirate Sabre.'")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
        player:setStorageValue(ADDON_CONFIG.pirateStorage, 1)
        npcHandler.topic[cid] = 0
        selfSay('Good. Bring me all at once! Just ask me about the Sabre!', cid)
        
    elseif msgcontains(msg, 'sabre') and addon == 1 then
        if player:isPremium() then
            selfSay('Have you gathered 100 eye patches, 100 peg legs and 100 hooks?', cid)
            npcHandler.topic[cid] = 3
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 3 then
        if player:getItemCount(ADDON_CONFIG.eyePatch) >= ADDON_CONFIG.itemAmount and 
           player:getItemCount(ADDON_CONFIG.pegLeg) >= ADDON_CONFIG.itemAmount and 
           player:getItemCount(ADDON_CONFIG.hook) >= ADDON_CONFIG.itemAmount then
            player:removeItem(ADDON_CONFIG.eyePatch, ADDON_CONFIG.itemAmount)
            player:removeItem(ADDON_CONFIG.pegLeg, ADDON_CONFIG.itemAmount)
            player:removeItem(ADDON_CONFIG.hook, ADDON_CONFIG.itemAmount)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.pirateStorage, 2)
            selfSay('I see, I see. Well done. Now find Morgan and tell him this codeword: firebird. Her know what to do...', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('You dont have the itens with you!', cid)
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
