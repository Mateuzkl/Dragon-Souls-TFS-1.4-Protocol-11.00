local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 31)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 16)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 5000)
condition:setFormula(-0.9, 0, -0.9, 0)
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
    local stunnedOutfit = {
        lookType = targetOutfit.lookType,
        lookHead = 70,
        lookBody = 70,
        lookLegs = 70,
        lookFeet = 70,
        lookAddons = targetOutfit.lookAddons
    }
    
    target:setOutfit(stunnedOutfit, 3000)
    
    if target:isPlayer() then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está atordoado!')
    end
    
    target:addCondition(condition)
    
    local targetVariant = Variant(target:getPosition())
    combatDist:execute(creature, targetVariant)
    
    player:say("Exori hur!", TALKTYPE_MONSTER_SAY)
    
    return combat:execute(creature, variant)
end
