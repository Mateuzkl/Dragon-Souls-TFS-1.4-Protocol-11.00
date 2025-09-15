local combatDist = createCombatObject()
setCombatParam(combatDist, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatDist, COMBAT_PARAM_EFFECT, 56)
setCombatParam(combatDist, COMBAT_PARAM_DISTANCEEFFECT, 44)
setCombatFormula(combatDist, COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 3000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -220)
setConditionFormula(condition, -0.9, 0, -0.9, 0)
setCombatCondition(combatDist, condition)

local exhausted_seconds = 1
local exhausted_storagevalue = 8163

function onCastSpell(cid, var)
local target = getCreatureTarget(cid)

if(target == 0) then
doPlayerSendCancel(cid,'Select your target.')
doSendMagicEffect(getCreaturePosition(cid), 2)
return TRUE
end

if(target ~= 0 and isPlayer(target) == 1) then
local congelado = { lookType = getCreatureOutfit(target).lookType,lookHead = 9, lookBody = 9, lookLegs = 9, lookFeet = 9, lookAddons = getCreatureOutfit(target).lookAddons} 
doSetCreatureOutfit(target, congelado, 3000)
setPlayerStorageValue(target, exhausted_storagevalue, os.time() + exhausted_seconds)
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doSendAnimatedText(getThingPos(target), "Frozzen!", TEXTCOLOR_WHITE_EXP)
doPlayerSendTextMessage(target,20,'Voce está congelado.')
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doCombat(cid, combatDist, numberToVariant(target))
else
local monstro = { lookType = getCreatureOutfit(target).lookType,lookHead = 9, lookBody = 9, lookLegs = 9, lookFeet = 9, lookAddons = getCreatureOutfit(target).lookAddons} 
doSendAnimatedText(getThingPos(target), "Frozzen!", TEXTCOLOR_WHITE_EXP)
doSetCreatureOutfit(target, monstro, 3000)
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doCombat(cid, combatDist, numberToVariant(target))
end
end