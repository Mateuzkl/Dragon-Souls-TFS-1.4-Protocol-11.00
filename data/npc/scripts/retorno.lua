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
        player:teleportTo(Position(1124, 1806, 6))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        selfSay('Have a safe trip!', cid)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'no') then
        selfSay('I wouldn\'t go there either.', cid)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'bree') or msgcontains(msg, 'travel') then
        selfSay('Do you want me to take you back to Bree?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msg, 'help') then
        selfSay('I can transport you to various destinations. Just ask me about a destination!', cid)
    end

    return true
end

-- Keywords for travel destinations and information
keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you back to Bree.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the Carpet Man!'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you back to Bree.'})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
