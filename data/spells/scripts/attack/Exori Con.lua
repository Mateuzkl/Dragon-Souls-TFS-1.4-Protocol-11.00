local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -10.5, -79, -10.1, 0)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
