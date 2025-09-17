local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 32)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 21)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local condition = Condition(CONDITION_STUN)
condition:setParameter(CONDITION_PARAM_TICKS, 5000)
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
        targetPlayer:sendTextMessage(MESSAGE_STATUS_WARNING, 'Voce está stunado.')
        
        addEvent(restoreOutfit, 3000, targetPlayer:getId(), targetOutfit)
        
        combatDist:execute(creature, Variant(target:getPosition()))
    else
        target:addCondition(condition)
        combatDist:execute(creature, Variant(target:getPosition()))
    end
    
    player:say("Exori hur!", TALKTYPE_MONSTER_SAY)
    
    return combat:execute(creature, variant)
end
