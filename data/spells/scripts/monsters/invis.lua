local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local condition = Condition(CONDITION_INVISIBLE)
condition:setParameter(CONDITION_PARAM_TICKS, 5000)
combat:addCondition(condition)

--local area = CombatArea( { {1, 1, 1}, {1, 3, 1}, {1, 1, 1} } )
--combat:setArea(area)

function onCastSpell(cid, var)
	return combat:execute(cid, var)
end
