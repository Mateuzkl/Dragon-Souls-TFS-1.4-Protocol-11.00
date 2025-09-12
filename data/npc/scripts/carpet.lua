local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local destinations = {
    ['tombstone'] = {cost = 200, pos = Position(219, 92, 7)},
    ['tomb'] = {cost = 200, pos = Position(219, 92, 7)},
    ['hills'] = {cost = 300, pos = Position(307, 378, 4)},
    ['femur hills'] = {cost = 300, pos = Position(307, 378, 4)},
    ['edron'] = {cost = 400, pos = Position(752, 816, 3)}
}

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('Hello ' .. player:getName() .. '! I can take you to Femur Hills (300gps), Edron (400gps) or Tombstone (200gps). Where do you want to go?', cid)
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    npcHandler:say('Good bye, ' .. player:getName() .. '!', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    -- Check for Portuguese/Spanish greetings
    if msgcontains(msg, 'oi') then
        npcHandler:say('Hola ' .. player:getName() .. '! Puesso levar-te a Femur Hills (300gps), Edron (400gps) ou Tombstone (200gps). Onde gostaria de ir?', cid)
        return true
    elseif msgcontains(msg, 'tchau') then
        npcHandler:say('Adios, ' .. player:getName() .. '!', cid)
        npcHandler:releaseFocus(cid)
        return true
    end
    
    -- Check all destinations
    for keyword, data in pairs(destinations) do
        if msgcontains(msg, keyword) then
            if player:removeMoney(data.cost) then
                npcHandler:say('Yhaa!', cid)
                player:teleportTo(data.pos)
                data.pos:sendMagicEffect(CONST_ME_TELEPORT)
                npcHandler:releaseFocus(cid)
            else
                npcHandler:say('Sorry, you don\'t have enough money.', cid)
            end
            return true
        end
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I can take you to Femur Hills (300gps), Edron (400gps) or Tombstone (200gps). Where do you want to go?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
