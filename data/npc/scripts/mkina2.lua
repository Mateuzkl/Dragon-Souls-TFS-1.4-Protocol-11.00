local keywordHandler = KeywordHandler:new()
local npcHandler     = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

---- callback bridge ----------------------------------------------------
function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

---- config -------------------------------------------------------------
local PROMO_VOC   = 4                      -- Knight
local DEST_POS    = {x = 121, y = 311, z = 7}
local TOWN_ID     = 2                      -- Carlin
local STORAGE_ID  = 1002                  -- promo flag
local MAX_DIST    = 2
local TIMEOUT     = 120

---- main conversation --------------------------------------------------
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player  = Player(cid)
    if not player then
        return false
    end

    msg = msg:lower()

    if msg == 'yes' and player:getVocation():getId() == 0 then
        npcHandler:say('Good luck in the real world, Knight!', cid)
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'You are now a Knight!')
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:addHealth(185)
        player:setVocation(Vocation(PROMO_VOC))
        player:setTown(Town(TOWN_ID))
        player:setStorageValue(STORAGE_ID, 2)
        player:teleportTo(Position(DEST_POS))
        Position(DEST_POS):sendMagicEffect(CONST_ME_TELEPORT)
        npcHandler:releaseFocus(cid)

    elseif msg == 'no' then
        npcHandler:say('Ok then... you decide.', cid)
        npcHandler:releaseFocus(cid)
    end
    return true
end

---- greeting / farewell ------------------------------------------------
local function onGreet(cid)
    local player = Player(cid)
    if not player then return true end

    if npcHandler:getDistanceToCreature(cid) <= MAX_DIST then
        npcHandler:say(
            'Hmm, congratulations ' .. player:getName() .. '! You passed the test! ' ..
            'Go to Calona in Carlin and say you are a "novice"—she will help you. ' ..
            'So... are you ready to become a Knight?', cid)
        npcHandler.talkStart = os.time()
    else
        npcHandler:say('Come closer if you wish to speak.', cid)
    end
    return true
end

local function onFarewell(cid)
    npcHandler:say('Good bye, come back when you are ready, ' .. Player(cid):getName() .. '!', cid)
    return true
end

---- timeout / distance check ------------------------------------------
local function onThinkInternal()
    if npcHandler.focus ~= 0 then
        local player = Player(npcHandler.focus)
        if (not player) or player:getDistance(getNpcCid()) > MAX_DIST then
            npcHandler:say('Good bye then.', npcHandler.focus)
            npcHandler:releaseFocus(npcHandler.focus)
        elseif os.time() - (npcHandler.talkStart or 0) > TIMEOUT then
            npcHandler:say('Next please!', npcHandler.focus)
            npcHandler:releaseFocus(npcHandler.focus)
        end
    end
    npcHandler:onThink()
end

---- register callbacks -------------------------------------------------
npcHandler:setCallback(CALLBACK_GREET,              onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL,           onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT,    creatureSayCallback)
npcHandler:addModule(FocusModule:new())

---- override default onThink
function onThink() onThinkInternal() end
