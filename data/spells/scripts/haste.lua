local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local condition = createConditionObject(CONDITION_HASTE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 40000)
setConditionFormula(condition, 0.3, -24, 0.3, -24)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
 	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Speed on!",16)
	doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Run!",16)
	doCombat(cid, combat, var)
else
	doCombat(cid, combat, var)
end
end
