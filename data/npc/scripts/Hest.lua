local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    BLESS_CONFIRM = 1
}

local cost = 40000

local function greetCallback(cid)
    local player = Player(cid)
    if player:getVocation():getId() >= 5 then
        if msgcontains(msg, 'hi') then
            npcHandler:say('I can only talk to regular vocations.', cid)
        else
            npcHandler:say('So vocacoes regulares sao permitidas aqui.', cid)
        end
        return false
    end
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    if player:hasBlessing(3) then -- Skraviosk blessing
        if msgcontains(msg, 'bye') then
            npcHandler:say('God will save your Soul, ' .. player:getName() .. '!', cid)
        else
            npcHandler:say('Voce esta com Deus, ' .. player:getName() .. '!', cid)
        end
    else
        if msgcontains(msg, 'bye') then
            npcHandler:say('Beware ' .. player:getName() .. '...', cid)
        else
            npcHandler:say('Cuidado ' .. player:getName() .. '...', cid)
        end
    end
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if msgcontains(msg, 'hi') or msgcontains(msg, 'oi') then
        if msgcontains(msg, 'hi') then
            npcHandler:say('Hello, ' .. player:getName() .. '!', cid)
        else
            npcHandler:say('Ola, ' .. player:getName() .. '!', cid)
        end
    elseif msgcontains(msg, 'bless') then
        npcHandler:say('Hmm... So you want be blessed by Skraviosk.... Are you shure about That?', cid)
        npcHandler.topic[cid] = topicList.BLESS_CONFIRM
    elseif npcHandler.topic[cid] == topicList.BLESS_CONFIRM and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if player:hasBlessing(3) then
            if msgcontains(msg, 'yes') then
                npcHandler:say('You already got Your bless...', cid)
            else
                npcHandler:say('Voce ja tem sua bless...', cid)
            end
        else
            if player:removeMoney(cost) then
                player:addBlessing(3)
                if msgcontains(msg, 'yes') then
                    npcHandler:say('Skraviosk sayd you are a good player... So you will be blessed!', cid)
                else
                    npcHandler:say('Skraviosk Disse que voce e uma boa pessoa , entao que seja!', cid)
                end
            else
                if msgcontains(msg, 'yes') then
                    npcHandler:say('Sorry, you do not have enough money.', cid)
                else
                    npcHandler:say('Desculpe , voce nao tem o dinheiro.', cid)
                end
            end
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif npcHandler.topic[cid] == topicList.BLESS_CONFIRM and (msgcontains(msg, 'no') or msgcontains(msg, 'nao')) then
        if msgcontains(msg, 'no') then
            npcHandler:say('Ok. Do you want something more?', cid)
        else
            npcHandler:say('Algo mais?', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'status') then
        npcHandler:say('Hmm... Let me see...', cid)
        
        if not player:hasBlessing(1) then
            npcHandler:say('You didnt get the Hersthiop bless yet.', cid)
        else
            npcHandler:say('You already got the Hersthiop bless.', cid)
        end
        
        if not player:hasBlessing(2) then
            npcHandler:say('You didnt get the Arquinothep bless yet.', cid)
        else
            npcHandler:say('You already got the Arquinothep bless.', cid)
        end
        
        if not player:hasBlessing(3) then
            npcHandler:say('You didnt get the Skraviosk bless yet.', cid)
        else
            npcHandler:say('You already got the Skraviosk bless.', cid)
        end
        
        if not player:hasBlessing(4) then
            npcHandler:say('You didnt get the UnHolly bless yet.', cid)
        else
            npcHandler:say('You already got the UnHolly bless.', cid)
        end
        
        if not player:hasBlessing(5) then
            npcHandler:say('You didnt get the bless came from God.', cid)
        else
            npcHandler:say('You already got bless came from God.', cid)
        end
    elseif msgcontains(msg, 'tchau') then
        if player:hasBlessing(3) then
            npcHandler:say('Voce esta com Deus, ' .. player:getName() .. '!', cid)
        else
            npcHandler:say('Cuidado ' .. player:getName() .. '...', cid)
        end
        npcHandler:releaseFocus(cid)
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye then.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Leave us alone, |PLAYERNAME|!')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
