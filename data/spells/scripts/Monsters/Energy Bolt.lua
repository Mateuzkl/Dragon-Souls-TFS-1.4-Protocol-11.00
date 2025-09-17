local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
combat:setParameter(COMBAT_PARAM_HITCOLOR, COLOR_BLUE)

local arr = {
    {1, 0, 1},
    {0, 3, 0},
    {1, 0, 1}
}

local area = createCombatArea(arr)
combat:setArea(area)


function onCastSpell(cid, var)
    doCreatureSay(cid, "Energy Bolt!", TALKTYPE_MONSTER)
    return combat:execute(cid, var)
end
