local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ARENA_CONFIG = {
    arenaStorage = 8111,
    minVocation = 8,
    arenaPosition = {x = 405, y = 496, z = 5},
    forbiddenItems = {6500, 2145, 2146, 2147, 2149, 2150, 2153, 2154, 2155, 2156, 2158}
}

local function hasAnyForbiddenItem(player)
    for _, itemId in pairs(ARENA_CONFIG.forbiddenItems) do
        if player:getItemCount(itemId) > 0 then
            return true
        end
    end
    return false
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'job') then
        selfSay('I am a gladiator, lost in the wonders of this world!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('Posso lhe oferecer diferentes tipos de arenas! Mas por enquanto somente a "Protect the King".', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('I am not a merchant!', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('I am not getting involved in quests anymore!', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('I am not getting involved in missions anymore!', cid)
        
    elseif msgcontains(msg, 'knowledge') then
        selfSay('I have been on long trips and quests! One more dangerous than the other, now I am just traveling and wondering the world beauties!', cid)
        
    elseif msgcontains(msg, 'addon') then
        selfSay('Hun?!', cid)
        
    elseif msgcontains(msg, 'asdkingzz') then
        if player:isPremium() then
            if player:getVocation():getId() > ARENA_CONFIG.minVocation then
                if not hasAnyForbiddenItem(player) then
                    selfSay('Tem certeza que deseja entrar na arena "Protect the King"?', cid)
                    npcHandler.topic[cid] = 1
                else
                    selfSay('Você não pode entrar nessa arena carregando: demonic essences, small diamond, small sapphire, small ruby, small emerald, small amethyst, big emerald, violet gem, yellow gem, big ruby e blue gem.', cid)
                    npcHandler.topic[cid] = 0
                end
            else
                selfSay('Somente Valans podem entrar nesta arena.', cid)
                npcHandler.topic[cid] = 0
            end
        else
            selfSay('Essa arena é somente para premiums.', cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
        selfSay('Está pronto?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        player:save()
        selfSay('Boa sorte!', cid)
        player:teleportTo(Position(ARENA_CONFIG.arenaPosition))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
