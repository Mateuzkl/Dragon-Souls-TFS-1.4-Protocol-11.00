local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local talk_state = npcHandler.topic[cid] or 0

    if msgcontains(msg, 'test') then
        selfSay('Yea, i know you will say that mortal. Are you from Brazil or foreigner?', cid)
        npcHandler.topic[cid] = 1

    elseif talk_state == 1 then
        if msgcontains(msg, 'brazil') or msgcontains(msg, 'brasil') then
            selfSay('Nao tenho tempo a perder mortal... Vamos ao treinamento.', cid)
            selfSay('Sorcerers(Magos) focam suas magias em destruicao, como principal aprendizagem a magia negra, sua fonte de poder provem de sua mente, com isso, sua constituicao e seu corpo sao fracos.', cid)
            selfSay('Ao teste... Pronto mortal?', cid)
            npcHandler.topic[cid] = 2
        else
            selfSay('I dont have time to waste... Lets train!', cid)
            selfSay('Sorcerers focus their magic in destruction, as main style, the black magic, their font of power is their mind, with that, their agility and body are weak.', cid)
            selfSay('So, lets go to test... Ready?', cid)
            npcHandler.topic[cid] = 4
        end

    elseif talk_state == 2 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('Seu teste e muito simples, ate mesmo para um simples mortal!', cid)
            selfSay('Meu centro de consulta foi tomado por uma maldicao mistica, preciso do livro contido em uma das bibliotecas, mas nao sera tao facil, pois corpos amaldicoados estao sedentos por carne fresca!', cid)
            selfSay('Pronto mortal?', cid)
            npcHandler.topic[cid] = 3
        end

    elseif talk_state == 4 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('Your test is really simple, even a mortal can do it!', cid)
            selfSay('My research center is cursed, i need one book that is in one of the bookcases, but remember, dead cursed bodies are waiting to taste your blood with no mercy!', cid)
            selfSay('Ready mortal?', cid)
            npcHandler.topic[cid] = 5
        end

    elseif talk_state == 3 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('Aguardo o livro em minhas maos no final do teste.', cid)
            player:teleportTo(Position(260, 197, 8))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler.topic[cid] = 0
        end

    elseif talk_state == 5 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('I am waiting for the book in the end of the room!', cid)
            player:teleportTo(Position(260, 197, 8))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler.topic[cid] = 0
        end
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    selfSay('Was late, i was waiting you ' .. player:getName() .. '! Are you sure, want train to be a Feared Sorcerer? So say "test" mortal.', cid)
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Good bye mortal, ' .. player:getName() .. '!', cid)
    npcHandler.topic[cid] = 0
    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
