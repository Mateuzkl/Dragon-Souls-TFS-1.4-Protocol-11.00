local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_HITCOLOR, COLOR_PURPLE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -40.0, -1500, -30.0, -1500)

local area = createCombatArea({
  {0, 0, 0},
  {0, 3, 0},
  {0, 0, 0}
})
combat:setArea(area)

function onCastSpell(cid, var)
doCreatureSay(cid, "GRAVITAAAA!", TALKTYPE_MONSTER_SAY)

  return combat:execute(cid, var)
end
