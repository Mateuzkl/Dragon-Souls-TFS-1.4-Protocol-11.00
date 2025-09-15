local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 58)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 37)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(1, 2000, -7000, -7000)
condition:addDamage(2, 2000, -6000, -6000)
condition:addDamage(3, 2000, -5000, -5000)
condition:addDamage(4, 2000, -4000, -4000)
condition:addDamage(5, 2000, -3000, -3000)
condition:addDamage(6, 2000, -2000, -2000)
condition:addDamage(7, 2000, -1000, -1000)

combatDist:addCondition(condition)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'CD: Exevo Pox')
    end
end

local exhausted_seconds = 18
local exhausted_storagevalue = 9423

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    if os.time() < player:getStorageValue(exhausted_storagevalue) then
        player:sendCancelMessage('O Cooldown não está pronto.')
        return false
    end
    
    local target = creature:getTarget()
    if not target then
        player:sendCancelMessage('Select your target.')
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    
    local targetOutfit = target:getOutfit()
    local poisonedOutfit = {
        lookType = targetOutfit.lookType,
        lookHead = 9,
        lookBody = 9,
        lookLegs = 9,
        lookFeet = 9,
        lookAddons = targetOutfit.lookAddons
    }
    
    target:setOutfit(poisonedOutfit, 3000)
    
    if target:isPlayer() then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está envenenado.')
    end
    
    target:addCondition(condition)
    combatDist:execute(creature, Variant(target:getId()))
    
    if math.random(1, 1) == 1 then
        player:say("Exevo Pox!", TALKTYPE_MONSTER_SAY)
    end
    
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    addEvent(Cooldown, exhausted_seconds * 1000, player:getId())
    
    return combat:execute(creature, variant)
end
