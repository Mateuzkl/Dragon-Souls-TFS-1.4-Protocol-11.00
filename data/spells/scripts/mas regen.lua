local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat1, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat1, COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, 0.6, -30, 1.2, 0)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat2, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat2, COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, 0.6, -30, 1.2, 0)

local condition = createConditionObject(CONDITION_REGENERATION)
setConditionParam(condition, CONDITION_PARAM_TICKS, 60000)
setConditionParam(condition, CONDITION_PARAM_MANAGAIN, 1000)
setConditionParam(condition, CONDITION_PARAM_MANATICKS, 1)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
setConditionParam(condition, CONDITION_PARAM_HEALTHGAIN, 1000)
setCombatCondition(combat1, condition)

local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 120, 60000, 1000)
setCombatCondition(combat2, condition)





local arr1 = {
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 3, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 0, 0}
}

local arr2 = {
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 3, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 0, 0}
}

local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)
setCombatArea(combat1, area1)
setCombatArea(combat2, area2)

local function onCastSpell1(parameters)
doCombat(parameters.cid, parameters.combat1, parameters.var)
end

local function onCastSpell2(parameters)
doCombat(parameters.cid, parameters.combat2, parameters.var)
end

function onTargetCreature(cid, target)
local function sun1(cid)
doPlayerSay(cid,"...",16)
return TRUE
end

local rand = math.random(1,5)
if isPlayer(target) == true and rand == 5 then
doSendAnimatedText(getCreaturePosition(target), "Regen!", TEXTCOLOR_TEAL)
return TRUE
elseif isPlayer(target) == true and rand == 4 then
doSendAnimatedText(getCreaturePosition(target), "Regen!", TEXTCOLOR_TEAL)
doSendMagicEffect(getCreaturePosition(target), 24)
return TRUE
elseif isPlayer(target) == true and rand < 4 then
doSendAnimatedText(getCreaturePosition(target), "Regen!", TEXTCOLOR_TEAL)
return TRUE
else
doSendAnimatedText(getCreaturePosition(target), "Regen!", TEXTCOLOR_TEAL)
return TRUE
end
end

setCombatCallback(combat1, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(cid, var)
local parameters = { cid = cid, var = var, combat1 = combat1, combat2 = combat2}
addEvent(onCastSpell1, 1, parameters)
addEvent(onCastSpell2, 1, parameters)
end
