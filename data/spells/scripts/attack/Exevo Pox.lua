local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 47)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 30)
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
combatDist:setCondition(condition)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local function restoreOutfit(targetId, originalOutfit)
    local target = Player(targetId)
    if target then
        target:setOutfit(originalOutfit)
    end
end

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
    
    if target:isPlayer() then
        local targetPlayer = target:getPlayer()
        local targetOutfit = target:getOutfit()
        local congelado = {
            lookType = targetOutfit.lookType,
            lookHead = 9,
            lookBody = 9,
            lookLegs = 9,
            lookFeet = 9,
            lookAddons = targetOutfit.lookAddons
        }
        target:setOutfit(congelado)
        target:addCondition(condition)
        targetPlayer:sendTextMessage(MESSAGE_STATUS_WARNING, 'Voce est� envenenado.')
        
        addEvent(restoreOutfit, 14000, targetPlayer:getId(), targetOutfit)
        
        combatDist:execute(creature, Variant(target:getPosition()))
    else
        target:addCondition(condition)
        combatDist:execute(creature, Variant(target:getPosition()))
    end
    
    player:say("Exevo Pox!", TALKTYPE_MONSTER_SAY)
    
    return combat:execute(creature, variant)
end
