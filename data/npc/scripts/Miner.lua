local keywordHandler = KeywordHandler:new()
local npcHandler     = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- Callbacks
function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

----------------------------------------------------------------
-- Configurações
----------------------------------------------------------------
local WANDER_CHANCE       = 20      -- 1-4 move, 5-20 idle
local MAX_IDLE_TIME       = 30      -- s
local MAX_FOCUS_DISTANCE  = 5       -- tiles
local PICK_ID             = 2553
local PICK_COST           = 50

----------------------------------------------------------------
-- Conversação
----------------------------------------------------------------
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    msg = msg:lower()

    -- Informações de mineração
    if msg == 'more' then
        selfSay('Using a pick on certain stalagmites you can extract some rocks or maybe a jewel! First you need a pick – just say PICK to buy one.', cid)

    elseif msg == 'mais' then
        selfSay('Usando uma picareta em certos tipos de rocha você pode extrair algumas pedras ou até uma joia! Primeiro, diga PICK para comprar a picareta.', cid)

    elseif msg == 'golem' then
        selfSay('Humpf!', cid)

    elseif msg == 'rocks' then
        selfSay('Rocks are useless; concentrate on JEWELS.', cid)

    elseif msg == 'jewels' then
        selfSay('Persist in mining – jewels can make good money!', cid)

    elseif msg == 'pedras' then
        selfSay('Pedras são inúteis; concentre-se em JOIAS.', cid)

    elseif msg == 'joias' then
        selfSay('Você obtém joias minerando duro; elas podem valer dinheiro!', cid)

    -- Compra da picareta
    elseif msg == 'pick' then
        npcHandler:say(string.format('A pick costs %d gold. Do you want to buy one?', PICK_COST), cid)
        npcHandler.topic[cid] = 1

    elseif msg == 'yes' and npcHandler.topic[cid] == 1 then
        if player:removeMoney(PICK_COST) then
            player:addItem(PICK_ID, 1)
            selfSay('Here is your pick. Happy mining!', cid)
        else
            selfSay('You don\'t have enough money.', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msg == 'no' and npcHandler.topic[cid] == 1 then
        selfSay('Maybe next time.', cid)
        npcHandler.topic[cid] = 0
    end
    return true
end

----------------------------------------------------------------
-- Saudação e despedida
----------------------------------------------------------------
local function onGreet(cid)
    local player = Player(cid)
    if not player then
        return true
    end

    if npcHandler:getDistanceToCreature(cid) <= 4 then
        selfSay('Hello ' .. player:getName() .. '! I am the master miner of the town. Say MORE to learn.', cid)
        npcHandler.focus      = cid
        npcHandler.topic[cid] = 0
        npcHandler.talkStart  = os.time()
    end
    return true
end

local function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('Goodbye, ' .. player:getName() .. '!', cid)
    end
    return true
end

----------------------------------------------------------------
-- Movimento aleatório e timeout
----------------------------------------------------------------
local function randomWalk()
    local pos       = getCreaturePosition(getNpcCid())
    local nx, ny, z = pos.x, pos.y, pos.z
    local r         = math.random(WANDER_CHANCE)

    if     r == 1 then nx = nx + 1
    elseif r == 2 then nx = nx - 1
    elseif r == 3 then ny = ny + 1
    elseif r == 4 then ny = ny - 1
    end
    doMoveCreature(getNpcCid(), {x = nx, y = ny, z = z})
end

local function onThinkInternal()
    if npcHandler.focus == 0 then
        randomWalk()
    else
        local focused = Player(npcHandler.focus)
        if (not focused) or (focused:getDistance(getNpcCid()) > MAX_FOCUS_DISTANCE) then
            selfSay('Adeus.', npcHandler.focus)
            npcHandler:releaseFocus(npcHandler.focus)
        elseif os.time() - (npcHandler.talkStart or 0) > MAX_IDLE_TIME then
            selfSay('Next please!', npcHandler.focus)
            npcHandler:releaseFocus(npcHandler.focus)
        end
    end
    npcHandler:onThink()
end

----------------------------------------------------------------
-- Registro de callbacks
----------------------------------------------------------------
npcHandler:setCallback(CALLBACK_GREET,              onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL,           onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT,    creatureSayCallback)
npcHandler:addModule(FocusModule:new())

-- Override da função onThink padrão
function onThink() onThinkInternal() end
