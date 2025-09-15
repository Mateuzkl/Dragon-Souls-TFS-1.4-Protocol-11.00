
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 3000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -300)
setCombatCondition(combat, condition)

local exhaust = createConditionObject(CONDITION_EXHAUSTED)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, 3000)

local arr = {
{0, 1, 1, 1, 0},
{1, 1, 1, 1, 1},
{1, 1, 3, 1, 1},
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)


function onTargetCreature(cid, target)

  
 if isPlayer(target) == 1 then
   rand = math.random(1,5)
   if rand == 1 then
     doSendAnimatedText(getThingPos(cid),"Silence!",215)
   doTargetCombatCondition(0, cid, exhaust, CONST_ME_NONE)
  setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
 setPlayerStorageValue(cid, exhausted_storagevalue1, os.time() + exhausted_seconds1)
   else
     doSendAnimatedText(getThingPos(target),"Silence!",215)
   doTargetCombatCondition(0, target, exhaust, CONST_ME_NONE)
  setPlayerStorageValue(target, exhausted_storagevalue, os.time() + exhausted_seconds)
 setPlayerStorageValue(target, exhausted_storagevalue1, os.time() + exhausted_seconds1)
   end
   end
 end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function Cooldown(cid)
if isPlayer(cid) == TRUE then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_WARNING,'CD: Exevo Gran Mas Time')
end
end

local exhausted_seconds = 15 -- Segundos que o Player Poderá castar a spell novamente
local exhausted_storagevalue = 9432 -- Storage Value do Cool Down

function onCastSpell(cid, var)
if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue)) then
doPlayerSendCancel(cid,'O Cooldown não está pronto.')
return TRUE
end
rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Stop Time!",16)
      addEvent(Cooldown, 1*15000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Stop Bitch!",16)
      addEvent(Cooldown, 1*15000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
else
      addEvent(Cooldown, 1*15000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
end
end