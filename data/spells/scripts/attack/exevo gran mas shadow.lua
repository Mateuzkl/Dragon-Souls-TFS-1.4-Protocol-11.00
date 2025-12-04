local acombat1 = Combat()
acombat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 22)

local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 22)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local condition1 = Condition(CONDITION_STUN)
condition1:setParameter(CONDITION_PARAM_TICKS, 6000)
acombat1:setCondition(condition1)

local acombat2 = Combat()
acombat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 22)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 22)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local condition2 = Condition(CONDITION_STUN)
condition2:setParameter(CONDITION_PARAM_TICKS, 6000)
acombat2:setCondition(condition2)

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

acombat1:setArea(area1)
acombat2:setArea(area2)

function onTargetCreature(creature, target)
    local rand = math.random(1, 5)
    if target:isPlayer() then
        Game.sendAnimatedText("Stun!", target:getPosition(), TEXTCOLOR_WHITE_EXP)
        if rand < 4 then
            target:getPosition():sendMagicEffect(32)
        end
    else
        Game.sendAnimatedText("Stun!", target:getPosition(), TEXTCOLOR_WHITE_EXP)
    end
end

combat1:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onTargetTile(creature, position)
    combat1:execute(creature, Variant(position))
end

acombat1:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetTile2(creature, position)
    combat2:execute(creature, Variant(position))
end

acombat2:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile2")

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local creatureId = creature:getId()
    
    local function spell4(creatureId)
        local creature = Creature(creatureId)
        if creature then
            return acombat1:execute(creature, variant)
        end
    end
    
    local function spell3(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell4, 450, creatureId)
            return acombat2:execute(creature, variant)
        end
    end
    
    local function spell2(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell3, 450, creatureId)
            return acombat1:execute(creature, variant)
        end
    end
    
    local function spell1(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell2, 450, creatureId)
            return acombat2:execute(creature, variant)
        end
    end
    
    addEvent(spell1, 450, creatureId)
    
    return acombat1:execute(creature, variant)
end
