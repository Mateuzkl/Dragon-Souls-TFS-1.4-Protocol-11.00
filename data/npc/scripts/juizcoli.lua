local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local NPC_STATE = {
    target = 0,
    following = false,
    attacking = false,
    lastCheck = 0,
    attackRadius = 7,
    followRadius = 15
}

local function stopActions()
    NPC_STATE.target = 0
    NPC_STATE.following = false
    NPC_STATE.attacking = false
end

local function performAttack(target, npcPos)
    local damage = math.random(10, 25)
    target:addHealth(-damage)
    
    local targetPos = target:getPosition()
    targetPos:sendMagicEffect(CONST_ME_DRAWBLOOD)
    targetPos:sendMagicEffect(CONST_ME_MORTAREA)
    npcPos:sendDistanceEffect(targetPos, CONST_ANI_SUDDENDEATH)
    
    Game.sendAnimatedText(damage, targetPos, TEXTCOLOR_RED)
    npcHandler:say('Take this, mortal!', NPC_STATE.target)
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local msgLower = msg:lower()
    
    if msgcontains(msgLower, 'follow') then
        NPC_STATE.target = cid
        NPC_STATE.following = true
        NPC_STATE.attacking = false
        npcHandler:say('I will follow you, brave ' .. player:getName() .. '!', cid)
        
    elseif msgcontains(msgLower, 'attack') then
        NPC_STATE.target = cid
        NPC_STATE.following = true
        NPC_STATE.attacking = true
        npcHandler:say('Prepare yourself for battle, ' .. player:getName() .. '!', cid)
        
    elseif msgcontains(msgLower, 'stop') then
        stopActions()
        npcHandler:say('I will cease my actions.', cid)
        
    elseif msgcontains(msgLower, 'help') then
        npcHandler:say('I can follow you, attack you, or stop my actions. Just say the command!', cid)
    end
    
    return true
end

local function onDisappear(cid)
    local player = Player(cid)
    if player then
        Game.broadcastMessage(player:getName() .. ' caiu em combate!', MESSAGE_STATUS_WARNING)
    end
    
    if NPC_STATE.target == cid then
        stopActions()
    end
    return true
end

addEvent(function()
    local function npcThink()
        if NPC_STATE.following and NPC_STATE.target > 0 then
            local target = Player(NPC_STATE.target)
            
            if not target then
                stopActions()
                return
            end
            
            if NPC_STATE.attacking then
                local damage = math.random(10, 25)
                target:addHealth(-damage)
                target:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
                Game.sendAnimatedText(damage, target:getPosition(), TEXTCOLOR_RED)
                npcHandler:say('Take this, mortal!', NPC_STATE.target)
            end
        end
        
        addEvent(npcThink, 2000)
    end
    
    npcThink()
end, 1000)

npcHandler:setMessage(MESSAGE_GREET, 'Vida longa aos Herois, apenas os fracos caem |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Farewell, warrior!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Come back when you are ready to fight!')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_DISAPPEAR, onDisappear)
npcHandler:addModule(FocusModule:new())
