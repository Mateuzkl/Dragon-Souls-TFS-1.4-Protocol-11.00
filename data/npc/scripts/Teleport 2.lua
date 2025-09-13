local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    READY_CONFIRM = 1
}

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local topic = npcHandler.topic[cid] or topicList.NONE
    local msgLower = msg:lower()
    
    if msgcontains(msgLower, 'ja') then
        npcHandler:say('Oh! kühlen, wenn Sie Sagen im bereit ich Sie zum folgenden Raum schicken.', cid)
        npcHandler.topic[cid] = topicList.READY_CONFIRM
        
    elseif topic == topicList.READY_CONFIRM and msgcontains(msgLower, 'im bereit') then
        npcHandler:say('Bis später!', cid)
        player:teleportTo(Position(439, 244, 14))
        Position(439, 244, 14):sendMagicEffect(CONST_ME_TELEPORT)
        npcHandler.topic[cid] = topicList.NONE
        npcHandler:releaseFocus(cid)
        
    elseif msgcontains(msgLower, 'wiedersehen') then
        npcHandler:say('Auf Wiedersehen!', cid)
        npcHandler:releaseFocus(cid)
    end
    
    return true
end

local function onAddFocus(cid)
    npcHandler.topic[cid] = topicList.NONE
end

local function onReleaseFocus(cid)
    npcHandler.topic[cid] = nil
end

npcHandler:setMessage(MESSAGE_GREET, 'Hallo, kennen Sie Gespräch Deutschland?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Auf Wiedersehen!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Auf Wiedersehen!')

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
