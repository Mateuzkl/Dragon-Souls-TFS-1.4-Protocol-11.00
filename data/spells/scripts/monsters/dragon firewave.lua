local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, 16)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -90, 0, -140)

local arr = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1},
    {0, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 1, 1, 0, 0},
    {0, 0, 1, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 1, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 1, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 3, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    doCreatureSay(cid, "FIREWAVEE!", TALKTYPE_MONSTER)
    return combat:execute(cid, var)
end
