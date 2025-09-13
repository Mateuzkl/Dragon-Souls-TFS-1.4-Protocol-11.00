--------------------------------------------------------------------------------------------
------------------------------------ Advanced Addon NPC ------------------------------------
-------------------------------- Script made by teh_pwnage ---------------------------------
--------------- Special thanks to: mokerhamer, Xidaozu and Jiddo, deaths'life --------------
------------------------------- Thanks also to everyone else -------------------------------
------------------------------ Converted for TFS 1.x ------------------------------
--------------------------------------------------------------------------------------------

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local costPerLevel = 300
local storages = {
    petUid = 60000,
    petIsOnline = 60001
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local talk_state = npcHandler.topic[cid] or 0
    local post = player:getStorageValue(2078)
    local msgLower = msg:lower()
    
    if msgcontains(msgLower, 'mission') and post == 0 then
        npcHandler:say('I am really disappointed with you, but I really need a hand. This is your last chance, do you accept?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msgLower, 'mission') and post == -1 then
        npcHandler:say('Oh, a helper! I really will need that, but this is not a simple job. Do you accept to be my Assistant Postman?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msgLower, 'mission') and post == 1 then
        npcHandler:say('Already lost? I will repeat: we have a problem in one mailbox not far from here. It is locked and I really need those letters. You will need a Crowbar to break it. The mailbox is near the Amazon Camp, west from here.', cid)

    elseif msgcontains(msgLower, 'mission') and post == 2 then
        npcHandler:say('Oh, you back? Did you bring me my letters?', cid)
        npcHandler.topic[cid] = 2

    elseif msgcontains(msgLower, 'mission') and post == 3 then
        npcHandler:say('Oh, you think you are up to the next step? Well here we go. Now that you work for me I cant let you walk with these terrible clothes. Go to Lina in Carlin and talk about Uniform, she will make one for you.', cid)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2078, 4)

    elseif msgcontains(msgLower, 'mission') and post == 4 then
        npcHandler:say('Already lost? Well I will repeat: go to Lina in Carlin and talk about Uniform, she will do one for you.', cid)

    elseif msgcontains(msgLower, 'mission') and post == 7 then
        npcHandler:say('Lets see if you are ready. I got something for you. Find Stelios in Femur Hills and ask about delivery. He will give the delivery for you and will say for who you must deliver. Good luck!', cid)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2078, 8)

    elseif msgcontains(msgLower, 'mission') and post == 8 then
        npcHandler:say('Already Lost? Well I will repeat: find Stelios in Femur Hills, talk about delivery. Good luck!', cid)

    elseif msgcontains(msgLower, 'mission') and post == 10 then
        npcHandler:say('Already done? Good, I need you to be done so we can talk about promotion!', cid)

    elseif msgcontains(msgLower, 'mission') and post == 11 then
        npcHandler:say('Hmm, no work for now, but be alert!', cid)

    elseif msgcontains(msgLower, 'job') then
        npcHandler:say('I am the Master Postman!', cid)

    elseif msgcontains(msgLower, 'offer') then
        npcHandler:say('I am offering the best Postman work in all Lands!', cid)

    elseif msgcontains(msgLower, 'promote') and post == 10 then
        npcHandler:say('Oh, I knew that your delivery was great! So, welcome my new postman! Here is your post officers hat! Now you can access all the PostMans Mailboxes in all the Land!', cid)
        player:addItem(2665, 1)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest 'O carteiro fiel.' completada.")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2078, 11)

    elseif msgcontains(msgLower, 'promote') and (post == 1 or post == 2 or post == 3 or post == 7 or post == 8) then
        npcHandler:say('Promote? Lets work first right?', cid)

    elseif msgcontains(msgLower, 'promote') and post == 11 then
        npcHandler:say('By now, no missions of promotion!', cid)

    -- Mission 1
    elseif msgcontains(msgLower, 'yes') and talk_state == 1 then
        npcHandler:say('Oh, great! We have little problems with a mailbox not far from here. Its locked and I need the letters inside it. With a Crowbar you can break it. The Mailbox is near Amazon Camp west from here.', cid)
        npcHandler:say('Fix it and bring me my letters, if you do it, we talk about Promote.', cid)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nova quest adicionada 'O carteiro fiel.'.")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2078, 1)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msgLower, 'yes') and talk_state == 2 then
        if player:getItemCount(2598) >= 4 then
            npcHandler:say('Oh, Congratulations! You did a great job in this first test. When you are ready we will talk about your next mission.', cid)
            player:removeItem(2598, 4)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(2078, 3)
        else
            npcHandler:say('I need all the letters!', cid)
        end
        npcHandler.topic[cid] = 0

    -- Mission 2 - Uniform
    elseif msgcontains(msgLower, 'uniform') and post == 6 then
        npcHandler:say('So, did you get your uniform?', cid)
        npcHandler.topic[cid] = 3

    elseif msgcontains(msgLower, 'yes') and talk_state == 3 then
        if player:getItemCount(6114) >= 1 then
            npcHandler:say('Oh thats good! You can rest a bit. When you are ready we can talk about your next mission.', cid)
            player:removeItem(6114, 1)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(2078, 7)
        else
            npcHandler:say('Hmm, but where is the uniform?', cid)
        end
        npcHandler.topic[cid] = 0

    -- Pet Revival System
    elseif msgcontains(msgLower, 'revive') then
        local petUid = player:getStorageValue(storages.petUid)
        local petOnline = player:getStorageValue(storages.petIsOnline)
        
        if not Creature(petUid) and petOnline == 2 then
            local cost = player:getLevel() * costPerLevel
            npcHandler:say('YOUR PET DIED?! YOU\'RE A BAD OWNER! This will cost you ' .. cost .. ' gold coins! Agree?!', cid)
            npcHandler.topic[cid] = 4
        elseif petOnline == 1 then
            npcHandler:say('Your pet is alive.', cid)
        else
            npcHandler:say('Your pet is standing next to you.', cid)
        end

    elseif msgcontains(msgLower, 'yes') and talk_state == 4 then
        local cost = player:getLevel() * costPerLevel
        if player:removeTotalMoney(cost) then
            player:setStorageValue(storages.petIsOnline, 1)
            npcHandler:say('You can now summon again your pet.', cid)
        else
            npcHandler:say('You don\'t have enough money.', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msgLower, 'no') and (talk_state >= 1 and talk_state <= 34) then
        npcHandler:say('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end

    return true
end

local function onAddFocus(cid)
    npcHandler.topic[cid] = 0
end

local function onReleaseFocus(cid)
    npcHandler.topic[cid] = nil
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I am the Master Postman, need help with missions or pet revival?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Come back when you need postal services!')

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
