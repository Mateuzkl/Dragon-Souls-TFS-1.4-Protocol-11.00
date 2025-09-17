local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -3.0, -59, -2.3, 83)

local area = createCombatArea({
  {0, 1, 1, 1, 0},
  {1, 1, 1, 1, 1},
  {1, 1, 2, 1, 1},
  {1, 1, 1, 1, 1},
  {0, 1, 1, 1, 0}
})
combat:setArea(area)

function onCastSpell(cid, var)
  -- Remova a verificação de exaustão e a mensagem associada
  return combat:execute(cid, var)
end
