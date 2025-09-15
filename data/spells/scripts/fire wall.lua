local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setParameter(COMBAT_PARAM_CREATEITEM, 1487)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.5, -30, -1.0, 0)

local arr = {
    {1, 1, 3, 1, 1}
}

local arrDiag = {
    {0, 0, 0, 0, 0, 0, 1},
    {0, 0, 0, 0, 0, 1, 1},
    {0, 0, 0, 0, 1, 1, 0},
    {0, 0, 1, 3, 1, 0, 0},
    {0, 1, 1, 0, 0, 0, 0},
    {1, 1, 0, 0, 0, 0, 0},
    {1, 0, 0, 0, 0, 0, 0}
}

local area = createCombatArea(arr, arrDiag)
combat:setArea(area)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
