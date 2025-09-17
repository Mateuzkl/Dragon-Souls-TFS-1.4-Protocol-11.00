local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.5, -150, -15.5, 250)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
