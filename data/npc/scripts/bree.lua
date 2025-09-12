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
            npcHandler:say('
