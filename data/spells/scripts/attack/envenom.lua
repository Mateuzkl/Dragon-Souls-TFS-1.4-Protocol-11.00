local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(3, 10000, -5, -5)
condition:addDamage(4, 10000, -4, -4)
condition:addDamage(6, 10000, -3, -3)
condition:addDamage(9, 10000, -2, -2)
condition:addDamage(12, 10000, -1, -1)
combat:setCondition(condition)

function onCastSpell(creature, var)
    return combat:execute(creature, var)
end
