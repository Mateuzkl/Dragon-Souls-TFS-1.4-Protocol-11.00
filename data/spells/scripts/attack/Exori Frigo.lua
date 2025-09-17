function onCastSpell(cid, var)
    local combat = Combat()
    combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
    combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
    combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
    combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2, -14, -2, -31, 5, 5, 1.4, 2.1)

    return combat:execute(cid, var)
end
