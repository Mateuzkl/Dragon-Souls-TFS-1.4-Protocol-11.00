local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BURSTARROW)

function onGetFormulaValues(player, level, maglevel)
    local min = -150
    local max = -150
    return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local area = createCombatArea({
    {0, 1, 0},
    {1, 1, 1},
    {0, 1, 0}
})
combat:setArea(area)

function onUseWeapon(player, variant)
    return combat:execute(player, variant)
end
