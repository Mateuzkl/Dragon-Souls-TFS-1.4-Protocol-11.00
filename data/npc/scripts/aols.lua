--------------------------------------------------------------------------------------------
------------------------------------ Advanced Addon NPC ------------------------------------
-------------------------------- Script made by teh_pwnage ---------------------------------
--------------- Special thanks to: mokerhamer, Xidaozu and Jiddo, deaths'life --------------
------------------------------- Thanks also to everyone else -------------------------------
------------------------------ NPC based on Evolutions V0.7.7 ------------------------------
-------------------------------- Converted to modern format --------------------------------
----------------------- Adapted for TFS 1.4 Protocol 11.00 by Mateus Roberto --------------
--------------------------------------------------------------------------------------------

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local voices = { {text = "I can help you with elemental items and blessings!"} }
npcHandler:addModule(VoiceModule:new(voices))

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am a servant of Merlian!'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'I can help you with several services:\n\n{Necklace} - Combine 6 necklaces into Elemental Necklace\n{Amulet} - Combine 7 amulets into Spirit Elemental Amulet\n{Magic} - Combine 7 magic amulets into Elemental Magic Amulet\n\n{Energize} (or {energy}, {ener}) - Upgrade your items:\n  - Necklace: 50k gold\n  - Amulet: 100k gold\n  - Magic Amulet: 150k gold\n\n{Bless} (or {blessing}) - Get all 5 blessings (Premium only)\n{Reset} - Reset your god character (Level 500+, God vocation)\n{Info} - Check your current stats and reset cost'})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = 'I am not a merchant!'})
keywordHandler:addKeyword({'buy'}, StdModule.say, {npcHandler = npcHandler, text = 'I am not a merchant!'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, text = 'Ha! You are only a novice!'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, text = 'Ha! You are only a novice!'})

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local preco = player:getLevel() * 3
    local bless = player:hasBlessing(1)
    local currentResets = player:getReset()
    local rubys = math.floor((player:getLevel() * 4000) * (currentResets * 30 * 2) / 1000000)

    if msgcontains(msg, 'necklace') then
        npcHandler:say('I only need a mysterious, dragon breath, scorpion, platinum, fluids and vampire tooth, accept change all for a Elemental necklace?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msg, 'amulet') then
        npcHandler:say('I only need a Ialamar, frozen, sickness, Samantha, Mastafar, priest and electric, accept change all for a Spirit Elemental amulet?', cid)
        npcHandler.topic[cid] = 2

    elseif msgcontains(msg, 'magic') then
        npcHandler:say('I only need a Merlian, relic of the hell, Broonier, Thordain, dark wizard, angel and gaya, accept change all for a Elemental magic amulet?', cid)
        npcHandler.topic[cid] = 3

    elseif msgcontains(msg, 'energize') or msgcontains(msg, 'energy') or msgcontains(msg, 'ener') then
        npcHandler:say('I can energize your items to make them more powerful!\n\nElemental Necklace (ID 2197) - 50,000 gold\nSpirit Elemental Amulet (ID 2173) - 100,000 gold\nElemental Magic Amulet (ID 38894) - 150,000 gold\n\nDo you want to energize one of your items?', cid)
        npcHandler.topic[cid] = 4

    elseif msgcontains(msg, 'bless') or msgcontains(msg, 'blessing') then
        npcHandler:say('Bless a mortal? Hmm... Sure I can bless, but it will not be cheap, what do you say about ' .. preco .. 'k?', cid)
        npcHandler.topic[cid] = 5

    elseif msgcontains(msg, 'reset') then
        if currentResets == 0 then
            npcHandler:say('Reset a god? Hmm... First time? Ok, i will do it free this time!', cid)
            npcHandler.topic[cid] = 6
        else
            npcHandler:say('Reset a god? Hmm... Sure I can, but it will not be cheap, what do you say about ' .. rubys .. ' ruby coins?', cid)
            npcHandler.topic[cid] = 6
        end

    elseif msgcontains(msg, 'info') or msgcontains(msg, 'information') then
        npcHandler:say('Current status: Level ' .. player:getLevel() .. ', HP atual: ' .. player:getMaxHealth() .. ', MP atual: ' .. player:getMaxMana() .. ', Resets: ' .. currentResets .. '. Custo próximo reset: ' .. rubys .. ' ruby coins.', cid)
        npcHandler.topic[cid] = 0

    elseif npcHandler.topic[cid] == 1 then -- Necklace
        if msgcontains(msg, 'yes') then
            if player:getItemCount(2198) >= 1 and player:getItemCount(2161) >= 1 and 
               player:getItemCount(2170) >= 1 and player:getItemCount(2171) >= 1 and 
               player:getItemCount(2172) >= 1 and player:getItemCount(2201) >= 1 then
                
                npcHandler:say('Its all yours!', cid)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu um Elemental necklace.")
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                
                player:removeItem(2198, 1)
                player:removeItem(2161, 1)
                player:removeItem(2170, 1)
                player:removeItem(2171, 1)
                player:removeItem(2172, 1)
                player:removeItem(2201, 1)
                player:addItem(38906, 1)
                npcHandler.topic[cid] = 0
            else
                npcHandler:say('You dont have these items!', cid)
                npcHandler.topic[cid] = 0
            end
        end

    elseif npcHandler.topic[cid] == 2 then -- Amulet
        if msgcontains(msg, 'yes') then
            if player:getItemCount(2129) >= 1 and player:getItemCount(2133) >= 1 and 
               player:getItemCount(2130) >= 1 and player:getItemCount(2199) >= 1 and 
               player:getItemCount(2135) >= 1 and player:getItemCount(2126) >= 1 and 
               player:getItemCount(2131) >= 1 then
                
                npcHandler:say('Its all yours!', cid)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu um Spirit Elemental amulet.")
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                
                player:removeItem(2129, 1)
                player:removeItem(2133, 1)
                player:removeItem(2130, 1)
                player:removeItem(2199, 1)
                player:removeItem(2135, 1)
                player:removeItem(2126, 1)
                player:removeItem(2131, 1)
                player:addItem(38901, 1)
                npcHandler.topic[cid] = 0
            else
                npcHandler:say('You dont have these items!', cid)
                npcHandler.topic[cid] = 0
            end
        end

    elseif npcHandler.topic[cid] == 3 then -- Magic Amulet
        if msgcontains(msg, 'yes') then
            if player:getItemCount(2218) >= 1 and player:getItemCount(2142) >= 1 and 
               player:getItemCount(2132) >= 1 and player:getItemCount(2136) >= 1 and 
               player:getItemCount(2138) >= 1 and player:getItemCount(2200) >= 1 and 
               player:getItemCount(2196) >= 1 then
                
                npcHandler:say('Its all yours!', cid)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu um Elemental magic amulet.")
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                
                player:removeItem(2218, 1)
                player:removeItem(2142, 1)
                player:removeItem(2132, 1)
                player:removeItem(2136, 1)
                player:removeItem(2138, 1)
                player:removeItem(2200, 1)
                player:removeItem(2196, 1)
                player:addItem(38900, 1)
                npcHandler.topic[cid] = 0
            else
                npcHandler:say('You dont have these items!', cid)
                npcHandler.topic[cid] = 0
            end
        end

    elseif npcHandler.topic[cid] == 4 then -- Energize
        if msgcontains(msg, 'yes') and player:getItemCount(2197) >= 1 then
            if player:removeMoney(50000) then
                npcHandler:say('Its all yours!', cid)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce energizou seu Elemental necklace.")
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                player:removeItem(2197, 1)
                player:addItem(38906, 1)
                npcHandler.topic[cid] = 0
            else
                npcHandler:say('You dont have this money!', cid)
                npcHandler.topic[cid] = 0
            end

        elseif msgcontains(msg, 'yes') and player:getItemCount(2173) >= 1 then
            if player:removeMoney(100000) then
                npcHandler:say('Its all yours!', cid)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce energizou seu Spirit Elemental amulet.")
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                player:removeItem(2173, 1)
                player:addItem(38901, 1)
                npcHandler.topic[cid] = 0
            else
                npcHandler:say('You dont have this money!', cid)
                npcHandler.topic[cid] = 0
            end

        elseif msgcontains(msg, 'yes') and player:getItemCount(38894) >= 1 then
            if player:removeMoney(150000) then
                npcHandler:say('Its all yours!', cid)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce energizou seu Elemental magic amulet.")
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                player:removeItem(38894, 1)
                player:addItem(38900, 1)
                npcHandler.topic[cid] = 0
            else
                npcHandler:say('You dont have this money!', cid)
                npcHandler.topic[cid] = 0
            end
        else
            npcHandler:say('You dont have this item!', cid)
            npcHandler.topic[cid] = 0
        end

    elseif npcHandler.topic[cid] == 5 then -- Bless
        if msgcontains(msg, 'yes') then
            if bless then
                npcHandler:say('You are already blessed my little mortal.', cid)
                npcHandler.topic[cid] = 0
            else
                if player:isPremium() then
                    if player:removeMoney(preco * 1000) then
                        npcHandler:say('Receive this bless mortal, with the gods touch i bless you!', cid)
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu a bencao de Isolda.")
                        for i = 1, 5 do
                            player:addBlessing(i)
                        end
                        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                        npcHandler.topic[cid] = 0
                    else
                        npcHandler:say('Sorry mortal, but you dont have this money!', cid)
                        npcHandler.topic[cid] = 0
                    end
                else
                    npcHandler:say('Sorry but only can bless a premium mortal.', cid)
                    npcHandler.topic[cid] = 0
                end
            end
        end

    elseif npcHandler.topic[cid] == 6 then -- Reset
        if msgcontains(msg, 'yes') then
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
        end

    elseif msgcontains(msg, 'no') and (npcHandler.topic[cid] >= 1 and npcHandler.topic[cid] <= 6) then
        npcHandler:say('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end

    return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
