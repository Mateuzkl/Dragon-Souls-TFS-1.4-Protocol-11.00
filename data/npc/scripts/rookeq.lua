local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

-- Shop Module for equipment
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Weapons
shopModule:addBuyableItem({'katana'}, 2412, 20, 1, 'katana')
shopModule:addBuyableItem({'mace'}, 2398, 20, 1, 'mace')  
shopModule:addBuyableItem({'hatchet'}, 2388, 20, 1, 'hatchet')

-- Armor
shopModule:addBuyableItem({'studded armor'}, 2484, 30, 1, 'studded armor')
shopModule:addBuyableItem({'chain armor'}, 2464, 90, 1, 'chain armor')
shopModule:addBuyableItem({'brass armor'}, 2465, 300, 1, 'brass armor')

-- Helmets
shopModule:addBuyableItem({'brass helmet'}, 2460, 20, 1, 'brass helmet')
shopModule:addBuyableItem({'leather helmet'}, 2461, 5, 1, 'leather helmet')

-- Shields
shopModule:addBuyableItem({'brass shield'}, 2511, 15, 1, 'brass shield')
shopModule:addBuyableItem({'copper shield'}, 2530, 50, 1, 'copper shield')

-- Legs
shopModule:addBuyableItem({'leather legs'}, 2649, 8, 1, 'leather legs')
shopModule:addBuyableItem({'studded legs'}, 2468, 20, 1, 'studded legs')

-- Boots
shopModule:addBuyableItem({'leather boots'}, 2643, 5, 1, 'leather boots')

-- Other
shopModule:addBuyableItem({'torch'}, 2050, 2, 1, 'torch')

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    if msgcontains(msg, 'job') then
        selfSay('I am a merchant! I sell basic equipment for new adventurers.', cid)
    elseif msgcontains(msg, 'offer') or msgcontains(msg, 'trade') then
        selfSay('I sell weapons, armor, helmets, shields, legs, boots and torches. Just tell me what you want to buy!', cid)
    elseif msgcontains(msg, 'weapon') then
        selfSay('I have katana (20gp), mace (20gp) and hatchet (20gp).', cid)
    elseif msgcontains(msg, 'armor') then
        selfSay('I sell studded armor (30gp), chain armor (90gp) and brass armor (300gp).', cid)
    elseif msgcontains(msg, 'helmet') then
        selfSay('I have leather helmet (5gp) and brass helmet (20gp).', cid)
    elseif msgcontains(msg, 'shield') then
        selfSay('I sell brass shield (15gp) and copper shield (50gp).', cid)
    elseif msgcontains(msg, 'legs') then
        selfSay('I have leather legs (8gp) and studded legs (20gp).', cid)
    elseif msgcontains(msg, 'boots') then
        selfSay('I sell leather boots for 5gp.', cid)
    elseif msgcontains(msg, 'help') then
        selfSay('I sell basic equipment. Say "offer" to see all items or ask about specific categories like "weapon", "armor", etc.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Hello, ' .. player:getName() .. '! I sell Katana(20gp), Mace(20gp), Hatchet(20gp), Studded Armor(30gp), Chain Armor(90gp), Brass Armor(300gp), Brass Helmet(20gp), Leather Helmet(5gp), Brass Shield(15gp), Copper Shield(50gp), Leather Legs(8gp), Studded Legs(20gp), Leather Boots(5gp), Torch(2gp).', cid)
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

-- Keywords for equipment categories
keywordHandler:addKeyword({'equipment'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell basic equipment for adventurers!'})
keywordHandler:addKeyword({'price'}, StdModule.say, {npcHandler = npcHandler, text = 'Ask me about specific items to know their prices.'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
