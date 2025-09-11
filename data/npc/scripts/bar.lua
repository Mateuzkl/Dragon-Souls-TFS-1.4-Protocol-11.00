local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local TAVERN_CONFIG = {
    questStorage = 5908,
    draconianSteel = 5889,
    obsidianLance = 2425,
    obsidianKnife = 5908,
    meat = 2666,
    vial = 3942
}

local DRINK_PRICES = {
    beer = 20,
    meat = 7,
    wine = 10,
    rum = 50,
    milk = 5
}

local VIAL_CHARGES = {
    beer = 3,
    wine = 15,
    rum = 27,
    milk = 6
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local questProgress = player:getStorageValue(TAVERN_CONFIG.questStorage)
    
    if msgcontains(msg, 'offer') then
        selfSay('Welcome to my Tavern! I got the best malt beer of the region! Flesh meat, pure wine, strong rum, and even milk if you want! What do you wish, my friend?', cid)
        
    elseif msgcontains(msg, 'beer') then
        selfSay('It\'s 20 gps for a malt beer, wanna buy?', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'meat') then
        selfSay('It\'s 7 gps for flesh meat, wanna buy?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'wine') then
        selfSay('It\'s 10 gps for pure wine, wanna buy?', cid)
        npcHandler.topic[cid] = 3
        
    elseif msgcontains(msg, 'rum') then
        selfSay('It\'s 50 gps for a strong rum, wanna buy?', cid)
        npcHandler.topic[cid] = 4
        
    elseif msgcontains(msg, 'milk') then
        selfSay('It\'s 5 gps for your milk, wanna buy?', cid)
        npcHandler.topic[cid] = 5
        
    elseif msgcontains(msg, 'draconian') and questProgress == 3 then
        if player:getItemCount(TAVERN_CONFIG.draconianSteel) >= 1 then
            selfSay('OH MY GOD! Where did you get that? I really need it to make a powerful weapon. Wanna trade it and an Obsidian Lance for a rare item used by doctors and assassins?', cid)
            npcHandler.topic[cid] = 10
        else
            selfSay('How do you know about that?', cid)
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 10 then
        if player:getItemCount(TAVERN_CONFIG.obsidianLance) >= 1 and player:getItemCount(TAVERN_CONFIG.draconianSteel) >= 1 then
            selfSay('I\'m really happy with that, my friend! Here is a rare Obsidian Knife as a gift!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest 'Mais que um favor!' completed.")
            player:removeItem(TAVERN_CONFIG.obsidianLance, 1)
            player:removeItem(TAVERN_CONFIG.draconianSteel, 1)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:addItem(TAVERN_CONFIG.obsidianKnife, 1)
            player:setStorageValue(TAVERN_CONFIG.questStorage, 4)
            npcHandler.topic[cid] = 0
        else
            selfSay('Hmm... I need a piece of draconian steel and one obsidian lance!', cid)
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] >= 1 and npcHandler.topic[cid] <= 5 then
        local topic = npcHandler.topic[cid]
        local items = {'beer', 'meat', 'wine', 'rum', 'milk'}
        local prices = {DRINK_PRICES.beer, DRINK_PRICES.meat, DRINK_PRICES.wine, DRINK_PRICES.rum, DRINK_PRICES.milk}
        
        if player:removeMoney(prices[topic]) then
            selfSay('It\'s here!', cid)
            if topic == 2 then
                player:addItem(TAVERN_CONFIG.meat, 1)
            else
                local charges = {VIAL_CHARGES.beer, 0, VIAL_CHARGES.wine, VIAL_CHARGES.rum, VIAL_CHARGES.milk}
                player:addItem(TAVERN_CONFIG.vial, charges[topic])
            end
        else
            selfSay('Friend, you don\'t have enough money.', cid)
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

local voices = { {text = 'Hicks!'} }
npcHandler:addModule(VoiceModule:new(voices))
