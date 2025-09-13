local keywordHandler = KeywordHandler:new()
local npcHandler     = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

----------------------------------------------------------------
-- Callbacks
----------------------------------------------------------------
function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local STORAGE_KEY = 30003       -- -1 = never met; 1 = ring given; 2 = told about drawer

----------------------------------------------------------------
-- Conversation
----------------------------------------------------------------
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local storage  = player:getStorageValue(STORAGE_KEY)
    local topic    = npcHandler.topic[cid] or 0
    msg = msg:lower()

    if msg == 'yes' and topic == 1 and storage == 1 then
        npcHandler:say('Damn! I got a key from the guards, but I hid it before being busted. Don\'t you have a friend who can help us escape?', cid)
        npcHandler.topic[cid] = 2
        return true
    end

    if msg == 'yes' and topic == 2 and storage == 1 then
        npcHandler:say('Great! I hid the key inside a drawer. You\'ll need a heavy hammer to break it.', cid)
        player:setStorageValue(STORAGE_KEY, 2)
        npcHandler.topic[cid] = 0
        return true
    end

    return true
end

----------------------------------------------------------------
-- Greeting / Farewell
----------------------------------------------------------------
local function onGreet(cid)
    local player   = Player(cid)
    local storage  = player:getStorageValue(STORAGE_KEY)

    if storage == -1 then
        npcHandler:say('Huh? You can see me? Nobody can! Take this ring; it\'ll help you get out. Lost too?', cid)
        player:addItem(2165, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'You receive a stealth ring.')
        player:setStorageValue(STORAGE_KEY, 1)
        npcHandler.topic[cid] = 1
    else
        npcHandler:say('Back again? Still no friend? I hid the key in a drawer—break it with something heavy.', cid)
        npcHandler.topic[cid] = 0
    end
    npcHandler.talkStart = os.time()
    return true
end

local function onFarewell(cid)
    npcHandler:say('Good bye, ' .. Player(cid):getName() .. '!', cid)
    return true
end

----------------------------------------------------------------
-- Timeout
----------------------------------------------------------------
local TIMEOUT = 30
local MAX_DIST = 5

local function onThinkInternal()
    if npcHandler.focus ~= 0 then
        local player = Player(npcHandler.focus)
        if (not player) or player:getDistance(getNpcCid()) > MAX_DIST then
            npcHandler:say('Good bye then.', npcHandler.focus)
            npcHandler:releaseFocus(npcHandler.focus)
        elseif os.time() - (npcHandler.talkStart or 0) > TIMEOUT then
            npcHandler:say('Bye...', npcHandler.focus)
            npcHandler:releaseFocus(npcHandler.focus)
        end
    end
    npcHandler:onThink()
end

----------------------------------------------------------------
-- Register
----------------------------------------------------------------
npcHandler:setCallback(CALLBACK_GREET,              onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL,           onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT,    creatureSayCallback)
npcHandler:addModule(FocusModule:new())

function onThink() onThinkInternal() end
