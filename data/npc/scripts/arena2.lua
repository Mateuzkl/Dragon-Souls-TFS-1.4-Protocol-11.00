local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local SKILL_CONFIG = {
    missionStorage = 8113,
    gems = {
        {id = 2149, name = 'small emerald'},
        {id = 2150, name = 'small amethyst'},
        {id = 2146, name = 'small sapphire'},
        {id = 2147, name = 'small ruby'},
        {id = 2145, name = 'small diamond'}
    },
    tradeGems = {
        {id = 2155, name = 'big emerald', bonus = 10},
        {id = 2153, name = 'violet gem', bonus = 20},
        {id = 2158, name = 'blue gem', bonus = 30},
        {id = 2156, name = 'big ruby', bonus = 40},
        {id = 2154, name = 'yellow gem', bonus = 50}
    }
}

local function giveVocationRewards(player, magicLevels, skillLevels)
    local vocation = player:getVocation():getId()
    
    if vocation == 9 or vocation == 13 or vocation == 10 or vocation == 14 then
        player:addMagicLevel(magicLevels)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Você recebeu %d magic levels.", magicLevels))
    elseif vocation == 11 or vocation == 15 then
        local magicBonus = math.floor(magicLevels / 5)
        player:addMagicLevel(magicBonus)
        player:addSkillLevel(SKILL_DISTANCE, skillLevels)
        player:addSkillLevel(SKILL_SHIELD, skillLevels)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Você recebeu %d magic levels e %d skills.", magicBonus, skillLevels))
    elseif vocation == 12 or vocation == 16 then
        player:addSkillLevel(SKILL_FIST, skillLevels)
        player:addSkillLevel(SKILL_CLUB, skillLevels)
        player:addSkillLevel(SKILL_SWORD, skillLevels)
        player:addSkillLevel(SKILL_AXE, skillLevels)
        player:addSkillLevel(SKILL_SHIELD, skillLevels)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Você recebeu %d skills.", skillLevels))
    end
end

local function tradeGemForHpMp(player, gemId, bonusPercent)
    if player:getItemCount(gemId) >= 1 then
        local maxHealth = player:getMaxHealth()
        local maxMana = player:getMaxMana()
        
        local healthBonus = math.floor((maxHealth * bonusPercent) / 100)
        local manaBonus = math.floor((maxMana * bonusPercent) / 100)
        
        player:setMaxHealth(maxHealth + healthBonus)
        player:setMaxMana(maxMana + manaBonus)
        player:addHealth(healthBonus)
        player:addMana(manaBonus)
        
        player:removeItem(gemId, 1)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Você recebeu %d pontos de vida e %d pontos de mana.", healthBonus, manaBonus))
        
        return true
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
    
    local missionProgress = player:getStorageValue(SKILL_CONFIG.missionStorage)
    local msgLower = msg:lower()
    local topic = npcHandler.topic[cid] or 0
    
    if msgcontains(msgLower, 'job') then
        npcHandler:say('I am a gladiator, lost in the wonders of this world!', cid)
        
    elseif msgcontains(msgLower, 'offer') then
        npcHandler:say('Aceita uma "missao" ou deseja "trocar" algo?', cid)
        
    elseif msgcontains(msgLower, 'knowledge') then
        npcHandler:say('I have been on long trips and quests! One more dangerous than the other, now I am just traveling and wondering the world beauties!', cid)
        
    elseif msgcontains(msgLower, 'missao') then
        if missionProgress == -1 then
            npcHandler:say('Se você me conseguir 10 small emeralds posso lhe conseguir alguns atributos extras, aceita a missão?', cid)
            npcHandler.topic[cid] = 10  -- Tópico especial para aceitar missão
            
        elseif missionProgress == 1 and player:getItemCount(2149) >= 10 then
            npcHandler:say('Como prometido.', cid)
            player:removeItem(2149, 10)
            giveVocationRewards(player, 10, 10)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(SKILL_CONFIG.missionStorage, 2)
            
        elseif missionProgress == 2 and player:getItemCount(2150) >= 10 then
            npcHandler:say('Como prometido.', cid)
            player:removeItem(2150, 10)
            giveVocationRewards(player, 20, 20)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(SKILL_CONFIG.missionStorage, 3)
            
        elseif missionProgress == 3 and player:getItemCount(2146) >= 10 then
            npcHandler:say('Como prometido.', cid)
            player:removeItem(2146, 10)
            giveVocationRewards(player, 30, 30)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(SKILL_CONFIG.missionStorage, 4)
            
        elseif missionProgress == 4 and player:getItemCount(2147) >= 10 then
            npcHandler:say('Como prometido.', cid)
            player:removeItem(2147, 10)
            giveVocationRewards(player, 40, 40)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(SKILL_CONFIG.missionStorage, 5)
            
        elseif missionProgress == 5 and player:getItemCount(2145) >= 10 then
            npcHandler:say('Como prometido.', cid)
            player:removeItem(2145, 10)
            giveVocationRewards(player, 50, 50)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(SKILL_CONFIG.missionStorage, 6)
            
        else
            local gemNames = {'small emerald', 'small amethyst', 'small sapphire', 'small ruby', 'small diamond'}
            local currentStep = math.max(1, math.min(missionProgress, 5))
            npcHandler:say(string.format('Traga-me 10 %ss e eu te darei atributos extras.', gemNames[currentStep]), cid)
        end
        
    elseif msgcontains(msgLower, 'trocar') then
        npcHandler:say('Troco big emerald, violet gem, blue gem, big ruby e yellow gem pelos devidos atributos!', cid)
        
    elseif msgcontains(msgLower, 'big emerald') then
        npcHandler:say('Aceita trocar big emerald por 10% de life e mana?', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msgLower, 'violet gem') then
        npcHandler:say('Aceita trocar violet gem por 20% de life e mana?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msgLower, 'blue gem') then
        npcHandler:say('Aceita trocar blue gem por 30% de life e mana?', cid)
        npcHandler.topic[cid] = 3
        
    elseif msgcontains(msgLower, 'big ruby') then
        npcHandler:say('Aceita trocar big ruby por 40% de life e mana?', cid)
        npcHandler.topic[cid] = 4
        
    elseif msgcontains(msgLower, 'yellow gem') then
        npcHandler:say('Aceita trocar yellow gem por 50% de life e mana?', cid)
        npcHandler.topic[cid] = 5
        
    elseif msgcontains(msgLower, 'yes') then
        if topic == 10 then  -- Aceitar missão
            npcHandler:say('Ótimo! Traga-me 10 small emeralds primeiro.', cid)
            player:setStorageValue(SKILL_CONFIG.missionStorage, 1)
            npcHandler.topic[cid] = 0
            
        elseif topic >= 1 and topic <= 5 then  -- Trocar gemas
            local gemData = SKILL_CONFIG.tradeGems[topic]
            if tradeGemForHpMp(player, gemData.id, gemData.bonus) then
                npcHandler:say('Muito obrigado!', cid)
            else
                npcHandler:say('Você não tem este item!', cid)
            end
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msgLower, 'no') and topic > 0 then
        npcHandler:say('Ok então.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

local function onAddFocus(cid)
    npcHandler.topic[cid] = 0
end

local function onReleaseFocus(cid)
    npcHandler.topic[cid] = nil
end

npcHandler:setMessage(MESSAGE_GREET, 'Hey! Aceita uma \'missao\' ou deseja \'trocar\' algo?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Goodbye, warrior!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Come back when you need my services!')

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
