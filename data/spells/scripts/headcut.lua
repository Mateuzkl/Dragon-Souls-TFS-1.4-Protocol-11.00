local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0, -2000, -0, -2000)

local condition = createConditionObject(CONDITION_EMO)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 10, 1000, -2000)
setCombatCondition(combat, condition)

local arr = {
{1, 1, 1},
{1, 2, 1},
{1, 1, 1}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end
