local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local target = 0
local following = false
local attacking = false

local storevalue = 2223
local alerttime = 600

function onCreatureAppear(cid)              
    npcHandler:onCreatureAppear(cid)
    attacking = true
    target = cid
end

function onCreatureDisappear(cid)           
    npcHandler:onCreatureDisappear(cid)
    if cid == target then
        target = 0
        attacking = false
        following = false
        local npc = Creature(getNpcId())
        if npc then
            npc:setTarget(nil)
        end
    end
end

function onCreatureSay(cid, msgType, msg)   
    npcHandler:onCreatureSay(cid, msgType, msg)
end

function onThink()                          
    npcHandler:onThink()
    
    local npc = Creature(getNpcId())
    if not npc then
        return
    end
    
    if following == true and target > 0 then
        local targetCreature = Creature(target)
        if targetCreature then
            npc:moveToPosition(targetCreature:getPosition())
        end
    end
    
    if attacking == true and target > 0 then
        local targetCreature = Creature(target)
        if targetCreature then
            local dist = npc:getPosition():getDistance(targetCreature:getPosition())
            if dist <= 1 then
                npc:setTarget(targetCreature)
            else
                npc:moveToPosition(targetCreature:getPosition())
            end
        else
            npc:setTarget(nil)
        end
    end
end

local function alertCheck(cid, storevalue, alerttime)
    local player = Player(cid)
    if not player then
        return 1
    end
    
    local lastAlert = player:getStorageValue(storevalue)
    local currentTime = os.time()
    
    if lastAlert == -1 or (currentTime - lastAlert) >= alerttime then
        player:setStorageValue(storevalue, currentTime)
        return 0
    end
    
    return 1
end

local function creatureSayCallback(cid, msgType, msg)
    local player = Player(cid)
    if not player then
        return false
    end
    
    local guild = player:getGuild()
    if not guild then
        return false
    end
    
    local guildRank = player:getGuildRank()
    if not guildRank then
        return false
    end
    
    local gname = guild:getName()
    local gstat = guildRank:getLevel()
    
    if msgcontains(msg, 'victory') then
        if gstat >= 3 then
            if alertCheck(cid, storevalue, alerttime) == 0 then
                Game.broadcastMessage('A guilda ' .. gname .. ', esta dominando o castelo!', MESSAGE_STATUS_WARNING)
            end
        end
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
