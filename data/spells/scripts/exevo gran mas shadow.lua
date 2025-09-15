local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 22)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local condition1 = Condition(CONDITION_PARALYZE)
condition1:setParameter(CONDITION_PARAM_TICKS, 6000)
condition1:setFormula(-0.7, 0, -0.7, 0)
combat1:addCondition(condition1)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 22)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local condition2 = Condition(CONDITION_PARALYZE)
condition2:setParameter(CONDITION_PARAM_TICKS, 6000)
condition2:setFormula(-0.7, 0, -0.7, 0)
combat2:addCondition(condition2)

local area1 = createCombatArea({
    {0, 1, 1, 1, 0},
    {1, 1, 1, 1, 1},
    {1, 1, 2, 1, 1},
    {1, 1, 1, 1, 1},
    {0, 1, 1, 1, 0}
})

local area2 = createCombatArea({
    {0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0},
    {0, 0, 1, 1, 1, 0, 0},
    {1, 1, 1, 2, 1, 1, 1},
    {0, 0, 1, 1, 1, 0, 0},
    {0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0}
})

combat1:setArea(area1)
combat2:setArea(area2)

function onTargetCreature(creature, target)
    local rand = math.random(1, 5)
    if target:isPlayer() then
        target:getPosition():sendAnimatedText("Stun!", TEXTCOLOR_WHITE_EXP)
        if rand < 4 then
            target:getPosition():sendMagicEffect(60)
        end
    else
        target:getPosition():sendAnimatedText("Stun!", TEXTCOLOR_WHITE_EXP)
    end
end

combat1:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
combat2:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local creatureId = creature:getId()
    
    local function spell4(creatureId)
        local creature = Creature(creatureId)
        if creature then
            return combat1:execute(creature, variant)
        end
    end
    
    local function spell3(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell4, 450, creatureId)
            return combat1:execute(creature, variant)
        end
    end
    
    local function spell2(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell3, 450, creatureId)
            return combat2:execute(creature, variant)
        end
    end
    
    local function spell1(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell2, 450, creatureId)
            return combat2:execute(creature, variant)
        end
    end
    
    addEvent(spell1, 450, creatureId)
    
    return combat1:execute(creature, variant)
end
