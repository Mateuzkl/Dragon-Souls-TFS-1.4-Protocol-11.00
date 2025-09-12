local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end

-- Home position for NPC movement
local homePosition = Position(323, 289, 7)
local lastMoveTime = 0
local lastWorkTime = 0

function onThink()
    npcHandler:onThink()
    
    -- Movement when not focused
    if not npcHandler:isFocused() then
        local currentTime = os.time()
        if currentTime - lastMoveTime > 5 then -- Move every 5 seconds
            lastMoveTime = currentTime
            local npc = Npc()
            if npc then
                -- Random movement around home position
                local pos = npc:getPosition()
                local newPos = Position(pos.x, pos.y, pos.z)
                local moveDirection = math.random(1, 5)
                
                if moveDirection == 1 then
                    newPos.x = newPos.x + 1
                elseif moveDirection == 2 then
                    newPos.x = newPos.x - 1
                elseif moveDirection == 3 then
                    newPos.y = newPos.y + 1
                elseif moveDirection == 4 then
                    newPos.y = newPos.y - 1
                else
                    -- Sometimes return to home position
                    newPos = homePosition
                end
                
                -- Check if new position is valid
                local tile = Tile(newPos)
                if tile and not tile:hasProperty(CONST_PROP_BLOCKINGANDNOTMOVEABLE) then
                    npc:teleportTo(newPos)
                end
            end
        end
    else
        -- Check for timeout (16 seconds)
        local currentTime = os.time()
        if currentTime - lastWorkTime > 16 then
            npcHandler:say('Now i need work!')
            npcHandler:releaseFocus()
        end
    end
end

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('Hey there! ' .. player:getName() .. '! What i can do for you my friend?', cid)
    lastWorkTime = os.time()
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    npcHandler:say('Good bye then.', cid)
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
    
    -- Update last work time on any interaction
    lastWorkTime = os.time()
    
    if msgcontains(msg, 'job') then
        npcHandler:say('I get exotics fruits!', cid)
        
    elseif msgcontains(msg, 'offer') then
        npcHandler:say('Go talk whit Fartun!', cid)
        
    elseif msgcontains(msg, 'sell') then
        npcHandler:say('Go talk whit Fartun!', cid)
        
    elseif msgcontains(msg, 'buy') then
        npcHandler:say('Dont have money now!', cid)
        
    elseif msgcontains(msg, 'quest') then
        npcHandler:say('Hehe!', cid)
        
    elseif msgcontains(msg, 'mission') then
        npcHandler:say('Nothing now.', cid)
        
    elseif msgcontains(msg, 'orc place') then
        npcHandler:say('Oh! Its here! Come i show you... on this hole!', cid)
        local npc = Npc()
        if npc then
            npc:teleportTo(Position(327, 296, 7))
            npc:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        end
        
    elseif msgcontains(msg, 'no') then
        npcHandler:say('Ok than.', cid)
    end
    
    return true
end

-- Keywords for automatic responses
keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I get exotics fruits!'
})

keywordHandler:addKeyword({'offer', 'sell'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Go talk whit Fartun!'
})

keywordHandler:addKeyword({'buy'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Dont have money now!'
})

keywordHandler:addKeyword({'quest'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Hehe!'
})

keywordHandler:addKeyword({'mission'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Nothing now.'
})

npcHandler:setMessage(MESSAGE_GREET, 'Hey there! |PLAYERNAME|! What i can do for you my friend?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye then.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
