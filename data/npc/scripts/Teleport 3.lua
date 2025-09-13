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
    
    local msgLower = msg:lower()
    
    if msgcontains(msgLower, 'sim') or msgcontains(msgLower, 'yes') then
        npcHandler:say('Parabéns ' .. player:getName() .. ', está a caminho da ultima sala do templo dos Deuses, e a um passo da imortalidade. Boa sorte!', cid)
        
        Game.broadcastMessage('Parabéns ' .. player:getName() .. ', está a caminho da ultima sala do templo dos Deuses, e a um passo da imortalidade. Boa sorte!', MESSAGE_EVENT_ADVANCE)
        
        player:teleportTo(Position(481, 260, 15))
        Position(481, 260, 15):sendMagicEffect(CONST_ME_TELEPORT)
        npcHandler:releaseFocus(cid)
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Ha! Ola mortal |PLAYERNAME|, fico impressionado que tenha chegado ate aqui, força já vi que você tem, agora vamos ver cérebro, esta pronto?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Não me deixe falando sozinho!')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
