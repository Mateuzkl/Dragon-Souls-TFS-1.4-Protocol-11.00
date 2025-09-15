local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_DISPEL, CONDITION_POISON)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat2, COMBAT_PARAM_DISPEL, CONDITION_FIRE)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat3, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat4, COMBAT_PARAM_DISPEL, CONDITION_EMO)

local combat5 = createCombatObject()
setCombatParam(combat5, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat5, COMBAT_PARAM_DISPEL, CONDITION_ENERGY)

local combat6 = createCombatObject()
setCombatParam(combat6, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat6, COMBAT_PARAM_DISPEL, CONDITION_REGEN)

local combat8 = createCombatObject()
setCombatParam(combat8, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat8, COMBAT_PARAM_DISPEL, CONDITION_INVISIBLE)

local combat9 = createCombatObject()
setCombatParam(combat9, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat9, COMBAT_PARAM_DISPEL, CONDITION_LIGHT)

local combat10 = createCombatObject()
setCombatParam(combat10, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat10, COMBAT_PARAM_DISPEL, CONDITION_FROZZEN)

local combat11 = createCombatObject()
setCombatParam(combat11, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat11, COMBAT_PARAM_DISPEL, CONDITION_DROWN)

local combat12 = createCombatObject()
setCombatParam(combat12, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat12, COMBAT_PARAM_DISPEL, CONDITION_DRUNK)


function onTargetCreature(cid, target)
   
 if isPlayer(target) == 1 then

if getPlayerSlotItem(target, 9).itemid == 2204 or getPlayerSlotItem(target, 10).itemid == 13502 then
     doSendAnimatedText(getThingPos(target),"Dispel!",215)
   else
	doCombat(target, combat10, numberToVariant(target))
	doCombat(target, combat6, numberToVariant(target))
     doSendAnimatedText(getThingPos(target),"Dispel!",215)
   end

   end
 end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")


function onCastSpell(cid, var)
	doCombat(cid, combat2, var)
	doCombat(cid, combat3, var)
	doCombat(cid, combat4, var)
	doCombat(cid, combat5, var)
	doCombat(cid, combat8, var)
	doCombat(cid, combat9, var)
	doCombat(cid, combat11, var)
	doCombat(cid, combat12, var)
	return doCombat(cid, combat, var)
end