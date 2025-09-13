local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local msgLower = msg:lower()
    local cook = player:getStorageValue(30006)
    local pao = player:getStorageValue(2689)

    if msgcontains(msgLower, 'yes') then
        if pao == -1 then  -- Primeira vez
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nova quest adicionada 'Aprendendo a cozinhar!'.")
            npcHandler:say('Well lets begin! Our first lesson is simple, i need you to bring "wheat", that can be obtained using a "scythe" in a "wheat field", so then, lets do it!', cid)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(2689, 1)
            player:setStorageValue(30006, 1)
        elseif pao == 1 and player:getItemCount(2694) >= 1 then  -- Tem wheat
            npcHandler:say('Great! Now its simple, you need to transform "wheat" in "flour", using a "mill", lets do it!', cid)
            player:setStorageValue(2689, 2)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        elseif pao == 2 and player:getItemCount(2692) >= 1 then  -- Tem flour
            npcHandler:say('Excellent! Our last step! Add water to the "flour", to do the "dough", then put in this oven here and voila!', cid)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(2689, 3)
        else
            npcHandler:say('You need to complete the current step first!', cid)
        end

    elseif msgcontains(msgLower, 'no') then
        npcHandler:say('Ok then, come back when you are ready to learn!', cid)

    elseif msgcontains(msgLower, 'done') then
        if pao == 3 then
            npcHandler:say('Congratulations ' .. player:getName() .. '! You have completed your first cooking lesson! Come back later for advanced lessons!', cid)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(30006, 2)
            player:setStorageValue(2689, 4)
        else
            npcHandler:say('You haven\'t finished the bread making yet!', cid)
        end

    elseif msgcontains(msgLower, 'help') or msgcontains(msgLower, 'wheat') then
        if pao == 1 then
            npcHandler:say('Use a scythe on wheat fields to get wheat. Then come back to me.', cid)
        elseif pao == 2 then
            npcHandler:say('Use wheat on a mill to make flour. Then come back to me.', cid)
        elseif pao == 3 then
            npcHandler:say('Add water to flour to make dough, then use dough on an oven to make bread. Say "done" when finished.', cid)
        else
            npcHandler:say('Say "yes" to start learning how to cook!', cid)
        end
    end

    return true
end

local function onAddFocus(cid)
    local player = Player(cid)
    if not player then return end
    
    local cook = player:getStorageValue(30006)
    local pao = player:getStorageValue(2689)
    
    if cook == 2 then
        npcHandler:say('Hello again ' .. player:getName() .. '! I am very busy right now, our lesson will have to wait for another day!', cid)
        npcHandler:releaseFocus(cid)
    elseif pao == 1 then
        npcHandler:say('Hello ' .. player:getName() .. '! Got the wheat I asked for?', cid)
    elseif pao == 2 then
        npcHandler:say('Hello ' .. player:getName() .. '! Got the flour?', cid)
    elseif pao == 3 then
        npcHandler:say('Hello ' .. player:getName() .. '! Have you made the bread yet? Say "done" when ready!', cid)
    end
end

local function onReleaseFocus(cid)
    local player = Player(cid)
    if not player then return end

    local cook = player:getStorageValue(30006)
    if cook == 2 then
        return
    end
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I am the master cooker of the town, wana learn to cook?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Come back when you want to learn cooking!')

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
