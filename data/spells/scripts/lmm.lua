local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONHIT)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.07, 0, -0.17, 0)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
