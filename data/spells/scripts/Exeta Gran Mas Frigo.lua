local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 56)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -2.50, -40, -3.25, 0)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 6000)
setConditionFormula(condition, -0.7, -0, -0.7, -0)

setCombatCondition(combat1, condition)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 56)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -2.50, -40, -3.25, 0)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 6000)
setConditionFormula(condition, -0.7, -0, -0.7, -0)

setCombatCondition(combat2, condition)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 56)
setCombatFormula(combat3, COMBAT_FORMULA_LEVELMAGIC, -2.50, -40, -3.25, 0)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 6000)
setConditionFormula(condition, -0.7, -0, -0.7, -0)

setCombatCondition(combat3, condition)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat4, COMBAT_PARAM_EFFECT, 56)
setCombatFormula(combat4, COMBAT_FORMULA_LEVELMAGIC, -3.50, -50, -3.25, 0)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 6000)
setConditionFormula(condition, -0.7, -0, -0.7, -0)
setCombatCondition(combat4, condition)


arr1 = {
{0, 1, 1, 1, 0},
{1, 1, 1, 1, 1},
{1, 1, 2, 1, 1},
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0},
}



arr2 = {
{0, 1, 1, 1, 0},
{1, 1, 1, 1, 1},
{1, 1, 2, 1, 1},
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0},
}

arr3 = {
{0, 1, 1, 1, 0},
{1, 1, 1, 1, 1},
{1, 1, 2, 1, 1},
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0},
}

arr4 = {
{0, 1, 1, 1, 0},
{1, 1, 1, 1, 1},
{1, 1, 2, 1, 1},
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0},
}

local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)
local area3 = createCombatArea(arr3)
local area4 = createCombatArea(arr4)
setCombatArea(combat1, area1)
setCombatArea(combat2, area2)
setCombatArea(combat3, area3)
setCombatArea(combat4, area4)

local function onCastSpell1(parameters)
doCombat(parameters.cid, parameters.combat1, parameters.var)
end

local function onCastSpell2(parameters)
doCombat(parameters.cid, parameters.combat2, parameters.var)
end

local function onCastSpell3(parameters)
doCombat(parameters.cid, parameters.combat3, parameters.var)
end

local function onCastSpell4(parameters)
doCombat(parameters.cid, parameters.combat4, parameters.var)
end



local function Cooldown(cid)
if isPlayer(cid) == TRUE then
doPlayerSendTextMessage(cid,MESSAGE_STATUS_WARNING,'CD: Exeta Gran Mas Frigo.')
end
end

local exhausted_seconds = 30 -- Segundos que o Player Poderá castar a spell novamente
local exhausted_storagevalue = 6445 -- Storage Value do Cool Down

function onCastSpell(cid, var)
if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue)) then
doPlayerSendCancel(cid,'O Cooldown não está pronto.')
return TRUE
end
         
                        local function spell4(cid)
               return doCombat(cid, combat4, var)
         end
         local function spell3(cid)
               addEvent(spell4, 1 * 350, cid)
               return doCombat(cid, combat2, var)
         end
local function spell3(cid)
               return doCombat(cid, combat3, var)
         end
         local function spell2(cid)
               addEvent(spell3, 1 * 350, cid)
               return doCombat(cid, combat2, var)
         end
         local function spell1(cid)
               addEvent(spell2, 1 * 350, cid)
               return doCombat(cid, combat1, var)
         end
         addEvent(spell1, 1 * 700, cid)
 addEvent(Cooldown, 1*30000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
return doCombat(cid, combat1, var)
end

