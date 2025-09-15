local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setParameter(COMBAT_PARAM_CREATEITEM, 1487)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
