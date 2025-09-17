local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DAMAGE_POISON)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYPOISON)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
