local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 230)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE = 47

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 15000)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
condition:setParameter(CONDITION_PARAM_SUBID, 219)
condition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, 80) -- 80% de chance

combat:addCondition(condition)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end

    if combat:execute(creature, variant) then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Critical Focus ativado! +80% de chance de critical por 15 segundos.")
        return true
    end
    return false
end
