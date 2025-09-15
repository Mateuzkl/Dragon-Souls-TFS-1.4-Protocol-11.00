local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 70)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 52)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local area = createCombatArea({
    {1, 1, 1},
    {1, 3, 1},
    {1, 1, 1}
})

combatDist:setArea(area)

local condition = Condition(CONDITION_FIRE)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(5, 1000, -6000, -6000)
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
    local burningOutfit = {
        lookType = targetOutfit.lookType,
        lookHead = 94,
        lookBody = 94,
        lookLegs = 94,
        lookFeet = 94,
        lookAddons = targetOutfit.lookAddons
    }
    
    target:setOutfit(burningOutfit, 5000)
    
    if target:isPlayer() then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está em chamas!')
    end
    
    target:addCondition(condition)
    
    local targetVariant = Variant(target:getPosition())
    combatDist:execute(creature, targetVariant)
    
    player:say("Exevo Mas Flam", TALKTYPE_MONSTER_SAY)
    
    return combat:execute(creature, variant)
end
