local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_EFFECT, 40)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, 1, 0, 10)

local condition = Condition(CONDITION_REGEN)
condition:setParameter(CONDITION_PARAM_TICKS, 15000)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 10000)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 1)

combat:addCondition(condition)

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'CD: Exeta Mas Regen')
    end
end

local exhausted_seconds = 35
local exhausted_storagevalue = 6784

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    if os.time() < player:getStorageValue(exhausted_storagevalue) then
        player:sendCancelMessage('O Cooldown não está pronto.')
        return false
    end
    
    if math.random(1, 1) == 1 then
        player:say("Exeta mas regen", TALKTYPE_MONSTER_SAY)
    end
    
    addEvent(Cooldown, exhausted_seconds * 1000, player:getId())
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    
    return combat:execute(creature, variant)
end
