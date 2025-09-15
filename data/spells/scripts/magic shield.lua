local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local condition = createConditionObject(CONDITION_MANASHIELD)
setConditionParam(condition, CONDITION_PARAM_TICKS, 180000)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
   	
	rand = math.random(1,30)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"The magic become to life!",16)
	return doCombat(cid, combat, var)
else
	return doCombat(cid, combat, var)
end
end
