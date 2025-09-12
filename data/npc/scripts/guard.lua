local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local target = 0
local following = false
local attacking = false

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        local player = Player(cid)
        if not player then
            return false
        end
        
        if msgcontains(msg, 'hi queen') then
            npcHandler:say('Hail the Queen!', cid)
            return true
        elseif msgcontains(msg, 'oi rainha') then
            npcHandler:say('Salve a rainha!', cid)
            return true
        end
        return false
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
