local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, 60)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -3.50, -30, -6.25, 0)

local condition1 = Condition(CONDITION_PARALYZE)
condition1:setParameter(CONDITION_PARAM_TICKS, 6000)
condition1:setFormula(-0.7, 0, -0.7, 0)
combat1:addCondition(condition1)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

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
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}
})

combat1:setArea(area1)
combat2:setArea(area2)

function onTargetCreature(creature, target)
    local targetPlayer = target:getPlayer()
    if targetPlayer then
        local rand = math.random(1, 5)
        target:getPosition():sendAnimatedText("Weakness!", TEXTCOLOR_WHITE_EXP)
        
        if rand < 4 then
            target:getPosition():sendMagicEffect(60)
        end
    end
    return true
end

combat1:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local function spell1()
        combat2:execute(creature, variant)
    end
    
    addEvent(spell1, 100)
    
    return combat1:execute(creature, variant)
end
