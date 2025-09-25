local combat = Combat()
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SPEAR)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 0, 0)

function onUseWeapon(cid, var)
	return combat:execute(cid, var)
end
