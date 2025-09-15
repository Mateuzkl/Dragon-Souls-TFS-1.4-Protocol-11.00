local combatDist = createCombatObject()
setCombatParam(combatDist, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatDist, COMBAT_PARAM_EFFECT, 56)
setCombatParam(combatDist, COMBAT_PARAM_DISTANCEEFFECT, 44)
setCombatFormula(combatDist, COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local combat= createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)


local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 3000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -220)
setConditionFormula(condition, -0.7, 0, -0.7, 0)
setCombatCondition(combatDist, condition)

local function Cooldown(cid)
if isPlayer(cid) == TRUE then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_WARNING,'CD: Adori Frigo')
end
end

local exhausted_seconds = 7 -- Segundos que o Player Poderá castar a spell novamente
local exhausted_storagevalue = 9636 -- Storage Value do Cool Down

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
doPlayerSendTextMessage(target,20,'Voce está congelado.')
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doCombat(cid, combatDist, numberToVariant(target))
else
local monstro = { lookType = getCreatureOutfit(target).lookType,lookHead = 9, lookBody = 9, lookLegs = 9, lookFeet = 9, lookAddons = getCreatureOutfit(target).lookAddons} 
doSetCreatureOutfit(target, monstro, 3000)
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doCombat(cid, combatDist, numberToVariant(target))
end

	rand = math.random(1,1)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Adori Frigo!",16)
      addEvent(Cooldown, 1*7000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Adori Frigo!",16)
      addEvent(Cooldown, 1*7000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
else
      addEvent(Cooldown, 1*7000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
end
end