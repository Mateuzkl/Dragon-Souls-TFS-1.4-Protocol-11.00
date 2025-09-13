local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}
local destination = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

-- Callback para validar no greeting
local function greetCallback(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    local level = player:getLevel()
    if level < 8 then
        npcHandler:say('CHILD! COME BACK WHEN YOU HAVE GROWN UP!', cid)
        return false
    elseif level > 50 then
        npcHandler:say('YOU ARE TOO STRONG ALREADY!', cid)
        return false
    elseif player:getVocation():getId() > 4 then
        npcHandler:say('YOU ALREADY HAVE AN ADVANCED VOCATION!', cid)
        return false
    end
    
    npcHandler:say('Hail ' .. player:getName() .. '! Are you sure, want train to be a Heroic Knight? So say "test".', cid)
    return true
end

-- Callback principal da conversação
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local talk_state = npcHandler.topic[cid] or 0
    msg = msg:lower()
    
    if msgcontains(msg, 'test') and talk_state == 0 then
        npcHandler:say('Ha! Nice choice soldier, where did you from? Brazil or foreigner?', cid)
        npcHandler.topic[cid] = 1
        
    -- País
    elseif talk_state == 1 then
        if msgcontains(msg, 'brazil') or msgcontains(msg, 'brasil') then
            npcHandler:say('Muito bem então... Vamos começar o treinamento!', cid)
            npcHandler:say('Knights(Cavaleiros) é a vocação que provém mais força, eles são fortes, resistentes, e sabem usar muito bem qualquer arma de "melee" com máxima eficiência!', cid)
            npcHandler:say('Pois vamos ao teste... Está pronto?', cid)
            npcHandler.topic[cid] = 2
        else
            npcHandler:say('Hmm, i never travel to there, but... Lets start the training!', cid)
            npcHandler:say('Knights are the toughest warriors. They are strong, resilient, and they know how to wield any melee weapon with fearsome efficiency.', cid)
            npcHandler:say('So, lets go to test... Ready?', cid)
            npcHandler.topic[cid] = 4
        end
        
    -- yes 1 (Brasil)
    elseif talk_state == 2 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say('Eis o que irá fazer para passar no teste soldado!', cid)
            npcHandler:say('Nossa sala de armamentos está infestada de ratos, quero que você desinfete essas pragas!', cid)
            npcHandler:say('Pronto?', cid)
            npcHandler.topic[cid] = 3
        end
        
    -- yes 1 (Foreigner)
    elseif talk_state == 4 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say('What all you will need do is!', cid)
            npcHandler:say('Our weapon room is infested with rats, i want you to defeat this plague!', cid)
            npcHandler:say('Ready?', cid)
            npcHandler.topic[cid] = 5
        end
        
    -- yes 2 (teleport Brasil)
    elseif talk_state == 3 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say('Boa sorte soldado, aguardo você no final do teste!', cid)
            player:teleportTo(Position(291, 177, 8))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:releaseFocus(cid)
        end
        
    -- yes 2 (teleport Foreigner)
    elseif talk_state == 5 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say('Good luck soldier, i was waiting you on the finish of this test!', cid)
            player:teleportTo(Position(291, 177, 8))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:releaseFocus(cid)
        end
    end
    
    return true
end

-- Callback para limpar dados quando player ganha focus
local function onAddFocus(cid)
    vocation[cid] = 0
    town[cid] = 0
    destination[cid] = 0
end

-- Callback para limpar dados quando player perde focus
local function onReleaseFocus(cid)
    vocation[cid] = nil
    town[cid] = nil
    destination[cid] = nil
end

-- Registrar callbacks
npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
