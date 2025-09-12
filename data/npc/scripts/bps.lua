local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    BP_UH_CONFIRM = 1
}

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('ola ' .. player:getName() .. '! fale bp de uh.', cid)
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    npcHandler:say('Good bye, ' .. player:getName() .. '!', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if msgcontains(msg, 'bp de uh') then
        npcHandler:say('Quer receber uma bp de uh ?', cid)
        npcHandler.topic[cid] = topicList.BP_UH_CONFIRM
    elseif npcHandler.topic[cid] == topicList.BP_UH_CONFIRM and msgcontains(msg, 'yes') then
        if player:getItemCount(6527) >= 1 then
            local dsp = player:getItemCount(6527)
            player:removeItem(6527, 1)
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Ainda lhe resta ' .. (dsp - 1) .. ' Dragon Souls Points.')
            npcHandler:say('Ta ae nb, a primeira bp eh de graça, aprende com o Major.', cid)
            
            local condition = Condition(CONDITION_FIRE)
            condition:setParameter(CONDITION_PARAM_DELAYED, 1)
            condition:addDamage(1, 3000, -20)
            condition:addDamage(7, 3000, -10)
            player:addCondition(condition)
            
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ganhou uma bp de uh.")
            local container = player:addItem(2002, 1)
            if container then
                for i = 1, 20 do
                    container:addItem(2273, 100)
                end
            end
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('ueh me da o item q t do a bp nb.', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif npcHandler.topic[cid] == topicList.NONE and msgcontains(msg, 'yes') then
        npcHandler:say('yes? yes oq ?', cid)
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'ola |PLAYERNAME|! fale bp de uh.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
