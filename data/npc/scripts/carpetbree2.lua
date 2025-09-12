local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    SECOND_TRAVEL = 1
}

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('Olá ' .. player:getName() .. '. Então..como foi a sua caça? Quer voltar para bree?', cid)
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    npcHandler:say('Tchau, ' .. player:getName() .. '!', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if npcHandler.topic[cid] == topicList.NONE and msgcontains(msg, 'yes') then
        player:teleportTo(Position(843, 2003, 7))
        Position(843, 2003, 7):sendMagicEffect(CONST_ME_TELEPORT)
        npcHandler:say('Que rude!', cid)
        npcHandler.topic[cid] = topicList.SECOND_TRAVEL
    elseif npcHandler.topic[cid] == topicList.SECOND_TRAVEL and msgcontains(msg, 'yes') then
        if player:removeMoney(3000) then
            player:teleportTo(Position(881, 1879, 6))
            Position(881, 1879, 6):sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:say('Que rude!', cid)
        else
            npcHandler:say('Desculpe, você não tem dinheiro suficiente.', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Olá |PLAYERNAME|. Então..como foi a sua caça? Quer voltar para bree?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Tchau, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Tchau então.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Desculpe, |PLAYERNAME|! Converso com você em um estante.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
