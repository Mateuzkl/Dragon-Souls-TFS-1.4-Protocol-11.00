local acombat1 = Combat()
local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 22)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local condition1 = Condition(CONDITION_PARALYZE)
condition1:setParameter(CONDITION_PARAM_TICKS, 6000)
condition1:setFormula(-0.7, 0, -0.7, 0)
acombat1:addCondition(condition1)

local acombat2 = Combat()
local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 22)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local condition2 = Condition(CONDITION_PARALYZE)
condition2:setParameter(CONDITION_PARAM_TICKS, 6000)
condition2:setFormula(-0.7, 0, -0.7, 0)
acombat2:addCondition(condition2)

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

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'CD: Exevo Gran Mas Shadow.')
    end
end

local exhausted_seconds = 35
local exhausted_storagevalue = 4345

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

function onTargetTile1(creature, position)
    combat1:execute(creature, Variant(position))
end

function onTargetTile2(creature, position)
    combat2:execute(creature, Variant(position))
end

acombat1:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
acombat2:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile2")

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    if os.time() < player:getStorageValue(exhausted_storagevalue) then
        player:sendCancelMessage('O Cooldown não está pronto.')
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
            return acombat1:execute(creature, variant)
        end
    end
    
    local function spell2(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell3, 450, creatureId)
            return acombat2:execute(creature, variant)
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
    addEvent(Cooldown, exhausted_seconds * 1000, player:getId())
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    
    return acombat1:execute(creature, variant)
end
