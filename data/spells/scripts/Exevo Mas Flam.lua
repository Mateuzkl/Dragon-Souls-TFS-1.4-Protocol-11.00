local combatDist = createCombatObject()
setCombatParam(combatDist, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatDist, COMBAT_PARAM_EFFECT, 70)
setCombatParam(combatDist, COMBAT_PARAM_DISTANCEEFFECT, 52)
setCombatFormula(combatDist, COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local area = createCombatArea( { {1, 1, 1}, {1, 3, 1}, {1, 1, 1} } )
setCombatArea(combatDist, area)

local condition = createConditionObject(CONDITION_FIRE)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 5, 1000, -6000)
setCombatCondition(combatDist, condition)

local combat= createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local function Cooldown(cid)
if isPlayer(cid) == TRUE then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_WARNING,'CD: Exevo Mas Flam')
end
end

local exhausted_seconds = 15 -- Segundos que o Player Poderá castar a spell novamente
local exhausted_storagevalue = 9369 -- Storage Value do Cool Down


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
doSetCreatureOutfit(target, congelado, 1)
setPlayerStorageValue(target, exhausted_storagevalue, os.time() + exhausted_seconds)
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doPlayerSendTextMessage(target,20,'Voce está em chamas.')
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doCombat(cid, combatDist, numberToVariant(target))
else
local monstro = { lookType = getCreatureOutfit(target).lookType,lookHead = 9, lookBody = 9, lookLegs = 9, lookFeet = 9, lookAddons = getCreatureOutfit(target).lookAddons} 
doSetCreatureOutfit(target, monstro, 1)
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doCombat(cid, combatDist, numberToVariant(target))
end


	rand = math.random(1,2)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Exevo Mas Flam",16)
      addEvent(Cooldown, 1*15000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Exevo Mas Flam",16)
      addEvent(Cooldown, 1*15000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
else
      addEvent(Cooldown, 1*15000,cid)
      addEvent(cid, combatDist, var)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
end
end