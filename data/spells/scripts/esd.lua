local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 39)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -3.50, -30, -6.25, 0)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat2, COMBAT_PARAM_DISTANCEEFFECT, 39)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -1.70, -30, -3.10, 0)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat3, COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
setCombatParam(combat3, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat3, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
setCombatFormula(combat3, COMBAT_FORMULA_LEVELMAGIC, 1.8, 0, 3.6, 0)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_MANADRAIN)
setCombatFormula(combat4, COMBAT_FORMULA_LEVELMAGIC, 1.0, 0, 2.0, 0)

local exhaust = createConditionObject(CONDITION_EXHAUSTED)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, 3000)

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


function onCastSpell(cid, var)
 rande = math.random(1,50)
 if rande == 1 and isPlayer(cid) == 1 then
 doPlayerSay(cid,"Take This!",16)
	doCombat(cid, combat, var)
else
	doCombat(cid, combat, var)
end
end
