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

local function moveTowardsTarget(npcPos, targetPos)
    if not npcPos or not targetPos then
        return false
    end
    
    local dx = targetPos.x - npcPos.x
    local dy = targetPos.y - npcPos.y
    
    local moveX = npcPos.x
    local moveY = npcPos.y
    
    if dx > 0 then
        moveX = moveX + 1
    elseif dx < 0 then
        moveX = moveX - 1
    end
    
    if dy > 0 then
        moveY = moveY + 1
    elseif dy < 0 then
        moveY = moveY - 1
    end
    
    local newPos = Position(moveX, moveY, npcPos.z)
    local tile = Tile(newPos)
    
    if tile and not tile:hasFlag(TILESTATE_BLOCKSOLID) then
        local npcCid = getNpcCid()
        if npcCid then
            local npc = Npc(npcCid)
            if npc then
                npc:move(newPos)
                return true
            end
        end
    end
    
    return false
end

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
    selfSay('Take this, mortal!')
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'follow') then
        NPC_STATE.target = cid
        NPC_STATE.following = true
        NPC_STATE.attacking = false
        selfSay('I will follow you, brave ' .. player:getName() .. '!', cid)
        
    elseif msgcontains(msg, 'attack') then
        NPC_STATE.target = cid
        NPC_STATE.following = true
        NPC_STATE.attacking = true
        selfSay('Prepare yourself for battle, ' .. player:getName() .. '!', cid)
        
    elseif msgcontains(msg, 'stop') then
        stopActions()
        selfSay('I will cease my actions.', cid)
        
    elseif msgcontains(msg, 'help') then
        selfSay('I can follow you, attack you, or stop my actions. Just say the command!', cid)
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        selfSay('Vida longa aos Herois, apenas os fracos caem ' .. player:getName() .. '!', cid)
    end
    return true
end

function onDisappear(cid)
    local player = Player(cid)
    if player then
        Game.broadcastMessage(player:getName() .. ' caiu em combate!', MESSAGE_STATUS_WARNING)
    end
    
    if NPC_STATE.target == cid then
        stopActions()
    end
    return true
end

function customOnThink()
    local currentTime = os.time()
    if currentTime - NPC_STATE.lastCheck < 1 then
        return
    end
    NPC_STATE.lastCheck = currentTime
    
    if NPC_STATE.following and NPC_STATE.target > 0 then
        local target = Player(NPC_STATE.target)
        
        if not target then
            stopActions()
            return
        end
        
        local npcCid = getNpcCid()
        if not npcCid then
            return
        end
        
        local npc = Npc(npcCid)
        if not npc then
            return
        end
        
        local npcPos = npc:getPosition()
        local targetPos = target:getPosition()
        local distance = npcPos:getDistance(targetPos)
        
        if distance > NPC_STATE.followRadius then
            selfSay('You are too far away!')
            stopActions()
            return
        end
        
        if NPC_STATE.attacking then
            if distance <= 1 then
                performAttack(target, npcPos)
            else
                moveTowardsTarget(npcPos, targetPos)
            end
        else
            if distance > 1 then
                moveTowardsTarget(npcPos, targetPos)
            end
        end
    end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_DISAPPEAR, onDisappear)
npcHandler:addModule(FocusModule:new())

local originalOnThink = onThink
function onThink()
    originalOnThink()
    customOnThink()
end
