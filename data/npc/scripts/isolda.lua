local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local voices = { {text = "Olá mortal! Posso te ajudar com itens elementais e bênçãos!"} }
npcHandler:addModule(VoiceModule:new(voices))

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu sou uma serva de Merlian!'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu posso criar itens elementais, energizar seus itens, dar {bless} para mortais e fazer {reset} de deuses! Diga {info} para informações de reset.'})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu não sou mercadora!'})
keywordHandler:addKeyword({'buy'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu não sou mercadora!'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, text = 'Ha! Você é apenas um novato!'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, text = 'Ha! Você é apenas um novato!'})

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local preco = player:getLevel() * 2 -- Original script uses level * 2000, so level * 2 for "k" format
    local bless = player:hasBlessing(1)
    local currentResets = player:getReset()
    local rubys = math.floor((player:getLevel() * 4000) * (currentResets * 30 * 2) / 1000000)
    
    if msgcontains(msg, 'energyze') or msgcontains(msg, 'energize') then
        npcHandler:say('Eu posso energyzar seu elemental necklace por 50k, spirit elemental amulet por 100k ou o seu magic elemental amulet por 150k, você deseja que eu energyze?', cid)
        npcHandler.topic[cid] = 1
        
    elseif npcHandler.topic[cid] == 1 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        -- Check for Elemental Necklace (2197)
        if player:getItemCount(2197) >= 1 and player:removeMoney(50000) then
            player:removeItem(2197, 1)
            player:addItem(38906, 1)
            npcHandler:say('Ele é todo seu! Você está protegido.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você energizou seu Elemental necklace.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        -- Check for Spirit Elemental Amulet (2173)  
        elseif player:getItemCount(2173) >= 1 and player:removeMoney(100000) then
            player:removeItem(2173, 1)
            player:addItem(38901, 1)
            npcHandler:say('Ele é todo seu! Você está protegido.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você energizou seu Spirit Elemental amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        -- Check for Magic Elemental Amulet (2125)
        elseif player:getItemCount(2125) >= 1 and player:removeMoney(150000) then
            player:removeItem(2125, 1)
            player:addItem(38900, 1)
            npcHandler:say('Ele é todo seu! Você está protegido.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você energizou seu Magic Elemental amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            if player:getItemCount(2125) == 0 and player:getItemCount(2173) == 0 and player:getItemCount(2197) == 0 then
                npcHandler:say('Você não tem nenhum amulet para ser energyzado.', cid)
            else
                npcHandler:say('Desculpe, você não tem a quantia necessária.', cid)
            end
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'elemental necklace') or msgcontains(msg, 'elemental') then
        npcHandler:say('Você deseja trocar o mysterious, dragon breath, scorpion, platinum e o vampire tooth necklace por um Elemental necklace?', cid)
        npcHandler.topic[cid] = 4
        
    elseif npcHandler.topic[cid] == 4 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if player:getItemCount(2201) >= 1 and player:getItemCount(2171) >= 1 and 
           player:getItemCount(2170) >= 1 and player:getItemCount(2161) >= 1 and 
           player:getItemCount(2198) >= 1 then
            
            player:removeItem(2201, 1) -- mysterious
            player:removeItem(2171, 1) -- dragon breath  
            player:removeItem(2170, 1) -- scorpion
            player:removeItem(2161, 1) -- platinum
            player:removeItem(2198, 1) -- vampire tooth
            player:addItem(2197, 1) -- elemental necklace
            npcHandler:say('Pronto! O seu elemental necklace está pronto, obrigada.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu um Elemental necklace.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            npcHandler:say('Desculpe, você não tem todos amulets necessários.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'spirit elemental amulet') or msgcontains(msg, 'spirit') then
        npcHandler:say('Você deseja trocar o Ialamar, frozzen, sickness, Samantha, Mastafar, priest e o eletric amulet por um Spirit Elemental Amulet?', cid)
        npcHandler.topic[cid] = 5
        
    elseif npcHandler.topic[cid] == 5 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if player:getItemCount(2199) >= 1 and player:getItemCount(2133) >= 1 and 
           player:getItemCount(2130) >= 1 and player:getItemCount(2135) >= 1 and 
           player:getItemCount(2126) >= 1 and player:getItemCount(2131) >= 1 and 
           player:getItemCount(2129) >= 1 then
            
            player:removeItem(2199, 1) -- ialamar
            player:removeItem(2133, 1) -- frozen
            player:removeItem(2130, 1) -- sickness
            player:removeItem(2135, 1) -- samantha
            player:removeItem(2126, 1) -- mastafar  
            player:removeItem(2131, 1) -- priest
            player:removeItem(2129, 1) -- electric
            player:addItem(2173, 1) -- spirit elemental amulet
            npcHandler:say('Pronto! O seu spirit elemental necklace está pronto, obrigada.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu um Spirit Elemental amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            npcHandler:say('Desculpe, você não tem todos amulets necessários.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'magic elemental amulet') or msgcontains(msg, 'magic') then
        npcHandler:say('Você deseja trocar o Merlian, relic of the hell, Broonier, Thordain, dark wyzard, angel e o gaya amulet por um Elemental Magic Amulet?', cid)
        npcHandler.topic[cid] = 6
        
    elseif npcHandler.topic[cid] == 6 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if player:getItemCount(2139) >= 1 and player:getItemCount(2142) >= 1 and 
           player:getItemCount(2132) >= 1 and player:getItemCount(2136) >= 1 and 
           player:getItemCount(2200) >= 1 and player:getItemCount(2196) >= 1 and 
           player:getItemCount(2138) >= 1 then
            
            player:removeItem(2139, 1) -- merlian
            player:removeItem(2142, 1) -- relic of hell
            player:removeItem(2132, 1) -- broonier
            player:removeItem(2136, 1) -- thordain
            player:removeItem(2200, 1) -- dark wizard
            player:removeItem(2196, 1) -- angel
            player:removeItem(2138, 1) -- gaya
            player:addItem(2125, 1) -- magic elemental amulet
            npcHandler:say('Pronto! O seu magic elemental necklace está pronto, obrigada.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu um Magic Elemental amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            npcHandler:say('Desculpe, você não tem todos amulets necessários.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'bless') or msgcontains(msg, 'blessing') then
        npcHandler:say('Você deseja ser abençoado por ' .. (preco * 1000) .. ' gold coins?', cid)
        npcHandler.topic[cid] = 7
        
    elseif npcHandler.topic[cid] == 7 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if bless then
            npcHandler:say('Você já está abençoado, meu pequeno mortal.', cid)
        else
            if player:isPremium() then
                if player:removeMoney(preco * 1000) then
                    for i = 1, 5 do
                        player:addBlessing(i)
                    end
                    player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu a benção de Isolda.")
                    npcHandler:say('Receba essa benção, agora todos os deuses estão olhando por tí.', cid)
                    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                else
                    npcHandler:say('Desculpe, você não tem a quantia necessária.', cid)
                end
            else
                npcHandler:say('Desculpe, eu só posso abençoar Premiums.', cid)
            end
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'the great dark wyzard') or msgcontains(msg, 'poem') then
        npcHandler:say('Você possui o poema de Merlian?', cid)
        npcHandler.topic[cid] = 8
        
    elseif npcHandler.topic[cid] == 8 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if player:removeItem(5952, 1) then
            player:addItem(2453, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest 'The Great Dark Wyzard.' completada.")
            npcHandler:say('Eu posso sentir o poder de Merlian, o grande dark wyzard.', cid)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            npcHandler:say('Desculpe, você não está com o poema.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'uihiui') or msgcontains(msg, 'god') then
        local vocation = player:getVocation():getId()
        local level = player:getLevel()
        
        if vocation < 9 then
            npcHandler:say('Hahaha, você me faz rir caro mortal, apenas valans podem ser tornar Deuses.', cid)
            return true
        end
        
        if level < 500 then
            if vocation < 13 then
                npcHandler:say('Hahaha, você não tem level suficiente para isso humilde semi-deus.', cid)
            else
                npcHandler:say('Essa é uma escolha de extrema sabedoria, você ainda não está preparado.', cid)
            end
            return true
        end
        
        if vocation > 12 then
            local valor = (currentResets * 55 + 5)
            if currentResets == 0 then
                npcHandler:say('Ual, você realmente conseguiu chegar até aqui! Se auto-resetar é uma decisão de extrema sabedoria, e se mal usada pode-ra trazer altos riscos!...', cid)
                npcHandler:say('Como é a sua 1° vez, eu não irei lhe cobrar nada, porém você ainda tem a escolha, você realmente deseja ser resetado?', cid)
            else
                npcHandler:say('Você anda sempre me surpreendendo, você se tornou um uma pessoa de extrema força e sabedoria, com dons de extrema nobreza!...', cid)
                npcHandler:say('Porém dessa vez meus serviços serão cobrados, como esse é o seu '..(currentResets+1)..'° reset, o preço é '..valor..'.000.000 gold coins, deseja proseguir?', cid)
            end
            npcHandler.topic[cid] = 10
            return true
        end
        
        npcHandler:say('Hmm, fico impressionada que você tenha chegado até aqui! Então realmente você deseja se tornar um Deus? Cuidado mortal, essa decisão é irreversivel.', cid)
        npcHandler.topic[cid] = 9
        
    elseif msgcontains(msg, 'reset') then
        if currentResets == 0 then
            npcHandler:say('Reset a god? Hmm... First time? Ok, i will do it free this time!', cid)
            npcHandler.topic[cid] = 11
        else
            npcHandler:say('Reset a god? Hmm... Sure I can, but it will not be cheap, what do you say about ' .. rubys .. ' ruby coins?', cid)
            npcHandler.topic[cid] = 11
        end
        
    elseif msgcontains(msg, 'info') or msgcontains(msg, 'information') then
        npcHandler:say('Current status: Level ' .. player:getLevel() .. ', HP atual: ' .. player:getMaxHealth() .. ', MP atual: ' .. player:getMaxMana() .. ', Resets: ' .. currentResets .. '. Custo próximo reset: ' .. rubys .. ' ruby coins.', cid)
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 9 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        local vocation = player:getVocation():getId()
        
        if vocation < 9 then
            npcHandler:say('Hahaha, você me faz rir caro mortal, apenas valans podem ser tornar Deuses.', cid)
            return true
        end
        
        if player:getLevel() < 500 then
            npcHandler:say('Hahaha, você não tem level suficiente para isso humilde semi-deus.', cid)
            return true
        end
        
        if vocation > 12 then
            npcHandler:say('Você já é um deus, guerreiro.', cid)
            return true
        end
        
        if vocation > 8 and vocation < 13 then
            -- Promote to god vocation (add 4 to vocation ID)
            player:setVocation(Vocation(vocation + 4))
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você evoluiu seu espírito a Deus.")
            npcHandler:say('Oh, um novo Deus! Boa sorte em sua jornada meu caro.', cid)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            npcHandler:say('Você já é um deus, guerreiro.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 10 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        local vocation = player:getVocation():getId()
        local level = player:getLevel()
        
        if vocation < 9 then
            npcHandler:say('Hahaha, você me faz rir caro mortal, apenas valans podem ser tornar Deuses.', cid)
            return true
        end
        
        if level < 500 then
            if vocation < 13 then
                npcHandler:say('Hahaha, você não tem level suficiente para isso humilde semi-deus.', cid)
            else
                npcHandler:say('Essa é uma escolha de extrema sabedoria, você ainda não está preparado.', cid)
            end
            return true
        end
        
        if vocation < 13 then
            npcHandler:say('Você não está preparado para isso humilde semi-deus.', cid)
            return true
        end
        
        if currentResets == 0 then
            if player:doReset() then
                local newResets = player:getReset()
                Game.broadcastMessage("Parabéns! O jogador " .. player:getName() .. " resetou com sucesso e agora tem " .. newResets .. " resets!", MESSAGE_STATUS_WARNING)
                npcHandler:say('Agora sim, sinta esse extremo poder em suas veias! Seja bem vindo, novo Deus resetado.', cid)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Você resetou seu personagem.")
                player:sendTextMessage(MESSAGE_STATUS_WARNING, "Você será desconectado em 5 segundos para finalizar o reset.")
                player:addHealth(player:getMaxHealth())
                player:addMana(player:getMaxMana())
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                
                addEvent(function(playerId)
                    local player = Player(playerId)
                    if player then
                        player:remove()
                    end
                end, 5000, player:getId())
            else
                npcHandler:say('Sorry, reset failed. Check requirements!', cid)
            end
        else
            local cost = (currentResets * 55000000 + 5000000)
            if player:removeMoney(cost) then
                if player:doReset() then
                    local newResets = player:getReset()
                    Game.broadcastMessage("Parabéns! O jogador " .. player:getName() .. " resetou com sucesso e agora tem " .. newResets .. " resets!", MESSAGE_STATUS_WARNING)
                    npcHandler:say('Seu poder agora é ainda maior, parábens '.. player:getName() ..'.', cid)
                    player:sendTextMessage(MESSAGE_INFO_DESCR, "Você resetou seu personagem.")
                    player:sendTextMessage(MESSAGE_STATUS_WARNING, "Você será desconectado em segundos para finalizar o reset.")
                    player:addHealth(player:getMaxHealth())
                    player:addMana(player:getMaxMana())
                    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                    
                    addEvent(function(playerId)
                        local player = Player(playerId)
                        if player then
                            player:remove()
                        end
                    end, 0, player:getId())
                else
                    npcHandler:say('Sorry, reset failed. Check requirements!', cid)
                end
            else
                npcHandler:say('Você não tem '..(currentResets * 55 + 5)..'.000.000 gold coins.', cid)
            end
        end
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 11 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if player:isPremium() then
            if player:getLevel() >= 500 then
                local vocation = player:getVocation():getId()
                if vocation >= 9 then
                    if vocation >= 13 then -- deuses
                        if currentResets == 0 or player:getItemCount(38915) >= rubys then
                            if player:doReset() then
                                local newResets = player:getReset()
                                
                                Game.broadcastMessage("Parabéns! O jogador " .. player:getName() .. " resetou com sucesso e agora tem " .. newResets .. " resets!", MESSAGE_STATUS_WARNING)
                                
                                npcHandler:say('Welcome new god! HP: ' .. player:getMaxHealth() .. ', MP: ' .. player:getMaxMana() .. ', Resets: ' .. newResets, cid)
                                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce resetou seu personagem.")
                                player:sendTextMessage(MESSAGE_STATUS_WARNING, "Você será desconectado em 5 segundos para finalizar o reset.")
                                
                                player:addHealth(player:getMaxHealth())
                                player:addMana(player:getMaxMana())
                                
                                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                                
                                if currentResets > 0 then
                                    player:removeItem(38915, rubys)
                                end
                                
                                addEvent(function(playerId)
                                    local player = Player(playerId)
                                    if player then
                                        player:remove()
                                    end
                                end, 5000, player:getId())
                                
                                npcHandler.topic[cid] = 0
                            else
                                npcHandler:say('Sorry, reset failed. Check requirements!', cid)
                                npcHandler.topic[cid] = 0
                            end
                        else
                            npcHandler:say('Sorry mortal, but you dont have this money!', cid)
                            npcHandler.topic[cid] = 0
                        end
                    else
                        npcHandler:say('Sorry, but only gods i can do that!', cid)
                        npcHandler.topic[cid] = 0
                    end
                else
                    npcHandler:say('Sorry, but only gods i can do that!', cid)
                    npcHandler.topic[cid] = 0
                end
            else
                npcHandler:say('Sorry, but only gods level 500 or above can do that!', cid)
                npcHandler.topic[cid] = 0
            end
        else
            npcHandler:say('Sorry but only can reset a premium god.', cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > 0 then
        npcHandler:say('Ok então.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, 'Olá |PLAYERNAME|! Em que posso lhe ajudar, mortal?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Até logo, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Então tá, tchau.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Proxímo porfavor...')
npcHandler:addModule(FocusModule:new())
