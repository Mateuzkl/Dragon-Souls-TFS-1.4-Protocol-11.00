local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 80)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -2.0, -30, -2.6, 0)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 80)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -1.0, -30, -1.4, 0)

local exhaust = createConditionObject(CONDITION_EXHAUSTED)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, 500)

local arr = {
{1, 1, 1},
{1, 2, 1},
{1, 1, 1}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)
setCombatArea(combat2, area)

local function combo(parameters)

   	doTargetCombatCondition(0, parameters.cid, exhaust, CONST_ME_NONE)
	doCombat(parameters.cid, parameters.combat2, parameters.var)

end

function onCastSpell(cid, var)

local parameters = { cid = cid, var = var, combat = combat, combat2 = combat2 }

 if isPlayer(cid) == 1 and getPlayerStorageValue(cid,7001) == 1 then
     	doSendAnimatedText(getThingPos(cid),"Combo!",215)
 	doPlayerSay(parameters.cid,'Fúria!',16)
	setPlayerStorageValue(cid,7001,0)
 	addEvent(combo, 800, parameters)
 	addEvent(combo, 1200, parameters)
 	addEvent(combo, 1600, parameters)
 if getPlayerStorageValue(cid,7000) > 900 then
 	addEvent(combo, 2000, parameters)
 	addEvent(combo, 2400, parameters)
 end
 end
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