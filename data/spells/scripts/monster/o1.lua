local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 80)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 12)

function onCastSpell(cid, var)
    combat:execute(cid, var)
end
