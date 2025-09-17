local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -400, -800, -400, -800)

local condition = Condition(CONDITION_ENERGY)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(5, 3000, -100)
combat:addCondition(condition)

local area = createCombatArea(AREA_CROSS1X1)
combat:setArea(area)

function onCastSpell(cid, var)
	return combat:execute(cid, var)
end
