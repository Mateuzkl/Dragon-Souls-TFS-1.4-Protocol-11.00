local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 7)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 26)

local condition = createConditionObject(CONDITION_EMO)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 5, 3000, -25)
addDamageCondition(condition, 5, 5000, -10)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end
