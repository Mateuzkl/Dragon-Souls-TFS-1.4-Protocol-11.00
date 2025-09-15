local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 81)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 39)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local drunk = Condition(CONDITION_DRUNK)
drunk:setParameter(CONDITION_PARAM_TICKS, 15000)

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
    
    local function damageEffect(targetId, effectId)
        local target = Creature(targetId)
        if target then
            local damage = math.random(2000, 4000)
            target:getPosition():sendMagicEffect(effectId)
            target:addHealth(-damage)
            target:getPosition():sendAnimatedText(-damage, TEXTCOLOR_RED)
        end
    end
    
    local targetOutfit = target:getOutfit()
    local panicOutfit = {
        lookType = targetOutfit.lookType,
        lookHead = 82,
        lookBody = 82,
        lookLegs = 82,
        lookFeet = 82,
        lookAddons = targetOutfit.lookAddons
    }
    
    target:setOutfit(panicOutfit, 3000)
    
    if target:isPlayer() then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está em pânico!')
    end
    
    target:addCondition(drunk)
    
    local targetVariant = Variant(target:getPosition())
    combatDist:execute(creature, targetVariant)
    
    local targetId = target:getId()
    local rand = math.random(1, 2)
    if rand == 1 then
        player:say("Exevo Mas Vita", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("Exevo Mas Vita!", TALKTYPE_MONSTER_SAY)
    end
    
    addEvent(damageEffect, 1000, targetId, 81)
    addEvent(damageEffect, 1500, targetId, 82)
    addEvent(damageEffect, 2000, targetId, 81)
    addEvent(damageEffect, 2500, targetId, 81)
    addEvent(damageEffect, 3000, targetId, 81)
    
    return combat:execute(creature, variant)
end
