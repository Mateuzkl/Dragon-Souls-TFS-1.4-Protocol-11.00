local function getBonus(player)
    if player:getStorageValue(6621) < 0 then
        return 0
    else
        return player:getStorageValue(6621)
    end
end

local function addBonus(player, number)
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
    
    if player:getStorageValue(6621) < 0 then
        player:setStorageValue(6621, 1)
    else
        player:setStorageValue(6621, 1 + getBonus(player))
    end
    
    local health = bonusvoc[player:getVocation():getId()].health
    local mana = bonusvoc[player:getVocation():getId()].mana
    
    player:setMaxHealth(player:getMaxHealth() + health)
    player:setMaxMana(player:getMaxMana() + mana)
    player:addHealth(100000)
    player:addMana(100000)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "voce recebeu " .. health .. " pontos de HP e " .. mana .. " pontos de Mana, agora seu bonus esta: " .. getBonus(player) .. ".")
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local skill = player:getSkillLevel(SKILL_FIST)
    local maglevel = player:getMagicLevel()
    local level = player:getLevel()
    local min = ((level * 3520) + (skill * 1285) + (maglevel * 1650))
    local max = ((level * 4895) + (skill * 1870) + (maglevel * 2090))
    
    local exp = math.random(min, max)
    local bonus = getBonus(player)
    
    if player:getLevel() <= 149 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Somente jogadores com nivel superior a 150 podem usar este elixir.')
        return true
    end
    
    if player:getSoul() <= 249 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Voce nao tem Souls suficiente.')
        return true
    end
    
    player:addExperience(exp)
    
    local condition = Condition(CONDITION_ENERGY)
    condition:setParameter(CONDITION_PARAM_DELAYED, 1)
    condition:setParameter(CONDITION_PARAM_MINVALUE, 0)
    condition:setParameter(CONDITION_PARAM_MAXVALUE, 0)
    condition:setParameter(CONDITION_PARAM_STARTVALUE, 0)
    player:addCondition(condition)
    
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'voce recebeu ' .. exp .. ' pontos de experiencia. Bonus: ' .. bonus .. '.')
    player:getPosition():sendAnimatedText(exp, TEXTCOLOR_LIGHTBLUE)
    item:remove(1)
    player:addSoul(-250)
    
    local random = math.random(1, 100)
    if random <= 5 then
        if not(getBonus(player) >= 10) then
            addBonus(player, bonus)
        end
    end
    
    return true
end
