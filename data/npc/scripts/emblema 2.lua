local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local waitingConfirmation = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function greetCallback(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    local addon = player:getStorageValue(30000)
    
    if addon == 3 then
        npcHandler:say('Did you found Narzan? Lets go now?', cid)
        waitingConfirmation[cid] = true
        npcHandler:say('Do you want to travel now? Say yes to confirm.', cid)
    else
        npcHandler:say('We cant go before we have sure that Narzan is alive!', cid)
    end
    return true
end

function creatureSayCallback(cid, type, msg)
    local player = Player(cid)
    if not player then
        return false
    end
    
    -- TRIGGER "oh god" SEMPRE FUNCIONA
    if msgcontains(msg, 'oh god') then
        npcHandler:say('Oh! What is going on? Find Narzan, i am going to find help!', cid)
        player:setStorageValue(30000, 2)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        return true
    end
    
    -- Resto precisa estar focado
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    -- Travel confirmation
    if waitingConfirmation[cid] and msg:lower() == "yes" then
        npcHandler:say('As you wish!', cid)
        player:teleportTo(Position(31, 298, 7))
        Position(31, 298, 7):sendMagicEffect(CONST_ME_TELEPORT)
        waitingConfirmation[cid] = nil
        npcHandler:releaseFocus(cid)
        return true
    elseif waitingConfirmation[cid] and msg:lower() == "no" then
        npcHandler:say('Come back when you are ready.', cid)
        waitingConfirmation[cid] = nil
        npcHandler:releaseFocus(cid)
        return true
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Did you found Narzan? Lets go now?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good luck, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Go go, fast!')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
