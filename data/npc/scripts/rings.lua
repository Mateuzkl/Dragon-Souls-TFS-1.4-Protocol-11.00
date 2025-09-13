local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

-- Ring prices for buying from players
local ringPrices = {
    [3030] = 250,   -- axe ring
    [3031] = 250,   -- club ring
    [2945] = 300,   -- crystal ring
    [3035] = 200,   -- dwarven ring
    [2989] = 1000,  -- energy ring
    [3001] = 1500,  -- golden ring
    [2990] = 100,   -- life ring
    [2986] = 1000,  -- might ring
    [2988] = 500,   -- power ring
    [3036] = 500,   -- ring of healing
    [2944] = 5000,  -- ring of the skies
    [2987] = 500,   -- stealth ring
    [3029] = 250,   -- sword ring
    [2991] = 100,   -- time ring
    [2942] = 200    -- wedding ring
}

function sellRing(cid, itemId, price)
    local player = Player(cid)
    if not player then
        return false
    end
    
    if player:getItemCount(itemId) >= 1 then
        player:removeItem(itemId, 1)
        player:addMoney(price)
        local itemType = ItemType(itemId)
        selfSay('Thank you! Here are your ' .. price .. ' gold coins for the ' .. itemType:getName() .. '.', cid)
        player:getPosition():sendMagicEffect(CONST_ME_SOUND_YELLOW)
        return true
    else
        selfSay('You don\'t have that ring!', cid)
        return false
    end
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    if msgcontains(msg, 'axe ring') then
        sellRing(cid, 3030, 250)
    elseif msgcontains(msg, 'club ring') then
        sellRing(cid, 3031, 250)
    elseif msgcontains(msg, 'crystal ring') then
        sellRing(cid, 2945, 300)
    elseif msgcontains(msg, 'dwarven ring') then
        sellRing(cid, 3035, 200)
    elseif msgcontains(msg, 'energy ring') then
        sellRing(cid, 2989, 1000)
    elseif msgcontains(msg, 'golden ring') then
        sellRing(cid, 3001, 1500)
    elseif msgcontains(msg, 'life ring') then
        sellRing(cid, 2990, 100)
    elseif msgcontains(msg, 'might ring') then
        sellRing(cid, 2986, 1000)
    elseif msgcontains(msg, 'power ring') then
        sellRing(cid, 2988, 500)
    elseif msgcontains(msg, 'ring of healing') then
        sellRing(cid, 3036, 500)
    elseif msgcontains(msg, 'ring of the skies') then
        sellRing(cid, 2944, 5000)
    elseif msgcontains(msg, 'stealth ring') then
        sellRing(cid, 2987, 500)
    elseif msgcontains(msg, 'sword ring') then
        sellRing(cid, 3029, 250)
    elseif msgcontains(msg, 'time ring') then
        sellRing(cid, 2991, 100)
    elseif msgcontains(msg, 'wedding ring') then
        sellRing(cid, 2942, 200)
    elseif msgcontains(msg, 'rings') or msgcontains(msg, 'offer') then
        selfSay('I buy axe (250gp), club (250gp), crystal (300gp), dwarven (200gp), energy (1k), golden (1.5k), life (100gp), might (1k), power (500gp), of healing (500gp), of skies (5k), stealth (500gp), sword (250gp), time (100gp), wedding (200gp).', cid)
    elseif msgcontains(msg, 'job') then
        selfSay('I buy rings of every type. Just tell me which ring you want to sell!', cid)
    elseif msgcontains(msg, 'help') then
        selfSay('Say "rings" to see what I buy, or just tell me the name of the ring you want to sell.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    -- Check if message was in Portuguese or English
    selfSay('Hello ' .. player:getName() .. '! I buy rings of every type.', cid)
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

-- Custom onThink for random movement
function onThink()
    npcHandler:onThink()
    
    -- Random movement when not focused on any player
    if not npcHandler:isFocused() then
        local position = Npc():getPosition()
        local randmove = math.random(1, 20)
        local newPos = Position(position.x, position.y, position.z)
        
        if randmove == 1 then
            newPos.x = newPos.x + 1
        elseif randmove == 2 then
            newPos.x = newPos.x - 1
        elseif randmove == 3 then
            newPos.y = newPos.y + 1
        elseif randmove == 4 then
            newPos.y = newPos.y - 1
        end
        
        -- Only move if it's a different position and valid
        if randmove <= 4 then
            local tile = Tile(newPos)
            if tile and not tile:hasFlag(TILESTATE_BLOCKSOLID) then
                Npc():moveTo(newPos)
            end
        end
    end
end

-- Keywords for bilingual support
keywordHandler:addKeyword({'aneis'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu compro todos os tipos de aneis!'})
keywordHandler:addKeyword({'oferta'}, StdModule.say, {npcHandler = npcHandler, text = 'Diga "rings" para ver os precos dos aneis que compro.'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
