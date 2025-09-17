local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SNOWBALL)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -25, 0, -100)

local arr = {
    {1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1},
    {0, 1, 1, 1, 0},
    {0, 1, 1, 1, 0},
    {0, 0, 1, 0, 0},
    {0, 0, 3, 0, 0},
}

local area = createCombatArea(arr)

combat:setArea(area)

function onCastSpell(cid, var)
    combat:execute(cid, var)
end
