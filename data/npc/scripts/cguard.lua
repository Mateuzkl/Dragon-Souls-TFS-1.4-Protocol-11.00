dofile('data/npc/lib/npcsystem/npcsystem.lua')
dofile('data/npc/lib/npcsystem/customModules.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)  
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local GUARD_CONFIG = {
    attackDamage = 10,
    attackRadius = 7,
    followRadius = 15,
    checkInterval = 1,
    lastCheck = 0,
    targetPlayer = nil,
    following = false,
    attackCount = 0,
    maxAttacks = 10
}

local function isInProtectionZone(position)
    local tile = Tile(position)
    return tile and tile:hasFlag(TILESTATE_PROTECTIONZONE)
end

local function stopFollowing()
    GUARD_CONFIG.targetPlayer = nil
    GUARD_CONFIG.following = false
    GUARD_CONFIG.attackCount = 0
end

local function moveTowardsPlayer(npcPos, playerPos)
    if not npcPos or not playerPos then
        return false
    end
    
    local dx = playerPos.x - npcPos.x
    local dy = playerPos.y - npcPos.y
    
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
        local npc = Npc(getNpcCid())
        if npc then
            npc:move(newPos)
            return true
        end
    end
    
    return false
end

local function attackCreature(creature, npcPos)
    if not creature then
        return
    end
    
    local pos = creature:getPosition()
    
    pos:sendMagicEffect(CONST_ME_MORTAREA)
    pos:sendMagicEffect(CONST_ME_DRAWBLOOD)
    
    if npcPos then
        npcPos:sendDistanceEffect(pos, CONST_ANI_SUDDENDEATH)
    end
    
    if creature:isPlayer() then
        creature:addHealth(-GUARD_CONFIG.attackDamage)
        creature:sendTextMessage(MESSAGE_EVENT_DEFAULT, "You have been attacked by the guard for -" .. GUARD_CONFIG.attackDamage .. " HP!")
    elseif creature:isMonster() then
        creature:addHealth(-GUARD_CONFIG.attackDamage)
    end
    
    Game.sendAnimatedText(GUARD_CONFIG.attackDamage, pos, TEXTCOLOR_RED)
    
    GUARD_CONFIG.attackCount = GUARD_CONFIG.attackCount + 1
end

local function guardThinkCheck()
    local currentTime = os.time()
    if currentTime - GUARD_CONFIG.lastCheck < GUARD_CONFIG.checkInterval then
        return
    end
    
    GUARD_CONFIG.lastCheck = currentTime
    
    local npcCid = getNpcCid()
    if not npcCid then
        return
    end
    
    local npc = Npc(npcCid)
    if not npc then
        return
    end
    
    local npcPos = npc:getPosition()
    
    if GUARD_CONFIG.following and GUARD_CONFIG.targetPlayer then
        local target = Player(GUARD_CONFIG.targetPlayer)
        
        if target then
            local targetPos = target:getPosition()
            local distance = npcPos:getDistance(targetPos)
            
            if distance > GUARD_CONFIG.followRadius then
                selfSay('You escaped this time, coward!')
                stopFollowing()
                return
            end
            
            if isInProtectionZone(targetPos) then
                selfSay('Hiding in the protection zone like a coward!')
                stopFollowing()
                return
            end
            
            if GUARD_CONFIG.attackCount >= GUARD_CONFIG.maxAttacks then
                selfSay('I think you learned your lesson!')
                stopFollowing()
                return
            end
            
            if distance <= 1 then
                attackCreature(target, npcPos)
            elseif distance <= GUARD_CONFIG.followRadius then
                moveTowardsPlayer(npcPos, targetPos)
            end
        else
            stopFollowing()
        end
        
        return
    end
    
    local spectators = Game.getSpectators(npcPos, false, false, GUARD_CONFIG.attackRadius, GUARD_CONFIG.attackRadius)
    
    for _, creature in pairs(spectators) do
        if creature:isPlayer() then
            local player = creature
            if player:getSkull() > 0 and not isInProtectionZone(player:getPosition()) then
                selfSay('A criminal! Attack!')
                attackCreature(player, npcPos)
            end
        elseif creature:isMonster() then
            if not isInProtectionZone(creature:getPosition()) then
                attackCreature(creature, npcPos)
            end
        end
    end
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        if msgcontains(msg, 'fuck') or msgcontains(msg, 'shit') or msgcontains(msg, 'foda') then
            local player = Player(cid)
            if player and npcHandler:getDistanceToCreature(cid) < 4 then
                selfSay('Watch your mouth, ' .. player:getName() .. '!', cid)
                if not isInProtectionZone(player:getPosition()) then
                    selfSay('I will chase you down and teach you some manners!', cid)
                    GUARD_CONFIG.targetPlayer = cid
                    GUARD_CONFIG.following = true
                    GUARD_CONFIG.attackCount = 0
                else
                    selfSay('Lucky you are in a safe zone!', cid)
                end
            end
        end
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'fuck') or msgcontains(msg, 'shit') or msgcontains(msg, 'foda') then
        if isInProtectionZone(player:getPosition()) then
            selfSay('Ha! On protection zone you coward!', cid)
        else
            selfSay('You will regret those words! I will hunt you down!', cid)
            GUARD_CONFIG.targetPlayer = cid
            GUARD_CONFIG.following = true
            GUARD_CONFIG.attackCount = 0
        end
        
    elseif msgcontains(msg, 'stop') or msgcontains(msg, 'sorry') then
        selfSay('Fine! Behave yourself next time!', cid)
        stopFollowing()
        
    elseif msgcontains(msg, 'help') then
        selfSay('I am here to protect this town from criminals and monsters.', cid)
        
    elseif msgcontains(msg, 'job') then
        selfSay('I am a guard of this town. I protect citizens and hunt down troublemakers.', cid)
    end
    
    return true
end

function onGreet(cid)
    selfSay('Long live the Queen! I am a guard of this town.', cid)
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('Stay out of trouble, ' .. player:getName() .. '.', cid)
    end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())

local originalOnThink = onThink
function onThink()
    originalOnThink()
    guardThinkCheck()
end
