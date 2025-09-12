local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local target = 0
local following = false
local attacking = false

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end

local lastRandomMove = 0
local lastRandomTalk = 0

function onThink()                          
    npcHandler:onThink()
    
    local npc = Creature(getNpcId())
    if not npc then
        return
    end
    
    -- Random movement when not focused
    if not npcHandler:isFocused() then
        local currentTime = os.time()
        
        -- Random movement every few seconds
        if currentTime - lastRandomMove > 2 then
            lastRandomMove = currentTime
            local randmove = math.random(1, 20)
            local npcPos = npc:getPosition()
            local newPos = Position(npcPos.x, npcPos.y, npcPos.z)
            
            if randmove == 1 then
                newPos.x = newPos.x + 1
            elseif randmove == 2 then
                newPos.x = newPos.x - 1
            elseif randmove == 3 then
                newPos.y = newPos.y + 1
            elseif randmove == 4 then
                newPos.y = newPos.y - 1
            end
            
            if randmove <= 4 then
                npc:moveToPosition(newPos)
            end
        end
        
        -- Random talking
        if currentTime - lastRandomTalk > 30 then
            lastRandomTalk = currentTime
            local randsay = math.random(1, 500)
            if randsay == 1 then
                npcHandler:say('What we will do?!')
            elseif randsay == 500 then
                npcHandler:say('I Want my son!')
            end
        end
    end
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        local player = Player(cid)
        if not player then
            return false
        end
        
        if msgcontains(msg, 'hi') then
            local randsay = math.random(1, 4)
            if randsay == 1 then
                npcHandler:say('Sings for me.', cid)
            elseif randsay == 2 then
                npcHandler:say('I Send my son to Osgiliath!', cid)
            elseif randsay == 3 then
                npcHandler:say('The war is comming! We are losted.', cid)
            elseif randsay == 4 then
                npcHandler:say('Where is Boromir?!', cid)
            end
            return true
        elseif msgcontains(msg, 'oi') then
            local randsay = math.random(1, 4)
            if randsay == 1 then
                npcHandler:say('Cante para mim.', cid)
            elseif randsay == 2 then
                npcHandler:say('Eu mandei meu filho a Osgiliath!', cid)
            elseif randsay == 3 then
                npcHandler:say('A guerra esta prócima! Estamos todos perdidos', cid)
            elseif randsay == 4 then
                npcHandler:say('Onde esta Boromir?!', cid)
            end
            return true
        elseif msgcontains(msg, 'orc') then
            npcHandler:say('Orcs are comming, all is losted!', cid)
            return true
        end
        return false
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
