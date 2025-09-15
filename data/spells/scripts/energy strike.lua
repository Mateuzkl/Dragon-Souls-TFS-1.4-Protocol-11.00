local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.25, -30, -0.55, 0)

local area = createCombatArea({
    {0, 0, 0},
    {0, 0, 0},
    {0, 0, 0},
    {0, 0, 0},
    {0, 3, 0}
})

combat:setArea(area)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
