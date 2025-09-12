local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    BRAMUM_CONFIRM = 1,
    CANUDIS_CONFIRM = 2,
    MORGUN_CONFIRM = 3,
    MORDOR_CONFIRM = 4,
    TANORIS_CONFIRM = 5
}

local function greetCallback(cid)
    local player = Player(cid)
    if player:isPremium() then
        npcHandler:say('Olá ' .. player:getName() .. '! Deseja fazer alguma viagem hoje?', cid)
        return true
    else
        npcHandler:say('Desculpe, somente premiuns podem viajar nesse barco.', cid)
        return false
    end
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
    local level = player:getLevel()
    local vocation = player:getVocation():getId()
    
    if msgcontains(msg, 'bramum') then
        if level > 99 or level < 8 then
            npcHandler:say('Requerimento para essa viagem : Minimo Level 8 e o máximo 99...', cid)
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Deseja viajar para Bramum por 500 moedas de ouro?', cid)
            npcHandler.topic[cid] = topicList.BRAMUM_CONFIRM
        end
    elseif msgcontains(msg, 'canudis') then
        if level > 199 or level < 100 then
            npcHandler:say('Requerimento para essa viagem : Minimo Level 100 e o máximo 199...', cid)
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Deseja viajar para Canudis por 1000 moedas de ouro?', cid)
            npcHandler.topic[cid] = topicList.CANUDIS_CONFIRM
        end
    elseif msgcontains(msg, 'morgun') then
        if level > 299 or level < 200 then
            npcHandler:say('Requerimento para essa viagem : Minimo Level 200 e o máximo 299...', cid)
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Deseja viajar para Morgun por 2500 moedas de ouro?', cid)
            npcHandler.topic[cid] = topicList.MORGUN_CONFIRM
        end
    elseif msgcontains(msg, 'mordor') then
        if vocation < 9 or vocation > 17 then
            npcHandler:say('Desculpe, Somente Valan\'s podem ter acesso à Mordor!', cid)
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Você deseja viajar para Mordor por 5000 moedas de ouro?', cid)
            npcHandler.topic[cid] = topicList.MORDOR_CONFIRM
        end
    elseif msgcontains(msg, 'tanoris') then
        if vocation < 13 or vocation > 16 then
            npcHandler:say('Desculpe, Somente God\'s Podem viajar ter acesso à Tanoris!', cid)
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Você deseja viajar para Tanoris por 100 Dsp\'s?', cid)
            npcHandler.topic[cid] = topicList.TANORIS_CONFIRM
        end
    elseif npcHandler.topic[cid] == topicList.BRAMUM_CONFIRM and msgcontains(msg, 'yes') then
        if player:removeMoney(500) then
            player:teleportTo(Position(793, 2058, 6))
            Position(793, 2058, 6):sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:say('Que rude!', cid)
        else
            npcHandler:say('Desculpe, você não tem dinheiro suficiente.', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif npcHandler.topic[cid] == topicList.CANUDIS_CONFIRM and msgcontains(msg, 'yes') then
        if player:removeMoney(1000) then
            player:teleportTo(Position(752, 1932, 6))
            Position(752, 1932, 6):sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:say('Que rude!', cid)
        else
            npcHandler:say('Desculpe, você não tem dinheiro suficiente.', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif npcHandler.topic[cid] == topicList.MORGUN_CONFIRM and msgcontains(msg, 'yes') then
        if player:removeMoney(2500) then
            player:teleportTo(Position(881, 1879, 6))
            Position(881, 1879, 6):sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:say('Que rude!', cid)
        else
            npcHandler:say('Desculpe, você não tem dinheiro suficiente.', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif npcHandler.topic[cid] == topicList.MORDOR_CONFIRM and msgcontains(msg, 'yes') then
        if player:removeMoney(5000) then
            player:teleportTo(Position(1024, 1858, 6))
            Position(1024, 1858, 6):sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:say('Que rude!', cid)
        else
            npcHandler:say('Desculpe, você não tem dinheiro suficiente.', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif npcHandler.topic[cid] == topicList.TANORIS_CONFIRM and msgcontains(msg, 'yes') then
        if player:removeItem(6527, 100) then
            player:teleportTo(Position(1103, 1888, 6))
            Position(1103, 1888, 6):sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:say('Que rude!', cid)
        else
            npcHandler:say('Desculpe, você não tem Dragon Souls Point suficiente.', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'Do Level 8 ao 99 para bramum, level 100 ao 199 para Canudis, level 200 ao 299 para Morgun,level 8 ao 510 para Mordor e somente Valans..e Do Level 8 ao 510 para tanoris somente gods.'
})

npcHandler:setMessage(MESSAGE_GREET, 'Olá |PLAYERNAME|! Deseja fazer alguma viagem hoje?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Tchau, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Tchau então.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Desculpe, |PLAYERNAME|! Converso com você em um estante.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
