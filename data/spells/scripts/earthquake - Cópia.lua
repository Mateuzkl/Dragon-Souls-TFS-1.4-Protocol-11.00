local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_CRAPS)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -3.0, -30, -3.6, 0)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 3000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -200)
setCombatCondition(combat, condition)


local arr = {
{0, 0, 1, 0, 0},
{0, 1, 1, 1, 0},
{1, 1, 2, 1, 1},
{0, 1, 1, 1, 0},
{0, 0, 1, 0, 0}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Feel my fury!",16)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"GROOOAR!",16)
	return doCombat(cid, combat, var)
else
	return doCombat(cid, combat, var)
end
end
