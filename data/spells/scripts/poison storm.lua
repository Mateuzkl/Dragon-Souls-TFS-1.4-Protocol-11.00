local combat = createCombatObject(COMBAT_POISONDAMAGE)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.1, -25, -0.3, -50)

local condition = createConditionObject(CONDITION_POISON)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 1, 3000, -20)
addDamageCondition(condition, 2, 3000, -19)
addDamageCondition(condition, 3, 3000, -17)
addDamageCondition(condition, 4, 3000, -14)
addDamageCondition(condition, 5, 3000, -10)
addDamageCondition(condition, 4, 3000, -5)
addDamageCondition(condition, 3, 3000, -4)
addDamageCondition(condition, 5, 3000, -3)
addDamageCondition(condition, 4, 3000, -2)
addDamageCondition(condition, 10, 3000, -1)
setCombatCondition(combat, condition)

local arr = {
{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"The sickness will show the real valor of life!",16)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"You don't deserves your life!",16)
	return doCombat(cid, combat, var)
else
	return doCombat(cid, combat, var)
end
end