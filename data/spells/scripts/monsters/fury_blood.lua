local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 0)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 20000)
condition:setParameter(CONDITION_PARAM_SPEED, -400)
condition:setFormula(-1, -1, -1, -1) -- Not necessary to set a formula for paralysis

combat:addCondition(condition)

local arr = {
    {0, 1, 0},
    {0, 1, 0},
    {0, 1, 0},
    {0, 1, 0},
    {0, 3, 0},
}

local arrDiag = {
    {1, 0, 0, 0, 0},
    {0, 1, 0, 0, 0},
    {0, 0, 1, 0, 0},
    {0, 0, 0, 1, 0},
    {0, 0, 0, 0, 3},
}

local area = createCombatArea(arr, arrDiag)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
