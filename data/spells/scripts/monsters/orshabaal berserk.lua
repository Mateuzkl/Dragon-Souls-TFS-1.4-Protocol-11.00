local arr = {
  {0, 0, 0, 1, 0, 0, 0},
  {0, 0, 1, 1, 1, 0, 0},
  {0, 1, 1, 1, 1, 1, 0},
  {1, 1, 1, 2, 1, 1, 1},
  {0, 1, 1, 1, 1, 1, 0},
  {0, 0, 1, 1, 1, 0, 0},
  {0, 0, 0, 1, 0, 0, 0},
}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -450, 0, -650)

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
  return doCombat(cid, var)
end

function doCombat(cid, var)
  return combat:execute(cid, var)
end
