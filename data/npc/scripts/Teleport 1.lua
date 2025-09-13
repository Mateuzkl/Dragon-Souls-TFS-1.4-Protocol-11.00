local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'anoriel') then
        local storage = player:getStorageValue(6040)
        local vocation = player:getVocation():getId()
        
        if storage == -1 then
            if vocation < 9 then
                npcHandler:say('Then go talk with him!', cid)
                player:teleportTo(Position(461, 254, 13))
                Position(461, 254, 13):sendMagicEffect(CONST_ME_TELEPORT)
                npcHandler:releaseFocus(cid)
            else
                npcHandler:say('You can not enter on this temple again, go away Semi-Deus!', cid)
            end
        else
            npcHandler:say('You can not enter on this temple again, go away!', cid)
        end
    end
    
    return true
end

local function onAddFocus(cid)
    -- Player gained focus
end

local function onReleaseFocus(cid)
    -- Player lost focus
end

npcHandler:setMessage(MESSAGE_GREET, 'Who invited you to enter on temple of Anoriel mortal?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Get out |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Get out!')

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
