local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.4, -30, -0.9, 0)

local arr = {
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0},
{0, 1, 1, 1, 0},
{0, 0, 3, 0, 0},
}

local area = createCombatArea(arr)

setCombatArea(combat, area)

function onCastSpell(cid, var)
	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Flame on!",16)
	return doCombat(cid, combat, var)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Burn on the fire of hell!",16)
	return doCombat(cid, combat, var)
else
	return doCombat(cid, combat, var)
end
end
