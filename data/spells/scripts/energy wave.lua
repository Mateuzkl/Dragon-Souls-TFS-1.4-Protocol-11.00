local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -1.1, -30, -2.2, 0)

local arr = {
    {1, 1, 1},
    {1, 1, 1},
    {1, 1, 1},
    {0, 1, 0},
    {0, 3, 0}
}

local arrDiag = {
    {1, 1, 1, 0, 0},
    {1, 1, 0, 0, 0},
    {1, 0, 1, 0, 0},
    {0, 0, 0, 1, 0},
    {0, 0, 0, 0, 3}
}

local area = createCombatArea(arr, arrDiag)
combat:setArea(area)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
