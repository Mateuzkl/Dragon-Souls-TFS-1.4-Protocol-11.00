local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talkState = {}

function onCreatureAppear(cid)
    npcHandler:onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
    npcHandler:onCreatureDisappear(cid)
end

function onCreatureSay(cid, msgType, msg)
    npcHandler:onCreatureSay(cid, msgType, msg)
end

local lastRandomTalk = 0

function onThink()
    npcHandler:onThink()
    
    if not npcHandler:isFocused() then
        local currentTime = os.time()
        if currentTime - lastRandomTalk > 30 then
            lastRandomTalk = currentTime
            local randsay = math.random(1, 100)
            if randsay == 1 or randsay == 50 then
                npcHandler:say('Hicks!')
            end
        end
    end
end

local topicList = {
    NONE = 0,
    QUEST_CONFIRM = 1,
    WATCH_CHECK = 2,
    ENTER_CONFIRM = 3,
    LEAVE_CONFIRM = 4,
    BUY_ITEM1 = 50,
    BUY_ITEM2 = 51
}

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('Who dare to enter our cave!', cid)
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    npcHandler:say('Good bye, ' .. player:getName() .. '!', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        local player = Player(cid)
        if not player then
            return false
        end
        
        if msgcontains(msg, 'hi') then
            npcHandler:say('Who dare to enter our cave!', cid)
            return true
        end
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    -- Initialize talkState if needed
    if not talkState[cid] then
        talkState[cid] = topicList.NONE
    end
    
    local quest = player:getStorageValue(5059)
    
    if msgcontains(msg, 'offer') then
        npcHandler:say('I cant offer you not eaven talk!', cid)
    elseif msgcontains(msg, 'help') then
        npcHandler:say('You are in the wrong place weak!', cid)
    elseif msgcontains(msg, 'mission') then
        npcHandler:say('My mission is to dont let none enter!', cid)
        
    -- Quest logic
    elseif msgcontains(msg, 'enter') and quest == -1 then
        npcHandler:say('Há, do you think I will let anyone enter? I am here to do the oposit!', cid)
        npcHandler:say('But if you are realy interested, I can let you in if you do something for me.', cid)
        npcHandler:say('Do you accept my task?', cid)
        talkState[cid] = topicList.QUEST_CONFIRM
        player:setStorageValue(5059, 1)
        
    elseif talkState[cid] == topicList.QUEST_CONFIRM and msgcontains(msg, 'yes') then
        npcHandler:say('Ok, some days ago, I went to the Black Knights cave to visit an old friend,', cid)
        npcHandler:say('But I think I forgot my Watch there, If you recover it Ill let you in! I think my friend have the watch...', cid)
        npcHandler:say('Tell him Savar sent you.', cid)
        player:setStorageValue(5059, 1)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nova quest adicionada 'O segredo Hero.'.")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        talkState[cid] = topicList.NONE
        
    elseif msgcontains(msg, 'enter') and (quest == 1 or quest == 2) then
        npcHandler:say('I lost my Watch in the Black Knights cave, not too far from here.', cid)
        
    elseif msgcontains(msg, 'enter') and quest == 3 then
        npcHandler:say('Did you manage to bring me back my Watch?', cid)
        talkState[cid] = topicList.WATCH_CHECK
        
    elseif talkState[cid] == topicList.WATCH_CHECK and msgcontains(msg, 'yes') then
        if player:getItemCount(6092) >= 1 then
            player:removeItem(6092, 1)
            npcHandler:say('Thanks alot! It was given by my grandfather to my father, and he gaved it to me.', cid)
            npcHandler:say('As I promissed, come in.', cid)
            npcHandler:say('/send ' .. player:getName() .. ', 759 771 8', cid)
            player:setStorageValue(5059, 4)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest 'O segredo Hero.' Completada!")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            talkState[cid] = topicList.NONE
        else
            npcHandler:say('You dont have it, I lost it in the Black Knights Cave.', cid)
        end
        
    -- Enter/Leave system for completed quest
    elseif msgcontains(msg, 'enter') and quest == 4 then
        npcHandler:say('Do you wana came in?', cid)
        talkState[cid] = topicList.ENTER_CONFIRM
        
    elseif talkState[cid] == topicList.ENTER_CONFIRM and msgcontains(msg, 'yes') then
        npcHandler:say('/send ' .. player:getName() .. ', 759 771 8', cid)
        talkState[cid] = topicList.NONE
        
    elseif msgcontains(msg, 'leave') then
        npcHandler:say('Do you wana leave?', cid)
        talkState[cid] = topicList.LEAVE_CONFIRM
        
    elseif talkState[cid] == topicList.LEAVE_CONFIRM and msgcontains(msg, 'yes') then
        npcHandler:say('/send ' .. player:getName() .. ', 763 771 8', cid)
        talkState[cid] = topicList.NONE
        
    -- Buy items system
    elseif talkState[cid] == topicList.BUY_ITEM1 and msgcontains(msg, 'yes') then
        if player:removeMoney(10) then
            npcHandler:say('It\'s here!', cid)
            player:addItem(2553, 1)
        else
            npcHandler:say('Friend, you don\'t have this money.', cid)
        end
        talkState[cid] = topicList.NONE
        
    elseif talkState[cid] == topicList.BUY_ITEM2 and msgcontains(msg, 'yes') then
        if player:removeMoney(5) then
            npcHandler:say('It\'s here!', cid)
            player:addItem(3942, 6)
        else
            npcHandler:say('Friend, you don\'t have this money.', cid)
        end
        talkState[cid] = topicList.NONE
        
    elseif msgcontains(msg, 'no') and talkState[cid] > topicList.NONE then
        npcHandler:say('Ok than.', cid)
        talkState[cid] = topicList.NONE
    end
    
    return true
end

-- Keywords for basic responses
keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I cant offer you not eaven talk!'
})

keywordHandler:addKeyword({'help'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'You are in the wrong place weak!'
})

keywordHandler:addKeyword({'mission'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'My mission is to dont let none enter!'
})

npcHandler:setMessage(MESSAGE_GREET, 'Who dare to enter our cave!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then. Continue Training!')
npcHandler:setMessage(MESSAGE_DECLINE, 'Go away you too.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
