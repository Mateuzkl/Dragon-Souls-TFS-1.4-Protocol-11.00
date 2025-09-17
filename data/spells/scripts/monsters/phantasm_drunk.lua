local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NONE)
combat:setParameter(COMBAT_PARAM_EFFECT, 13)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, 0, 0, 0)

local arr = {
    {0, 0, 1, 1, 1, 0, 0},
    {0, 1, 1, 1, 1, 1, 0},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 3, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {0, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 0, 0}
}

local area = CombatArea()
area:setMatrix(arr)

combat:setArea(area)

local condition = Condition(CONDITION_DRUNK)
condition:setParameter(CONDITION_PARAM_TICKS, 20000)
combat:setCondition(condition)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
