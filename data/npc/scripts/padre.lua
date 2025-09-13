local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

local focus1 = 0
local focus2 = 0
local talk_start = 0
local talkstate = 0

function ceremonyend(msg)
    focus1 = 0
    focus2 = 0
    talk_start = 0
    talkstate = 0
    selfSay(msg)
end

function creatureSayCallback(cid, type, msg)
    local player = Player(cid)
    if not player then
        return false
    end

    if talkstate == 1 then
        if cid == focus2 then
            if msgcontains(msg, 'sim') then
                talkstate = 2
                local player1 = Player(focus1)
                if player1 then
                    selfSay(player1:getName() .. ' devo comecar a cerimonia?')
                end
            else
                ceremonyend('Volte quando voce estiver preparado.')
            end
        end

    elseif talkstate == 2 then
        if cid == focus1 then
            if msgcontains(msg, 'sim') then
                talkstate = 3
                talk_start = os.clock()
            else
                ceremonyend('Volte quando voce estiver preparado.')
            end
        end

    elseif talkstate == 9 then
        if cid == focus1 then
            if msgcontains(msg, 'sim') then
                talkstate = 10
                talk_start = os.clock()
            else
                ceremonyend('Volte quando voce estiver preparado.')
            end
        end

    elseif talkstate == 11 then
        if cid == focus2 then
            if msgcontains(msg, 'sim') then
                talkstate = 12
                talk_start = os.clock()
            else
                ceremonyend('Volte quando voce estiver preparado.')
            end
        end

    elseif msgcontains(msg, 'oi') and focus1 > 0 and focus2 == 0 and cid ~= focus1 then
        -- Check if player is already married (assuming storage value)
        if player:getStorageValue(30020) == -1 then
            selfSay('Ola, ' .. player:getName() .. '! Grande dia nao? Bem, vamos comecar?')
            focus2 = cid
            talk_start = os.clock()
            talkstate = 1
        else
            selfSay('Voce ja esta casado(a).')
        end

    elseif msgcontains(msg, 'oi') and focus1 == 0 then
        -- Check if player is already married (assuming storage value)
        if player:getStorageValue(30020) == -1 then
            selfSay('Oi, ' .. player:getName() .. '! Eu sou o padre do Dragon Souls Otserv. E posso unir voces com seu grande amor.')
            focus1 = cid
            talk_start = os.clock()
        else
            selfSay('Voce ja esta casado(a).')
        end

    elseif msgcontains(msg, 'tchau') and (focus1 == cid or focus2 == cid) then
        ceremonyend('Va com deus, ' .. player:getName() .. '!')
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
    
    ceremonyend('Va com deus, ' .. player:getName() .. '!')
    return true
end

-- Custom onThink for ceremony progression
function onThink()
    npcHandler:onThink()
    
    if talkstate == 3 and (os.clock() - talk_start) > 10 then
        selfSay('Duas vidas, duas pessoas, dois seres vivos tao diferentes, mas tao iguais ao mesmo tempo.')
        talk_start = os.clock()
        talkstate = 4
        
    elseif talkstate == 4 and (os.clock() - talk_start) > 6 then
        selfSay('Juntos eles formao soh um, para celebrar o futuro nao importando qual for.')
        talk_start = os.clock()
        talkstate = 5
        
    elseif talkstate == 5 and (os.clock() - talk_start) > 6 then
        selfSay('O passado eh passado. Agora o que importa eh o futuro desse lindo casal.')
        talk_start = os.clock()
        talkstate = 6
        
    elseif talkstate == 6 and (os.clock() - talk_start) > 8 then
        selfSay('Honestidade e amor, essas sao as caracteristicas de um bom casamento.')
        talk_start = os.clock()
        talkstate = 7
        
    elseif talkstate == 7 and (os.clock() - talk_start) > 6 then
        selfSay('Que as almas de todos os dragoes os abencoe esse dia tao especial.')
        talk_start = os.clock()
        talkstate = 8
        
    elseif talkstate == 8 and (os.clock() - talk_start) > 6 then
        local player1 = Player(focus1)
        local player2 = Player(focus2)
        if player1 and player2 then
            selfSay(player1:getName() .. ' voce aceita ' .. player2:getName() .. ' para sempre....na alegria...na tristesa...na riquesa...ou na pobresa...na saude ou na doenca...para viver...confiar...e acima de tudo amar?')
        end
        talk_start = os.clock()
        talkstate = 9
        
    elseif talkstate == 10 and (os.clock() - talk_start) > 6 then
        local player1 = Player(focus1)
        local player2 = Player(focus2)
        if player1 and player2 then
            selfSay(player2:getName() .. ' voce aceita ' .. player1:getName() .. ' para sempre....na alegria...na tristesa...na riquesa...ou na pobresa...na saude ou na doenca...para viver...confiar...e acima de tudo amar?')
        end
        talk_start = os.clock()
        talkstate = 11
        
    elseif talkstate == 12 and (os.clock() - talk_start) > 6 then
        local player1 = Player(focus1)
        local player2 = Player(focus2)
        if player1 and player2 then
            -- Set marriage storage values
            player1:setStorageValue(30020, focus2) -- Store partner's ID
            player2:setStorageValue(30020, focus1) -- Store partner's ID
            player1:setStorageValue(30021, player2:getName()) -- Store partner's name
            player2:setStorageValue(30021, player1:getName()) -- Store partner's name
            
            -- Send effects
            player1:getPosition():sendMagicEffect(CONST_ME_HEARTS)
            player2:getPosition():sendMagicEffect(CONST_ME_HEARTS)
        end
        ceremonyend('Pelos poderes em mim investidos eu vos declaro marido e mulher. Boa sorte.')
        talk_start = os.clock()
        
    elseif (os.clock() - talk_start) > 100 then
        if focus1 > 0 or focus2 > 0 then
            ceremonyend('Goodbye, then.')
        end
    end
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
