local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

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
    local vezes = getResets and getResets(cid) or 0
    local rubys = math.floor((player:getLevel() * 4000) * (vezes * 30 * 2) / 1000000)
    
    if msgcontains(msg, 'neckla4ce') then
        selfSay('I only need a mysterious, dragon breath, scorpion, platinum, fluids and vampire tooth, accept change all for a Elemental necklace?', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'amul3et') then
        selfSay('I only need a Ialamar, frozzen, sickness, Samantha, Mastafar, priest and eletric, accept change all for a Spirit Elemental amulet?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'mag3ic') then
        selfSay('I only need a Merlian, relic of the hell, Broonier, Thordain, dark wyzard, angel and gaya, accept change all for a Elemental magic amulet?', cid)
        npcHandler.topic[cid] = 3
        
    elseif msgcontains(msg, 'ener3gyze') then
        selfSay('I can energyze your necklace for 50k, amulet for 100k or your magic amulet for 150k, do you want energyze?', cid)
        npcHandler.topic[cid] = 4
        
    elseif msgcontains(msg, 'bles3s') or msgcontains(msg, 'blessing') then
        selfSay('Bless a mortal? Hmm... Sure I can bless, but it will not be cheap, what do you say about ' .. preco .. 'k?', cid)
        npcHandler.topic[cid] = 5
        
    elseif msgcontains(msg, 'valan') then
        if vezes == -1 or vezes == 0 then
            selfSay('Reset a valan? Hmm... First time? Ok, i will do it free this time!', cid)
            npcHandler.topic[cid] = 6
        else
            selfSay('Reset a valan? Hmm.. Sure I can, But it will not be cheap, what do you say about 10 ruby coins?', cid)
            npcHandler.topic[cid] = 6
        end
        
    elseif msgcontains(msg, 'job') then
        selfSay('I am a servent of Merlian!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('say valan', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('Ha! You are only a novice!', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('Ha! You are only a novice!', cid)
        
    elseif npcHandler.topic[cid] == 1 and msgcontains(msg, 'yes') then
        if player:getItemCount(2198) >= 1 and player:getItemCount(2161) >= 1 and player:getItemCount(2170) >= 1 and 
           player:getItemCount(2171) >= 1 and player:getItemCount(2172) >= 1 and player:getItemCount(2201) >= 1 then
            selfSay('Its all yours!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um Elemental necklace.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:removeItem(2198, 1)
            player:removeItem(2161, 1)
            player:removeItem(2170, 1)
            player:removeItem(2171, 1)
            player:removeItem(2172, 1)
            player:removeItem(2201, 1)
            player:addItem(2197, 1)
        else
            selfSay('You dont have this itens!', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 2 and msgcontains(msg, 'yes') then
        if player:getItemCount(2129) >= 1 and player:getItemCount(2133) >= 1 and player:getItemCount(2130) >= 1 and
           player:getItemCount(2199) >= 1 and player:getItemCount(2135) >= 1 and player:getItemCount(2126) >= 1 and
           player:getItemCount(2131) >= 1 then
            selfSay('Its all yours!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um Spirit Elemental amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:removeItem(2129, 1)
            player:removeItem(2133, 1)
            player:removeItem(2130, 1)
            player:removeItem(2199, 1)
            player:removeItem(2135, 1)
            player:removeItem(2126, 1)
            player:removeItem(2131, 1)
            player:addItem(2173, 1)
        else
            selfSay('You dont have this itens!', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 3 and msgcontains(msg, 'yes') then
        if player:getItemCount(2218) >= 1 and player:getItemCount(2142) >= 1 and player:getItemCount(2132) >= 1 and
           player:getItemCount(2136) >= 1 and player:getItemCount(2138) >= 1 and player:getItemCount(2200) >= 1 and
           player:getItemCount(2196) >= 1 then
            selfSay('Its all yours!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um Elemental magic amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:removeItem(2218, 1)
            player:removeItem(2142, 1)
            player:removeItem(2132, 1)
            player:removeItem(2136, 1)
            player:removeItem(2138, 1)
            player:removeItem(2200, 1)
            player:removeItem(2196, 1)
            player:addItem(2125, 1)
        else
            selfSay('You dont have this itens!', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 4 and msgcontains(msg, 'yes') then
        if player:getItemCount(2197) >= 1 and player:removeMoney(50000) then
            selfSay('Its all yours!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce energizou seu Elemental necklace.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:removeItem(2197, 1)
            player:addItem(13682, 1)
        elseif player:getItemCount(2173) >= 1 and player:removeMoney(100000) then
            selfSay('Its all yours!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce energizou seu Spirit Elemental amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:removeItem(2173, 1)
            player:addItem(13683, 1)
        elseif player:getItemCount(2125) >= 1 and player:removeMoney(150000) then
            selfSay('Its all yours!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce energizou seu Elemental magic amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:removeItem(2125, 1)
            player:addItem(13684, 1)
        else
            selfSay('You dont have this item or money!', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 5 and msgcontains(msg, 'yes') then
        if bless then
            selfSay('You are already blessed my little mortal.', cid)
        else
            if player:isPremium() and player:removeMoney(preco * 1000) then
                selfSay('Receive this bless mortal, with the gods touch i bless you!', cid)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu a bencao de Isolda.")
                player:addBlessing(1)
                player:addBlessing(2)
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            else
                selfSay('Sorry mortal, but you dont have this money or are not premium!', cid)
            end
        end
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 6 and msgcontains(msg, 'yes') then
        if player:isPremium() and player:getLevel() >= 200 then
            if vezes <= 0 and player:getVocation():getId() >= 1 and player:getVocation():getId() < 5 then
                if player:getItemCount(2160) >= 10 then
                    selfSay('Oh! Now you are a Valan!', cid)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce evoluiu seu espirito a Valan.")
                    player:removeExperience(player:getExperience())
                    player:addExperience(4200)
                    player:setMaxHealth(185)
                    player:addHealth(185)
                    player:setMaxMana(35)
                    player:addMana(35)
                    player:setCapacity(360)
                    
                    if player:getVocation():getId() >= 1 and player:getVocation():getId() < 3 then
                        player:addMagicLevel(15)
                    elseif player:getVocation():getId() == 3 then
                        player:addMagicLevel(2)
                        player:addSkillLevel(SKILL_DISTANCE, 15)
                        player:addSkillLevel(SKILL_SHIELD, 15)
                    elseif player:getVocation():getId() == 4 then
                        player:addMagicLevel(1)
                        player:addSkillLevel(SKILL_FIST, 15)
                        player:addSkillLevel(SKILL_CLUB, 15)
                        player:addSkillLevel(SKILL_SWORD, 15)
                        player:addSkillLevel(SKILL_AXE, 15)
                        player:addSkillLevel(SKILL_SHIELD, 15)
                    end
                    
                    player:setVocation(Vocation(player:getVocation():getId() + 8))
                    player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
                    player:removeItem(2160, 10)
                else
                    selfSay('Sorry, but you dont have 10 Crystal Coins!', cid)
                end
            else
                selfSay('Reset system for gods level 500+ would go here.', cid)
            end
        else
            selfSay('Sorry, but only premium level 200+ can do that!', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
