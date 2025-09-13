local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

-- Shop Module for standard items
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Standard items
shopModule:addBuyableItem({'rope'}, 2120, 50, 1, 'rope')
shopModule:addBuyableItem({'shovel'}, 2554, 20, 1, 'shovel')
shopModule:addBuyableItem({'backpack'}, 1988, 10, 1, 'backpack')
shopModule:addBuyableItem({'fishing rod'}, 2580, 100, 1, 'fishing rod')
shopModule:addBuyableItem({'torch'}, 2050, 2, 1, 'torch')
shopModule:addBuyableItem({'aol', 'amulet of loss'}, 2173, 10000, 1, 'amulet of loss')

-- Vials (buy back)
shopModule:addSellableItem({'vial', 'flask'}, 2006, 10, 0, 'vial')

-- Helper function to get count from message
function getCount(msg)
    local count = tonumber(msg:match('%d+'))
    if not count or count < 1 then
        count = 1
    end
    return count
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    if msgcontains(msg, 'manafluid') or msgcontains(msg, 'mana fluid') then
        local count = getCount(msg)
        local totalCost = 100 * count
        
        if player:removeTotalMoney(totalCost) then
            for i = 1, count do
                local vial = player:addItem(2006, 7) -- mana fluid
                if vial then
                    vial:transform(2006, 7) -- ensure it's mana fluid
                end
            end
            selfSay('Here you go.', cid)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            selfSay('Sorry, you do not have enough money.', cid)
        end

    elseif msgcontains(msg, 'lifefluid') or msgcontains(msg, 'life fluid') then
        local count = getCount(msg)
        local totalCost = 60 * count
        
        if player:removeTotalMoney(totalCost) then
            for i = 1, count do
                local vial = player:addItem(2006, 10) -- life fluid
                if vial then
                    vial:transform(2006, 10) -- ensure it's life fluid
                end
            end
            selfSay('Here you go.', cid)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            selfSay('Sorry, you do not have enough money.', cid)
        end

    elseif msgcontains(msg, 'job') then
        selfSay('I am a general goods merchant. I sell useful items and buy back empty vials.', cid)

    elseif msgcontains(msg, 'offer') then
        selfSay('I sell ropes (50gp), shovels (20gp), backpacks (10gp), mana fluids (100gp), life fluids (60gp), fishing rods (100gp), amulet of loss (10k), and torches (2gp). I buy vials (10gp).', cid)

    elseif msgcontains(msg, 'help') then
        selfSay('You can buy items by saying their names, or say "offer" to see all items and prices.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Hello, ' .. player:getName() .. '! I sell ropes (50gp), shovels (20gp), backpacks (10gp), mana fluids (100gp), life fluids (60gp), fishing rods (100gp), amulet of loss (10k), and torches (2gp). I buy vials (10gp).', cid)
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Good bye, ' .. player:getName() .. '!', cid)
    return true
end

-- Keywords for additional functionality
keywordHandler:addKeyword({'fluid'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell mana fluids for 100 gold and life fluids for 60 gold.'})
keywordHandler:addKeyword({'goods'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell all kinds of useful adventuring supplies!'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
