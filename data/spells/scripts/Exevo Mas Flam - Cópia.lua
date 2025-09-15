local combatDist = createCombatObject()
setCombatParam(combatDist, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatDist, COMBAT_PARAM_EFFECT, 70)
setCombatParam(combatDist, COMBAT_PARAM_DISTANCEEFFECT, 52)
setCombatFormula(combatDist, COMBAT_FORMULA_LEVELMAGIC, -17.7, 0, -21.9, 0)

local condition = createConditionObject(CONDITION_FIRE)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 5, 1000, -4000)
setCombatCondition(combatDist, condition)

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

if(target == 0) then
doPlayerSendCancel(cid,'Select your target.')
doSendMagicEffect(getCreaturePosition(cid), 2)
return TRUE
end
local target = getCreatureTarget(cid)

if(target ~= 0 and isPlayer(target) == 1) then
setPlayerStorageValue(target, exhausted_storagevalue, os.time() + exhausted_seconds)
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doSendAnimatedText(getThingPos(target), "Bomb!", TEXTCOLOR_WHITE_EXP)
doPlayerSendTextMessage(target,20,'Voce está agoniado.')
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doCombat(cid, combatDist, numberToVariant(target))
else
doSendAnimatedText(getThingPos(target), "Bomb!", TEXTCOLOR_WHITE_EXP)
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
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
end
end