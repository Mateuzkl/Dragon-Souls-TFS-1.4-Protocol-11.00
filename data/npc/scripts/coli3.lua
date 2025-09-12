local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local target = 0
local following = false
local attacking = false

function onCreatureAppear(cid)              
    npcHandler:onCreatureAppear(cid)
    -- Execute raid when creature appears
    Game.startRaid('coli3')
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

local function creatureSayCallback(cid, msgType, msg)
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'hi') then
        npcHandler:say('oi oi, ' .. player:getName() .. '!', cid)
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
