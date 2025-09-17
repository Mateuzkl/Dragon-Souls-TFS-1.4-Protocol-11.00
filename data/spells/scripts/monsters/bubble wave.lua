local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -1.3, 0, -1.7, 0)

local arr = {
    {1, 1, 1},
    {1, 1, 1},
    {1, 1, 1},
    {0, 3, 0},
}

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
