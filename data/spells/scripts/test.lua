local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 59)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local Immortal = Condition(CONDITION_ATTRIBUTES)
Immortal:setParameter(CONDITION_PARAM_TICKS, 6000)
Immortal:setParameter(CONDITION_PARAM_SUBID, 50)
Immortal:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

combat:addCondition(Immortal)

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'Cooldown Pronto.')
    end
end

local exhausted_seconds = 16
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
        player:say("HA! I'am GOD!", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("Blessing I'like!", TALKTYPE_MONSTER_SAY)
    end
    
    addEvent(Cooldown, 16000, player:getId())
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    
    return combat:execute(creature, variant)
end
