local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end

-- Movement area configuration
local ox = 145
local oy = 51  
local oz = 6
local max = 5

local lastRandomMove = 0

function onThink()
    npcHandler:onThink()
    
    -- Random movement when not focused
    if not npcHandler:isFocused() then
        local currentTime = os.time()
        if currentTime - lastRandomMove > 3 then -- Move every 3 seconds
            lastRandomMove = currentTime
            local npc = Npc()
            if npc then
                local pos = npc:getPosition()
                local randmove = math.random(1, 20)
                local newPos = Position(pos.x, pos.y, pos.z)
                
                if randmove == 1 then
                    newPos.x = pos.x + 1
                elseif randmove == 2 then
                    newPos.x = pos.x - 1
                elseif randmove == 3 then
                    newPos.y = pos.y + 1
                elseif randmove == 4 then
                    newPos.y = pos.y - 1
                end
                
                -- Check if new position is within allowed area
                if math.abs(newPos.x - ox) <= max and math.abs(newPos.y - oy) <= max then
                    local tile = Tile(newPos)
                    if tile and not tile:hasProperty(CONST_PROP_BLOCKINGANDNOTMOVEABLE) then
                        npc:teleportTo(newPos)
                    end
                end
            end
        end
    end
end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Shop items
shopModule:addBuyableItem({'beer'}, 2006, 10, 3, 'beer') -- beer with 3 charges
shopModule:addBuyableItem({'wine'}, 2006, 10, 15, 'wine') -- wine with 15 charges

local function greetCallback(cid)
    local player = Player(cid)
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        local player = Player(cid)
        if not player then
            return false
        end
        
        if msgcontains(msg, 'hi') then
            npcHandler:say('Hello, ' .. player:getName() .. '! I sell beer and wine for 10 gp.', cid)
            return true
        elseif msgcontains(msg, 'oi') then
            npcHandler:say('Ola, ' .. player:getName() .. '! Vendo beer e wine por 10gp.', cid)
            return true
        end
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'buy beer') then
        if player:removeMoney(10) then
            player:addItem(2006, 1):setAttribute(ITEM_ATTRIBUTE_FLUIDTYPE, 3) -- beer fluid
            npcHandler:say('Here is your beer!', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You bought a beer.")
        else
            npcHandler:say('You don\'t have enough money.', cid)
        end
        
    elseif msgcontains(msg, 'buy wine') then
        if player:removeMoney(10) then
            player:addItem(2006, 1):setAttribute(ITEM_ATTRIBUTE_FLUIDTYPE, 15) -- wine fluid
            npcHandler:say('Here is your wine!', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You bought a wine.")
        else
            npcHandler:say('You don\'t have enough money.', cid)
        end
        
    elseif msgcontains(msg, 'quest') then
        npcHandler:say('Explore Dungeon Caves on carlin a tired old man told me anything about a great teasure and many quests on this city', cid)
        
    elseif msgcontains(msg, 'tchau') then
        npcHandler:say('Adeus, ' .. player:getName() .. '!', cid)
        npcHandler:releaseFocus(cid)
    end
    
    return true
end

-- Keywords for automatic responses
keywordHandler:addKeyword({'quest'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Explore Dungeon Caves on carlin a tired old man told me anything about a great teasure and many quests on this city'
})

keywordHandler:addKeyword({'beer'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I sell fresh beer for 10 gold pieces. Just say "buy beer" if you want one!'
})

keywordHandler:addKeyword({'wine'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I sell good wine for 10 gold pieces. Just say "buy wine" if you want one!'
})

keywordHandler:addKeyword({'offer', 'trade'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I sell beer and wine, both for 10 gold pieces each.'
})

-- Greet messages
npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I sell beer and wine for 10 gp.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Leave us alone, |PLAYERNAME|!')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
