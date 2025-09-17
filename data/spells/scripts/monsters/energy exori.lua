local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function getFormulaValues(cid, level, maglevel)
    local min = -(level * 22) / 10
    local max = -(level * 38.5) / 10
    return min, max
end

combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -22, -38.5, 1, -1)

local arr = {
    {0, 0, 0, 0, 0},
    {0, 1, 1, 1, 0},
    {0, 1, 2, 1, 0},
    {0, 1, 1, 1, 0},
    {0, 0, 0, 0, 0}
}

local area = CombatArea()
area:setMatrix(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
