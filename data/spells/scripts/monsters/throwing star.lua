local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_THROWINGSTAR)

function onCastSpell(cid, var)
    combat:execute(cid, var)
end
