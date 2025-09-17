local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONHIT)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -8.2, -440, -15.3, 500)

local area = createCombatArea({
  {1, 1, 1},
  {1, 2, 1},
  {1, 1, 1}
})

combat:setArea(area)

function onCastSpell(cid, var)
doCreatureSay(cid, "Exori!", TALKTYPE_MONSTER_SAY)

  return combat:execute(cid, var)
end
