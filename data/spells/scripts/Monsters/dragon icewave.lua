local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 41)
combat:setParameter(COMBAT_PARAM_HITCOLOR, 100)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -90, 0, -140)

local area = createCombatArea({
{1, 1, 1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 0, 0, 0},
{0, 0, 0, 1, 1, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 3, 0, 0, 0, 0},
})

combat:setArea(area)

function onCastSpell(cid, var)
return combat:execute(cid, var)
end