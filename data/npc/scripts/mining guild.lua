local keywordHandler = KeywordHandler:new()
local npcHandler     = NpcHandler:new(keywordHandler)
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
local STORAGE_QUEST      = 893       -- −1 = none, 1 = need coal, 2 = has coal, 3 = finished
local TIMEOUT            = 30        -- s
local FOCUS_DISTANCE     = 5         -- tiles

---------------------------------------------------------------
-- Helpers
---------------------------------------------------------------
local function hasCoal(player)
    return player:getItemCount(COAL_ID) >= COAL_AMOUNT
end

local function npcSay(text, cid) selfSay(text, cid) end

---------------------------------------------------------------
-- Dialogue
---------------------------------------------------------------
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player  = Player(cid)
    local storage = player:getStorageValue(STORAGE_QUEST)
    msg = msg:lower()

    -- Basic info ---------------------------------------------
    if msg == 'offer' then
        npcSay('I can sell you a pick so you can start working! Need HELP about mining?', cid)

    elseif msg == 'help' then
        npcSay('Use a pick on stalagmites or iron walls. Iron walls are in Minas Tirith and need mining 35 to break.', cid)

    elseif msg == 'nugget' then
        npcSay('Nuggets are the base for forging weapons. Visit the Smithing Guild for details.', cid)

    elseif msg == 'tirith' then
        npcSay('The master mining and smithing city – premium only.', cid)

    -- Buy pick -----------------------------------------------
    elseif msg == 'pick' then
        npcSay('A pick costs 10 gold. Do you want to buy one?', cid)
        npcHandler.topic[cid] = 1

    elseif msg == 'yes' and npcHandler.topic[cid] == 1 then
        if player:removeMoney(PICK_COST) then
            player:addItem(PICK_ID, 1)
            npcSay('Here is your pick. Happy mining!', cid)
        else
            npcSay('You don\'t have enough money.', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msg == 'no' and npcHandler.topic[cid] == 1 then
        npcSay('Maybe next time.', cid)
        npcHandler.topic[cid] = 0

    -- Quest chain --------------------------------------------
    elseif msg == 'quest' then
        if storage == -1 then                                -- first time
            npcSay('As a novice I have an easy task: bring me 1 Coal Ore.', cid)
            npcSay('Coal is rare, but you can mine it here in the guild with mining 35.', cid)
            player:setStorageValue(STORAGE_QUEST, 1)

        elseif storage == 1 then                             -- reminder
            npcSay('Use your pick on Coal Rocks until you find some coal.', cid)

        elseif storage == 2 then                             -- ready to deliver
            npcSay('Did you bring me the Coal I asked?', cid)
            npcHandler.topic[cid] = 2
        else                                                 -- finished
            npcSay('No more quests for now. Go train.', cid)
        end

    elseif msg == 'yes' and npcHandler.topic[cid] == 2 then
        if hasCoal(player) then
            player:removeItem(COAL_ID, COAL_AMOUNT)
            player:addItem(REWARD_ID, 1)
            npcSay('Great job! Take this reward and come back later for more tasks.', cid)
            player:setStorageValue(STORAGE_QUEST, 3)
        else
            npcSay('You still don\'t have the coal. Keep mining!', cid)
        end
        npcHandler.topic[cid] = 0
    elseif msg == 'no' and npcHandler.topic[cid] == 2 then
        npcSay('Come back when you have the coal.', cid)
        npcHandler.topic[cid] = 0
    end
    return true
end

---------------------------------------------------------------
-- Greeting / Farewell
---------------------------------------------------------------
local function onGreet(cid)
    npcSay('Hey there, ' .. Player(cid):getName() .. '! New miners arrive every day – say OFFER or QUEST.', cid)
    npcHandler.talkStart = os.time()
    return true
end

local function onFarewell(cid)
    npcSay('Good bye, ' .. Player(cid):getName() .. '!', cid)
    return true
end

---------------------------------------------------------------
-- Timeout handling
---------------------------------------------------------------
local function onThinkInternal()
    if npcHandler.focus ~= 0 then
        local player = Player(npcHandler.focus)
        if not player or player:getDistance(getNpcCid()) > FOCUS_DISTANCE then
            npcSay('Good bye then. Continue training!', npcHandler.focus)
            npcHandler:releaseFocus(npcHandler.focus)
        elseif os.time() - (npcHandler.talkStart or 0) > TIMEOUT then
            npcSay('See you later. Continue training!', npcHandler.focus)
            npcHandler:releaseFocus(npcHandler.focus)
        end
    end
    npcHandler:onThink()
end

---------------------------------------------------------------
-- Register
---------------------------------------------------------------
npcHandler:setCallback(CALLBACK_GREET,              onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL,           onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT,    creatureSayCallback)
npcHandler:addModule(FocusModule:new())

function onThink() onThinkInternal() end
