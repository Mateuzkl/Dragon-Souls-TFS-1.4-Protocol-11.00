local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.2, -130, -0.2, -200)

local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 1, 2300, -50)
addDamageCondition(condition, 1, 2300, -25)
addDamageCondition(condition, 1, 2300, -10)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
	doCombat(cid, combat, var)
end
