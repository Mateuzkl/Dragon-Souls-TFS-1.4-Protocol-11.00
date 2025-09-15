local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)

local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 1, 3000, -200)
addDamageCondition(condition, 1, 5000, -100)
setCombatCondition(combat, condition)

local arr = {
{0, 0, 0, 0, 0},
{0, 1, 1, 1, 0},
{0, 1, 2, 1, 0},
{0, 1, 1, 1, 0},
{0, 0, 0, 0, 0}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end
