local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ARCHER_CONFIG = {
    trainingArea = {x = 274, y = 186, z = 8},
    maxDistance = 2,
    timeout = 120
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if npcHandler:getDistanceToCreature(cid) > ARCHER_CONFIG.maxDistance then
        selfSay('Come closer to me!', cid)
        return true
    end
    
    if msgcontains(msg, 'test') then
        selfSay('It\'s nice to hear that. Are you from Brazil or are you a foreigner?', cid)
        npcHandler.topic[cid] = 1
        
    elseif npcHandler.topic[cid] == 1 then
        if msgcontains(msg, 'brazil') or msgcontains(msg, 'brasil') then
            selfSay('Hmm, conheço bastante a sua língua... Então vamos ao treinamento!', cid)
            selfSay('Archers(Arqueiros) são ágeis em "melee" mas não provém de grande força, seu principal ataque é o combate à distância, mantém sua força física e mental equilibradas.', cid)
            selfSay('Então vamos ao teste... Está Pronto Melmë?', cid)
            npcHandler.topic[cid] = 2
        else
            selfSay('Hmm, I never traveled there, but... Let\'s start the training!', cid)
            selfSay('Archers are quick with "melee" but don\'t provide great strength, their main fighting style is distance combat, they have their physical and mental strength balanced.', cid)
            selfSay('So, let\'s go to the test... Ready?', cid)
            npcHandler.topic[cid] = 4
        end
        
    elseif npcHandler.topic[cid] == 2 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('Seu teste fará você usar a cabeça e sua agilidade!', cid)
            selfSay('Apenas treine um pouco sua mira, no baú há intermináveis spears para o seu treino, mas cuidado, você saberá presenciar o perigo!', cid)
            selfSay('Pronto Melmë?', cid)
            npcHandler.topic[cid] = 3
        end
        
    elseif npcHandler.topic[cid] == 4 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('Use your mind and agility!', cid)
            selfSay('Just train your aim, in the chest there are endless spears for your training, but be careful, you will face danger!', cid)
            selfSay('Ready?', cid)
            npcHandler.topic[cid] = 5
        end
        
    elseif npcHandler.topic[cid] == 3 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('Estou lhe esperando do outro lado da sala quando você estiver pronto.', cid)
            player:teleportTo(Position(ARCHER_CONFIG.trainingArea))
            Position(ARCHER_CONFIG.trainingArea):sendMagicEffect(CONST_ME_TELEPORT)
        end
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 5 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            selfSay('Good luck soldier, I will be waiting for you at the finish of this test!', cid)
            player:teleportTo(Position(ARCHER_CONFIG.trainingArea))
            Position(ARCHER_CONFIG.trainingArea):sendMagicEffect(CONST_ME_TELEPORT)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'archer') then
        selfSay('Archers are masters of ranged combat. They balance physical and mental strength for perfect aim.', cid)
        
    elseif msgcontains(msg, 'training') then
        selfSay('My training will test your mind, agility, and precision. Are you ready for the challenge?', cid)
        
    elseif msgcontains(msg, 'spear') then
        selfSay('Spears are excellent weapons for training distance combat and improving your aim.', cid)
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Come back when you are ready for training.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        if npcHandler:getDistanceToCreature(cid) < ARCHER_CONFIG.maxDistance then
            selfSay('Melmë ' .. player:getName() .. '! Are you sure you want to train to be a Precise Archer? So say "test".', cid)
        else
            selfSay('Come closer, ' .. player:getName() .. '!', cid)
        end
    end
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('Good bye Melmë, ' .. player:getName() .. '!', cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())
