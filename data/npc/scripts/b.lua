local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local BLESSING_COST = 100

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if player:getVocation():getId() >= 5 then
        selfSay('I can only talk to regular vocations.', cid)
        return true
    end
    
    if msgcontains(msg, 'bless') then
        selfSay('Hmm... So you want to be blessed by Hersthiop.... Are you sure about that?', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
        if npcHandler.topic[cid] == 1 then
            if not player:hasBlessing(2) then
                if player:removeMoney(BLESSING_COST) then
                    player:addBlessing(2)
                    if msgcontains(msg, 'sim') then
                        selfSay('Você está abençoado por Hersthiop!', cid)
                    else
                        selfSay('You are blessed by Hersthiop now!', cid)
                    end
                else
                    if msgcontains(msg, 'sim') then
                        selfSay('Desculpe você não tem o dinheiro.', cid)
                    else
                        selfSay('Sorry, you do not have enough money.', cid)
                    end
                end
            else
                if msgcontains(msg, 'sim') then
                    selfSay('Você já está abençoado.', cid)
                else
                    selfSay('You already got your bless...', cid)
                end
            end
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'no') or msgcontains(msg, 'nao') then
        if npcHandler.topic[cid] == 1 then
            if msgcontains(msg, 'nao') then
                selfSay('Gostaria de algo mais?', cid)
            else
                selfSay('Ok. Do you want something more?', cid)
            end
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'status') then
        selfSay('Hmm... Let me see...', cid)
        
        local blessings = {
            'Arquinothep',
            'Hersthiop', 
            'Skraviosk',
            'UnHolly',
            'God'
        }
        
        for i = 1, 5 do
            if player:hasBlessing(i) then
                selfSay(string.format('You already got the %s blessing.', blessings[i]), cid)
            else
                selfSay(string.format('You didn\'t get the %s blessing yet.', blessings[i]), cid)
            end
        end
    end
    
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    if player:hasBlessing(1) then
        selfSay('God will save your soul, ' .. player:getName() .. '!', cid)
    else
        selfSay('Beware ' .. player:getName() .. '...', cid)
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())

keywordHandler:addKeyword({'oi'}, StdModule.say, {npcHandler = npcHandler, text = 'Olá!'})
keywordHandler:addKeyword({'tchau'}, StdModule.farewell, {npcHandler = npcHandler})
keywordHandler:addKeyword({'xau'}, StdModule.farewell, {npcHandler = npcHandler})
