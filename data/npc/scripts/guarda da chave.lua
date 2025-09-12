local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    HELP_CONFIRM_EN = 1,
    HELP_CONFIRM_PT = 2
}

local function greetCallback(cid)
    local player = Player(cid)
    if msgcontains(msg, 'hi') then
        npcHandler:say('Hello ' .. player:getName() .. '! I take care of the prison ,could take the key on the table and help me?', cid)
        npcHandler.topic[cid] = topicList.HELP_CONFIRM_EN
    else
        npcHandler:say('Ola ' .. player:getName() .. '! Eu tomo conta da prisao, pegue a chave da bancada e poderia me ajuda a tomar conta do presos ?', cid)
        npcHandler.topic[cid] = topicList.HELP_CONFIRM_PT
    end
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    npcHandler:say('Goodbye, ' .. player:getName() .. '!', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        local player = Player(cid)
        if not player then
            return false
        end
        
        if msgcontains(msg, 'hi') then
            npcHandler:say('Hello ' .. player:getName() .. '! I take care of the prison ,could take the key on the table and help me?', cid)
            npcHandler.topic[cid] = topicList.HELP_CONFIRM_EN
            return true
        elseif msgcontains(msg, 'oi') then
            npcHandler:say('Ola ' .. player:getName() .. '! Eu tomo conta da prisao, pegue a chave da bancada e poderia me ajuda a tomar conta do presos ?', cid)
            npcHandler.topic[cid] = topicList.HELP_CONFIRM_PT
            return true
        end
        return false
    end
    
    local player = Player(cid)
    
    if npcHandler.topic[cid] == topicList.HELP_CONFIRM_EN and msgcontains(msg, 'yes') then
        npcHandler:say('Thanks! but take care , they are dangerous.', cid)
        npcHandler:releaseFocus(cid)
        npcHandler.topic[cid] = topicList.NONE
    elseif npcHandler.topic[cid] == topicList.HELP_CONFIRM_PT and msgcontains(msg, 'sim') then
        npcHandler:say('Obrigado! mas tome cuidado, eles são perigosos.', cid)
        npcHandler:releaseFocus(cid)
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'tchau') then
        npcHandler:say('Tchau, ' .. player:getName() .. '!', cid)
        npcHandler:releaseFocus(cid)
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I take care of the prison, could take the key on the table and help me?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Goodbye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
