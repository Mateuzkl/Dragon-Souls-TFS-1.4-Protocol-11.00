local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 57)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)
setCombatParam(combat1, COMBAT_PARAM_CREATEITEM, 5396)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 57)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local arr1 = {
{0, 0, 0, 0, 0, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 2, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 0, 0, 0, 0, 0},
}
local arr2 = {
{0, 0, 0, 0, 0, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 2, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 0, 0, 0, 0, 0},
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
doPlayerSendTextMessage(cid,MESSAGE_STATUS_WARNING,'CD: Exori Gran Tera')
end
end

local exhausted_seconds = 20 -- Segundos que o Player Poderá castar a spell novamente
local exhausted_storagevalue = 4234 -- Storage Value do Cool Down

function onCastSpell(cid, var)
if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue)) then
doPlayerSendCancel(cid,'O Cooldown não está pronto.')
return TRUE
end
	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Does not move!",16)
      addEvent(Cooldown, 1*20000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat1, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Where do you think you're going?",16)
      addEvent(Cooldown, 1*20000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat1, var)
else
      addEvent(Cooldown, 1*20000,cid)
         setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
	return doCombat(cid, combat1, var)
end
end

