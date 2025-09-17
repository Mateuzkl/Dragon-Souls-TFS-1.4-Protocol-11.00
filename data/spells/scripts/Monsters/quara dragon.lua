local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 25)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -75, 0, -400)

local area = createCombatArea({
    {0, 1, 0},
    {1, 3, 1},
    {0, 1, 0}
})
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
