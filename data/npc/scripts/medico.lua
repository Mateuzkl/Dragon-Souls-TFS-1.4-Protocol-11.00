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
    
    if msgcontains(msg, 'offer') or msgcontains(msg, 'heal') then
        selfSay('Want me to heal you for 100 gold?', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'job') then
        selfSay('I am the doctor of this town!', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('Hmm... I don\'t know!', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('I don\'t have anything for you to do!', cid)
        
    elseif msgcontains(msg, 'poisoned') then
        selfSay('I don\'t have anything for you to do!', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'bleeding') then
        selfSay('Want me to cure your bleeding for 1000 gold?', cid)
        npcHandler.topic[cid] = 3
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
        if player:removeMoney(100) then
            Game.sendAnimatedText("Health!", player:getPosition(), TEXTCOLOR_LIGHTBLUE)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            player:addHealth(player:getMaxHealth())
            selfSay('Brand new!', cid)
        else
            selfSay('You don\'t have enough money.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
