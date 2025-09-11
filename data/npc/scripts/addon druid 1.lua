local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ADDON_CONFIG = {
    druidStorage = 40002,
    postmanStorage = 2078,
    bearPaws = 5896,
    wolfPaws = 5897,
    bearPawsAmount = 50,
    wolfPawsAmount = 50,
    packageItem = 2330,
    packageCap = 500,
    packageMoney = 3
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local druidAddon = player:getStorageValue(ADDON_CONFIG.druidStorage)
    local postman = player:getStorageValue(ADDON_CONFIG.postmanStorage)
    
    local needPremium = 'Sorry, you need a premium account to get addons.'
    local noItems = 'Sorry, you don\'t have these items.'
    
    if msgcontains(msg, 'job') then
        selfSay('I am an adventurer, seeking knowledge!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('Hmm... Now I don\'t have nothing ready, but... come again later!', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I don\'t have nothing already done!', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('Oh, I am not buying anything!', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('I am not getting involved in quests anymore!', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('I am not getting involved in missions anymore!', cid)
        
    elseif msgcontains(msg, 'knowledge') then
        selfSay('I have been on long trips and quests! One more dangerous than the other, now I am studying the druid necromant powers!', cid)
        
    elseif msgcontains(msg, 'paws') and druidAddon == -1 then
        selfSay('What about it?', cid)
        
    elseif msgcontains(msg, 'addon') and druidAddon == 1 then
        selfSay('You will love this paws!', cid)
        
    elseif msgcontains(msg, 'paws') and druidAddon >= 2 then
        selfSay('I have done a great job on yours. Hehe.', cid)
        
    elseif msgcontains(msg, 'addon') and druidAddon >= 2 then
        selfSay('I have done a great job on yours. Hehe.', cid)
        
    elseif msgcontains(msg, 'addon') and druidAddon == -1 then
        if player:isPremium() then
            selfSay('Would you like to wear bear paws like I do?', cid)
            npcHandler.topic[cid] = 2
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        selfSay('No problem, just bring me 50 bear paws and 50 wolf paws and I\'ll fit them on.', cid)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "New quest added '(Addon) Druid Bear Paws.'")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
        player:setStorageValue(ADDON_CONFIG.druidStorage, 1)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'paws') and druidAddon == 1 then
        if player:isPremium() then
            selfSay('Have you brought 50 bear paws and 50 wolf paws?', cid)
            npcHandler.topic[cid] = 3
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 3 then
        if player:getItemCount(ADDON_CONFIG.bearPaws) >= ADDON_CONFIG.bearPawsAmount and 
           player:getItemCount(ADDON_CONFIG.wolfPaws) >= ADDON_CONFIG.wolfPawsAmount then
            player:removeItem(ADDON_CONFIG.bearPaws, ADDON_CONFIG.bearPawsAmount)
            player:removeItem(ADDON_CONFIG.wolfPaws, ADDON_CONFIG.wolfPawsAmount)
            player:addOutfitAddon(148, 1)
            player:addOutfitAddon(144, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest '(Addon) Druid Bear Paws.' completed.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.druidStorage, 2)
            selfSay('Excellent! Like promised, here are your bear paws.', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('You don\'t have the items with you!', cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'delivery') and postman == 8 then
        if player:getFreeCapacity() >= ADDON_CONFIG.packageCap then
            selfSay('Oh, you are late mrs. postman, I have an urgent delivery, I need you to take this stuff and give to Moriar, I think he may be in Caradhras, say about a delivery to him! Thanks and Fast! Here it\'s for you buy a beer!', cid)
            player:addItem(2152, ADDON_CONFIG.packageMoney)
            local package = player:addItem(ADDON_CONFIG.packageItem, 1)
            if package then
                package:setSpecialDescription("It's your delivery.")
                package:setActionId(100)
            end
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.postmanStorage, 9)
        else
            selfSay('Oh, you are late mrs. postman, I have an urgent delivery, but I think you are out of capacity, you need 500 cap for this delivery!', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
