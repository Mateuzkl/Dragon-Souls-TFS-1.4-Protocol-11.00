local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -5.2, -120, -6.8, 0)

function onCastSpell(cid, var)
  return combat:execute(cid, var)
end
