local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function greetCallback(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    local addon = player:getStorageValue(30000)
    
    if addon == -1 then
        npcHandler:say('What do you want here? This boat is only for the royal family!', cid)
    elseif addon >= 1 then
        npcHandler:say('What do you want here? This boat is only for the royal family! Say {royal} if you have business with us.', cid)
    else
        npcHandler:say('What do you want here? This boat is only for the royal family!', cid)
    end
    return true
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local addon = player:getStorageValue(30000)
    
    if msgcontains(msg, 'royal') then
        if addon == -1 then
            npcHandler:say('Go bother someone else!', cid)
        elseif addon == 1 then
            if player:getItemCount(2122) >= 1 then
                npcHandler:say('I dont know how did you get the royal family broch, but is my job to take you to the prince, the king\'s son of dagmar. Can we go now?', cid)
                npcHandler.topic[cid] = 1
            else
                npcHandler:say('Go bother someone else!', cid)
            end
        elseif addon == 2 then
            if player:getItemCount(2122) >= 1 then
                npcHandler:say('You need find Narzan the prince, the king\'s son of dagmar! Can we go now?', cid)
                npcHandler.topic[cid] = 1
            else
                npcHandler:say('I can\'t go without the broch!', cid)
            end
        elseif addon >= 3 then
            npcHandler:say('Now, we just need wait the orders of the queen!', cid)
        end
    end
    
    if msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
        if player:getItemCount(2122) >= 1 then
            npcHandler:say('Set the Sails!', cid)
            player:teleportTo(Position(56, 431, 7))
            Position(56, 431, 7):sendMagicEffect(CONST_ME_TELEPORT)
            player:say('Oh God', TALKTYPE_MONSTER_SAY)
            npcHandler:releaseFocus(cid)
        else
            npcHandler:say('You are not with the broch!', cid)
            npcHandler:releaseFocus(cid)
        end
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
        npcHandler:say('Come back when you are ready.', cid)
        npcHandler:releaseFocus(cid)
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
