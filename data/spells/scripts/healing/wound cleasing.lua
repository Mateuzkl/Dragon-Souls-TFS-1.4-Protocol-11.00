local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 8, 6, 18.5, 40)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
