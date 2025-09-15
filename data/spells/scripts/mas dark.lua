------------------Script por Daniel Oliveira------------------
local acombat = createCombatObject()

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 39)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 6000)
setConditionFormula(condition, -0.7, -0, -0.7, -0)

setCombatCondition(acombat, condition)

arr = {
{0, 0, 0, 1, 0, 0, 0},
{0, 0, 0, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{1, 1, 1, 2, 1, 1, 1},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 0, 0, 0},
{0, 0, 0, 1, 0, 0, 0},
}
local area = createCombatArea(arr)
setCombatArea(acombat, area)

function onTargetTile(cid, pos)
doCombat(cid,combat,positionToVariant(pos))
end

setCombatCallback(acombat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")


function onCastSpell(cid, var)
	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Come on! I got more for you!",16)
	return doCombat(cid, acombat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Feel the power of darkness!",16)
	return doCombat(cid, acombat, var)
	elseif rand == 3 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"You can't run of your death!",16)
	return doCombat(cid, acombat, var)
	elseif rand == 4 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"FLAME OF HELL!!!",16)
	return doCombat(cid, acombat, var)
else
	return doCombat(cid, acombat, var)
end
end
