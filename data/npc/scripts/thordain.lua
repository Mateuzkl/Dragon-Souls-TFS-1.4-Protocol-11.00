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

local QUEST_STORAGES = {
    thordainQuest = 30004,  -- Dwarven axe quest
    karceQuest = 31001,     -- Kar'ce sword quest  
    warhkQuest = 31002      -- Warhk devil quest
}

local ALERT_TIMES = {
    axeWait = 300,          -- 5 minutes for axe crafting
    swordWait = 1800        -- 30 minutes for sword analysis
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
    local level = player:getLevel()
    local addon = player:getStorageValue(QUEST_STORAGES.thordainQuest)
    local karce = player:getStorageValue(QUEST_STORAGES.karceQuest)
    local karce2 = player:getStorageValue(QUEST_STORAGES.warhkQuest)
    local msgLower = msg:lower()
    
    -- Basic responses
    if msgcontains(msgLower, 'monster') then
        npcHandler:say('I kill monsters.', cid)

    elseif msgcontains(msgLower, 'job') then
        npcHandler:say('Oh my young, now I\'m just a blacksmith, only for hobby!', cid)

    elseif msgcontains(msgLower, 'offer') then
        npcHandler:say('The only thing I can offer you is the knowledge of what I have experienced until now!', cid)

    elseif msgcontains(msgLower, 'sell') or msgcontains(msgLower, 'buy') then
        npcHandler:say('I am not a merchant!', cid)

    elseif msgcontains(msgLower, 'quest') then
        npcHandler:say('I am not getting involved in quests anymore!', cid)

    elseif msgcontains(msgLower, 'dwarf') then
        npcHandler:say('I am a dwarfcrafter! I can make you a dwarven axe!', cid)

    elseif msgcontains(msgLower, 'knowledge') then
        npcHandler:say('I have been on long trips and quests! One more dangerous than the other, now I am just a blacksmith!', cid)

    -- Kar'ce Sword Quest System
    elseif msgcontains(msgLower, 'warkh') and karce2 == 1 then
        npcHandler:say('Warkh is an older Devil, but he became good, it\'s a long story! You can find him in Edron, the fire elementals next to him keep him strong and happy.', cid)

    elseif msgcontains(msgLower, 'mission') and karce == -1 then
        npcHandler:say('I am not getting involved in missions anymore!', cid)

    elseif msgcontains(msgLower, 'mission') and karce == 4 and karce2 == -1 then
        npcHandler:say('Oh, you\'re back! This destruction cannot be made by my hands, it must be destroyed at the same place it was made, but I\'m too old for this. Do you really want to try to destroy this?', cid)
        npcHandler.topic[cid] = 5

    elseif msgcontains(msgLower, 'mission') and karce2 == 1 then
        npcHandler:say('Oh, you\'re here again? So, how was your trip to the mountain Dhur?', cid)

    elseif msgcontains(msgLower, 'kar') then
        if karce == 1 then
            if player:getItemCount(2392) >= 1 then
                npcHandler:say('This presence! That in your hand! I can feel the presence of Kar\'ce here! You need to destroy it!', cid)
                npcHandler:say('I can try to destroy it, but I need one thing: bring me 10 pure small diamonds, as fast as you can!', cid)
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
                player:setStorageValue(QUEST_STORAGES.karceQuest, 2)
            else
                npcHandler:say('Kar\'ce, Kar\'ce, a great enemy! Just his presence in the war burned our hearts!', cid)
            end
        else
            npcHandler:say('Kar\'ce, Kar\'ce, a great enemy! Just his presence in the war burned our hearts!', cid)
        end

    elseif msgcontains(msgLower, 'small diamond') and karce == 2 then
        if player:getItemCount(2145) >= 10 and player:getItemCount(2392) >= 1 then
            npcHandler:say('Nice job young! I will need some time, come back here in 30 minutes, and ask me if I\'m done.', cid)
            player:removeItem(2145, 10)
            player:removeItem(2392, 1)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(QUEST_STORAGES.karceQuest, 3)
            player:setStorageValue(50000, os.time()) -- Timer storage
        else
            npcHandler:say('I need the diamonds and the Kar\'ce sword!', cid)
        end

    elseif msgcontains(msgLower, 'did') and karce == 3 then
        local currentTime = os.time()
        local waitTime = player:getStorageValue(50000)
        if waitTime == -1 or (currentTime - waitTime) < ALERT_TIMES.swordWait then
            npcHandler:say('Not done yet, I need more time!', cid)
        else
            npcHandler:say('Oh, you\'re back! Sorry, this destruction cannot be made by my hands. This must be destroyed at the same place it was made, but I\'m old for this. Take this item for your loyalty. Do you really want to try to destroy this?', cid)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You receive a Silver mace.")
            local silver = player:addItem(2424, 1)
            if silver then
                silver:setAttribute(ITEM_ATTRIBUTE_TEXT, "It's a gift of Thordain.")
            end
            player:setStorageValue(QUEST_STORAGES.karceQuest, 4)
            npcHandler.topic[cid] = 5
        end

    -- Dwarven Axe Quest System
    elseif msgcontains(msgLower, 'dwarven') and addon == -1 then
        npcHandler:say('Hmm... I can give you one, a gift because you are so far from home. Just bring me a hatchet, ok?', cid)
        npcHandler.topic[cid] = 2

    elseif msgcontains(msgLower, 'dwarven') and addon == 1 then
        npcHandler:say('Did you bring me the hatchet?', cid)
        npcHandler.topic[cid] = 3

    elseif msgcontains(msgLower, 'dwarven') and addon == 2 then
        npcHandler:say('Great job! Just ask me for your axe!', cid)

    elseif msgcontains(msgLower, 'dwarven') and addon >= 3 then
        npcHandler:say('Did I do a great job on yours?', cid)

    elseif msgcontains(msgLower, 'axe') and addon == 2 then
        local currentTime = os.time()
        local waitTime = player:getStorageValue(50001)
        if waitTime == -1 or (currentTime - waitTime) < ALERT_TIMES.axeWait then
            npcHandler:say('The axe is not done yet, come back later.', cid)
        else
            player:addItem(2435, 1)
            npcHandler:say('Just in time! Hope you like it, my gift!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest 'Uma simples troca.' completed.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(QUEST_STORAGES.thordainQuest, 3)
        end

    -- Confirmation responses
    elseif msgcontains(msgLower, 'yes') and talk_state == 2 then
        addon = player:getStorageValue(QUEST_STORAGES.thordainQuest)
        if addon == -1 then
            npcHandler:say('Great! I will be waiting for you!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "New quest added: 'Uma simples troca.'")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(QUEST_STORAGES.thordainQuest, 1)
        else
            npcHandler:say('Sorry, you already have taken yours.', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msgLower, 'yes') and talk_state == 3 then
        if player:getItemCount(2388) >= 1 then
            addon = player:getStorageValue(QUEST_STORAGES.thordainQuest)
            if addon == -1 or addon == 1 then
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
                player:setStorageValue(QUEST_STORAGES.thordainQuest, 2)
                player:setStorageValue(50001, os.time()) -- Timer storage
                player:removeItem(2388, 1)
                npcHandler:say('Great! It will be done in 5 minutes! Come back later and ask for your axe!', cid)
            else
                npcHandler:say('Sorry, you already have taken yours.', cid)
            end
        else
            npcHandler:say('Where is the hatchet?', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msgLower, 'yes') and talk_state == 5 then
        if level >= 100 then
            npcHandler:say('You are really brave! So that is what we want to do. Where Kar\'ce made this sword, on Mountain Dhur, it\'s really hot there, you will not survive, so we need to increase your resistance!', cid)
            npcHandler:say('I have an old friend that can help you, his name is Warkh. Don\'t be afraid, he is a good devil. Tell him Thordain sent you, and you must train the resistance. DON\'T tell him about Kar\'ce!', cid)
            npcHandler:say('Take that! And good luck, so many things depend on you!', cid)
            local sword = player:addItem(2392, 1)
            if sword then
                sword:setAttribute(ITEM_ATTRIBUTE_TEXT, "The sword of Kar'ce 'The Flame of Kar'ce' is engraved on it.")
                sword:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 100)
            end
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You receive the sword of Kar'ce.")
            player:setStorageValue(QUEST_STORAGES.warhkQuest, 1)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        else
            npcHandler:say("You are really novice for that. I guess level 100 is good for you to try. Ask about mission when you're ready!", cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msgLower, 'no') and talk_state >= 1 then
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

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I am Thordain, the old dwarven blacksmith. Ask me about my knowledge or dwarven crafts!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Farewell, |PLAYERNAME|! May your weapons serve you well!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Come back if you need my smithing skills!')

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
