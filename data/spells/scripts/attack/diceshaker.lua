local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -1.5, -155, -1.8, 80)

local area = createCombatArea({
    {1, 1, 1},
    {1, 2, 1},
    {1, 1, 1}
})
combat:setArea(area)

function onCastSpell(cid, var)
    -- Remova a verificação de exaustão e a mensagem associada
    return combat:execute(cid, var)
end
