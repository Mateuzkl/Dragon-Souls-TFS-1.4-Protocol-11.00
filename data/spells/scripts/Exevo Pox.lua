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

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
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
        lookHead = 47,
        lookBody = 47,
        lookLegs = 47,
        lookFeet = 47,
        lookAddons = targetOutfit.lookAddons
    }
    
    target:setOutfit(poisonedOutfit, 3000)
    
    if target:isPlayer() then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está envenenado!')
    end
    
    target:addCondition(condition)
    
    local targetVariant = Variant(target:getPosition())
    combatDist:execute(creature, targetVariant)
    
    player:say("Exevo Pox!", TALKTYPE_MONSTER_SAY)
    
    return combat:execute(creature, variant)
end
