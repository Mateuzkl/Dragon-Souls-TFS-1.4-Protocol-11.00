local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 56)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 44)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 3000)
condition:setParameter(CONDITION_PARAM_SPEED, -220)
condition:setFormula(-0.7, 0, -0.7, 0)
combatDist:addCondition(condition)

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
    local frozenOutfit = {
        lookType = targetOutfit.lookType,
        lookHead = 9,
        lookBody = 9,
        lookLegs = 9,
        lookFeet = 9,
        lookAddons = targetOutfit.lookAddons
    }
    
    target:setOutfit(frozenOutfit, 3000)
    
    if target:isPlayer() then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está congelado.')
    end
    
    target:addCondition(condition)
    combatDist:execute(creature, Variant(target:getId()))
    
    if math.random(1, 1) == 1 then
        player:say("Adori Frigo!", TALKTYPE_MONSTER_SAY)
    end
    
    return combat:execute(creature, variant)
end
