local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}
local destination = {}

local ARCHER_CONFIG = {
    trainingArea = {x = 274, y = 186, z = 8}
}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

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
    
    npcHandler:say('Melmë ' .. player:getName() .. '! Are you sure you want to train to be a Precise Archer? So say "test".', cid)
    return true
end

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
        npcHandler:say('It\'s nice to hear that. Are you from Brazil or are you a foreigner?', cid)
        npcHandler.topic[cid] = 1
        
    elseif talk_state == 1 then
        if msgcontains(msg, 'brazil') or msgcontains(msg, 'brasil') then
            npcHandler:say({
                'Hmm, conheço bastante a sua língua... Então vamos ao treinamento!',
                'Archers(Arqueiros) são ágeis em "melee" mas não provém de grande força, seu principal ataque é o combate à distância, mantém sua força física e mental equilibradas.',
                'Então vamos ao teste... Está Pronto Melmë?'
            }, cid)
            npcHandler.topic[cid] = 2
        else
            npcHandler:say({
                'Hmm, I never traveled there, but... Let\'s start the training!',
                'Archers are quick with "melee" but don\'t provide great strength, their main fighting style is distance combat, they have their physical and mental strength balanced.',
                'So, let\'s go to the test... Ready?'
            }, cid)
            npcHandler.topic[cid] = 4
        end
        
    elseif talk_state == 2 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say({
                'Seu teste fará você usar a cabeça e sua agilidade!',
                'Apenas treine um pouco sua mira, no baú há intermináveis spears para o seu treino, mas cuidado, você saberá presenciar o perigo!',
                'Pronto Melmë?'
            }, cid)
            npcHandler.topic[cid] = 3
        end
        
    elseif talk_state == 4 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say({
                'Use your mind and agility!',
                'Just train your aim, in the chest there are endless spears for your training, but be careful, you will face danger!',
                'Ready?'
            }, cid)
            npcHandler.topic[cid] = 5
        end
        
    elseif talk_state == 3 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say('Estou lhe esperando do outro lado da sala quando você estiver pronto.', cid)
            player:teleportTo(Position(ARCHER_CONFIG.trainingArea))
            Position(ARCHER_CONFIG.trainingArea):sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:releaseFocus(cid)
        end
        
    elseif talk_state == 5 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            npcHandler:say('Good luck soldier, I will be waiting for you at the finish of this test!', cid)
            player:teleportTo(Position(ARCHER_CONFIG.trainingArea))
            Position(ARCHER_CONFIG.trainingArea):sendMagicEffect(CONST_ME_TELEPORT)
            npcHandler:releaseFocus(cid)
        end
    end
    
    return true
end

local function onAddFocus(cid)
    vocation[cid] = 0
    town[cid] = 0
    destination[cid] = 0
end

local function onReleaseFocus(cid)
    vocation[cid] = nil
    town[cid] = nil
    destination[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
