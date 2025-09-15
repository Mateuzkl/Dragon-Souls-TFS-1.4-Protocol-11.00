local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local condition = createConditionObject(CONDITION_INVISIBLE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 120000)
setCombatCondition(combat, condition)

--local area = createCombatArea( { {1, 1, 1}, {1, 3, 1}, {1, 1, 1} } )
--setCombatArea(combat, area)

function onCastSpell(cid, var)
	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Can see me now?",16)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"You can't attack, what you can't see!",16)
	return doCombat(cid, combat, var)
else
	return doCombat(cid, combat, var)
end
end
