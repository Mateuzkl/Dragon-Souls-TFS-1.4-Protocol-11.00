local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local combat2 = createCombatObject()

local condition = createConditionObject(CONDITION_HASTE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 80000)
setConditionFormula(condition, 0.3, -24, 0.3, -24)
setCombatCondition(combat, condition)

local condition2 = createConditionObject(CONDITION_OUTFIT)
setConditionParam(condition2, CONDITION_PARAM_TICKS, 80000)
addOutfitCondition(condition2, 0, 230, 0, 0, 0, 0)
setCombatCondition(combat2, condition2)

function onCastSpell(cid, var)
	doCombat(cid, combat, var)
	doCombat(cid, combat2, var)
end
