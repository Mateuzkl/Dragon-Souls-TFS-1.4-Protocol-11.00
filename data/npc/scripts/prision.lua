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

    if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
        if player:removeTotalMoney(10000) then
            local key = player:addItem(2091, 1)
            if key then
                key:setActionId(5000)
                selfSay('Here is your prison key!', cid)
            end
        else
            selfSay('You do not have enough money!', cid)
        end

    elseif msgcontains(msg, 'no') or msgcontains(msg, 'nao') then
        selfSay('Ok then... bye!', cid)

    elseif msgcontains(msg, 'key') or msgcontains(msg, 'chave') then
        selfSay('I sell the prison key for 10,000 gold coins. Do you want it?', cid)

    elseif msgcontains(msg, 'job') or msgcontains(msg, 'work') then
        selfSay('I take care of the prison and need an assistant.', cid)

    elseif msgcontains(msg, 'help') or msgcontains(msg, 'ajuda') then
        selfSay('I can sell you a prison key for 10,000 gold coins.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    -- Check if player said "oi" (Portuguese) or "hi" (English)
    local greeting = 'Hello ' .. player:getName() .. '! I take care of the prison, but I need an assistant. I sell the key for only 10k, accepted?'
    selfSay(greeting, cid)
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
keywordHandler:addKeyword({'chave'}, StdModule.say, {npcHandler = npcHandler, text = 'Vendo a chave da prisao por 10.000 gold coins.'})
keywordHandler:addKeyword({'prisao'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu tomo conta da prisao e preciso de um assistente.'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
