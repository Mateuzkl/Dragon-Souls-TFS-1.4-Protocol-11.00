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
    local msgLower = msg:lower()
    
    if msgcontains(msgLower, 'quest') then
        if quest1 == -1 then
            npcHandler:say('Hmm... Let me see...', cid)
            npcHandler:say('Many ages ago, on the second middle earth, Carlin suffered, with surely the most bloody war ever seen in this region. The undead made an alliance with the poison masters, they attacked us with no mercy. We were excellent fighters, but two of us struggled with glory...', cid)
            npcHandler:say('Shima and Natalier, feared even by the most powerful undead, but I don\'t have time to tell you the whole tale. Finally, we won this war, but we had losses. Shima and Natalier fallen.', cid)
            npcHandler:say('Buried with them, their legendary weapons, made by Thordain. Your task is simple, find the graves, they are located in Carlin.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "New quest added: 'Shima and Natalier, rest in peace.'")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(QUEST_CONFIG.questStorage, 1)
        else
            npcHandler:say('Hmm... I know so many quests, but now, I don\'t have time to tell you. Another day, ok?', cid)
        end
        
    elseif msgcontains(msgLower, 'offer') then
        npcHandler:say('Hmm... I have nothing to offer now.', cid)
        
    elseif msgcontains(msgLower, 'mission') then
        npcHandler:say('I don\'t have anything for you, maybe another day, ok?', cid)
        
    elseif msgcontains(msgLower, 'job') then
        npcHandler:say('I am the librarian of this town. I keep the knowledge and stories of our people.', cid)
        
    elseif msgcontains(msgLower, 'book') or msgcontains(msgLower, 'library') then
        npcHandler:say('Welcome to my library! At this moment we don\'t have books, but new books are coming!', cid)
        
    elseif msgcontains(msgLower, 'shima') or msgcontains(msgLower, 'natalier') then
        if quest1 >= 1 then
            npcHandler:say('Ah yes, the legendary warriors! Their graves should be somewhere in Carlin. Look for ancient tombstones.', cid)
        else
            npcHandler:say('Ask me about a quest first, and I\'ll tell you about these heroes.', cid)
        end
        
    elseif msgcontains(msgLower, 'thordain') then
        if quest1 >= 1 then
            npcHandler:say('Thordain was the greatest blacksmith of our time. His weapons were legendary!', cid)
        else
            npcHandler:say('I don\'t know who you\'re talking about.', cid)
        end
    end
    
    return true
end

local function onAddFocus(cid)
    -- Player gained focus
end

local function onReleaseFocus(cid)
    -- Player lost focus
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello my young |PLAYERNAME|! Welcome to my library, at this moment we don\'t have books, but new books are coming!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Come back anytime to learn more stories!')

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
