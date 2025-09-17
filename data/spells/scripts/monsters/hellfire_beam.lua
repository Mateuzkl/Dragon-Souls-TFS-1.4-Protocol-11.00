local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIRE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -1.3, -30, -1.7, 0)

local arr = {
    {0, 1, 0},
    {0, 1, 0},
    {0, 1, 0},
    {0, 1, 0},
    {0, 3, 0},
}

local arrDiag = {
    {1, 0, 0, 0, 0},
    {0, 1, 0, 0, 0},
    {0, 0, 1, 0, 0},
    {0, 0, 0, 1, 0},
    {0, 0, 0, 0, 3},
}

local area = createCombatArea(arr, arrDiag)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
