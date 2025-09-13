local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local talk_state = npcHandler.topic[cid] or 0

    if msgcontains(msg, 'enter') then
        selfSay('Do you wish enter on arena?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msg, 'leave') then
        selfSay('Do you wish leave arena?', cid)
        npcHandler.topic[cid] = 2

    elseif msgcontains(msg, 'yes') and talk_state == 1 then
        if player:isPremium() then
            player:teleportTo(Position(49, 462, 7))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            selfSay('Good luck in the arena!', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('Sorry, only premium players can enter.', cid)
            npcHandler.topic[cid] = 0
        end

    elseif msgcontains(msg, 'yes') and talk_state == 2 then
        player:teleportTo(Position(121, 318, 7))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        selfSay('Welcome back!', cid)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'no') and talk_state > 0 then
        selfSay('I wouldn\'t go there either.', cid)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'arena') then
        selfSay('I can help you enter or leave the arena. What would you like to do?', cid)
    end

    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the gate guard. I can let you enter or leave the arena.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no time for this.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no time for this.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can let you enter or leave arena.'})

npcHandler:addModule(FocusModule:new())
