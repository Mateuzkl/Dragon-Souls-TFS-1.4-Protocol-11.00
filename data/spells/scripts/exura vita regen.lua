local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 0, 1, 0,10)

local condition = createConditionObject(CONDITION_REGEN)
setConditionParam(condition, CONDITION_PARAM_TICKS, 60000)
setConditionParam(condition, CONDITION_PARAM_HEALTHGAIN, 1000)
setConditionParam(condition, CONDITION_PARAM_HEALTHTICKS, 1)
setCombatCondition(combat, condition)


function onCastSpell(cid, var)
	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"From the death to life!",16)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Feel the life on your soul!",16)
	return doCombat(cid, combat, var)
	elseif rand == 3 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"The light on the darkness!",16)
	return doCombat(cid, combat, var)
else
	return doCombat(cid, combat, var)
end
end