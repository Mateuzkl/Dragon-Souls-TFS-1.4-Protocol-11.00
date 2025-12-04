local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.1, -30, -1.1, 0)

local area = createCombatArea({
    {0, 1, 0},
    {1, 3, 1},
    {0, 1, 0}
})

combat:setArea(area)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
