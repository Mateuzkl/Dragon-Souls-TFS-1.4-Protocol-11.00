local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLSTONE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.4, -30, -0.5, 0)

function onCastSpell(cid, var)
doCreatureSay(cid, "Critical!", TALKTYPE_MONSTER_SAY)

  return combat:execute(cid, var)
end

