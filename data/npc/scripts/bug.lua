local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local target = 0
local following = false
local attacking = false

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
        local npc = Npc()
    if npc then
        npc:setTarget(nil)
    end
        following = false
    end
end

function onCreatureSay(cid, msgType, msg)   
    npcHandler:onCreatureSay(cid, msgType, msg)
end

function onThink()                          
    npcHandler:onThink()
    if following == true and target > 0 then
        local targetCreature = Creature(target)
        if targetCreature then
            local npc = Npc()
        if npc then
            npc:moveToPosition(targetCreature:getPosition())
        end
        end
    end
    if attacking == true and target > 0 then
        local targetCreature = Creature(target)
        local npc = Npc()
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
    
    if msgcontains(msg, 'hi') then
        npcHandler:say('Hello, ' .. player:getName() .. '!', cid)
    elseif msgcontains(msg, 'follow') then
        following = true
        target = cid
        npcHandler:say('Ok!', cid)
    elseif msgcontains(msg, 'attack') then
        attacking = true
        target = cid
        npcHandler:say('Ok, I will.', cid)
    elseif msgcontains(msg, 'stop') then
        following = false
        attacking = false
        target = 0
        local npc = Npc()
        if npc then
            npc:setTarget(nil)
        end
        npcHandler:say('Ok, I will wait here.', cid)
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
