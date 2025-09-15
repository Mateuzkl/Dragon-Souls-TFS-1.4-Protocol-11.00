local combatDist = createCombatObject()
setCombatParam(combatDist, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatDist, COMBAT_PARAM_EFFECT, 81)
setCombatParam(combatDist, COMBAT_PARAM_DISTANCEEFFECT, 39)
setCombatFormula(combatDist, COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local drunk = createConditionObject(CONDITION_DRUNK)
setConditionParam(drunk, CONDITION_PARAM_TICKS, 15000)

local combat= createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local function Cooldown(cid)
if isPlayer(cid) == TRUE then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_WARNING,'CD: Exevo Mas Vita')
end
end

local exhausted_seconds = 12 -- Segundos que o Player Poderá castar a spell novamente
local exhausted_storagevalue = 6346 -- Storage Value do Cool Down


function onCastSpell(cid, var)
rand = math.random(2000,4000)
rand2 = math.random(2000,4000)
rand3 = math.random(2000,4000)
rand4 = math.random(2000,4000)


         function frozzen(target)
               doSendMagicEffect(getThingPos(target), 81)   
	doPlayerAddHealth(target,-rand)
	doSendAnimatedText(getThingPos(target),-rand4, TEXTCOLOR_RED)
	end
        function frozzen2(target)
               doSendMagicEffect(getThingPos(target), 82)   
	doPlayerAddHealth(target,-rand)
	doSendAnimatedText(getThingPos(target),-rand2, TEXTCOLOR_RED)
	end
      function frozzen3(target)
               doSendMagicEffect(getThingPos(target), 81)   
	doPlayerAddHealth(target,-rand)
	doSendAnimatedText(getThingPos(target),-rand3, TEXTCOLOR_RED)
	end
      function frozzen4(target)
               doSendMagicEffect(getThingPos(target), 81)   
	doPlayerAddHealth(target,-rand)
	doSendAnimatedText(getThingPos(target),-rand3, TEXTCOLOR_RED)
	end
      function frozzen5(target)
               doSendMagicEffect(getThingPos(target), 81)   
	doPlayerAddHealth(target,-rand)
	doSendAnimatedText(getThingPos(target),-rand4, TEXTCOLOR_RED)
	end
       

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
doPlayerSendTextMessage(target,20,'Voce está em panico.')
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
 	doPlayerSay(cid,"Exevo Mas Vita",16)
      addEvent(Cooldown, 1*12000,cid)
  addEvent(frozzen, 1*1000, target)
         addEvent(frozzen2, 1.5*1000, target)
  addEvent(frozzen3, 2*1000, target)
addEvent(frozzen4, 2.5*1000, target)
addEvent(frozzen5, 3*1000, target)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Exevo Mas Vita!",16)
      addEvent(Cooldown, 1*12000,cid)
  addEvent(frozzen, 1*1000, target)
         addEvent(frozzen2, 1.5*1000, target)
  addEvent(frozzen3, 2*1000, target)
addEvent(frozzen4, 2.5*1000, target)
addEvent(frozzen5, 3*1000, target)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
else
      addEvent(Cooldown, 1*12000,cid)
  addEvent(frozzen, 1*1000, target)
         addEvent(frozzen2, 1.5*1000, target)
         addEvent(frozzen3, 2*1000, target)
addEvent(frozzen4, 2.5*1000, target)
addEvent(frozzen5, 3*1000, target)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
end
end


      