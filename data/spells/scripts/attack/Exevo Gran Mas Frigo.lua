local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, 56)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -4.70, -40, -7.10, 0)

local condition1 = Condition(CONDITION_PARALYZE)
condition1:setParameter(CONDITION_PARAM_TICKS, 6000)
condition1:setFormula(-0.7, 0, -0.7, 0)
combat1:setCondition(condition1)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, 56)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -4.70, -40, -7.10, 0)

local condition2 = Condition(CONDITION_PARALYZE)
condition2:setParameter(CONDITION_PARAM_TICKS, 6000)
condition2:setFormula(-0.7, 0, -0.7, 0)
combat2:setCondition(condition2)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, 56)
combat3:setFormula(COMBAT_FORMULA_LEVELMAGIC, -4.70, -40, -7.10, 0)

local condition3 = Condition(CONDITION_PARALYZE)
condition3:setParameter(CONDITION_PARAM_TICKS, 6000)
condition3:setFormula(-0.7, 0, -0.7, 0)
combat3:setCondition(condition3)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat4:setParameter(COMBAT_PARAM_EFFECT, 56)
combat4:setFormula(COMBAT_FORMULA_LEVELMAGIC, -4.70, -40, -7.10, 0)

local condition4 = Condition(CONDITION_PARALYZE)
condition4:setParameter(CONDITION_PARAM_TICKS, 6000)
condition4:setFormula(-0.7, 0, -0.7, 0)
combat4:setCondition(condition4)

local area = createCombatArea({
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}
})

combat1:setArea(area)
combat2:setArea(area)
combat3:setArea(area)
combat4:setArea(area)

function onTargetCreature(creature, target)
    local player = creature:getPlayer()
    
    local function sun1(playerId)
        local player = Player(playerId)
        if player then
            player:say("...", TALKTYPE_MONSTER_SAY)
        end
    end
    
    local rand = math.random(1, 5)
    Game.sendAnimatedText("Frozen!", target:getPosition(), 143)
    
    if target:isPlayer() then
        if rand == 5 or rand == 4 then
            if player and rand == 4 then
                target:getPosition():sendMagicEffect(24)
            end
            if player then
                addEvent(sun1, 1000, player:getId())
            end
        end
    end
end

combat1:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local creatureId = creature:getId()
    
    local function spell4(creatureId, var)
        local creature = Creature(creatureId)
        if creature then
            return combat4:execute(creature, var)
        end
    end
    
    local function spell3(creatureId, var)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell4, 750, creatureId, var)
            return combat3:execute(creature, var)
        end
    end
    
    local function spell2(creatureId, var)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell3, 750, creatureId, var)
            return combat2:execute(creature, var)
        end
    end
    
    local function spell1(creatureId, var)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell2, 750, creatureId, var)
            return combat1:execute(creature, var)
        end
    end
    
    addEvent(spell1, 750, creatureId, variant)
    
    return combat1:execute(creature, variant)
end
