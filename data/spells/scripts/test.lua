local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 59)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)


local Immortal = createConditionObject(CONDITION_IMMORTAL)
setConditionParam(Immortal, CONDITION_PARAM_TICKS, 6000)

local function Cooldown(cid)
if isPlayer(cid) == TRUE then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_WARNING,'Cooldown Pronto.')
end
end

local exhausted_seconds = 16 -- Segundos que o Player Poderá castar a spell novamente
local exhausted_storagevalue = 9666 -- Storage Value do Cool Down

function onCastSpell(cid, var)
if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue)) then
doPlayerSendCancel(cid,'O Cooldown não está pronto.')
return TRUE
end
	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"HA! I'am GOD!",16)
      addEvent(Cooldown, 1*16000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Blessing I'like!",16)
      addEvent(Cooldown, 1*16000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
else
      addEvent(Cooldown, 1*16000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat, var)
end
end
