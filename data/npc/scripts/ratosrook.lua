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

    local rat = player:getStorageValue(2467)

    -- This NPC doesn't need complex conversation, just different greetings based on quest state
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    local rat = player:getStorageValue(2467)
    local playerName = player:getName()

    if rat == -1 then
        -- Start quest
        selfSay('Help ' .. playerName .. '! My food storage was infested with rats! I cant lose more food!', cid)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nova quest adicionada 'Infestacao do armazen!'.")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2467, 1)
        
    elseif rat == 1 then
        -- Quest in progress
        selfSay('Help ' .. playerName .. '! My food storage was infested with rats! I cant lose more food!', cid)
        
    elseif rat == 2 then
        -- Complete quest and give rewards
        selfSay('Thanks so much ' .. playerName .. '! Take this to help you!', cid)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You receive some oranges, a studded club and a wooden shield.")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setStorageValue(2467, 3)
        player:addItem(2675, 15) -- oranges
        player:addItem(2448, 1)  -- studded club
        player:addItem(2512, 1)  -- wooden shield
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest 'Infestacao do armazen!' completada.")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        
    elseif rat == 3 then
        -- Quest completed
        selfSay('Hey you again ' .. playerName .. '!', cid)
        
    else
        -- Default greeting
        selfSay('Hello ' .. playerName .. '!', cid)
    end
    
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Good bye, ' .. player:getName() .. '!', cid)
    return true
end

-- Keywords for quest-related dialogue
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Please help me with the rat infestation in my storage!'})
keywordHandler:addKeyword({'rat'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Yes, rats are destroying my food supplies!'})
keywordHandler:addKeyword({'rats'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'They are everywhere in my storage!'})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Please kill the rats in my food storage!'})
keywordHandler:addKeyword({'storage'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'My food storage is behind this building.'})
keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The rats are eating all my food supplies!'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
