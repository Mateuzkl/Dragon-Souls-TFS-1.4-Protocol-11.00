local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, 124)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.50, -30, -5.25, 0)

local condition1 = Condition(CONDITION_PARALYZE)
condition1:setParameter(CONDITION_PARAM_TICKS, 6000)
condition1:setFormula(-0.7, -0, -0.7, -0)
combat1:addCondition(condition1)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, 101)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -10.7, 0, -15.9, 0)

local condition2 = Condition(CONDITION_PARALYZE)
condition2:setParameter(CONDITION_PARAM_TICKS, 6000)
condition2:setFormula(-0.7, -0, -0.7, -0)
combat2:addCondition(condition2)


local arr1 = {
    {0, 1, 1, 1, 0},
    {1, 1, 1, 1, 1},
    {1, 1, 2, 1, 1},
    {1, 1, 1, 1, 1},
    {0, 1, 1, 1, 0},
}

local arr2 = {
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
}

local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)
combat1:setArea(area1)
combat2:setArea(area2)

local function spell2(cid)
    local creature = Player(cid)
    return combat2:execute(creature, variant)
end

local function spell1(cid)
    local creature = Player(cid)
    addEvent(spell2, 150, cid)
    return combat1:execute(creature, variant)
end

function onCastSpell(creature, variant)
    local function onCastSpell1(parameters)
        local player = Player(parameters.cid)
        return combat1:execute(player, parameters.var)
    end

    local function onCastSpell2(parameters)
        local player = Player(parameters.cid)
        combat2:execute(player, parameters.var)
    end

    local cid = creature:getId()
    addEvent(onCastSpell1, 100, { cid = cid, var = variant })
    addEvent(onCastSpell2, 250, { cid = cid, var = variant })

    return true
end
