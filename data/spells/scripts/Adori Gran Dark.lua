local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 75)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 39)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local condition = Condition(CONDITION_EMO)
condition:addDamage(1, 1000, -5, -5)
condition:addDamage(1, 1000, -5, -5)
condition:addDamage(1, 1000, -4, -4)
condition:addDamage(1, 1000, -3, -3)
condition:addDamage(1, 1000, -2, -2)
condition:addDamage(1, 1000, -1, -1)
condition:addDamage(1, 1000, -25000, -25000)

combatDist:addCondition(condition)

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'CD: Adori Gran Dark')
    end
end

local exhausted_seconds = 45
local exhausted_storagevalue = 9389

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
        local cursedOutfit = {
            lookType = targetOutfit.lookType,
            lookHead = 9,
            lookBody = 9,
            lookLegs = 9,
            lookFeet = 9,
            lookAddons = targetOutfit.lookAddons
        }
        target:setOutfit(cursedOutfit, 3000)
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está condenado.')
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
    
    local rand = math.random(1, 2)
    if rand == 1 or rand == 2 then
        player:say("Adori Gran Dark", TALKTYPE_MONSTER_SAY)
    end
    
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    addEvent(Cooldown, exhausted_seconds * 1000, player:getId())
    
    return combat:execute(creature, variant)
end
