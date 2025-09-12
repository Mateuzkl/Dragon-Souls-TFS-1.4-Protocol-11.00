local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              
    npcHandler:onCreatureAppear(cid)
    npcHandler:say('Help!')
end

function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end

local lastRandomTalk = 0

function onThink()                          
    npcHandler:onThink()
    
    -- Random help messages when not focused
    if not npcHandler:isFocused() then
        local currentTime = os.time()
        if currentTime - lastRandomTalk > 30 then -- Talk every 30 seconds max
            lastRandomTalk = currentTime
            local randsay = math.random(1, 100)
            if randsay == 1 then
                npcHandler:say('Help!')
            elseif randsay == 50 then
                npcHandler:say('Here! I need help!')
            elseif randsay == 100 then
                npcHandler:say('Help me please!')
            end
        end
    end
end

local topicList = {
    NONE = 0,
    LETTER_CONFIRM = 1
}

local function greetCallback(cid)
    local player = Player(cid)
    local addon = player:getStorageValue(30000)
    
    if addon == 2 then
        npcHandler:say('Thanks god! I was losing my hope... I am damaged, can you take a message from me to the queen?', cid)
        npcHandler.topic[cid] = topicList.LETTER_CONFIRM
    else
        npcHandler:say('What you doing here? Take a message from the queen!', cid)
        npcHandler.topic[cid] = topicList.NONE
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
        return false
    end
    
    local player = Player(cid)
    
    if npcHandler.topic[cid] == topicList.LETTER_CONFIRM and msgcontains(msg, 'yes') then
        player:setStorageValue(30000, 3)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        
        local letter = player:addItem(2598, 1)
        if letter then
            letter:setAttribute(ITEM_ATTRIBUTE_TEXT, "Dagmar was on attack, we need your help my queen! By Narzan.")
        end
        
        npcHandler:say('Say to her that you have a message from Narzan... Run, we have no time!', cid)
        npcHandler.topic[cid] = topicList.NONE
    elseif npcHandler.topic[cid] == topicList.LETTER_CONFIRM and msgcontains(msg, 'no') then
        npcHandler:say('Ok than.', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Thanks god! I was losing my hope... I am damaged, can you take a message from me to the queen?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! Calm down.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
