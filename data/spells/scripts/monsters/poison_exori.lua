local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)

local area = createCombatArea({{1, 1, 1}, {1, 2, 1}, {1, 1, 1}})
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
