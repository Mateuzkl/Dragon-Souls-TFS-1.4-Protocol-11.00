local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 60)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -4.7, 0, -5.9, 0)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 6000)
setConditionFormula(condition, -0.7, -0, -0.7, -0)

setCombatCondition(combat1, condition)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 6000)
setConditionFormula(condition, -0.7, -0, -0.7, -0)

setCombatCondition(combat2, condition)


arr1 = {
{0, 1, 1, 1, 0},
{1, 1, 1, 1, 1},
{1, 1, 2, 1, 1},
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0},
}



arr2 = {
{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
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

local function Cooldown(cid)
if isPlayer(cid) == TRUE then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_WARNING,'CD: Exevo Gran Mas Dark.')
end
end

local exhausted_seconds = 35 -- Segundos que o Player Poderá castar a spell novamente
local exhausted_storagevalue = 6345 -- Storage Value do Cool Down

function onTargetCreature(cid, target)
local function sun1(cid)
doPlayerSay(cid,"...",16)
return TRUE
end

local rand = math.random(1,5)
if isPlayer(target) == true and rand == 5 then
doSendAnimatedText(getCreaturePosition(target), "Weakness!", TEXTCOLOR_WHITE_EXP)
return TRUE
elseif isPlayer(target) == true and rand == 4 then
doSendAnimatedText(getCreaturePosition(target), "Weakness!", TEXTCOLOR_WHITE_EXP)
return TRUE
elseif isPlayer(target) == true and rand < 4 then
doSendAnimatedText(getCreaturePosition(target), "Weakness!", TEXTCOLOR_WHITE_EXP)
doSendMagicEffect(getCreaturePosition(target), 60)
return TRUE
else
doSendAnimatedText(getCreaturePosition(target), "Weakness!", TEXTCOLOR_WHITE_EXP)
return TRUE
end
end

setCombatCallback(combat1, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(cid, var)
if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue)) then
doPlayerSendCancel(cid,'O Cooldown não está pronto.')
return TRUE
end
         
       local function spell1(cid)
               addEvent(spell2, 1 * 150, cid)
               return doCombat(cid, combat2, var)
         end
         addEvent(spell1, 1 * 100, cid)
 addEvent(Cooldown, 1*35000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
return doCombat(cid, combat1, var)
end
