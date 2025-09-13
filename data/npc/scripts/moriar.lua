local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local post = player:getStorageValue(2078)
    local msgLower = msg:lower()

    if msgcontains(msgLower, 'delivery') then
        if post == 0 then
            if player:getItemCount(1993) >= 1 then
                npcHandler:say('What tha hec... It\'s empty! I will talk about your work with your boss!', cid)
                player:removeItem(1993, 1)
            else
                npcHandler:say('You don\'t have any delivery for me.', cid)
            end
        elseif post == 9 then
            if player:getItemCount(2330) >= 1 then
                npcHandler:say('Oh, thanks god, i will really need this, talk with your boss about promotion, you deserve it, here is something for you.', cid)
                player:addItem(2152, 4)
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
                player:setStorageValue(2078, 10)
                player:removeItem(2330, 1)
            else
                npcHandler:say('So where is my delivery?', cid)
            end
        else
            npcHandler:say('I don\'t expect any delivery from you.', cid)
        end

    elseif msgcontains(msgLower, 'job') then
        npcHandler:say('I fish something in our ice rivers!', cid)

    elseif msgcontains(msgLower, 'offer') then
        npcHandler:say('I am not selling or buying nothing!', cid)

    elseif msgcontains(msgLower, 'sell') then
        npcHandler:say('Haha, sorry, not today!', cid)

    elseif msgcontains(msgLower, 'buy') then
        npcHandler:say('No, no merchant', cid)

    elseif msgcontains(msgLower, 'quest') or msgcontains(msgLower, 'mission') then
        npcHandler:say('Not involved.. you know!', cid)
    end

    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! What brings you to these icy lands?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Goodbye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Come back soon!')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
