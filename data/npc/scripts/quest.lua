local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

-- Shop Module for basic items
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Shop items
shopModule:addBuyableItem({'rope'}, 2120, 50, 1, 'rope')
shopModule:addBuyableItem({'shovel'}, 2554, 10, 1, 'shovel')  
shopModule:addBuyableItem({'torch'}, 2050, 2, 1, 'torch')
shopModule:addBuyableItem({'machete'}, 2420, 30, 1, 'machete')
shopModule:addBuyableItem({'scythe'}, 2550, 30, 1, 'scythe')
shopModule:addBuyableItem({'pick'}, 2553, 20, 1, 'pick')

-- Quest and trading functions
function processQuest(cid, message, keywords, parameters, node)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local storageValue = player:getStorageValue(parameters.questid)
    
    if storageValue == -1 then
        selfSay('If you need an essential item for addon, please bring me 15 chicken feathers.', cid)
        player:setStorageValue(parameters.questid, 1)
        return true
    elseif storageValue == 1 then
        if player:getItemCount(5890) >= 15 then
            selfSay('I see that you have found the feathers, take this.', cid)
            player:removeItem(5890, 15)
            local item = player:addItem(2366, 1)
            if item then
                item:setActionId(1000)
            end
            player:setStorageValue(parameters.questid, 2)
        else
            selfSay('I guess you are too busy to find what I need...', cid)
        end
    elseif storageValue == 2 then
        selfSay('You already have done my mission.', cid)
    end
    
    return true
end

function itemForItem(cid, message, keywords, parameters, node)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if player:getItemCount(parameters.itemtrade) >= parameters.counti then
        player:removeItem(parameters.itemtrade, parameters.counti)
        player:addItem(parameters.itemtrade2, parameters.counti2)
        selfSay('Thanks, take this.', cid)
    else
        selfSay('You dont have such item.', cid)
    end
    
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'quest') then
        local storageValue = player:getStorageValue(1000)
        
        if storageValue == -1 then
            selfSay('If you need an essential item for addon, please bring me 15 chicken feathers.', cid)
            player:setStorageValue(1000, 1)
        elseif storageValue == 1 then
            if player:getItemCount(5890) >= 15 then
                selfSay('I see that you have found the feathers, take this.', cid)
                player:removeItem(5890, 15)
                local item = player:addItem(2366, 1)
                if item then
                    item:setActionId(1000)
                end
                player:setStorageValue(1000, 2)
            else
                selfSay('I guess you are too busy to find what I need...', cid)
            end
        elseif storageValue == 2 then
            selfSay('You already have done my mission.', cid)
        end
        
    elseif msgcontains(msg, 'trade pick') then
        if player:getItemCount(2553) >= 1 then
            player:removeItem(2553, 1)
            player:addItem(5890, 15)
            selfSay('Thanks, take these feathers.', cid)
        else
            selfSay('You dont have a pick to trade.', cid)
        end
        
    elseif msgcontains(msg, 'job') then
        selfSay('I sell all kinds of tools.', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('I sell ropes, shovels, torches, picks, machetes and scythes.', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('I cannot help you in that area, son.', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('Why would I need that rubbish?', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('Just tell me what you want to buy.', cid)
    end
    
    return true
end

-- Keywords for additional responses
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I sell ropes, shovels, torches, picks, machetes and scythes.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I sell all kinds of tools.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I cannot help you in that area, son.'})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
