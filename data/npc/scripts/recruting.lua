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
    local level = player:getLevel()

    if msgcontains(msg, 'test') then
        if level >= 8 then
            if player:getItemCount(2160) == 0 then -- no crystal coins
                if player:getItemCount(13685) == 0 then -- no special item
                    if player:getItemCount(2152) < 101 then -- less than 101 platinum coins (10k)
                        selfSay('Levarei voce para uma sala onde possa escolher o seu teste para sua vocacao, tera que provar que esta pronto! Acha que esta realmente pronto?', cid)
                        npcHandler.topic[cid] = 1
                    else
                        selfSay('Voce so pode ir para o teste com no maximo 10k!', cid)
                        npcHandler:releaseFocus()
                        npcHandler.topic[cid] = 0
                    end
                else
                    selfSay('Voce so pode ir para o teste com no maximo 10k!', cid)
                    npcHandler:releaseFocus()
                    npcHandler.topic[cid] = 0
                end
            else
                selfSay('Voce so pode ir para o teste com no maximo 10k!', cid)
                npcHandler:releaseFocus()
                npcHandler.topic[cid] = 0
            end
        else
            selfSay('Sorry, you need level 8 to stay ready, go train children!', cid)
            npcHandler:releaseFocus()
            npcHandler.topic[cid] = 0
        end

    elseif talk_state == 1 and msgcontains(msg, 'yes') then
        selfSay('Well well, if you think so, good luck!', cid)
        player:teleportTo(Position(270, 199, 8))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        npcHandler:releaseFocus()
        npcHandler.topic[cid] = 0

    elseif talk_state == 1 and msgcontains(msg, 'no') then
        selfSay('So come back here when you are ready!', cid)
        npcHandler:releaseFocus()
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'ready') then
        selfSay('When you think you are ready to try the test, just say "test" to me.', cid)

    elseif msgcontains(msg, 'vocation') or msgcontains(msg, 'vocacao') then
        selfSay('The test will help you choose your vocation path.', cid)

    elseif msgcontains(msg, 'help') or msgcontains(msg, 'ajuda') then
        selfSay('You need to be level 8+ and have no more than 10k gold to take the test.', cid)

    elseif msgcontains(msg, 'level') then
        selfSay('You need to be at least level 8 to take the vocation test.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Hello ' .. player:getName() .. '! When you think you are ready to try the "test", just say to me.', cid)
    npcHandler.topic[cid] = 0
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Good bye, come back here when you ready ' .. player:getName() .. '!', cid)
    npcHandler.topic[cid] = 0
    return true
end

-- Keywords for additional dialogue
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I help new adventurers choose their vocation through a test.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'My mission is to test if you are ready for your vocation.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'This is not a quest, but a vocation test.'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
