local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -40, 0, -120)

local arr = {
    {1, 1, 1, 1, 1, 1 ,1},
    {1, 1, 1, 1, 1, 1 ,1},
    {1, 1, 1, 1, 1, 1 ,1},
    {0, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 0, 0},
    {0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 3, 0, 0, 0},
}

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
