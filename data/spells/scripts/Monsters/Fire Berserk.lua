local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -8.2, -440, -15.3, 500)

local arr = {
  {1, 1, 1},
  {1, 2, 1},
  {1, 1, 1}
}

local stun = Condition(CONDITION_FIRE)
stun:setParameter(CONDITION_PARAM_DELAYED, true)
stun:addDamage(5, 1000, -500)
combat:setCondition(stun)

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(creature, variant)
  creature:say("Exori!", TALKTYPE_MONSTER_SAY)
  return combat:execute(creature, variant)
end
