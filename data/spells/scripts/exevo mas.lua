local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 14)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

local exhaust = createConditionObject(CONDITION_EXHAUSTED)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, 5000)


function onCastSpell(cid, var)
   	doTargetCombatCondition(0, cid, exhaust, CONST_ME_NONE)
     	doSendAnimatedText(getThingPos(cid),"Power Up!",215)
	setPlayerStorageValue(cid,7001,1)

 if getPlayerStorageValue(cid,7000) == 900 then
	setPlayerStorageValue(cid,7000,getPlayerStorageValue(cid,7000)+1)
 	doPlayerSay(cid,'Concentração Level Up!',16)
 	doPlayerSendTextMessage(cid,20,'Sua concentração agora está level 2.')
 end

 if getPlayerStorageValue(cid,7000) < 998 then
	setPlayerStorageValue(cid,7000,getPlayerStorageValue(cid,7000)+1)
 end

	return doCombat(cid, combat, var)
end
