local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_LARGEROCK)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.4, 0, -5.6, 0)

function onCastSpell(cid, var)
    -- Remova a verificação de exaustão e a mensagem associada
    return combat:execute(cid, var) -- Use a função combat:execute para executar o combate
end
