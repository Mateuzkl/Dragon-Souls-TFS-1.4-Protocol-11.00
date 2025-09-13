local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

-- Shop Module for runes
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Attack Runes
shopModule:addBuyableItem({'light magic missile'}, 2287, 200, 1, 'light magic missile rune')
shopModule:addBuyableItem({'heavy magic missile'}, 2311, 600, 1, 'heavy magic missile rune')
shopModule:addBuyableItem({'fireball'}, 2302, 800, 1, 'fireball rune')
shopModule:addBuyableItem({'great fireball'}, 2304, 1200, 1, 'great fireball rune')
shopModule:addBuyableItem({'explosion'}, 2313, 1800, 1, 'explosion rune')
shopModule:addBuyableItem({'sudden death'}, 2268, 3000, 1, 'sudden death rune')
shopModule:addBuyableItem({'soul fire'}, 2308, 1800, 1, 'soulfire rune')

-- Field Runes
shopModule:addBuyableItem({'poison field'}, 2285, 300, 1, 'poison field rune')
shopModule:addBuyableItem({'fire field'}, 2301, 500, 1, 'fire field rune')
shopModule:addBuyableItem({'energy field'}, 2277, 700, 1, 'energy field rune')

-- Wall Runes
shopModule:addBuyableItem({'poison wall'}, 2289, 1600, 1, 'poison wall rune')
shopModule:addBuyableItem({'fire wall'}, 2303, 2000, 1, 'fire wall rune')
shopModule:addBuyableItem({'energy wall'}, 2279, 2500, 1, 'energy wall rune')
shopModule:addBuyableItem({'magic wall'}, 2293, 2100, 1, 'magic wall rune')

-- Bomb Runes
shopModule:addBuyableItem({'poison bomb'}, 2286, 1000, 1, 'poison bomb rune')
shopModule:addBuyableItem({'fire bomb'}, 2305, 1500, 1, 'fire bomb rune')
shopModule:addBuyableItem({'energy bomb'}, 2262, 2300, 1, 'energy bomb rune')

-- Healing Runes
shopModule:addBuyableItem({'intense healing rune'}, 2265, 600, 1, 'intense healing rune')
shopModule:addBuyableItem({'ultimate healing rune'}, 2273, 1500, 1, 'ultimate healing rune')

-- Support Runes
shopModule:addBuyableItem({'antidote rune'}, 2266, 600, 1, 'antidote rune')
shopModule:addBuyableItem({'destroy field'}, 2261, 350, 1, 'destroy field rune')
shopModule:addBuyableItem({'animate dead'}, 2316, 1200, 1, 'animate dead rune')
shopModule:addBuyableItem({'convince creature'}, 2290, 1300, 1, 'convince creature rune')
shopModule:addBuyableItem({'chameleon'}, 2291, 1800, 1, 'chameleon rune')
shopModule:addBuyableItem({'desintegrate'}, 2310, 900, 1, 'desintegrate rune')
shopModule:addBuyableItem({'paralyze'}, 2278, 19000, 1, 'paralyze rune')
shopModule:addBuyableItem({'envenenom'}, 2292, 1000, 1, 'envenom rune')

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    if msgcontains(msg, 'job') then
        selfSay('I am a rune merchant! I sell all kinds of runes for mages and sorcerers.', cid)
    elseif msgcontains(msg, 'offer') or msgcontains(msg, 'runes') then
        selfSay('I sell all runes! Attack runes, field runes, wall runes, bomb runes, healing runes and support runes. Just say the name of the rune you want!', cid)
    elseif msgcontains(msg, 'attack') then
        selfSay('I sell light magic missile (200gp), heavy magic missile (600gp), fireball (800gp), great fireball (1200gp), explosion (1800gp), soul fire (1800gp) and sudden death (3000gp).', cid)
    elseif msgcontains(msg, 'field') then
        selfSay('I have poison field (300gp), fire field (500gp) and energy field (700gp).', cid)
    elseif msgcontains(msg, 'wall') then
        selfSay('I sell poison wall (1600gp), fire wall (2000gp), energy wall (2500gp) and magic wall (2100gp).', cid)
    elseif msgcontains(msg, 'bomb') then
        selfSay('I have poison bomb (1000gp), fire bomb (1500gp) and energy bomb (2300gp).', cid)
    elseif msgcontains(msg, 'healing') then
        selfSay('I sell intense healing rune (600gp) and ultimate healing rune (1500gp).', cid)
    elseif msgcontains(msg, 'support') then
        selfSay('I have antidote rune (600gp), destroy field (350gp), animate dead (1200gp), convince creature (1300gp), chameleon (1800gp), desintegrate (900gp), paralyze (19000gp) and envenom (1000gp).', cid)
    elseif msgcontains(msg, 'help') then
        selfSay('I sell all types of runes! Say "offer" to see categories or just tell me the name of the rune you want to buy.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    -- Check if greeting was in Portuguese or English
    selfSay('Hello ' .. player:getName() .. '! I sell all runes, just say their names.', cid)
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Goodbye, ' .. player:getName() .. '!', cid)
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
keywordHandler:addKeyword({'runas'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu vendo todas as runas! Basta dizer o nome da runa que deseja.'})
keywordHandler:addKeyword({'oferta'}, StdModule.say, {npcHandler = npcHandler, text = 'Vendo runas de ataque, campo, parede, bomba, cura e suporte!'})
keywordHandler:addKeyword({'trabalho'}, StdModule.say, {npcHandler = npcHandler, text = 'Sou um comerciante de runas!'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
