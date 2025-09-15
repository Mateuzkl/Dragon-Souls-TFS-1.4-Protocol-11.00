local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_HASTE)
condition:setParameter(CONDITION_PARAM_TICKS, 60000)
condition:setFormula(1.7, -76, 1.7, -76)

combat:addCondition(condition)

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'CD: Utani Mas Hur.')
    end
end

local exhausted_seconds = 8
local exhausted_storagevalue = 9666

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    if os.time() < player:getStorageValue(exhausted_storagevalue) then
        player:sendCancelMessage('O Cooldown não está pronto.')
        return false
    end
    
    local rand = math.random(1, 50)
    if rand == 1 then
        player:say("HA! Try get me now!", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("See ya!", TALKTYPE_MONSTER_SAY)
    end
    
    addEvent(Cooldown, 7000, player:getId())
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    
    return combat:execute(creature, variant)
end
