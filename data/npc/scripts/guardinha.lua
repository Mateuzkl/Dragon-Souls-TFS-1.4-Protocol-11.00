local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local target = 0
local following = false
local attacking = false

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end

local lastRandomTalk = 0

function onThink()
    npcHandler:onThink()
    
    if not npcHandler:isFocused() then
        local currentTime = os.time()
        if currentTime - lastRandomTalk > 30 then
            lastRandomTalk = currentTime
            local randsay = math.random(1, 500)
            if randsay == 1 then
                selfSay('Hmm...There is something strange about this place.')
            elseif randsay == 250 then
                selfSay('Huh?...I think i heard something over there!')
            elseif randsay == 500 then
                selfSay('My fire sword is burning my hand!')
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
                npcHandler:say('I cannot talk with you now.', cid)
            elseif randsay == 2 then
                npcHandler:say('Not now...', cid)
            elseif randsay == 3 then
                npcHandler:say('Who are you anyway?', cid)
            elseif randsay == 4 then
                npcHandler:say('Hail King Denethor!', cid)
            end
            return true
        elseif msgcontains(msg, 'oi') then
            local randsay = math.random(1, 4)
            if randsay == 1 then
                npcHandler:say('Não posso falar com você agora.', cid)
            elseif randsay == 2 then
                npcHandler:say('Você viu orcs?', cid)
            elseif randsay == 3 then
                npcHandler:say('Criança sem educação!', cid)
            elseif randsay == 4 then
                npcHandler:say('Salve o Rei Denethor!', cid)
            end
            return true
        elseif msgcontains(msg, 'fuck') then
            npcHandler:say('Hey! Watch your mouth!', cid)
            return true
        elseif msgcontains(msg, 'fdp') then
            npcHandler:say('Ei! Olha a educação!', cid)
            return true
        end
        return false
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
