local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_CREATEITEM, 1491)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
