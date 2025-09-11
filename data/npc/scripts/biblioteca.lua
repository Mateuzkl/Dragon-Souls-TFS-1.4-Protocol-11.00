local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local QUEST_CONFIG = {
    questStorage = 6006
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local quest1 = player:getStorageValue(QUEST_CONFIG.questStorage)
    
    if msgcontains(msg, 'quest') then
        if quest1 == -1 then
            selfSay('Hmm... Let me see...', cid)
            selfSay('Many ages ago, on the second middle earth, Carlin suffered, with surely the most bloody war ever seen in this region. The undead made an alliance with the poison masters, they attacked us with no mercy. We were excellent fighters, but two of us struggled with glory...', cid)
            selfSay('Shima and Natalier, feared even by the most powerful undead, but I don\'t have time to tell you the whole tale. Finally, we won this war, but we had losses. Shima and Natalier fallen.', cid)
            selfSay('Buried with them, their legendary weapons, made by Thordain. Your task is simple, find the graves, they are located in Carlin.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "New quest added: 'Shima and Natalier, rest in peace.'")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(QUEST_CONFIG.questStorage, 1)
        else
            selfSay('Hmm... I know so many quests, but now, I don\'t have time to tell you. Another day, ok?', cid)
        end
        
    elseif msgcontains(msg, 'offer') then
        selfSay('Hmm... I have nothing to offer now.', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('I don\'t have anything for you, maybe another day, ok?', cid)
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        selfSay('Hello my young ' .. player:getName() .. '! Welcome to my library, at this moment we don\'t have books, but new books are coming!', cid)
    end
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('Good bye, ' .. player:getName() .. '!', cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())
