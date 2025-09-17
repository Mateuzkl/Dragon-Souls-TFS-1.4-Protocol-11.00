local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.5, -30, -1.0, 0)

function onCastSpell(cid, var)
	combat:execute(cid, var)
end
