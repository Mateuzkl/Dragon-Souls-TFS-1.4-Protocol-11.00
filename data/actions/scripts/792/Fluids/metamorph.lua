local EXHAUSTED_SECONDS = 30
local EXHAUSTED_STORAGE = 4850

local Speed = Condition(CONDITION_HASTE)
Speed:setParameter(CONDITION_PARAM_TICKS, 30000)
Speed:setFormula(0, 6000, 0, 6000)

local function bloodHealing(playerGuid, healType, count)
    local player = Player(playerGuid)
    if not player then
        return
    end
    
    if count <= 0 then
        return
    end
    
    local level = player:getLevel()
    local skill = player:getSkillLevel(SKILL_CLUB)
    local magic = player:getMagicLevel()
    
    local healthGain, manaGain = 0, 0
    
    if healType == 1 then -- Chronos
        healthGain = math.floor(10 * player:getMaxHealth() / 100) + (skill * 3) + (magic * 5) + (level * 5)
        manaGain = math.floor(10 * player:getMaxMana() / 100) + (skill * 5) + (magic * 3) + (level * 5)
    elseif healType == 2 then -- Kazard
        healthGain = math.floor(10 * player:getMaxHealth() / 100) + (skill * 3) + (magic * 2) + (level * 3)
        manaGain = math.floor(10 * player:getMaxMana() / 100) + (skill * 2) + (magic * 3) + (level * 3)
    else -- Hazus
        healthGain = math.floor(10 * player:getMaxHealth() / 100) + (skill * 2) + (magic * 2) + (level * 1)
        manaGain = math.floor(10 * player:getMaxMana() / 100) + (skill * 2) + (magic * 2) + (level * 1)
    end
    
    player:addHealth(healthGain)
    player:addMana(manaGain)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    
    addEvent(bloodHealing, 2000, playerGuid, healType, count - 1)
end

local function revertOutfit(playerGuid, originalOutfit)
    local player = Player(playerGuid)
    if player then
        player:setOutfit(originalOutfit)
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Seu blood of god's terminou!")
    end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getSoul() <= 49 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Desculpe, você não tem Souls suficiente.")
        return true
    end
    
    if os.time() < player:getStorageValue(EXHAUSTED_STORAGE) then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Você não pode usar um blood of gods durante o efeito de outro.")
        return true
    end
    
    local currentOutfit = player:getOutfit()
    local bloodType = math.random(1, 3)
    
    local outfits = {
        [1] = {lookType = 251, name = "Chronos"},
        [2] = {lookType = 262, name = "Kazard"},
        [3] = {lookType = 194, name = "Hazus"}
    }
    
    local messages = {
        [1] = "Grr! Chronos back!",
        [2] = "Nhe hehe!",
        [3] = "My hands are burning!"
    }
    
    local descriptions = {
        [1] = "você usou concentrated demoniac blood e se transformou em um Chronos. (Revitalization Ativado)",
        [2] = "Você usou um concentrated demoniac blood e se transformou em um Kazard. (Full Haste Ativado)",
        [3] = "Você usou um concentrated demoniac blood e se transformou em um Hazus. (Reflect Ativado)"
    }
    
    local newOutfit = {
        lookType = outfits[bloodType].lookType,
        lookHead = currentOutfit.lookHead,
        lookBody = currentOutfit.lookBody,
        lookLegs = currentOutfit.lookLegs,
        lookFeet = currentOutfit.lookFeet,
        lookAddons = currentOutfit.lookAddons
    }
    
    if bloodType == 1 then
        player:addHealth(math.floor(15 * player:getMaxHealth() / 100))
        player:addMana(math.floor(15 * player:getMaxMana() / 100))
    elseif bloodType == 2 then
        player:addHealth(math.floor(10 * player:getMaxHealth() / 100))
        player:addMana(math.floor(10 * player:getMaxMana() / 100))
        player:addCondition(Speed)
    else
        player:addHealth(math.floor(10 * player:getMaxHealth() / 100))
        player:addMana(math.floor(10 * player:getMaxMana() / 100))
    end
    
    player:setOutfit(newOutfit)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    player:sendTextMessage(MESSAGE_STATUS_WARNING, descriptions[bloodType])
    player:say(messages[bloodType], TALKTYPE_ORANGE_1)
    
    bloodHealing(player:getGuid(), bloodType, 14)
    addEvent(revertOutfit, 30000, player:getGuid(), currentOutfit)
    
    player:setStorageValue(EXHAUSTED_STORAGE, os.time() + EXHAUSTED_SECONDS)
    player:addSoul(-50)
    item:remove(1)
    
    return true
end
