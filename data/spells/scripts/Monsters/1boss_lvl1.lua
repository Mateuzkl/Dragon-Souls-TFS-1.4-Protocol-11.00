local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SOUND_PURPLE)
combat:setParameter(COMBAT_PARAM_HITCOLOR, COLOR_PURPLE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -8.2, -440, -15.3, 500)

local arr = {
    {0, 0, 1, 1, 1, 0, 0},
    {0, 1, 1, 1, 1, 1, 0},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 3, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {0, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 0, 0}
}
local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
