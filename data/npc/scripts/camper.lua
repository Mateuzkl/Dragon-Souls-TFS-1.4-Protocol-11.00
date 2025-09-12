local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('Shhh! I See an head of orc leaving on this hole!', cid)
    return true
end

keywordHandler:addKeyword({'hi'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'Shhh! I See an head of orc leaving on this hole!'
})

keywordHandler:addKeyword({'hello'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'Shhh! I See an head of orc leaving on this hole!'
})

keywordHandler:addKeyword({'oi'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'Shhh! Eu vi uma cabeça de orc saindo desse buraco!'
})

npcHandler:setMessage(MESSAGE_GREET, 'Shhh! I See an head of orc leaving on this hole!')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)

npcHandler:addModule(FocusModule:new())
