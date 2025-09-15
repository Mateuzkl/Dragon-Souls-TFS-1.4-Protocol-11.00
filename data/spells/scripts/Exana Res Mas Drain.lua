local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 59)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 55)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local condition = Condition(CONDITION_DROWN)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(8, 1000, -5000, -5000)

combatDist:addCondition(condition)

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'CD: Exana res mas drain')
    end
end

local exhausted_seconds = 15
local exhausted_storagevalue = 9369

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
    
    if target:isPlayer() then
        local drainedOutfit = {
            lookType = targetOutfit.lookType,
            lookHead = 9,
            lookBody = 9,
            lookLegs = 9,
            lookFeet = 9,
            lookAddons = targetOutfit.lookAddons
        }
        target:setOutfit(drainedOutfit, 3000)
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está sendo drenado.')
    else
        local monsterOutfit = {
            lookType = targetOutfit.lookType,
            lookHead = targetOutfit.lookHead,
            lookBody = targetOutfit.lookBody,
            lookLegs = targetOutfit.lookLegs,
            lookFeet = targetOutfit.lookFeet,
            lookAddons = targetOutfit.lookAddons
        }
        target:setOutfit(monsterOutfit, 3000)
    end
    
    target:addCondition(condition)
    combatDist:execute(creature, Variant(target:getId()))
    
    if math.random(1, 1) == 1 then
        player:say("Exana Res Mas Drain", TALKTYPE_MONSTER_SAY)
    end
    
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    addEvent(Cooldown, exhausted_seconds * 1000, player:getId())
    
    return combat:execute(creature, variant)
end
