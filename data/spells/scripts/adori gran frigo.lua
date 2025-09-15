local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 64)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 36)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 6000)
condition:setFormula(-0.9, 0, -0.9, 0)

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
    
    local targetOutfit = target:getOutfit()
    local frozenOutfit = {
        lookType = targetOutfit.lookType,
        lookHead = 88,
        lookBody = 88,
        lookLegs = 88,
        lookFeet = 88,
        lookAddons = targetOutfit.lookAddons
    }
    
    target:setOutfit(frozenOutfit, 6000)
    
    if target:isPlayer() then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está congelado!')
    end
    
    target:addCondition(condition)
    
    local targetVariant = Variant(target:getPosition())
    combatDist:execute(creature, targetVariant)
    
    player:say("Adori Gran Frigo", TALKTYPE_MONSTER_SAY)
    
    return combat:execute(creature, variant)
end
