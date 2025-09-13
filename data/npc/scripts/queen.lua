local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

local target = 0
local following = false
local attacking = false

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local msgLower = string.lower(msg)

    -- Check for respectful greetings first (more specific)
    if msgcontains(msgLower, 'hi queen') then
        selfSay('I am so hungry, I need a cook...', cid)
        npcHandler:setFocus(cid)
        
    elseif msgcontains(msgLower, 'oi rainha') then
        selfSay('Estou com tanta fome, preciso de um cozinheiro...', cid)
        npcHandler:setFocus(cid)
        
    -- Regular greetings (less respectful)
    elseif msgcontains(msgLower, 'hi') then
        selfSay('I dont talk to unrespectable people!', cid)
        npcHandler:setFocus(cid)
        
    elseif msgcontains(msgLower, 'oi') then
        selfSay('Quem vc pensa que e para falar assim comigo?!', cid)
        npcHandler:setFocus(cid)

    -- Combat commands (if you want to keep attack functionality)
    elseif msgcontains(msgLower, 'attack') then
        target = cid
        following = true
        attacking = true
        selfSay('You dare challenge me?!', cid)
        -- Note: Actual attack functions require server-side implementation

    elseif msgcontains(msgLower, 'stop') or msgcontains(msgLower, 'peace') then
        attacking = false
        following = false
        target = 0
        selfSay('Fine! I will spare you this time.', cid)

    elseif msgcontains(msgLower, 'follow') then
        following = true
        target = cid
        selfSay('I will follow you.', cid)

    elseif msgcontains(msgLower, 'stay') then
        following = false
        target = 0
        selfSay('Very well, I will stay here.', cid)

    elseif msgcontains(msgLower, 'cook') or msgcontains(msgLower, 'cozinheiro') then
        selfSay('Yes! Can you cook for me? I need food!', cid)

    elseif msgcontains(msgLower, 'food') or msgcontains(msgLower, 'comida') then
        selfSay('Bring me something delicious to eat!', cid)

    elseif msgcontains(msgLower, 'help') or msgcontains(msgLower, 'ajuda') then
        selfSay('Address me with respect if you want my help!', cid)
    end

    return true
end

function onGreet(cid)
    -- Custom greeting handled in creatureSayCallback
    return false
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Farewell, ' .. player:getName() .. '.', cid)
    attacking = false
    following = false
    target = 0
    return true
end

-- Custom onThink for following behavior
function onThink()
    npcHandler:onThink()
    
    if following and target > 0 then
        local player = Player(target)
        if player then
            local playerPos = player:getPosition()
            local npcPos = Npc():getPosition()
            local distance = npcPos:getDistance(playerPos)
            
            -- Follow if too far away
            if distance > 3 then
                local direction = npcPos:getDirectionTo(playerPos)
                if direction < 8 then
                    Npc():move(direction)
                end
            end
            
            -- Attack behavior (requires server-side implementation)
            if attacking and distance <= 1 then
                -- Combat would happen here in a properly configured system
                -- This requires the NPC to be configured as attackable in XML
            end
        else
            -- Player disconnected or doesn't exist
            following = false
            attacking = false
            target = 0
        end
    end
end

-- Handle player disconnection
function onCreatureDisappear(cid, pos)
    if target == cid then
        attacking = false
        following = false
        target = 0
    end
    npcHandler:onCreatureDisappear(cid, pos)
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
