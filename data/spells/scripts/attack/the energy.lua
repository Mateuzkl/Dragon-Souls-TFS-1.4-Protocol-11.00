local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 10, 100, 30, 300)

local = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat1, COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
setCombatParam(combat1, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat1, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, 10, 100, 30, 300)

local condition = createConditionObject(CONDITION_REGENERATION)
setConditionParam(condition, CONDITION_PARAM_TICKS, 20000)
setConditionParam(condition, CONDITION_PARAM_MANAGAIN, 1000)
setConditionParam(condition, CONDITION_PARAM_MANATICKS, 1)
setConditionParam(condition, CONDITION_PARAM_HEALTHGAIN, 1000)
setConditionParam(condition, CONDITION_PARAM_HEALTHTICKS, 1)
setConditionParam(condition, CONDITION_PARAM_BUFF, true)
setCombatCondition(combat, condition)

function onCastSpell11(cid)
	if isPlayer(cid) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "CD: Exura Gran Mas Regen.")
	end
end

function onCastSpell(cid, var)
if getPlayerStorageValue(cid, 10569) == 1 then
doSendAnimatedText((getCreaturePosition(cid)), "Socorro!", 255)
doSendMagicEffect(getCreaturePosition(cid), 19)
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
return false  
end
if exhaustion.check(cid, 23076) == false then
exhaustion.set(cid, 23076, 20)
addEvent(onCastSpell11, 20000, cid)
return doCombat(cid, combat, var)

else
doSendMagicEffect(getCreaturePosition(cid), 2)
doPlayerSendCancel(cid, "Golpe em cooldown por " ..exhaustion.get(cid, 23076).." segundos")
return false 
end
	return doCombat(cid, combat, var)
end