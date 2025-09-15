local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, 56)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.50, -40, -3.25, 0)

local condition1 = Condition(CONDITION_PARALYZE)
condition1:setParameter(CONDITION_PARAM_TICKS, 6000)
condition1:setFormula(-0.7, 0, -0.7, 0)
combat1:addCondition(condition1)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, 56)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.50, -40, -3.25, 0)

local condition2 = Condition(CONDITION_PARALYZE)
condition2:setParameter(CONDITION_PARAM_TICKS, 6000)
condition2:setFormula(-0.7, 0, -0.7, 0)
combat2:addCondition(condition2)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, 56)
combat3:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.50, -40, -3.25, 0)

local condition3 = Condition(CONDITION_PARALYZE)
condition3:setParameter(CONDITION_PARAM_TICKS, 6000)
condition3:setFormula(-0.7, 0, -0.7, 0)
combat3:addCondition(condition3)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat4:setParameter(COMBAT_PARAM_EFFECT, 56)
combat4:setFormula(COMBAT_FORMULA_LEVELMAGIC, -3.50, -50, -3.25, 0)

local condition4 = Condition(CONDITION_PARALYZE)
condition4:setParameter(CONDITION_PARAM_TICKS, 6000)
condition4:setFormula(-0.7, 0, -0.7, 0)
combat4:addCondition(condition4)

local area = createCombatArea({
    {0, 1, 1, 1, 0},
    {1, 1, 1, 1, 1},
    {1, 1, 2, 1, 1},
    {1, 1, 1, 1, 1},
    {0, 1, 1, 1, 0}
})

combat1:setArea(area)
combat2:setArea(area)
combat3:setArea(area)
combat4:setArea(area)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local creatureId = creature:getId()
    
    local function spell4(creatureId)
        local creature = Creature(creatureId)
        if creature then
            return combat4:execute(creature, variant)
        end
    end
    
    local function spell3(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell4, 350, creatureId)
            return combat3:execute(creature, variant)
        end
    end
    
    local function spell2(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell3, 350, creatureId)
            return combat2:execute(creature, variant)
        end
    end
    
    local function spell1(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell2, 350, creatureId)
            return combat1:execute(creature, variant)
        end
    end
    
    addEvent(spell1, 700, creatureId)
    
    return combat1:execute(creature, variant)
end
