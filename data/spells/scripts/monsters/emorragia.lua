local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combat, COMBAT_FORMULA_SKILL, -0.2, 0, -1, 0)

local condition = createConditionObject(CONDITION_EMO)
rande = math.random(10,25)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 300, 2200, -rande)
setCombatCondition(combat, condition)


function onCastSpell(cid, var)
    	return doCombat(cid, combat, var)
end
