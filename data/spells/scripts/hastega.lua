
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 3000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -300)
setCombatCondition(combat, condition)

local exhaust = createConditionObject(CONDITION_FROZZEN)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, 10000)

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
   
     doSendAnimatedText(getThingPos(target),"Frost!",215)
   doTargetCombatCondition(0, target, exhaust, CONST_ME_NONE)
   end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end