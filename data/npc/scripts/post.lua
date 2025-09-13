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

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

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
    
    if msgcontains(msg, 'mission') and post == 0 then
        selfSay('I am really disappointed with you, but I really need a hand. This is your last chance, do you accept?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msg, 'mission') and post == -1 then
        selfSay('Oh, a helper! I really will need that, but this is not a simple job. Do you accept to be my Assistant Postman?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msg, 'mission') and post == 1 then
        selfSay('Already lost? I will repeat: we have a problem in one mailbox not far from here. It is locked and I really need those letters. You will need a Crowbar to break it. The mailbox is near the Amazon Camp, west from here.', cid)

    elseif msgcontains(msg, 'mission') and post == 2 then
        selfSay('Oh, you back? Did you bring me my letters?', cid)
        npcHandler.topic[cid] = 2

    elseif msgcontains(msg, 'mission') and post == 3 then
        selfSay('Oh, you think you are up to the next step? Well here we go. Now that you work for me I cant let you walk with these terrible clothes. Go to Lina in Carlin and talk about Uniform, she will make one for you.', cid)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2078, 4)

    elseif msgcontains(msg, 'mission') and post == 4 then
        selfSay('Already lost? Well I will repeat: go to Lina in Carlin and talk about Uniform, she will do one for you.', cid)

    elseif msgcontains(msg, 'mission') and post == 7 then
        selfSay('Lets see if you are ready. I got something for you. Find Stelios in Femur Hills and ask about delivery. He will give the delivery for you and will say for who you must deliver. Good luck!', cid)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2078, 8)

    elseif msgcontains(msg, 'mission') and post == 8 then
        selfSay('Already Lost? Well I will repeat: find Stelios in Femur Hills, talk about delivery. Good luck!', cid)

    elseif msgcontains(msg, 'mission') and post == 10 then
        selfSay('Already done? Good, I need you to be done so we can talk about promotion!', cid)

    elseif msgcontains(msg, 'mission') and post == 11 then
        selfSay('Hmm, no work for now, but be alert!', cid)

    elseif msgcontains(msg, 'job') then
        selfSay('I am the Master Postman!', cid)

    elseif msgcontains(msg, 'offer') then
        selfSay('I am offering the best Postman work in all Lands!', cid)

    elseif msgcontains(msg, 'promote') and post == 10 then
        selfSay('Oh, I knew that your delivery was great! So, welcome my new postman! Here is your post officers hat! Now you can access all the PostMans Mailboxes in all the Land!', cid)
        player:addItem(2665, 1)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest 'O carteiro fiel.' completada.")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2078, 11)

    elseif msgcontains(msg, 'promote') and (post == 1 or post == 2 or post == 3 or post == 7 or post == 8) then
        selfSay('Promote? Lets work first right?', cid)

    elseif msgcontains(msg, 'promote') and post == 11 then
        selfSay('By now, no missions of promotion!', cid)

    -- Mission 1
    elseif msgcontains(msg, 'yes') and talk_state == 1 then
        selfSay('Oh, great! We have little problems with a mailbox not far from here. Its locked and I need the letters inside it. With a Crowbar you can break it. The Mailbox is near Amazon Camp west from here.', cid)
        selfSay('Fix it and bring me my letters, if you do it, we talk about Promote.', cid)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nova quest adicionada 'O carteiro fiel.'.")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2078, 1)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'yes') and talk_state == 2 then
        if player:getItemCount(2598) >= 4 then
            selfSay('Oh, Congratulations! You did a great job in this first test. When you are ready we will talk about your next mission.', cid)
            player:removeItem(2598, 4)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(2078, 3)
        else
            selfSay('I need all the letters!', cid)
        end
        npcHandler.topic[cid] = 0

    -- Mission 2 - Uniform
    elseif msgcontains(msg, 'uniform') and post == 6 then
        selfSay('So, did you get your uniform?', cid)
        npcHandler.topic[cid] = 3

    elseif msgcontains(msg, 'yes') and talk_state == 3 then
        if player:getItemCount(6114) >= 1 then
            selfSay('Oh thats good! You can rest a bit. When you are ready we can talk about your next mission.', cid)
            player:removeItem(6114, 1)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(2078, 7)
        else
            selfSay('Hmm, but where is the uniform?', cid)
        end
        npcHandler.topic[cid] = 0

    -- Pet Revival System
    elseif msgcontains(msg, 'revive') then
        local petUid = player:getStorageValue(storages.petUid)
        local petOnline = player:getStorageValue(storages.petIsOnline)
        
        if not Creature(petUid) and petOnline == 2 then
            local cost = player:getLevel() * costPerLevel
            selfSay('YOUR PET DIED?! YOU\'RE A BAD OWNER! This will cost you ' .. cost .. ' gold coins! Agree?!', cid)
            npcHandler.topic[cid] = 4
        elseif petOnline == 1 then
            selfSay('Your pet is alive.', cid)
        else
            selfSay('Your pet is standing next to you.', cid)
        end

    elseif msgcontains(msg, 'yes') and talk_state == 4 then
        local cost = player:getLevel() * costPerLevel
        if player:removeTotalMoney(cost) then
            player:setStorageValue(storages.petIsOnline, 1)
            selfSay('You can now summon again your pet.', cid)
        else
            selfSay('You don\'t have enough money.', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end

    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
