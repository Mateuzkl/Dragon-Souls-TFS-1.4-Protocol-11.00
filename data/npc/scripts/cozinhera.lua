local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    LEARN_COOKING_EN = 1,
    LEARN_COOKING_PT = 2,
    WHEAT_CHECK_EN = 3,
    WHEAT_CHECK_PT = 4,
    FLOUR_CHECK_EN = 5,
    FLOUR_CHECK_PT = 6
}

local function greetCallback(cid)
    local player = Player(cid)
    local cook = player:getStorageValue(30006)
    local pao = player:getStorageValue(2689)
    
    if pao == -1 then
        npcHandler:say('Hello ' .. player:getName() .. '! I am the master cooker of the town, wana learn to cook?', cid)
        npcHandler.topic[cid] = topicList.LEARN_COOKING_EN
    elseif cook == 2 then
        npcHandler:say('Hello again ' .. player:getName() .. '! In the moment i am very busy, sorry but our lesson will have to wait for another day, ok?', cid)
        npcHandler:releaseFocus(cid)
    elseif pao == 1 then
        npcHandler:say('Hello ' .. player:getName() .. '! Got what i asked you?', cid)
        npcHandler.topic[cid] = topicList.WHEAT_CHECK_EN
    elseif pao == 2 then
        npcHandler:say('Hello ' .. player:getName() .. '! Got the flour?', cid)
        npcHandler.topic[cid] = topicList.FLOUR_CHECK_EN
    elseif pao == 3 then
        npcHandler:say('Ainda não conseguiu fazer o pão ' .. player:getName() .. '?', cid)
        npcHandler:releaseFocus(cid)
    end
    
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    npcHandler:say('Good bye, ' .. player:getName() .. '!', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        if msgcontains(msg, 'oi') then
            local player = Player(cid)
            local cook = player:getStorageValue(30006)
            local pao = player:getStorageValue(2689)
            
            if pao == -1 then
                npcHandler:say('Ola ' .. player:getName() .. '! Sou a cozinheira chefe da cidade , gostaria de aprender a cozinhar?', cid)
                npcHandler.topic[cid] = topicList.LEARN_COOKING_PT
            elseif cook == 2 then
                npcHandler:say('Ola denovo ' .. player:getName() .. '! No momento ando muito ocupada, desculpe mas nossa aula ficara para outro dia, ok?', cid)
                npcHandler:releaseFocus(cid)
            elseif pao == 1 then
                npcHandler:say('Ola ' .. player:getName() .. '! Conseguiu oque lhe pedi?', cid)
                npcHandler.topic[cid] = topicList.WHEAT_CHECK_PT
            elseif pao == 2 then
                npcHandler:say('Ola ' .. player:getName() .. '! Conseguiu o flour?', cid)
                npcHandler.topic[cid] = topicList.FLOUR_CHECK_PT
            elseif pao == 3 then
                npcHandler:say('Ainda não conseguiu fazer o pão ' .. player:getName() .. '?', cid)
                npcHandler:releaseFocus(cid)
            end
            return true
        elseif msgcontains(msg, 'done') then
            local player = Player(cid)
            local pao = player:getStorageValue(2689)
            
            if pao == 3 then
                npcHandler:say('Congratulations ' .. player:getName() .. '! You have done the first part of your training! Come back when you wana do the second lesson!', cid)
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
                player:setStorageValue(30006, 2)
                player:setStorageValue(2689, 4)
                npcHandler:releaseFocus(cid)
            end
            return true
        end
        return false
    end
    
    local player = Player(cid)
    
    if npcHandler.topic[cid] == topicList.LEARN_COOKING_EN and msgcontains(msg, 'yes') then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nova quest adicionada 'Aprendendo a cozinhar!'.")
        npcHandler:say('Well lets begin! Our first lesson is simple, i need you to bring "wheat", that can be obtained using a "scythe" in a "wheat filed", so then, lets do it!', cid)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2689, 1)
        player:setStorageValue(30006, 1)
        npcHandler:releaseFocus(cid)
    elseif npcHandler.topic[cid] == topicList.LEARN_COOKING_PT and msgcontains(msg, 'sim') then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nova quest adicionada 'Aprendendo a cozinhar!'.")
        npcHandler:say('Bom então vamo la! Nossa primeira aula é simples, vou precisar que voce me traga "wheat", pode ser conseguido, usando uma "scythe" em um "wheat filed", pois então, mãos a obra!', cid)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2689, 1)
        player:setStorageValue(30006, 1)
        npcHandler:releaseFocus(cid)
    elseif npcHandler.topic[cid] == topicList.WHEAT_CHECK_PT and msgcontains(msg, 'sim') then
        if player:getItemCount(2694) >= 1 then
            npcHandler:say('Mas que otimo! Agora é simples, voce precisa transformar o "wheat" em "flour", usando uma "mill", mãos a obra!', cid)
            player:setStorageValue(2689, 2)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            npcHandler:releaseFocus(cid)
        else
            npcHandler:say('Mas aonde esta o "wheat"?!', cid)
            npcHandler:releaseFocus(cid)
        end
    elseif npcHandler.topic[cid] == topicList.WHEAT_CHECK_EN and msgcontains(msg, 'yes') then
        if player:getItemCount(2694) >= 1 then
            npcHandler:say('Great! Now its simple, you need to trasform "wheat" in "flour", using a "mill", lets do it!', cid)
            player:setStorageValue(2689, 2)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            npcHandler:releaseFocus(cid)
        else
            npcHandler:say('But where is the "wheat"?!', cid)
            npcHandler:releaseFocus(cid)
        end
    elseif npcHandler.topic[cid] == topicList.FLOUR_CHECK_PT and msgcontains(msg, 'sim') then
        if player:getItemCount(2692) >= 1 then
            npcHandler:say('Excelente! Nosso ultimo passo! Adicione agua ao "flour", para fazer a "dough", depois coloque nesse forno aqui e voila!', cid)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(2689, 3)
            npcHandler:releaseFocus(cid)
        else
            npcHandler:say('Mas aonde esta o "flour"?!', cid)
            npcHandler:releaseFocus(cid)
        end
    elseif npcHandler.topic[cid] == topicList.FLOUR_CHECK_EN and msgcontains(msg, 'yes') then
        if player:getItemCount(2692) >= 1 then
            npcHandler:say('Excelent! Our last step! Add water to the "flour", to do the "dough", then put in this oven here and voila!', cid)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(2689, 3)
            npcHandler:releaseFocus(cid)
        else
            npcHandler:say('But where is the "flour"?!', cid)
            npcHandler:releaseFocus(cid)
        end
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > topicList.NONE then
        npcHandler:say('Ok than.', cid)
        npcHandler.topic[cid] = topicList.NONE
        npcHandler:releaseFocus(cid)
    elseif msgcontains(msg, 'hi') then
        npcHandler:say('Hmm, I am already talking to you!', cid)
    elseif msgcontains(msg, 'oi') then
        npcHandler:say('Hmm, ja estou falando com voce!', cid)
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I am the master cooker of the town, wana learn to cook?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
