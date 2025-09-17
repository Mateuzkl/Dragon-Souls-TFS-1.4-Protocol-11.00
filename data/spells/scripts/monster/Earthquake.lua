local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 26)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -10.2, -540, -20.3, 550)

local arr = {
    {1, 1, 1},
    {1, 2, 1},
    {1, 1, 1}
}

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
