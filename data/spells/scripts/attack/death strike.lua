local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2, -10, -2, -25, 6, 5, 1.4, 2.2)



function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
