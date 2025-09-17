local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onGetFormulaValues(cid, level, maglevel)
    local min = -(level * 44) / 10
    local max = -(level * 76.10) / 10
    return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 500)
condition:setParameter(CONDITION_PARAM_SPEED, -1000)
combat:setCondition(condition)

local arr = {
    {0, 0, 1, 0, 0},
    {0, 1, 1, 1, 0},
    {1, 1, 3, 1, 1},
    {0, 1, 1, 1, 0},
    {0, 0, 1, 0, 0},
}

local area = CombatArea()
area:setMatrix(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
