local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.85, -30, -1.75, 0)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat2, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.40, -30, -0.90, 0)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat3, COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
setCombatParam(combat3, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat3, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
setCombatFormula(combat3, COMBAT_FORMULA_LEVELMAGIC, 0.9, 0, 1.8, 0)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_MANADRAIN)
setCombatFormula(combat4, COMBAT_FORMULA_LEVELMAGIC, 0.5, 0, 1.0, 0)

local exhaust = createConditionObject(CONDITION_EXHAUSTED)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, 2000)

local marcher1 = createCombatObject()
setCombatParam(marcher1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(marcher1, COMBAT_PARAM_DISTANCEEFFECT, 16)

local mmage1 = createCombatObject()
setCombatParam(mmage1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(mmage1, COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONHIT)
setCombatParam(mmage1, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
setCombatFormula(mmage1, COMBAT_FORMULA_LEVELMAGIC, -0.4, 0, -0.8, 0)


function onGetFormulaValues1(cid, level, maglevel)

if getPlayerSlotItem(cid, 10).itemid == 2543 then
skill = getPlayerSkill(cid,4)
min = -((skill*5)+level)/2
max = -((skill*7)+level)/2
return min, max
end

if getPlayerSlotItem(cid, 10).itemid == 2547 then
skill = getPlayerSkill(cid,4)
min = -((skill*7)+level)/2
max = -((skill*9)+level)/2
return min, max
end

end

setCombatCallback(marcher1, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")

function onTargetCreature(cid, target)

 if isPlayer(target) == 1 and isPlayer(cid) == 1 and getCreatureOutfit(target).lookType == 194 then
 	doPlayerSay(target,'Haha!',16)
	return doCombat(target, combat2, positionToVariant(getPlayerPosition(cid)))
 end

 if isPlayer(target) == 1 and isPlayer(cid) == 1 and getCreatureOutfit(target).lookType == 251 then
 	doPlayerSay(target,'Weak!',16)
	doCombat(cid, combat3, positionToVariant(getPlayerPosition(target)))
	return doCombat(cid, combat4, positionToVariant(getPlayerPosition(target)))
 end

 if isPlayer(target) == 1 and isPlayer(cid) == 1 and getCreatureOutfit(target).lookType == 262 then
 	doPlayerSay(target,'Shhhh!',16)
     	doSendAnimatedText(getThingPos(cid),"Silence!",215)
 	doPlayerSay(cid,'...',16)
   	doTargetCombatCondition(0, cid, exhaust, CONST_ME_NONE)
 end

 -- magias storage

 rand = math.random(1,50)
 if isPlayer(target) == 1 and rand == 1 then
 doPlayerSay(target,"Ouch, its hurt!",16)
else
end
 if isPlayer(target) == 1 and rand == 2 then
 doPlayerSay(target,"Ouch!",16)
else
end
 end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")


local function combo(parameters)

   	doTargetCombatCondition(0, parameters.cid, exhaust, CONST_ME_NONE)

 if isInArray({1,2,5,6}, getPlayerVocation(parameters.cid)) == TRUE then
	doCombat(parameters.cid, parameters.mmage1, parameters.var)
 end

 if isInArray({3,7}, getPlayerVocation(parameters.cid)) == TRUE then
	doCombat(parameters.cid, parameters.marcher1, parameters.var)
 end

end

function onCastSpell(cid, var)

local parameters = { cid = cid, var = var, marcher1 = marcher1, mmage1 = mmage1 }

 if isPlayer(cid) == 1 and getPlayerStorageValue(cid,7001) == 1 then
     	doSendAnimatedText(getThingPos(cid),"Combo!",215)

 if isInArray({1,2,5,6}, getPlayerVocation(cid)) == TRUE then
 	doPlayerSay(parameters.cid,'Trovão!',16)
 end

 if isInArray({3,7}, getPlayerVocation(cid)) == TRUE then
 	doPlayerSay(parameters.cid,'Rajada!',16)
 end

	setPlayerStorageValue(cid,7001,0)
 	addEvent(combo, 800, parameters)
 	addEvent(combo, 1200, parameters)
 	addEvent(combo, 1600, parameters)
 if getPlayerStorageValue(cid,7000) > 900 then
 	addEvent(combo, 2000, parameters)
 	addEvent(combo, 2400, parameters)
 end

 end

 rande = math.random(1,50)
 if rande == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Take This!",16)
	doCombat(cid, combat, var)
else
	doCombat(cid, combat, var)
end
end


