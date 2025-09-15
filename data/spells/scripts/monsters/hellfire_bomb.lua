local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_CREATEITEM, 1487)

arr = {
{1, 1, 1},
{1, 3, 1},
{1, 1, 1},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end
