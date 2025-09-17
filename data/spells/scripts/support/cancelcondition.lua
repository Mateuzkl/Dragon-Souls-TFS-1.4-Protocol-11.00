local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat1, COMBAT_PARAM_DISPEL, CONDITION_POISON)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat2, COMBAT_PARAM_DISPEL, CONDITION_FIRE)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat3, COMBAT_PARAM_DISPEL, CONDITION_ENERGY)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat4, COMBAT_PARAM_DISPEL, CONDITION_LIFEDRAIN)

local combat5 = createCombatObject()
setCombatParam(combat5, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat5, COMBAT_PARAM_DISPEL, CONDITION_HASTE)

local combat6 = createCombatObject()
setCombatParam(combat6, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat6, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local combat7 = createCombatObject()
setCombatParam(combat7, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat7, COMBAT_PARAM_DISPEL, CONDITION_OUTFIT)

local combat8 = createCombatObject()
setCombatParam(combat8, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat8, COMBAT_PARAM_DISPEL, CONDITION_INVISIBLE)

local combat9 = createCombatObject()
setCombatParam(combat9, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat9, COMBAT_PARAM_DISPEL, CONDITION_LIGHT)

local combat10 = createCombatObject()
setCombatParam(combat10, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat10, COMBAT_PARAM_DISPEL, CONDITION_MANASHIELD)

local combat11 = createCombatObject()
setCombatParam(combat12, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat12, COMBAT_PARAM_DISPEL, CONDITION_DRUNK)

local combat12 = createCombatObject()
setCombatParam(combat13, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat13, COMBAT_PARAM_DISPEL, CONDITION_EXHAUSTED)

local combat13 = createCombatObject()
setCombatParam(combat14, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat14, COMBAT_PARAM_DISPEL, CONDITION_FOOD)

local combat14 = createCombatObject()
setCombatParam(combat15, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat15, COMBAT_PARAM_DISPEL, CONDITION_REGENERATION)

local combat15 = createCombatObject()
setCombatParam(combat16, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat16, COMBAT_PARAM_DISPEL, CONDITION_SOUL)

local combat16 = createCombatObject()
setCombatParam(combat17, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat17, COMBAT_PARAM_DISPEL, CONDITION_DROWN)

local combat17 = createCombatObject()
setCombatParam(combat18, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat18, COMBAT_PARAM_DISPEL, CONDITION_MUTED)

local combat18 = createCombatObject()
setCombatParam(combat19, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat19, COMBAT_PARAM_DISPEL, CONDITION_EMO)
 
local function onCastSpell1(parameters)
    doCombat(parameters.cid, combat1, parameters.var)
end
 
local function onCastSpell2(parameters)
    doCombat(parameters.cid, combat2, parameters.var)
end
 
local function onCastSpell3(parameters)
    doCombat(parameters.cid, combat3, parameters.var)
end
 
local function onCastSpell4(parameters)
    doCombat(parameters.cid, combat4, parameters.var)
end
 
local function onCastSpell5(parameters)
    doCombat(parameters.cid, combat5, parameters.var)
end
 
local function onCastSpell6(parameters)
    doCombat(parameters.cid, combat6, parameters.var)
end
 
local function onCastSpell7(parameters)
    doCombat(parameters.cid, combat7, parameters.var)
end
 
local function onCastSpell8(parameters)
    doCombat(parameters.cid, combat8, parameters.var)
end
 
local function onCastSpell9(parameters)
    doCombat(parameters.cid, combat9, parameters.var)
end
 
local function onCastSpell10(parameters)
    doCombat(parameters.cid, combat10, parameters.var)
end
 
local function onCastSpell11(parameters)
    doCombat(parameters.cid, combat11, parameters.var)
end
 
local function onCastSpell12(parameters)
    doCombat(parameters.cid, combat12, parameters.var)
end
 
local function onCastSpell13(parameters)
    doCombat(parameters.cid, combat13, parameters.var)
end

local function onCastSpell14(parameters)
    doCombat(parameters.cid, combat14, parameters.var)
end

local function onCastSpell15(parameters)
    doCombat(parameters.cid, combat15, parameters.var)
end

local function onCastSpell16(parameters)
    doCombat(parameters.cid, combat16, parameters.var)
end

local function onCastSpell17(parameters)
    doCombat(parameters.cid, combat17, parameters.var)
end

local function onCastSpell18(parameters)
    doCombat(parameters.cid, combat18, parameters.var)
end

local function onCastSpell19(parameters)
    doCombat(parameters.cid, combat19, parameters.var)
end
 
function onCastSpell(cid, var)
if getPlayerStorageValue(cid, 10569) == 1 then
doSendAnimatedText((getCreaturePosition(cid)), "Socorro!", 255)
doSendMagicEffect(getCreaturePosition(cid), 19)
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
return false 
end

doSendAnimatedText(getThingPos(var.number), "Dispel!", TEXTCOLOR_WHITE)
local parameters = { cid = cid, var = var}
addEvent(onCastSpell1, 1, parameters)
addEvent(onCastSpell2, 2, parameters)
addEvent(onCastSpell3, 3, parameters)
addEvent(onCastSpell4, 4, parameters)
addEvent(onCastSpell5, 5, parameters)
addEvent(onCastSpell6, 6, parameters)
addEvent(onCastSpell7, 7, parameters)
addEvent(onCastSpell8, 8, parameters)
addEvent(onCastSpell9, 9, parameters)
addEvent(onCastSpell10, 10, parameters)
addEvent(onCastSpell11, 11, parameters)
addEvent(onCastSpell12, 12, parameters)
addEvent(onCastSpell13, 13, parameters)
addEvent(onCastSpell14, 14, parameters)
addEvent(onCastSpell15, 15, parameters)
addEvent(onCastSpell16, 16, parameters)
addEvent(onCastSpell17, 17, parameters)
addEvent(onCastSpell18, 18, parameters)
addEvent(onCastSpell19, 19, parameters)
return doCombat(cid, combat, var)
end