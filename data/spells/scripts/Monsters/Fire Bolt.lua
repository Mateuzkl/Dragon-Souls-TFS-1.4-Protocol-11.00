local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 33)
combat:setParameter(COMBAT_PARAM_EFFECT, 6)
combat:setParameter(COMBAT_PARAM_HITCOLOR, COLOR_ORANGE)



local stun = Condition(CONDITION_FIRE)
stun:setParameter(CONDITION_PARAM_DELAYED, 25)
stun:addDamage(500, 5, -2000)
combat:addCondition(stun)


local arr = {
    {1, 1, 1},
    {1, 3, 1},
    {1, 1, 1}
}


local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    doCreatureSay(cid, "Fire Bolt!", TALKTYPE_MONSTER)
    return combat:execute(cid, var)
end
