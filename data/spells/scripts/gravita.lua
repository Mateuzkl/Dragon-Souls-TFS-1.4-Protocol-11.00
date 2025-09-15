
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 60)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)


function onTargetCreature(cid, target)
   
 if isPlayer(cid) == 1 and isPlayer(target) == 1 then
   rand = math.random(1,1)
   if getPlayerMaxMana(target) == getPlayerMaxMana(target) then
   if rand == 1 then
     doSendAnimatedText(getThingPos(cid),"Drain!",160)
     doPlayerAddMana(cid,getPlayerMana(cid)/4*3)
     doSendMagicEffect(getPlayerPosition(cid),59)
    
     doSendAnimatedText(getThingPos(target),"Drain!",160)
     doCreatureAddHealth(target,-getPlayerHealth(target)/4*3)
   end
end  
end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function Cooldown(cid)
if isPlayer(cid) == TRUE then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_WARNING,'CD: Gravita')
end
end

local exhausted_seconds = 15 -- Segundos que o Player Poderá castar a spell novamente
local exhausted_storagevalue = 3459 -- Storage Value do Cool Down

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
local congelado = { lookType = getCreatureOutfit(target).lookType,lookHead = getCreatureOutfit(target).Head, lookBody = getCreatureOutfit(target).lookBody, lookLegs = getCreatureOutfit(target).lookLegs, lookFeet = getCreatureOutfit(target).lookFeet, lookAddons = getCreatureOutfit(target).lookAddons} 
doSetCreatureOutfit(target, congelado, 3000)
setPlayerStorageValue(target, exhausted_storagevalue, os.time() + exhausted_seconds)
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doPlayerSendTextMessage(target,20,'Voce foi drenado.')
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doCombat(cid, combatDist, numberToVariant(target))
else
local monstro = { lookType = getCreatureOutfit(target).lookType,lookHead = getCreatureOutfit(target).Head, lookBody = getCreatureOutfit(target).lookBody, lookLegs = getCreatureOutfit(target).lookLegs, lookFeet = getCreatureOutfit(target).lookFeet, lookAddons = getCreatureOutfit(target).lookAddons} 
doSetCreatureOutfit(target, monstro, 3000)
doTargetCombatCondition(0, target, condition, CONST_ME_NONE)
doCombat(cid, combatDist, numberToVariant(target))
end

	rand = math.random(1,1)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Gravita",16)
      addEvent(Cooldown, 1*15000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Gravita",16)
      addEvent(Cooldown, 1*15000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
else
      addEvent(Cooldown, 1*15000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
end
end