local function getBonus(player)
    local bonus = player:getStorageValue(6629)
    return bonus < 0 and 0 or bonus
end

local function addBonus(player)
    local bonusvoc = {
        [9] = {health = 20, mana = 120},
        [10] = {health = 20, mana = 120},
        [11] = {health = 40, mana = 60},
        [12] = {health = 60, mana = 20},
        [13] = {health = 30, mana = 180},
        [14] = {health = 30, mana = 180},
        [15] = {health = 60, mana = 90},
        [16] = {health = 90, mana = 30}
    }
    
    local vocation = player:getVocation():getId()
    local vocBonus = bonusvoc[vocation]
    
    if not vocBonus then
        return
    end
    
    local currentBonus = getBonus(player)
    player:setStorageValue(6629, currentBonus + 1)
    
    player:setMaxHealth(player:getMaxHealth() + vocBonus.health)
    player:setMaxMana(player:getMaxMana() + vocBonus.mana)
    player:addMana(100000)
    player:addHealth(100000)
    
    player:sendTextMessage(MESSAGE_STATUS_WARNING, "voce recebeu " .. vocBonus.health .. " pontos de HP e " .. vocBonus.mana .. " pontos de Mana, agora seu bônus está: " .. (currentBonus + 1) .. ".")
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local skill = player:getSkillLevel(SKILL_CLUB)
    local maglevel = player:getMagicLevel()
    local level = player:getLevel()
    local bonus = getBonus(player)
    
    if level <= 7 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Somente jogadores com nivel superior a 8 podem usar este elixir.")
        return true
    end
    
    if player:getSoul() <= 249 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce não tem Souls suficiente.")
        return true
    end
    
    local min = (level * 220) + (skill * 155) + (maglevel * 100)
    local max = (level * 595) + (skill * 310) + (maglevel * 290)
    local exp = math.random(min, max)
    
    player:addExperience(exp)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    player:sendTextMessage(MESSAGE_STATUS_WARNING, "voce recebeu " .. exp .. " pontos de experiência. Bônus: " .. bonus .. ".")
    Game.sendAnimatedText(tostring(exp), player:getPosition(), TEXTCOLOR_WHITE)
    
    player:addSoul(-250)
    item:remove(1)
    
    local random = math.random(1, 220)
    if random == 1 and bonus < 10 then
        addBonus(player)
    end
    
    return true
end
