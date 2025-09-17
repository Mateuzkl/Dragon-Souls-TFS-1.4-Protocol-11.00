local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -5.0, -50, -3.6, 0)

local arr = {
    {1, 1, 1},
    {1, 1, 1},
    {1, 1, 1},
    {0, 1, 0},
    {0, 3, 0},
}

local arrDiag = {
    {1, 1, 1, 0, 0},
    {1, 1, 0, 0, 0},
    {1, 0, 1, 0, 0},
    {0, 0, 0, 1, 0},
    {0, 0, 0, 0, 3},
}

local area = createCombatArea(arr, arrDiag)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
