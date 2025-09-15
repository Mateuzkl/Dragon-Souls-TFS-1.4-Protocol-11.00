local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 78)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 32)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local condition = Condition(CONDITION_BLEEDING)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(1, 1000, -5, -5)
condition:addDamage(1, 1000, -5, -5)
condition:addDamage(1, 1000, -4, -4)
condition:addDamage(1, 1000, -3, -3)
condition:addDamage(1, 1000, -2, -2)
condition:addDamage(1, 1000, -1, -1)
condition:addDamage(1, 1000, -100, -100)
combatDist:addCondition(condition)

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
    
    if not player:getPosition():isSightClear(target:getPosition()) then
        player:sendCancelMessage('You cannot see your target.')
        return false
    end
    
    local targetOutfit = target:getOutfit()
    
    if target:isPlayer() then
        local cursedOutfit = {
            lookType = targetOutfit.lookType,
            lookHead = 96,
            lookBody = 96,
            lookLegs = 96,
            lookFeet = 96,
            lookAddons = targetOutfit.lookAddons
        }
        target:setOutfit(cursedOutfit, 3000)
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está amaldiçoado!')
    end
    
    target:addCondition(condition)
    
    local targetVariant = Variant(target:getPosition())
    combatDist:execute(creature, targetVariant)
    
    player:say("Adori Gran Dark", TALKTYPE_MONSTER_SAY)
    
    return combat:execute(creature, variant)
end
