local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, 56)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -4.70, -40, -7.10, 0)

local condition1 = Condition(CONDITION_PARALYZE)
condition1:setParameter(CONDITION_PARAM_TICKS, 6000)
condition1:setFormula(-0.7, 0, -0.7, 0)
combat1:addCondition(condition1)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, 56)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -4.70, -40, -7.10, 0)

local condition2 = Condition(CONDITION_PARALYZE)
condition2:setParameter(CONDITION_PARAM_TICKS, 6000)
condition2:setFormula(-0.7, 0, -0.7, 0)
combat2:addCondition(condition2)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, 56)
combat3:setFormula(COMBAT_FORMULA_LEVELMAGIC, -4.70, -40, -7.10, 0)

local condition3 = Condition(CONDITION_PARALYZE)
condition3:setParameter(CONDITION_PARAM_TICKS, 6000)
condition3:setFormula(-0.7, 0, -0.7, 0)
combat3:addCondition(condition3)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat4:setParameter(COMBAT_PARAM_EFFECT, 56)
combat4:setFormula(COMBAT_FORMULA_LEVELMAGIC, -4.70, -40, -7.10, 0)

local condition4 = Condition(CONDITION_PARALYZE)
condition4:setParameter(CONDITION_PARAM_TICKS, 6000)
condition4:setFormula(-0.7, 0, -0.7, 0)
combat4:addCondition(condition4)

local area = createCombatArea({
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
    if target:isPlayer() then
        target:getPosition():sendAnimatedText("Frozzen!", TEXTCOLOR_TEAL)
        if rand == 5 or rand == 4 then
            if player and rand == 4 then
                target:getPosition():sendMagicEffect(24)
            end
            if player then
                addEvent(sun1, 1000, player:getId())
            end
        end
    else
        target:getPosition():sendAnimatedText("Frozzen!", TEXTCOLOR_TEAL)
    end
end

combat1:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
combat2:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
combat3:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
combat4:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'CD: Exevo Gran Mas Frigo')
    end
end

local exhausted_seconds = 35
local exhausted_storagevalue = 6347

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
            return combat4:execute(creature, variant)
        end
    end
    
    local function spell3(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell4, 750, creatureId)
            return combat3:execute(creature, variant)
        end
    end
    
    local function spell2(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell3, 750, creatureId)
            return combat2:execute(creature, variant)
        end
    end
    
    local function spell1(creatureId)
        local creature = Creature(creatureId)
        if creature then
            addEvent(spell2, 750, creatureId)
            return combat1:execute(creature, variant)
        end
    end
    
    addEvent(spell1, 750, creatureId)
    addEvent(Cooldown, exhausted_seconds * 1000, player:getId())
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    
    return combat1:execute(creature, variant)
end
