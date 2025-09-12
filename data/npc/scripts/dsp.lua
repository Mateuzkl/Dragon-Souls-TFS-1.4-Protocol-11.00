local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    UH_CONFIRM = 1,
    EXPLOSION_CONFIRM = 2,
    SD_CONFIRM = 3,
    GFB_CONFIRM = 4,
    HMM_CONFIRM = 5,
    DESTROY_FIELD_CONFIRM = 6,
    PREMIUM_CONFIRM = 21,
    SURGERY_CONFIRM = 22,
    LIFE_RING_CONFIRM = 31,
    RING_OF_HEALING_CONFIRM = 32,
    MANA_FLUID_CONFIRM = 33,
    BLESSED_RING_CONFIRM = 34,
    TELEPORT_CONFIRM = 35,
    SMALL_ELIXIR_CONFIRM = 36,
    NORMAL_ELIXIR_CONFIRM = 37,
    FIGHTING_SPIRIT_CONFIRM = 38,
    ENERGETICO_CONFIRM = 39,
    BLOOD_CONFIRM = 40,
    FREE_PREMIUM_CONFIRM = 41
}

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    local dsp = player:getItemCount(6527)
    
    if msgcontains(msg, 'job') then
        npcHandler:say('I am a merchant, lost in the wonders of this world!', cid)
    elseif msgcontains(msg, 'offer') then
        npcHandler:say('I change runes and premium days for Dragon Souls points!', cid)
    elseif msgcontains(msg, 'sell') or msgcontains(msg, 'buy') then
        npcHandler:say('Just change!', cid)
    elseif msgcontains(msg, 'quest') or msgcontains(msg, 'mission') then
        npcHandler:say('I am not getting involved in quests anymore!', cid)
    elseif msgcontains(msg, 'knowledge') then
        npcHandler:say('I have been in long trips and quests! One more dangerous than the other, now i am just traveling and wondering the world beauties!', cid)
    elseif msgcontains(msg, 'addon') or msgcontains(msg, 'backpack') then
        npcHandler:say('Ahh, this backpack? It\'s a present from Brian.', cid)
    
    -- Item exchanges
    elseif msgcontains(msg, 'uh') then
        npcHandler:say('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 20x de uh? (Requerido 45 de cap)', cid)
        npcHandler.topic[cid] = topicList.UH_CONFIRM
    elseif msgcontains(msg, 'explosion') then
        npcHandler:say('Aceita trocar 15 DSP\'s por uma bp de 60x de explosion? (Requerido 45 de cap)', cid)
        npcHandler.topic[cid] = topicList.EXPLOSION_CONFIRM
    elseif msgcontains(msg, 'sd') then
        npcHandler:say('Aceita trocar 20 DSP\'s por uma bp de 20x de sd? (Requerido 45 de cap)', cid)
        npcHandler.topic[cid] = topicList.SD_CONFIRM
    elseif msgcontains(msg, 'gfb') then
        npcHandler:say('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 40x de gfb? (Requerido 45 de cap)', cid)
        npcHandler.topic[cid] = topicList.GFB_CONFIRM
    elseif msgcontains(msg, 'hmm') then
        npcHandler:say('Aceita trocar 5 DSP\'s por 1 bp com 20 runas de 100x de hmm? (Requerido 45 de cap)', cid)
        npcHandler.topic[cid] = topicList.HMM_CONFIRM
    elseif msgcontains(msg, 'destroy field') then
        npcHandler:say('Aceita trocar 5 DSP\'s por 1 bp com 20 runas de 60x de destroy field? (Requerido 45 de cap)', cid)
        npcHandler.topic[cid] = topicList.DESTROY_FIELD_CONFIRM
    elseif msgcontains(msg, 'premium') then
        npcHandler:say('Aceita trocar 100 DSP\'s por 30 dias de premium?', cid)
        npcHandler.topic[cid] = topicList.PREMIUM_CONFIRM
    elseif msgcontains(msg, 'cirurgia') then
        npcHandler:say('Aceita trocar 10 GP\'s por uma cirurgia de troca de sexo?', cid)
        npcHandler.topic[cid] = topicList.SURGERY_CONFIRM
    elseif msgcontains(msg, 'life ring') then
        npcHandler:say('Aceita trocar 10 DSP\'s por 1 bp com 20 life rings? (Requerido 35 de cap)', cid)
        npcHandler.topic[cid] = topicList.LIFE_RING_CONFIRM
    elseif msgcontains(msg, 'ring of healing') then
        npcHandler:say('Aceita trocar 20 DSP\'s por 1 bp com 20 ring of healings? (Requerido 35 de cap)', cid)
        npcHandler.topic[cid] = topicList.RING_OF_HEALING_CONFIRM
    elseif msgcontains(msg, 'mana fluid') then
        npcHandler:say('Aceita trocar 15 DSP\'s por 1 Large Mana Fluid com 100 cargas? (Requerido 100 de cap)', cid)
        npcHandler.topic[cid] = topicList.MANA_FLUID_CONFIRM
    elseif msgcontains(msg, 'blessed ring') then
        npcHandler:say('Aceita trocar 40 DSP\'s por 1 bp com 20 Blessed rings? (Requerido 170 de cap)', cid)
        npcHandler.topic[cid] = topicList.BLESSED_RING_CONFIRM
    elseif msgcontains(msg, 'teleport') then
        npcHandler:say('Aceita trocar 25 DSP\'s por 10 Teleports? (Requerido 10 de cap)', cid)
        npcHandler.topic[cid] = topicList.TELEPORT_CONFIRM
    elseif msgcontains(msg, 'small elixir of experience') then
        npcHandler:say('Aceita trocar 30 DSP\'s por 50 Small Elixir of Experience? (Requerido 60 de cap)', cid)
        npcHandler.topic[cid] = topicList.SMALL_ELIXIR_CONFIRM
    elseif msgcontains(msg, 'normal elixir of experience') then
        npcHandler:say('Aceita trocar 50 DSP\'s por 50 Normal Elixir of Experience? (Requerido 160 de cap)', cid)
        npcHandler.topic[cid] = topicList.NORMAL_ELIXIR_CONFIRM
    elseif msgcontains(msg, 'fighting spirit') then
        npcHandler:say('Aceita trocar 50 DSP\'s por 1 Fighting Spirit? (Requerido 2 de cap)', cid)
        npcHandler.topic[cid] = topicList.FIGHTING_SPIRIT_CONFIRM
    elseif msgcontains(msg, 'energetico') then
        npcHandler:say('Aceita trocar 20 DSP\'s por 1 Energético? (Requerido 30 de cap)', cid)
        npcHandler.topic[cid] = topicList.ENERGETICO_CONFIRM
    elseif msgcontains(msg, 'blood') then
        npcHandler:say('Aceita trocar 50 DSP\'s por 1 Backpack com 20 Blood of God\'s? (Requerido 1550 de cap)', cid)
        npcHandler.topic[cid] = topicList.BLOOD_CONFIRM
    elseif msgcontains(msg, 'free premmy') then
        npcHandler:say('Voce ganhara 15 dias de premium de graça, mas só dessa vez!! aceita?!', cid)
        npcHandler.topic[cid] = topicList.FREE_PREMIUM_CONFIRM
    
    -- Confirmations
    elseif npcHandler.topic[cid] == topicList.UH_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(6527) >= 10 then
            player:removeItem(6527, 10)
            npcHandler:say('Aqui esta! Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma bp de uh.")
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Ainda lhe resta ' .. (dsp - 10) .. ' Dragon Souls Points.')
            local container = player:addItem(2002, 1)
            if container then
                for i = 1, 20 do
                    container:addItem(2273, 20)
                end
            end
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce não tem DSP\'s suficiente.', cid)
        end
    
    elseif npcHandler.topic[cid] == topicList.EXPLOSION_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(6527) >= 15 then
            player:removeItem(6527, 15)
            npcHandler:say('Aqui esta! Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma backpack de explosion.")
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Ainda lhe resta ' .. (dsp - 15) .. ' Dragon Souls Points.')
            local container = player:addItem(2001, 1)
            if container then
                for i = 1, 20 do
                    container:addItem(2313, 60)
                end
            end
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce não tem DSP\'s suficiente.', cid)
        end
    
    elseif npcHandler.topic[cid] == topicList.SD_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(6527) >= 20 then
            player:removeItem(6527, 20)
            npcHandler:say('Aqui esta! Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma backpack de sd.")
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Ainda lhe resta ' .. (dsp - 20) .. ' Dragon Souls Points.')
            local container = player:addItem(2003, 1)
            if container then
                for i = 1, 20 do
                    container:addItem(2268, 20)
                end
            end
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce não tem DSP\'s suficiente.', cid)
        end
    
    elseif npcHandler.topic[cid] == topicList.GFB_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(6527) >= 10 then
            player:removeItem(6527, 10)
            npcHandler:say('Aqui esta! Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma bp de gfb.")
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Ainda lhe resta ' .. (dsp - 10) .. ' Dragon Souls Points.')
            local container = player:addItem(2000, 1)
            if container then
                for i = 1, 20 do
                    container:addItem(2304, 40)
                end
            end
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce não tem DSP\'s suficiente.', cid)
        end
    
    elseif npcHandler.topic[cid] == topicList.HMM_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(6527) >= 5 then
            player:removeItem(6527, 5)
            npcHandler:say('Aqui esta! Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma bp de hmm.")
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Ainda lhe resta ' .. (dsp - 5) .. ' Dragon Souls Points.')
            local container = player:addItem(2001, 1)
            if container then
                for i = 1, 20 do
                    container:addItem(2311, 100)
                end
            end
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce não tem DSP\'s suficiente.', cid)
        end
    
    elseif npcHandler.topic[cid] == topicList.DESTROY_FIELD_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(6527) >= 5 then
            player:removeItem(6527, 5)
            npcHandler:say('Aqui esta! Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma bp de destroy field.")
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Ainda lhe resta ' .. (dsp - 5) .. ' Dragon Souls Points.')
            local container = player:addItem(2003, 1)
            if container then
                for i = 1, 20 do
                    container:addItem(2261, 60)
                end
            end
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce não tem DSP\'s suficiente.', cid)
        end
    
    elseif npcHandler.topic[cid] == topicList.PREMIUM_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(6527) >= 100 then
            player:removeItem(6527, 100)
            player:addPremiumDays(30)
            npcHandler:say('Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 30 dias de Premium Account.")
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Ainda lhe resta ' .. (dsp - 100) .. ' Dragon Souls Points.')
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce não tem DSP\'s suficiente.', cid)
        end
    
    elseif npcHandler.topic[cid] == topicList.SURGERY_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(2152) >= 1 then
            player:removeItem(2152, 1)
            if player:getSex() == 0 then
                player:setSex(1)
            else
                player:setSex(0)
            end
            npcHandler:say('Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce trocou de sexo com sucesso.")
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce não tem o item necessário.', cid)
        end
    
    elseif npcHandler.topic[cid] == topicList.LIFE_RING_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(6527) >= 10 then
            player:removeItem(6527, 10)
            npcHandler:say('Aqui esta! Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma bp de life ring.")
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Ainda lhe resta ' .. (dsp - 10) .. ' Dragon Souls Points.')
            local container = player:addItem(1998, 1)
            if container then
                for i = 1, 20 do
                    container:addItem(2168, 1)
                end
            end
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce não tem DSP\'s suficiente.', cid)
        end
    
    elseif npcHandler.topic[cid] == topicList.RING_OF_HEALING_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(6527) >= 20 then
            player:removeItem(6527, 20)
            npcHandler:say('Aqui esta! Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu uma bp de ring of healing.")
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Ainda lhe resta ' .. (dsp - 20) .. ' Dragon Souls Points.')
            local container = player:addItem(2000, 1)
            if container then
                for i = 1, 20 do
                    container:addItem(2214, 1)
                end
            end
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce não tem DSP\'s suficiente.', cid)
        end
    
    elseif npcHandler.topic[cid] == topicList.MANA_FLUID_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(6527) >= 15 then
            player:removeItem(6527, 15)
            npcHandler:say('Aqui esta! Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um Large Mana fluid.")
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Ainda lhe resta ' .. (dsp - 15) .. ' Dragon Souls Points.')
            player:addItem(11771, 100)
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce não tem DSP\'s suficiente.', cid)
        end
    
    elseif npcHandler.topic[cid] == topicList.FREE_PREMIUM_CONFIRM and msgcontains(msg, 'yes') then
        if not player:isPremium() then
            player:addPremiumDays(15)
            npcHandler:say('Aqui esta! Obrigado e volte sempre.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 15 dias de premium account. Relogue sua conta.")
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('Desculpe, mas voce ja ganhou sua premium.', cid)
        end
    
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > topicList.NONE then
        npcHandler:say('Ok then.', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I am a merchant, lost in the wonders of this world!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
