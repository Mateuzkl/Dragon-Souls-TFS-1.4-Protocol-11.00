local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 58)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 37)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

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
    
    local function damageEffect(targetId)
        local target = Creature(targetId)
        if target then
            local damage = math.random(2000, 4000)
            target:getPosition():sendMagicEffect(58)
            target:addHealth(-damage)
            target:getPosition():sendAnimatedText(-damage, TEXTCOLOR_RED)
        end
    end
    
    local targetOutfit = target:getOutfit()
    local devouredOutfit = {
        lookType = targetOutfit.lookType,
        lookHead = 78,
        lookBody = 78,
        lookLegs = 78,
        lookFeet = 78,
        lookAddons = targetOutfit.lookAddons
    }
    
    target:setOutfit(devouredOutfit, 3000)
    
    if target:isPlayer() then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está sendo devorado!')
    end
    
    target:addCondition(condition)
    
    local targetVariant = Variant(target:getPosition())
    combatDist:execute(creature, targetVariant)
    
    local targetId = target:getId()
    player:say("Exevo Tera!", TALKTYPE_MONSTER_SAY)
    
    addEvent(damageEffect, 1000, targetId)
    addEvent(damageEffect, 1500, targetId)
    addEvent(damageEffect, 2000, targetId)
    addEvent(damageEffect, 2500, targetId)
    addEvent(damageEffect, 3000, targetId)
    addEvent(damageEffect, 3500, targetId)
    
    return combat:execute(creature, variant)
end
