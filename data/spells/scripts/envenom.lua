local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(10, 2000, -5, -5)

combat:addCondition(condition)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
