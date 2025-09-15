local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)
combat:setParameter(COMBAT_PARAM_CREATEITEM, 1490)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
