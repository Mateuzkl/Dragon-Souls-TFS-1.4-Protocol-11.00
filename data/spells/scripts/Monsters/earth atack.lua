local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -400, 0, -800)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
