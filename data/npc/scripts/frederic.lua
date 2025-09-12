local STORAGE = 100010
local ITEM = 2403 
local QUANT = 50

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    MISSION_CONFIRM = 1
}

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('Olá ' .. player:getName() .. '. Eu Tenho uma mission para voce.', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if msgcontains(msg, 'mission') then
        npcHandler:say('Você aceita esta missão?', cid)
        npcHandler.topic[cid] = topicList.MISSION_CONFIRM
    elseif npcHandler.topic[cid] == topicList.MISSION_CONFIRM and msgcontains(msg, 'yes') then
        if player:getStorageValue(STORAGE) < 1 then
            player:addItem(ITEM, QUANT)
            player:setStorageValue(STORAGE, 1)
            npcHandler:say('Obrigado e Boa Sorte na sua jornada', cid)
        else
            npcHandler:say('Eu ja te dei sua missao.', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif npcHandler.topic[cid] == topicList.MISSION_CONFIRM and msgcontains(msg, 'no') then
        npcHandler:say('Talvez outra hora.', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Olá |PLAYERNAME|. Eu Tenho uma mission para voce.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Até logo!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Até logo!')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
