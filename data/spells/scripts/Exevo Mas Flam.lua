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

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'CD: Exevo Mas Flam')
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
    local burningOutfit = {
        lookType = targetOutfit.lookType,
        lookHead = 9,
        lookBody = 9,
        lookLegs = 9,
        lookFeet = 9,
        lookAddons = targetOutfit.lookAddons
    }
    
    target:setOutfit(burningOutfit, 5000)
    
    if target:isPlayer() then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você está em chamas.')
    end
    
    target:addCondition(condition)
    combatDist:execute(creature, Variant(target:getId()))
    
    local rand = math.random(1, 2)
    if rand == 1 or rand == 2 then
        player:say("Exevo Mas Flam", TALKTYPE_MONSTER_SAY)
    end
    
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    addEvent(Cooldown, exhausted_seconds * 1000, player:getId())
    
    return combat:execute(creature, variant)
end
