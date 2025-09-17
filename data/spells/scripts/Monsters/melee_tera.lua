local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_CARNIPHILA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2, -14, -2, -31, 5, 5, 1.4, 2.1)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
