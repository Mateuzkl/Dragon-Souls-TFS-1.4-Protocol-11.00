function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getActionId() ~= 100 then
        return false
    end
    
    if player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT) then
        player:sendCancelMessage("You dont need water now.")
        return true
    end
    
    -- Adiciona condição de regeneração (equivalente ao food)
    local condition = Condition(CONDITION_REGENERATION)
    condition:setParameter(CONDITION_PARAM_SUBID, 1)
    condition:setParameter(CONDITION_PARAM_TICKS, 10000 * 4 * 1000) -- 4x mais tempo
    condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 1)
    condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 1000)
    
    player:addCondition(condition)
    
    -- Efeitos visuais
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    
    -- Cura massiva
    player:addHealth(10000000)
    
    -- Player fala
    player:say("Ah... Fresh Water!!!", TALKTYPE_MONSTER_SAY)
    
    return true
end
