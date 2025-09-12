local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local target = 0
local following = false
local attacking = false

function onCreatureAppear(cid)              
    npcHandler:onCreatureAppear(cid)
    npcHandler:say('Olaaa !')
end

function onCreatureDisappear(cid)           
    npcHandler:onCreatureDisappear(cid)
    local creature = Creature(cid)
    if creature then
        npcHandler:say('Poxa! pq vc mato o ' .. creature:getName() .. '?!')
    end
end

function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end

function onThink()                          
    npcHandler:onThink()
    
    -- Handle following and attacking behavior
    if following and target > 0 then
        local npc = Npc()
        local targetCreature = Creature(target)
        if npc and targetCreature then
            npc:moveToCreature(targetCreature)
        else
            following = false
            target = 0
        end
    elseif attacking and target > 0 then
        local npc = Npc()
        local targetCreature = Creature(target)
        if npc and targetCreature then
            local distance = npc:getPosition():getDistance(targetCreature:getPosition())
            if distance <= 1 then
                npc:setTarget(targetCreature)
            else
                npc:moveToCreature(targetCreature)
            end
        else
            attacking = false
            target = 0
        end
    end
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        local player = Player(cid)
        if not player then
            return false
        end
        
        local message = msg:lower()
        
        if string.find(message, 'hi') then
            npcHandler:say('oi oi, ' .. player:getName() .. '!', cid)
            return true
        elseif string.find(message, 'kiss') then
            npcHandler:say('kiss!', cid)
            return true
        elseif string.find(message, 'wuff') then
            npcHandler:say('cachorrinho lindo!', cid)
            return true
        elseif string.find(message, 'munch') or string.find(message, 'chomp') then
            npcHandler:say('da um pedaço?', cid)
            return true
        elseif string.find(message, 'bye') then
            npcHandler:say('Ja vai?', cid)
            return true
        elseif string.find(message, 'exevo con') then
            npcHandler:say('ai pra que vc quer flecha se nao sabe usar um arco?', cid)
            return true
        end
        
        return false
    end
    
    return true
end

-- Special keywords that work without focus
keywordHandler:addKeyword({'hi'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = false,
    text = 'oi oi, |PLAYERNAME|!'
})

keywordHandler:addKeyword({'kiss'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = false,
    text = 'kiss!'
})

keywordHandler:addKeyword({'wuff'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = false,
    text = 'cachorrinho lindo!'
})

keywordHandler:addKeyword({'munch', 'chomp'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = false,
    text = 'da um pedaço?'
})

keywordHandler:addKeyword({'bye'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = false,
    text = 'Ja vai?'
})

keywordHandler:addKeyword({'exevo con'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = false,
    text = 'ai pra que vc quer flecha se nao sabe usar um arco?'
})

npcHandler:setMessage(MESSAGE_GREET, 'oi oi, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Ja vai?')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Ja vai?')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
