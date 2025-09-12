local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end

-- Movement configuration
local lastMoveTime = 0
local homePosition = nil

function onThink()
    npcHandler:onThink()
    
    -- Set home position on first run
    if not homePosition then
        local npc = Npc()
        if npc then
            homePosition = npc:getPosition()
        end
    end
    
    -- Random movement when not focused
    if not npcHandler:isFocused() then
        local currentTime = os.time()
        if currentTime - lastMoveTime > 3 then -- Move every 3 seconds
            lastMoveTime = currentTime
            local npc = Npc()
            if npc and homePosition then
                local pos = npc:getPosition()
                local newPos = Position(pos.x, pos.y, pos.z)
                local randmove = math.random(1, 20)
                
                if randmove == 1 then
                    newPos.x = pos.x + 1
                elseif randmove == 2 then
                    newPos.x = pos.x - 1
                elseif randmove == 3 then
                    newPos.y = pos.y + 1
                elseif randmove == 4 then
                    newPos.y = pos.y - 1
                -- randmove >= 5 stays in same position
                end
                
                -- Check if new position is valid and within range
                if math.abs(newPos.x - homePosition.x) <= 3 and math.abs(newPos.y - homePosition.y) <= 3 then
                    local tile = Tile(newPos)
                    if tile and not tile:hasProperty(CONST_PROP_BLOCKINGANDNOTMOVEABLE) then
                        npc:teleportTo(newPos)
                    end
                end
            end
        end
    end
end

-- Shop Module setup
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Jewelry items for sale
shopModule:addSellableItem({'amethyst'}, 2971, 200, 'amethyst')
shopModule:addSellableItem({'diamond'}, 2966, 300, 'diamond')
shopModule:addSellableItem({'emerald'}, 2970, 250, 'emerald')
shopModule:addSellableItem({'ruby'}, 2968, 350, 'ruby')
shopModule:addSellableItem({'sapphire'}, 2967, 400, 'sapphire')
shopModule:addSellableItem({'white pearl'}, 2964, 160, 'white pearl')
shopModule:addSellableItem({'black pearl'}, 2965, 280, 'black pearl')
shopModule:addSellableItem({'blue gem'}, 2979, 20000, 'blue gem')
shopModule:addSellableItem({'yellow gem'}, 2975, 10000, 'yellow gem')
shopModule:addSellableItem({'violet gem'}, 2974, 18000, 'violet gem')
shopModule:addSellableItem({'gold nugget'}, 2978, 30000, 'gold nugget')
shopModule:addSellableItem({'silver brooch'}, 2955, 15000, 'silver brooch')
shopModule:addSellableItem({'brooch'}, 2948, 25000, 'brooch')
shopModule:addSellableItem({'crown'}, 2949, 40000, 'crown')
shopModule:addSellableItem({'big emerald', 'big esmerald'}, 2976, 22000, 'big emerald')
shopModule:addSellableItem({'big ruby'}, 2977, 23000, 'big ruby')
shopModule:addSellableItem({'scarab coin'}, 2980, 100, 'scarab coin')
shopModule:addSellableItem({'talon'}, 2972, 2000, 'talon')
shopModule:addSellableItem({'life crystal'}, 2999, 5000, 'life crystal')
shopModule:addSellableItem({'mind stone'}, 3000, 6000, 'mind stone')
shopModule:addSellableItem({'horn'}, 3041, 2000, 'horn')

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('Hello ' .. player:getName() .. '! I selling fantastic julery.', cid)
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    npcHandler:say('Goodbye, ' .. player:getName() .. '!', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    -- Handle manual selling commands for compatibility
    if msgcontains(msg, 'amethyst') then
        local count = player:getItemCount(2971)
        if count > 0 then
            if player:removeItem(2971, count) then
                player:addMoney(200 * count)
                npcHandler:say('I bought ' .. count .. ' amethyst for ' .. (200 * count) .. ' gold coins.', cid)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "You sold " .. count .. " amethyst.")
            end
        else
            npcHandler:say('You don\'t have any amethyst to sell.', cid)
        end
    elseif msgcontains(msg, 'offer') then
        npcHandler:say('I can buy all gems, pearls, horn and many more cool julery from you. Just say the name of the item you want to sell!', cid)
    elseif msgcontains(msg, 'tchau') then
        npcHandler:say('Tchau então.', cid)
        npcHandler:releaseFocus(cid)
    end
    
    return true
end

-- Keywords for automatic responses
keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I can buy all gems, pearls, horn and many more cool julery from you. Just say the name of the item!'
})

keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I am a jewelry trader! I buy precious gems and valuable items.'
})

keywordHandler:addKeyword({'gems'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I buy amethyst, diamond, emerald, ruby, sapphire and many other precious gems!'
})

keywordHandler:addKeyword({'pearls'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I buy both white pearls and black pearls at good prices!'
})

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I selling fantastic julery.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Goodbye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Not now, |PLAYERNAME|! I will talk with you for moment.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
