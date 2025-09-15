local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -2000, 0, -2000)

local condition = Condition(CONDITION_BLEEDING)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(10, 1000, -2000, -2000)

combat:addCondition(condition)

local area = createCombatArea({
    {1, 1, 1},
    {1, 2, 1},
    {1, 1, 1}
})

combat:setArea(area)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
