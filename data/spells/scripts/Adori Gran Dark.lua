local combatDist = createCombatObject()
setCombatParam(combatDist, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatDist, COMBAT_PARAM_EFFECT, 75)
setCombatParam(combatDist, COMBAT_PARAM_DISTANCEEFFECT, 39)
setCombatFormula(combatDist, COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local condition = createConditionObject(CONDITION_EMO)
addDamageCondition(condition, 1, 1000, -5)
addDamageCondition(condition, 1, 1000, -5)
addDamageCondition(condition, 1, 1000, -4)
addDamageCondition(condition, 1, 1000, -3)
addDamageCondition(condition, 1, 1000, -2)
addDamageCondition(condition, 1, 1000, -1)
addDamageCondition(condition, 1, 1000, -25000)
setCombatCondition(combatDist, condition)

local function Cooldown(cid)
if isPlayer(cid) == TRUE then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_WARNING,'CD: Adori Gran Dark')
end
end

local combat= createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local exhausted_seconds = 45 -- Segundos que o Player Poderá castar a spell novamente
local exhausted_storagevalue = 9389 -- Storage Value do Cool Down

function onCastSpell(cid, var)
if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue)) then
doPlayerSendCancel(cid,'O Cooldown não está pronto.')
return TRUE
end

if(target == 1) then
doPlayerSendCancel(cid,'Select your target.')
doSendMagicEffect(getCreaturePosition(cid), 2)
return TRUE
end
local target = getCreatureTarget(cid)

if(target ~= 0 and isPlayer(target) == 1) then
local congelado = { lookType = getCreatureOutfit(target).lookType,lookHead = 9, lookBody = 9, lookLegs = 9, lookFeet = 9, lookAddons = getCreatureOutfit(target).lookAddons} 
doSetCreatureOutfit(target, congelado, 3000)
setPlayerStorageValue(target, exhausted_storagevalue, os.time() + exhausted_seconds)
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doPlayerSendTextMessage(target,20,'Voce está condenado.')
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doCombat(cid, combatDist, numberToVariant(target))
else
local monstro = { lookType = getCreatureOutfit(target).lookType,lookHead = getCreatureOutfit(target).lookHead, lookBody = getCreatureOutfit(target).lookBody, lookLegs = getCreatureOutfit(target).lookLegs, lookFeet = getCreatureOutfit(target).lookFeet, lookAddons = getCreatureOutfit(target).lookAddons} 
doSetCreatureOutfit(target, monstro, 3000)
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doCombat(cid, combatDist, numberToVariant(target))
end

	rand = math.random(1,2)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Adori Gran Dark",16)
      addEvent(Cooldown, 1*45000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Adori Gran Dark",16)
      addEvent(Cooldown, 1*45000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
else
      addEvent(Cooldown, 1*45000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
end
end