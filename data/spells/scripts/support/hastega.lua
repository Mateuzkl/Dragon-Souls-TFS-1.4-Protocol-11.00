local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local condition = Condition(CONDITION_HASTEGA)
condition:setParameter(CONDITION_PARAM_TICKS, 3000) -- 3 segundos
combat:addCondition(condition)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end