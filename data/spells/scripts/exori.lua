local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onGetFormulaValues(player, level, maglevel)
    local min = -(level * 22) / 10
    local max = -(level * 38.5) / 10
    return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local area = createCombatArea({
    {0, 0, 0, 0, 0},
    {0, 1, 1, 1, 0},
    {0, 1, 2, 1, 0},
    {0, 1, 1, 1, 0},
    {0, 0, 0, 0, 0}
})

combat:setArea(area)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
