local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 61)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

local condition = createConditionObject(CONDITION_HASTE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 30000)
setConditionFormula(condition, 0.9, -81, 0.9, -81)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
if getPlayerStorageValue(cid, 10569) == 1 then
doSendAnimatedText((getCreaturePosition(cid)), "Socorro!", 255)
doSendMagicEffect(getCreaturePosition(cid), 19)
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
return false 
end
	return doCombat(cid, combat, var)
end
