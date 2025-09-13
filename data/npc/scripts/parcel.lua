local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    if msgcontains(msg, 'letter') then
        if player:removeTotalMoney(10) then
            player:addItem(2597, 1)
            selfSay('Here is your letter!', cid)
        else
            selfSay('You do not have enough money!', cid)
        end

    elseif msgcontains(msg, 'parcel') then
        if player:removeTotalMoney(15) then
            player:addItem(2595, 1)
            player:addItem(2599, 1) -- label
            selfSay('Here is your parcel with label!', cid)
        else
            selfSay('You do not have enough money!', cid)
        end

    elseif msgcontains(msg, 'label') then
        player:addItem(2599, 1)
        selfSay('Here is your label!', cid)

    elseif msgcontains(msg, 'offer') or msgcontains(msg, 'trade') then
        selfSay('I sell letters for 10 gold and parcels for 15 gold.', cid)

    elseif msgcontains(msg, 'job') then
        selfSay('I am one of Marine Sisters, we sell parcels and letters in all cities.', cid)

    elseif msgcontains(msg, 'help') then
        selfSay('You can buy letters, parcels and labels from me.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    -- Check language preference or use both
    local msg = string.lower(player:getName())
    if msgcontains(msg, 'oi') then
        selfSay('Ola ' .. player:getName() .. '! Sou uma das Marine Sisters, Estamos vendendo parcels e letters em todas as cidades.', cid)
    else
        selfSay('Hello ' .. player:getName() .. '! I\'m one of Marine Sisters, we selling parcels and letters in all cities.', cid)
    end
    
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
keywordHandler:addKeyword({'carta'}, StdModule.say, {npcHandler = npcHandler, text = 'Cartas custam 10 gold pieces.'})
keywordHandler:addKeyword({'encomenda'}, StdModule.say, {npcHandler = npcHandler, text = 'Encomendas custam 15 gold pieces.'})
keywordHandler:addKeyword({'etiqueta'}, StdModule.say, {npcHandler = npcHandler, text = 'Aqui esta sua etiqueta!'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
