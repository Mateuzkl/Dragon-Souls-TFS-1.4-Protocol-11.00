local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

local condition = Condition(CONDITION_FIRE)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(20, 2000, -10, -10)

combat:addCondition(condition)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
