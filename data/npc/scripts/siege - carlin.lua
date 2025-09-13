--------------------------------------------------------------------------------------------
------------------------------------ Advanced Addon NPC ------------------------------------
-------------------------------- Script made by teh_pwnage ---------------------------------
--------------- Special thanks to: mokerhamer, Xidaozu and Jiddo, deaths'life --------------
------------------------------- Thanks also to everyone else -------------------------------
------------------------------ Converted for TFS 1.x ------------------------------
--------------------------------------------------------------------------------------------

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

    if msgcontains(msg, 'yes') then
        player:teleportTo(Position(151, 356, 6))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        selfSay('Here we go then.', cid)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'job') then
        selfSay('I can bring you to carlin port, let\'s go?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msg, 'offer') or msgcontains(msg, 'travel') then
        selfSay('I can bring you to carlin port, let\'s go?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msg, 'carlin') then
        selfSay('Do you want me to take you to Carlin port?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msg, 'port') then
        selfSay('I can take you to Carlin port. Shall we go?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msg, 'no') then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'help') then
        selfSay('I can transport you to Carlin port. Just say "carlin" or "travel" if you want to go!', cid)
    end

    return true
end

-- Keywords for travel information
keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Carlin port.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'My mission is to transport people to Carlin port.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no quests for you.'})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
