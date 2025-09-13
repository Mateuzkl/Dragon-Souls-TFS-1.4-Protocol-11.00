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
    
    local msgLower = msg:lower()
    local topic = npcHandler.topic[cid] or 0
    
    if msgcontains(msgLower, 'offer') or msgcontains(msgLower, 'heal') then
        npcHandler:say('Want me to heal you for 100 gold?', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msgLower, 'job') then
        npcHandler:say('I am the doctor of this town!', cid)
        
    elseif msgcontains(msgLower, 'sell') or msgcontains(msgLower, 'buy') then
        npcHandler:say('I am not a merchant!', cid)
        
    elseif msgcontains(msgLower, 'quest') then
        npcHandler:say('Hmm... I don\'t know!', cid)
        
    elseif msgcontains(msgLower, 'mission') then
        npcHandler:say('I don\'t have anything for you to do!', cid)
        
    elseif msgcontains(msgLower, 'poisoned') then
        npcHandler:say('Want me to cure your poison for 500 gold?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msgLower, 'bleeding') then
        npcHandler:say('Want me to cure your bleeding for 1000 gold?', cid)
        npcHandler.topic[cid] = 3
        
    elseif msgcontains(msgLower, 'yes') then
        if topic == 1 then  -- Heal
            if player:removeTotalMoney(100) then
                Game.sendAnimatedText("Health!", player:getPosition(), TEXTCOLOR_LIGHTBLUE)
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                player:addHealth(player:getMaxHealth())
                npcHandler:say('Brand new!', cid)
            else
                npcHandler:say('You don\'t have enough money.', cid)
            end
            npcHandler.topic[cid] = 0
            
        elseif topic == 2 then  -- Poison
            if player:removeTotalMoney(500) then
                Game.sendAnimatedText("Poison cured!", player:getPosition(), TEXTCOLOR_GREEN)
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
                player:removeCondition(CONDITION_POISON)
                npcHandler:say('You are no longer poisoned!', cid)
            else
                npcHandler:say('You don\'t have enough money.', cid)
            end
            npcHandler.topic[cid] = 0
            
        elseif topic == 3 then  -- Bleeding
            if player:removeTotalMoney(1000) then
                Game.sendAnimatedText("Bleeding stopped!", player:getPosition(), TEXTCOLOR_RED)
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
                -- Remove bleeding condition if exists
                player:removeCondition(CONDITION_BLEEDING)
                npcHandler:say('Your bleeding has been stopped!', cid)
            else
                npcHandler:say('You don\'t have enough money.', cid)
            end
            npcHandler.topic[cid] = 0
        else
            npcHandler:say('What are you agreeing to?', cid)
        end
        
    elseif msgcontains(msgLower, 'no') and topic > 0 then
        npcHandler:say('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

local function onAddFocus(cid)
    npcHandler.topic[cid] = 0
end

local function onReleaseFocus(cid)
    npcHandler.topic[cid] = nil
end

npcHandler:setMessage(MESSAGE_GREET, 'Hi |PLAYERNAME|, I am the doctor of this town, do you have any trouble?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Goodbye, |PLAYERNAME|! Stay healthy!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Come back if you need healing!')

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
