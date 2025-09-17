local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
combat:setParameter(COMBAT_PARAM_HITCOLOR, COLOR_LIGHTBLUE)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 20000)
condition:setParameter(CONDITION_PARAM_SPEED, -300)
combat:addCondition(condition)

function onCastSpell(cid, var)
    doCreatureSay(cid, "Ice Bolt!", TALKTYPE_MONSTER)
    return combat:execute(cid, var)
end
