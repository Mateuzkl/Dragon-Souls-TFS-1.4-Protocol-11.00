local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 75)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 39)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local condition = Condition(CONDITION_BLEEDING)
condition:setParameter(CONDITION_PARAM_TICKS, 6000)
condition:setParameter(CONDITION_PARAM_PERIODICDAMAGE, -5)
condition:setParameter(CONDITION_PARAM_STARTDAMAGE, -25)
condition:setParameter(CONDITION_PARAM_TICKINTERVAL, 1000)

combatDist:addCondition(condition)

local exhausted_seconds = 45
local exhausted_storagevalue = 9389

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    if player:getStorageValue(exhausted_storagevalue) > os.time() then
        player:sendCancelMessage('You are exhausted.')
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
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
            lookHead = 9,
            lookBody = 9,
            lookLegs = 9,
            lookFeet = 9,
            lookAddons = targetOutfit.lookAddons
        }
        target:setOutfit(cursedOutfit, 3000)
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está amaldiçoado!')
    end
    
    target:addCondition(condition)
    
    local targetVariant = Variant(target:getPosition())
    combatDist:execute(creature, targetVariant)
    
    local rand = math.random(1, 4)
    if rand <= 2 then
        player:say("Adori Gran Dark", TALKTYPE_MONSTER_SAY)
    end
    
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    
    return combat:execute(creature, variant)
end
