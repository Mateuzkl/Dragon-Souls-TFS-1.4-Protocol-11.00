local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end

local lastRandomTalk = 0

function onThink()                          
    npcHandler:onThink()
    
    if not npcHandler:isFocused() then
        local currentTime = os.time()
        if currentTime - lastRandomTalk > 30 then
            lastRandomTalk = currentTime
            local randsay = math.random(1, 100)
            if randsay == 1 then
                npcHandler:say('Train Train!')
            elseif randsay == 50 then
                npcHandler:say('Never give up!')
            end
        end
    end
end

local topicList = {
    NONE = 0,
    MONSTER_LOOT = 1,
    DEMON_HORNS = 2,
    BUY_CONFIRM = 5
}

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('Hello young Fighter! ' .. player:getName() .. '! Ask for HELP if you need so!', cid)
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
    local quest1 = player:getStorageValue(1569)
    
    if msgcontains(msg, 'offer') then
        npcHandler:say('I can offer you challanges.', cid)
        npcHandler:say('Challanges are like quest, you can participate a challange here in the Fighters Guild, after some missions.', cid)
        npcHandler:say('Completing challanges you will be training your Fighting skill(say skills to more information)!', cid)
    elseif msgcontains(msg, 'help') then
        npcHandler:say('Welcome to the Fighters Guild! Only the best fighters are allowed in here!', cid)
        npcHandler:say('Here you can use our training areas and face Challanges to train you Fighting Skill(say skills to more information)!', cid)
    elseif msgcontains(msg, 'skills') then
        npcHandler:say('By completing Challanges you will be training tour Fighting Skill...', cid)
        npcHandler:say('Fighting Skill is used to unlock Ancient Weapons!', cid)
    elseif msgcontains(msg, 'ancient') then
        npcHandler:say('They are unlocked after reaching Fighting Skill 30, 50, and 80!', cid)
    elseif msgcontains(msg, 'challange') then
        if quest1 == -1 or quest1 == 1 or quest1 == 2 then
            npcHandler:say('You cant access challanges yet. Complete my quests to gain access to it.', cid)
        elseif quest1 == 3 then
            npcHandler:say('Kaya ponha pra acessar quando tive skill 90.', cid)
        end
    elseif msgcontains(msg, 'quest') then
        if quest1 == 3 then
            npcHandler:say('No more quests for you, you can now access Challanges.', cid)
        elseif quest1 == -1 then
            npcHandler:say('Ok, your first quest will be easy, just open the door, nort here in the Guild, and kill the monster inside it, bring me hes loot!', cid)
            player:setStorageValue(1569, 1)
        elseif quest1 == 1 then
            npcHandler:say('did you bring me the monster loot?', cid)
            npcHandler.topic[cid] = topicList.MONSTER_LOOT
        elseif quest1 == 2 then
            npcHandler:say('did you bring me 5 Demon Horns?', cid)
            npcHandler.topic[cid] = topicList.DEMON_HORNS
        end
    elseif npcHandler.topic[cid] == topicList.MONSTER_LOOT and msgcontains(msg, 'yes') then
        if player:getItemCount(5900) >= 1 then
            player:removeItem(5900, 1)
            npcHandler:say('Nice work, but that was easy...', cid)
            npcHandler:say('Now if you want to gain access for challanges you have to do one more thing...', cid)
            npcHandler:say('Bring me 5 Demon Horns!', cid)
            player:setStorageValue(1569, 2)
        else
            npcHandler:say('The monster is found north here in the Guild, after a door.', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif npcHandler.topic[cid] == topicList.DEMON_HORNS and msgcontains(msg, 'yes') then
        if player:getItemCount(5954) >= 5 then
            player:removeItem(5954, 5)
            npcHandler:say('Nice work! Now you are allowed to access Challanges!', cid)
            local baguio = player:addItem(5785, 1)
            if baguio then
                baguio:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Its a proof of Honor!")
            end
            player:setStorageValue(1569, 3)
        else
            npcHandler:say('Kill demons to obtain it.', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif npcHandler.topic[cid] == topicList.BUY_CONFIRM and msgcontains(msg, 'yes') then
        if player:removeMoney(5) then
            npcHandler:say('It\'s here!', cid)
            player:addItem(3942, 6)
        else
            npcHandler:say('Friend, you don\'t have this money.', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > topicList.NONE then
        npcHandler:say('Ok than.', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello young Fighter! |PLAYERNAME|! Ask for HELP if you need so!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then. Continue Training!')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! Wait in the line.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
