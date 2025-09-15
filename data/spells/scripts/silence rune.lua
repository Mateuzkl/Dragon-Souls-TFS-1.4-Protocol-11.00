local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 32)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 6000)
condition:setParameter(CONDITION_PARAM_SPEED, -220)
condition:setFormula(-0.8, 0, -0.8, 0)

combat:addCondition(condition)

local exhaust = Condition(CONDITION_EXHAUSTED)
exhaust:setParameter(CONDITION_PARAM_TICKS, 6000)

local area = createCombatArea({
    {0, 1, 1, 1, 0},
    {1, 1, 1, 1, 1},
    {1, 1, 3, 1, 1},
    {1, 1, 1, 1, 1},
    {0, 1, 1, 1, 0}
})

combat:setArea(area)

local exhausted_seconds = 35
local exhausted_storagevalue = 9261

function onTargetCreature(creature, target)
    local targetPlayer = target:getPlayer()
    if targetPlayer then
        local rand = math.random(1, 5)
        if rand == 1 then
            creature:getPosition():sendAnimatedText("Silence!", 215)
            creature:addCondition(exhaust)
            creature:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
        else
            target:getPosition():sendAnimatedText("Silence!", 215)
            target:addCondition(exhaust)
            targetPlayer:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
        end
    end
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'CD: Exevo Gran Mas Time Ultime')
    end
end

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    if os.time() < player:getStorageValue(exhausted_storagevalue) then
        player:sendCancelMessage('O Cooldown não está pronto.')
        return false
    end
    
    local rand = math.random(1, 50)
    if rand == 1 then
        player:say("Stop Time!", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("Stop Bitch!", TALKTYPE_MONSTER_SAY)
    end
    
    addEvent(Cooldown, 55000, player:getId())
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    
    return combat:execute(creature, variant)
end
