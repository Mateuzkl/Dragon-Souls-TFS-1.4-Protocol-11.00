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

----------------------------------------------------------------
-- Config
----------------------------------------------------------------
local TRAIN_POS         = {x = 291, y = 177, z = 8}
local MAX_DIST          = 5    -- tiles
local TIMEOUT           = 120  -- seconds

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

    local topic = npcHandler.topic[cid] or 0
    msg = msg:lower()

    -- nationality question ------------------------------------
    if topic == 0 and msg == 'test' then
        npcHandler:say('Ha! Nice choice soldier. Where are you from, Brazil or foreigner?', cid)
        npcHandler.topic[cid] = 1
        return true
    end

    -- Brazilian branch ----------------------------------------
    if topic == 1 and (msg == 'brazil' or msg == 'brasil') then
        npcHandler:say({
            'Muito bem então... Vamos começar o treinamento!',
            'Knights (Cavaleiros) são a vocação que possui mais força, fortes, resistentes e peritos em qualquer arma de melee!',
            'Pois vamos ao teste... Está pronto?'
        }, cid)
        npcHandler.topic[cid] = 2
        return true
    end

    -- Foreign branch ------------------------------------------
    if topic == 1 then
        npcHandler:say({
            'Hmm, I never traveled there, but let\'s start the training!',
            'Knights are the toughest warriors: strong, resilient, and masters of every melee weapon.',
            'So, let\'s go to the test... Ready?'
        }, cid)
        npcHandler.topic[cid] = 3
        return true
    end

    -- PT ready confirmation -----------------------------------
    if topic == 2 and (msg == 'yes' or msg == 'sim') then
        npcHandler:say({
            'Eis o que irá fazer para passar no teste, soldado!',
            'Nossa sala de armamentos está infestada de ratos; desinfete essas pragas!',
            'Pronto?'
        }, cid)
        npcHandler.topic[cid] = 4
        return true
    end

    -- EN ready confirmation -----------------------------------
    if topic == 3 and (msg == 'yes' or msg == 'sim') then
        npcHandler:say({
            'All you need to do is this:',
            'Our weapon room is infested with rats. Defeat this plague!',
            'Ready?'
        }, cid)
        npcHandler.topic[cid] = 5
        return true
    end

    -- PT teleport ---------------------------------------------
    if topic == 4 and (msg == 'yes' or msg == 'sim') then
        npcHandler:say('Boa sorte, soldado! Aguardo você no final do teste!', cid)
        player:teleportTo(Position(TRAIN_POS))
        Position(TRAIN_POS):sendMagicEffect(CONST_ME_TELEPORT)
        npcHandler:releaseFocus(cid)
        return true
    end

    -- EN teleport ---------------------------------------------
    if topic == 5 and (msg == 'yes' or msg == 'sim') then
        npcHandler:say('Good luck, soldier! I will be waiting for you at the end of this test!', cid)
        player:teleportTo(Position(TRAIN_POS))
        Position(TRAIN_POS):sendMagicEffect(CONST_ME_TELEPORT)
        npcHandler:releaseFocus(cid)
        return true
    end

    return true
end

----------------------------------------------------------------
-- Greeting / Farewell
----------------------------------------------------------------
local function onGreet(cid)
    local player = Player(cid)
    if not player then
        return true
    end

    if npcHandler:getDistanceToCreature(cid) <= 2 then
        npcHandler:say('Hail ' .. player:getName() .. '! Want to train to be a **Heroic Knight**? Say "test".', cid)
        npcHandler.topic[cid]  = 0
        npcHandler.talkStart   = os.time()
    else
        npcHandler:say('Come closer, brave one!', cid)
    end
    return true
end

local function onFarewell(cid)
    npcHandler:say('Good bye, soldier ' .. Player(cid):getName() .. '!', cid)
    return true
end

----------------------------------------------------------------
-- Timeout & distance check
----------------------------------------------------------------
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

----------------------------------------------------------------
-- Register
----------------------------------------------------------------
npcHandler:setCallback(CALLBACK_GREET,              onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL,           onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT,    creatureSayCallback)
npcHandler:addModule(FocusModule:new())

function onThink() onThinkInternal() end
