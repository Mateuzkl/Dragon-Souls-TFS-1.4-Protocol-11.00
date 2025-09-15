
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 34)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)

local exhaust = createConditionObject(CONDITION_EXHAUSTED)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, 5000)


function onTargetCreature(cid, target)

-- Exhausted Settings --
local exhausted_seconds3 = 5 -- How many seconds mana fluid will be unavailible to use. --
local exhausted_storagevalue3 = 8162 -- Storage Value to store exhaust. It MUST be unused! --
-- Exhausted Settings END --
   
 if isPlayer(cid) ~= 1 and isPlayer(target) == 1 then
     	doSendAnimatedText(getThingPos(target),"Silence!",215)
 	doPlayerSay(target,"...",16)
     setPlayerStorageValue(target, exhausted_storagevalue3, os.time() + exhausted_seconds3)
   	doTargetCombatCondition(0, target, exhaust, CONST_ME_NONE)
 end

 end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end