local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

---------------------------------------------------------------
-- Callbacks
---------------------------------------------------------------
function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

---------------------------------------------------------------
-- Config
---------------------------------------------------------------
local PICK_ID            = 2553
local PICK_COST          = 10
local COAL_ID            = 5880
local COAL_AMOUNT        = 1
local REWARD_ID          = 2157      -- crystal coin
local STORAGE_QUEST      = 893       -- -1 = none, 1 = need coal, 2 = has coal, 3 = finished

---------------------------------------------------------------
-- Helpers
---------------------------------------------------------------
local function hasCoal(player)
    return player:getItemCount(COAL_ID) >= COAL_AMOUNT
end

---------------------------------------------------------------
-- Dialogue
---------------------------------------------------------------
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end
    
    local storage = player:getStorageValue(STORAGE_QUEST)
    local msgLower = msg:lower()
    local topic = npcHandler.topic[cid] or 0

    -- Basic info ---------------------------------------------
    if msgLower == 'offer' then
        npcHandler:say('I can sell you a pick so you can start working! Need HELP about mining?', cid)

    elseif msgLower == 'help' then
        npcHandler:say('Use a pick on stalagmites or iron walls. Iron walls are in Minas Tirith and need mining 35 to break.', cid)

    elseif msgLower == 'nugget' then
        npcHandler:say('Nuggets are the base for forging weapons. Visit the Smithing Guild for details.', cid)

    elseif msgLower == 'tirith' then
        npcHandler:say('The master mining and smithing city – premium only.', cid)

    -- Buy pick -----------------------------------------------
    elseif msgLower == 'pick' then
        npcHandler:say('A pick costs 10 gold. Do you want to buy one?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msgLower, 'yes') and topic == 1 then
        if player:removeTotalMoney(PICK_COST) then
            player:addItem(PICK_ID, 1)
            npcHandler:say('Here is your pick. Happy mining!', cid)
        else
            npcHandler:say('You don\'t have enough money.', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msgLower, 'no') and topic == 1 then
        npcHandler:say('Maybe next time.', cid)
        npcHandler.topic[cid] = 0

    -- Quest chain --------------------------------------------
    elseif msgLower == 'quest' then
        if storage == -1 then                                -- first time
            npcHandler:say('As a novice I have an easy task: bring me 1 Coal Ore.', cid)
            npcHandler:say('Coal is rare, but you can mine it here in the guild with mining 35.', cid)
            player:setStorageValue(STORAGE_QUEST, 1)

        elseif storage == 1 then                             -- reminder
            npcHandler:say('Use your pick on Coal Rocks until you find some coal.', cid)

        elseif storage == 2 then                             -- ready to deliver
            npcHandler:say('Did you bring me the Coal I asked?', cid)
            npcHandler.topic[cid] = 2
        else                                                 -- finished
            npcHandler:say('No more quests for now. Go train.', cid)
        end

    elseif msgcontains(msgLower, 'yes') and topic == 2 then
        if hasCoal(player) then
            player:removeItem(COAL_ID, COAL_AMOUNT)
            player:addItem(REWARD_ID, 1)
            npcHandler:say('Great job! Take this reward and come back later for more tasks.', cid)
            player:setStorageValue(STORAGE_QUEST, 3)
        else
            npcHandler:say('You still don\'t have the coal. Keep mining!', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msgLower, 'no') and topic == 2 then
        npcHandler:say('Come back when you have the coal.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

---------------------------------------------------------------
-- Focus Management
---------------------------------------------------------------
local function onAddFocus(cid)
    npcHandler.topic[cid] = 0
end

local function onReleaseFocus(cid)
    npcHandler.topic[cid] = nil
end

---------------------------------------------------------------
-- Register
---------------------------------------------------------------
npcHandler:setMessage(MESSAGE_GREET, 'Hey there, |PLAYERNAME|! New miners arrive every day – say OFFER or QUEST.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then. Continue training!')

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
