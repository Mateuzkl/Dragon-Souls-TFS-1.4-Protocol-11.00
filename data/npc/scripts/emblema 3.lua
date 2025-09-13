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
    
    local addon = player:getStorageValue(30000)
    
    if addon == 2 and msgcontains(msg, 'yes') then
        player:setStorageValue(30000, 3)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        
        local letter = player:addItem(2598, 1)
        if letter then
            letter:setAttribute(ITEM_ATTRIBUTE_TEXT, "Dagmar was on attack, we need your help my queen! By Narzan.")
        end
        
        npcHandler:say('Say to her that you have a message from Narzan... Run, we have no time!', cid)
    elseif addon == 2 and msgcontains(msg, 'no') then
        npcHandler:say('Ok then.', cid)
    elseif addon == 2 then
        npcHandler:say('Thanks god! I was losing my hope... I am damaged, can you take a message from me to the queen?', cid)
    else
        npcHandler:say('What you doing here? Take a message from the queen!', cid)
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Thanks god! I was losing my hope... I am damaged, can you take a message from me to the queen?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
