local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0
}

local destinations = {
    ['dragon land'] = {cost = 500, pos = Position(122, 119, 7)},
    ['dragon'] = {cost = 500, pos = Position(122, 119, 7)},
    ['edron'] = {cost = 120, pos = Position(734, 795, 6)},
    ['carlin'] = {cost = 200, pos = Position(149, 356, 6)},
    ['tirith'] = {cost = 500, pos = Position(476, 293, 6)},
    ['minas tirith'] = {cost = 500, pos = Position(476, 293, 6)},
    ['tombstone'] = {cost = 100, pos = Position(168, 65, 7)},
    ['tomb'] = {cost = 100, pos = Position(168, 65, 7)},
    ['lorien island'] = {cost = 100, pos = Position(309, 53, 7)},
    ['lorien'] = {cost = 100, pos = Position(309, 53, 7)}
}

local function greetCallback(cid)
    local player = Player(cid)
    if player:isPremium() then
        npcHandler:say('Hello ' .. player:getName() .. '! I can take you to the Carlin (200gps), Dragon Land (500gp), Tombstone (100gps), Edron (120gps), Minas Tirith (500gps) or Lorien Island (100gps). Where do you want to go?', cid)
        return true
    else
        npcHandler:say('Sorry, only premium players can travel by boat.', cid)
        return false
    end
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
    
    -- Check all destinations
    for keyword, data in pairs(destinations) do
        if msgcontains(msg, keyword) then
            if player:removeMoney(data.cost) then
                npcHandler:say('Let\'s go!', cid)
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

-- Set messages
npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I can take you to the Carlin (200gps), Dragon Land (500gp), Tombstone (100gps), Edron (120gps), Minas Tirith (500gps) or Lorien Island (100gps). Where do you want to go?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

-- Set callbacks
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(F
