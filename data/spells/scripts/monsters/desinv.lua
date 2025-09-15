local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_DISPEL, CONDITION_INVISIBLE)

local arr = {
	{0, 0, 0},
	{0, 1, 0},
	{0, 0, 0}
}

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end