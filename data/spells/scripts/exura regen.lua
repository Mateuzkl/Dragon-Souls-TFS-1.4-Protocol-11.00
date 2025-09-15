local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 0.4, -30, 0.7, 0)

local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 120, 1000, 50)
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